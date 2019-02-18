Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B22C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA49D208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550476740;
	bh=bS3o+5mPwMdNDi336qsw05WrH1zhNIze59onu9FtArA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S4ejUoFbKAfzkIB0ork7Z3Vzg5q4QzheVBZxXLjJooWuPzqA1VWWFRqx1Uxfj2T6b
	 tpQPzULWzc9v8mcnOtoebpJrIh8SONaT20g85Y4hec+hM9l7CV2sCk6w7furbh8/fR
	 4dqtGEVJFe2QwB0Tvk7NxtZTUy4hLHRM7nz81QHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfBRH67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:58:59 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39435 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfBRH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:58:58 -0500
Received: by mail-lj1-f176.google.com with SMTP id g80so13495191ljg.6;
        Sun, 17 Feb 2019 23:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zCnehaW0PseU5RatCGdgxLRTLVwxGJo1Fx6spfjL6so=;
        b=mWdxhTm+vUwaTx/iUKEKcrBPBuSkE5EGVPJPlk0caJ/pB0godJSzG77RBxWy7XHpnD
         Hw50EpmKkxH4aKWi9oREGcT9aiIW8mIG6GyzY10O+emGV+981pbeWcy7FGizGlJV4gJE
         VLfvBdqeOPSvx16ehiDnfztYrObysE1rsBoDQy1aXWv3WUWOfeTfR6Te8iYSmnAzj0CR
         QohY0sQ8gZJckHZIKaRk16fXaD5RKylCUS/uXfSKXJo5JbWXLNERB/Ixk/XjUvzH9lIm
         hbvPAgW1u6U9cb0dPp87xgNTKKrueWUsEed5D93tTK8rIgqsYOCcmqdDdWk91uNa6xbs
         ox7w==
X-Gm-Message-State: AHQUAubjQkWKL/gGjhb81EPSsOZhZZoFb16Z3SEup/p2Swxhv4Bz/adK
        nVO3FaQNjVZ/8IX2uOaeWWc=
X-Google-Smtp-Source: AHgI3IYeb3Dd+qu+aMNzXR74QPWTYwCIGCZ0yBQI7+Ut8jBlqKDfVrpQgcgaf4QwLiMlow/SUUqZkA==
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr13828785ljc.97.1550476736199;
        Sun, 17 Feb 2019 23:58:56 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g6sm3618562lfh.35.2019.02.17.23.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 23:58:55 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gvdpD-000179-HQ; Mon, 18 Feb 2019 08:58:51 +0100
Date:   Mon, 18 Feb 2019 08:58:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nix <nix@esperi.org.uk>
Cc:     Greg KH <greg@kroah.com>, johan@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 4.20.7: pl2303 not working (post-4.19 regression) (limited info
 so far, not yet bisected)
Message-ID: <20190218075851.GA4072@localhost>
References: <87o97bu2bt.fsf@esperi.org.uk>
 <20190216194758.GA10756@kroah.com>
 <877edytehb.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877edytehb.fsf@esperi.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 07:13:52PM +0000, Nix wrote:
> On 16 Feb 2019, Greg KH told this:
> 
> > On Sat, Feb 16, 2019 at 04:26:30PM +0000, Nix wrote:
> >> So I just tried to connect up to my ancient Soekris firewall's serial
> >> console to try to bisect a problem where it stopped booting in 4.20, and
> >> found I couldn't.
> >> 
> >> minicom says:
> >> 
> >> minicom: cannot open /dev/ttyUSB0: Input/output error
> >> 
> >> and in the dmesg we see
> >> 
> >> [705576.028170] pl2303 ttyUSB0: failed to submit interrupt urb: -28
> >>
> >> Booting to 4.19, everything works fine. (A random GalliumOS Chromebook
> [...]
> >
> > bisection would be great, thanks!
> 
> Rrrg. This is going to be harder than I thought. Rebooting, everything
> works fine! So this is something that kicks in after something less than
> eight days uptime, consistently on every box I own, but is fine on
> reboot.

Tough one.

> I'm still fairly sure this is a regression -- my machines are often up
> for a lot longer than that and I've never seen this before I upgraded to
> 4.20.x -- but I don't think I'm going to identify it by mindless
> bisection. I might have to actually *think* about it.

I doubt it's a regression in usb-serial as essentially nothing changed
with respect to pl2303 or core since 4.19.

The -ENOSPC you're seeing is returned by the host controller to
indicate:

	This request would overcommit the usb bandwidth reserved for
	periodic transfers (interrupt, isochronous).

but if you're saying you can reproduce this on "every box" it may not be
related to any particular host-controller driver (or USB topology).

Johan
