Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13EFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E6D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FadFHOcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfBLQHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:07:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35463 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbfBLQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:07:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so3561050qtk.2;
        Tue, 12 Feb 2019 08:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TRTDdhZi5/0UIdqdON+PB46U/PJshVrSPEBvfdFGXQA=;
        b=FadFHOcSyTZYlFLD1n5y4xPHumt+mbYLwkOxs1mMLd1WsWrrazMZQEgkbycfn1EK1h
         dX9axgtORfZGEH2D3iYJwbwcdk6gKofvUN1ofyiXLVxD+13FLbiN+F5OjkY7AhMlzqqb
         7WzRTQI6AD/qCRcFLZzxnkA5hS1E1C6y2WtvRJgEwFKmW/7s0HPLcX5cOifHHH9CO51k
         Swkx3Xpw3htI7J2CwLdMDl8kMCUc0dh1d/GyDU2bEN9mXhDoYJLNDEwCKXuY/PF6IPjm
         4pohYojEt3D0mR2wVabZJx4MJJUC3EGNjWvxnhv7f/BkRx6RfoNhRJ9H+ZsuluSvrKHv
         PCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRTDdhZi5/0UIdqdON+PB46U/PJshVrSPEBvfdFGXQA=;
        b=U7SQV1cqk6pfvo0t6hbjhL8po7T+FVXoEX0P4uoSTnhqsKAQVQdQGgmSaaJIgbnsW5
         rp3A19R1jv2jpUnnG4EqJgwyQPEY0FMCbD2A2fzPaGTk2yTT5gQelyFLiVJWs3M1VrB1
         QQlqtBeLQBw6fLLAv018++OzQYDh8LNBE6oQmODduu9z/S4kGgH7crlZznpJUcA2QtyV
         DvgVeEe1O6OWt2aVYjqGQCgviNi8c0Tlar9iFS8apwgiWlzdn0oR1lnMx3ZZWkGElQyB
         jaTMzUV2Zu4kAw7KwPamZyHy0YnFyHHIrsGrakmUqldYcF8YgDDdmTan67D/A3PCOvEE
         6SzQ==
X-Gm-Message-State: AHQUAuaUeMR9+Bvhvjr2bQ++mSeNIWav9sfwmm6v/dHUBbO9Ec0sOUpP
        0Vuy6D9sZASx8HIb0kAUwY8=
X-Google-Smtp-Source: AHgI3Ian1KkISEebfJp3v1x72Y6nGVtgjo39CBMHN5UQ1+CdmWPmwF9VtC4+vlctNF5ubDnGHGSQow==
X-Received: by 2002:ac8:23aa:: with SMTP id q39mr3335333qtq.82.1549987662102;
        Tue, 12 Feb 2019 08:07:42 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f019:3a5b:b662:7c1a:9012:e865])
        by smtp.gmail.com with ESMTPSA id d19sm11908401qtm.10.2019.02.12.08.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 08:07:41 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 64862180C61; Tue, 12 Feb 2019 14:07:38 -0200 (-02)
Date:   Tue, 12 Feb 2019 14:07:38 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, davem@davemloft.net,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH net] sctp: set stream ext to NULL after freeing it in
 sctp_stream_outq_migrate
Message-ID: <20190212160738.GG10665@localhost.localdomain>
References: <0cb9e543c21495df48c3723044d6c9f64f238eca.1549968661.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb9e543c21495df48c3723044d6c9f64f238eca.1549968661.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 06:51:01PM +0800, Xin Long wrote:
> In sctp_stream_init(), after sctp_stream_outq_migrate() freed the
> surplus streams' ext, but sctp_stream_alloc_out() returns -ENOMEM,
> stream->outcnt will not be set to 'outcnt'.
> 
> With the bigger value on stream->outcnt, when closing the assoc and
> freeing its streams, the ext of those surplus streams will be freed
> again since those stream exts were not set to NULL after freeing in
> sctp_stream_outq_migrate(). Then the invalid-free issue reported by
> syzbot would be triggered.
> 
> We fix it by simply setting them to NULL after freeing.
> 
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Reported-by: syzbot+58e480e7b28f2d890bfd@syzkaller.appspotmail.com
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> ---
>  net/sctp/stream.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index f246331..2936ed1 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -144,8 +144,10 @@ static void sctp_stream_outq_migrate(struct sctp_stream *stream,
>  		}
>  	}
>  
> -	for (i = outcnt; i < stream->outcnt; i++)
> +	for (i = outcnt; i < stream->outcnt; i++) {
>  		kfree(SCTP_SO(stream, i)->ext);
> +		SCTP_SO(stream, i)->ext = NULL;
> +	}
>  }
>  
>  static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
> -- 
> 2.1.0
> 
