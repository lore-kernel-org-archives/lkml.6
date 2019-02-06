Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5184FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AA218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyUQX/T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfBFUiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:38:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33982 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFUiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:38:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id a15so5174151qkc.1;
        Wed, 06 Feb 2019 12:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CcZFjHbu7+gvUTWVxQ2fRRKBQKhhRo9fVmU7KgPkWxQ=;
        b=lyUQX/T3x9gX76C0F4j0UyOuwVfAFcB6lxGLq8ZfeDgJshGb7xNVytl+KW2IMF3mdP
         aUtP9iRsRX8T4SLhRwBT6UkuPYRjHkKv4/jMLyt2rsU6df6MfMUMlAhD2cvem5q7eVih
         oy3vaNpooOp5AbL7u3LfqPNqcsBtqbHvQJ5HO4sv8vH9Y/3NSKW5HO2VnhHVpX4q13WT
         h1Mq8ZkXoq7myF76ZL7wn+m4I57KPe4Cx8yBzpW/H3iSPoWiVETlwz6qI74Vwvm4AoWs
         elu1Cyx7tREOOip3GDFLo2Xg3uUw/X9Jnc5Gw3w0wy/suAni4eT3BaQe36zaeduRMP2c
         Crmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CcZFjHbu7+gvUTWVxQ2fRRKBQKhhRo9fVmU7KgPkWxQ=;
        b=cYTVi1Nzt6Mh9zw4GfMYESn5MLYQu1UEI+JqEo5o9JYmJ3mr6fdYbxXrXzxF9ZRPl1
         M6qrnxS1yCniRhmNi+6hThLhS7trqatkB5gZVPIqDiwEb+AJLq6L92J2LsncuCTgoPKG
         zrpGLbFKMkdOAXpmj1dlkbiHAgYaUjnwUR+1PAFwgP+wLfWkGMYafPRzVtolrbJNqXZS
         FdkI5GrpSYLwrWqdzQsUT1j+aMa7F5NW/qswtcWj/15UY7SwPNofFyQLzJUGBEfAJU8I
         J7DUCdoansNIJweHfpJdbJ/118rUidESWV1vlvIc3kU8fR8Fq5N7UOu5gpQzwXJv0dSF
         hbvw==
X-Gm-Message-State: AHQUAuZVIkYnphPp92DvedI+8MgHSLN1miBt3SNvHKtgpG0mFsgW5liv
        5IPGi4t2nULgUQEz+/wpxtg=
X-Google-Smtp-Source: AHgI3IYs1fjSLTURPJg01gKPudVhclP42W8yJypq4EUk8yNFt1RcolRGrbtxm8yN7IRIICNMf04ZpQ==
X-Received: by 2002:a37:4b07:: with SMTP id y7mr8631927qka.207.1549485478581;
        Wed, 06 Feb 2019 12:37:58 -0800 (PST)
Received: from localhost.localdomain ([168.181.50.206])
        by smtp.gmail.com with ESMTPSA id j189sm12761295qkc.77.2019.02.06.12.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 12:37:57 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 3B9CA180C4F; Wed,  6 Feb 2019 18:37:54 -0200 (-02)
Date:   Wed, 6 Feb 2019 18:37:54 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Julien Gomes <julien@arista.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190206203754.GC13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206201430.18830-1-julien@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
> structures longer than the current definitions.
> 
> This should prevent unjustified setsockopt() failures due to struct
> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
> binaries that should be compatible, but were built with later kernel
> uapi headers.

Not sure if we support backwards compatibility like this?

My issue with this change is that by doing this, application will have
no clue if the new bits were ignored or not and it may think that an
event is enabled while it is not.

A workaround would be to do a getsockopt and check the size that was
returned. But then, it might as well use the right struct here in the
first place.

I'm seeing current implementation as an implicitly versioned argument:
it will always accept setsockopt calls with an old struct (v4.11 or
v4.12), but if the user tries to use v3 on a v1-only system, it will
be rejected. Pretty much like using a newer setsockopt on an old
system.

> 
> Signed-off-by: Julien Gomes <julien@arista.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 9644bdc8e85c..f9717e2789da 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
>  	int i;
>  
>  	if (optlen > sizeof(struct sctp_event_subscribe))
> -		return -EINVAL;
> +		optlen = sizeof(struct sctp_event_subscribe);
>  
>  	if (copy_from_user(&subscribe, optval, optlen))
>  		return -EFAULT;
> -- 
> 2.20.1
> 
