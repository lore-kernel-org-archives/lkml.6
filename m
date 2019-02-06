Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96281C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5841C218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyAlQEQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBFVH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:07:29 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41468 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfBFVH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:07:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id b15so9565556qto.8;
        Wed, 06 Feb 2019 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puz1i9A6+KRdCfe4pAye0waGdRAiNmmXDeN4ZpsGeM0=;
        b=TyAlQEQREVc+lFl8orIWD3Vt5dqUQeHeHBuCnXYOPWzodGiV+dCIiaLonKJr2m2G/r
         HKhM1n1C3yg7jIlteUdIUziDyrjV/OsRSaBb+2K5EnnVmJuf8HdVQ6QeK3E0tuqvKpRI
         cXGPAOFii4zqED3hJfZhcHeXmxLAaSDIEvpy1kZVwKWkN/wpjnctzfjrPFRC++6cr668
         2tI8HwnGC+j5jHiaa4u2Yqo618xB+AzzEviPcpJfCbdRa9+DSitQ47zlSWEGC9Gzix3W
         yKIvIK5asMKyR/V6bNID44wI28akWm3Lp+Euc+bIRn5OYx+YfSVQAj6OHoL9ndm0wr6P
         kMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puz1i9A6+KRdCfe4pAye0waGdRAiNmmXDeN4ZpsGeM0=;
        b=pjHrqblkkKPBRlPm5FvF9qj4Y6xW4jv2elwq5jSkwfyKr61/PqQruumpHVwrb+PZVf
         JoOE2TyUyW0IxwDyEXLMqYzJw0YvobOsIHxKxHttSoqt5XP8EPbT7zJEhQu8fNT3KkCv
         bGNpzewKKC6xlqviqJlw+xfxNUfuELoWu9bSA3OJg0IW+S3nXZ2pVh3GRNwz8NmEASZk
         CkdCBBDz1SHCswuZPg9VO9/sKVugE+mYLyo4EFTRDq1nI9q0XoC1jOkrIE9U01nTsl3q
         xa9qeanR+J6gkogk39hXeTuL4lM1K6DAV6fNW5kLPxB/lYh1mlUdyl+fO2NsifcVDWCf
         6r9g==
X-Gm-Message-State: AHQUAuZ/+oxOzK7iXLg8Aqv/EYjeEzQHpY2/HrTvA335hGN8/J5rCriX
        /JSXMosRTuckhRkjz653a1g=
X-Google-Smtp-Source: AHgI3IZv+YWx7MI8Ac9HRLQcpwOMLxYgXdsUyyociAVohO1Bg3JOdIzLyiH2ot+CkIoq7/WZvp6Y5Q==
X-Received: by 2002:ac8:7384:: with SMTP id t4mr9131784qtp.203.1549487246618;
        Wed, 06 Feb 2019 13:07:26 -0800 (PST)
Received: from localhost.localdomain ([168.181.50.206])
        by smtp.gmail.com with ESMTPSA id f19sm22138708qtf.1.2019.02.06.13.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 13:07:25 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 28F79180C4F; Wed,  6 Feb 2019 19:07:23 -0200 (-02)
Date:   Wed, 6 Feb 2019 19:07:23 -0200
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Julien Gomes <julien@arista.com>
Cc:     netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        nhorman@tuxdriver.com, vyasevich@gmail.com, lucien.xin@gmail.com
Subject: Re: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Message-ID: <20190206210723.GD13621@localhost.localdomain>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 12:48:38PM -0800, Julien Gomes wrote:
> 
> 
> On 2/6/19 12:37 PM, Marcelo Ricardo Leitner wrote:
> > On Wed, Feb 06, 2019 at 12:14:30PM -0800, Julien Gomes wrote:
> >> Make sctp_setsockopt_events() able to accept sctp_event_subscribe
> >> structures longer than the current definitions.
> >>
> >> This should prevent unjustified setsockopt() failures due to struct
> >> sctp_event_subscribe extensions (as in 4.11 and 4.12) when using
> >> binaries that should be compatible, but were built with later kernel
> >> uapi headers.
> > 
> > Not sure if we support backwards compatibility like this?
> > 
> > My issue with this change is that by doing this, application will have
> > no clue if the new bits were ignored or not and it may think that an
> > event is enabled while it is not.
> > 
> > A workaround would be to do a getsockopt and check the size that was
> > returned. But then, it might as well use the right struct here in the
> > first place.
> > 
> > I'm seeing current implementation as an implicitly versioned argument:
> > it will always accept setsockopt calls with an old struct (v4.11 or
> > v4.12), but if the user tries to use v3 on a v1-only system, it will
> > be rejected. Pretty much like using a newer setsockopt on an old
> > system.
> 
> With the current implementation, given sources that say are supposed to
> run on a 4.9 kernel (no use of any newer field added in 4.11 or 4.12),
> we can't rebuild the exact same sources on a 4.19 kernel and still run
> them on 4.9 without messing with structures re-definition.

Maybe what we want(ed) here then is explicit versioning, to have the 3
definitions available. Then the application is able to use, say struct
sctp_event_subscribe, and be happy with it, while there is struct
sctp_event_subscribe_v2 and struct sctp_event_subscribe_v3 there too.

But it's too late for that now because that would break applications
already using the new fields in sctp_event_subscribe.

> 
> I understand your point, but this still looks like a sort of uapi
> breakage to me.

Not disagreeing. I really just don't know how supported that is.
Willing to know so I can pay more attention to this on future changes.

Btw, is this the only occurrence?

> 
> 
> I also had another way to work-around this in mind, by copying optlen
> bytes and checking that any additional field (not included in the
> "current" kernel structure definition) is not set, returning EINVAL in
> such case to keep a similar to current behavior.
> The issue with this is that I didn't find a suitable (ie not totally
> arbitrary such as "twice the existing structure size") upper limit to
> optlen.

Seems interesting. Why would it need that upper limit to optlen?

Say struct v1 had 4 bytes, v3 now had 12. The user supplies 12 bytes
to the kernel that only knows about 4 bytes. It can check that (12-4)
bytes in the end, make sure no bit is on and use only the first 4.

The fact that it was 12 or 200 shouldn't matter, should it? As long as
the (200-4) bytes are 0'ed, only the first 4 will be used and it
should be ok, otherwise EINVAL. No need to know how big the current
current actually is because it wouldn't be validating that here: just
that it can safely use the first 4 bytes.

> 
> > 
> >>
> >> Signed-off-by: Julien Gomes <julien@arista.com>
> >> ---
> >>  net/sctp/socket.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> >> index 9644bdc8e85c..f9717e2789da 100644
> >> --- a/net/sctp/socket.c
> >> +++ b/net/sctp/socket.c
> >> @@ -2311,7 +2311,7 @@ static int sctp_setsockopt_events(struct sock *sk, char __user *optval,
> >>  	int i;
> >>  
> >>  	if (optlen > sizeof(struct sctp_event_subscribe))
> >> -		return -EINVAL;
> >> +		optlen = sizeof(struct sctp_event_subscribe);
> >>  
> >>  	if (copy_from_user(&subscribe, optval, optlen))
> >>  		return -EFAULT;
> >> -- 
> >> 2.20.1
> >>
> 
