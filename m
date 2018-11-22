Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02820824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFXHUT21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D02820824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403935AbeKWD3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:29:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732770AbeKWD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:29:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so2158497pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kC4sLiWuy0LyCSyiHS0PVP02yjUvLp/5peK2DM8t9IM=;
        b=vFXHUT21nzBrfkeKxK8o+WAJNkorIXbY3/PXZ+h4pekMr79nmUuooLLebnF+XD34a8
         lh0+9IiCIz54zVAaxey8jd2CptraQFaqN2Ui3MeM0UxJRC6IoUKeQ/y4ifjKg0nJmsCt
         zenOMENL/7Jt3eypEWErX7TpYc6AXwArQiH2UzgBzOlOEFl/sJ1z96AAaTuhU12wgFXv
         DpPLypQ8Yk4js4drbbPapwgjbHCQO0q8SpUd+w5S0gFzvAtG2B47An79CfgQGnQzXKAF
         sVAVIx3p03Oo5x0ePbvd8NdUkQoCIp27VxVQ0R/JXwwjTJnRKLlKvetnTWotPAOmomiK
         uTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kC4sLiWuy0LyCSyiHS0PVP02yjUvLp/5peK2DM8t9IM=;
        b=QQ8d1xIHMnxS4kU33AURxjedDCzixFtpwUMkc5kVvl+vma5zuaLQmElneeI2UStoCv
         z2KIZLDs8qmrBHW0+hlZ4fjRXP8nN+xKuY/GWtbr7L74/1S7PIWo5ralw66nd7eXfOmB
         e3Y1yBTk6o7u6gupkv0BZR2exd0sp+ug4vYNaKW5ewM7Vi5pg41IvI+MHg0g5BkEWaPz
         tL9z5qJLQaVQQy97LwcBzRzbeevMi9pNMSodg/qZDrfU8qNoUqKyL7fTkkPexk1ihDG2
         fRnYT+pxE7QHQtync1iQ6nu+/2Y+ofaRHhq6O/jCcEd22i+igE++b6av3XgFcUNo28xS
         kJLQ==
X-Gm-Message-State: AGRZ1gKgAZyyori+It/z2srhbgSsOc7ip5IkDO3OjPGZkYkSPwwEjzrB
        YMe/CqrqQX8Tx1IywXpq9eogVX4hKwAClw==
X-Google-Smtp-Source: AJdET5eKKLbgW9ERbHXfwHy4QgRYibMNEe2u6ZTyT24KabmUyJ3UweSxNCRzxpQYirKBIi1JUiDuBA==
X-Received: by 2002:a62:8a51:: with SMTP id y78mr12019341pfd.35.1542905364574;
        Thu, 22 Nov 2018 08:49:24 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id h134sm33933041pfe.27.2018.11.22.08.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 08:49:24 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:19:18 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181122164916.GA18733@nishad>
References: <20181116151740.GA12250@nishad>
 <20181116160622.GQ19900@localhost>
 <20181117071109.GA14187@nishad>
 <20181117154027.GV19900@localhost>
 <20181120094954.GC8089@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120094954.GC8089@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:49:54AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 17, 2018 at 04:40:27PM +0100, Johan Hovold wrote:
> > On Sat, Nov 17, 2018 at 12:41:11PM +0530, Nishad Kamdar wrote:
> > > On Fri, Nov 16, 2018 at 05:06:22PM +0100, Johan Hovold wrote:
> > > > On Fri, Nov 16, 2018 at 08:47:44PM +0530, Nishad Kamdar wrote:
> > > > > Use the gpiod interface instead of the deprecated
> > > > > old non-descriptor interface.
> > > > > 
> > > > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > > > ---
> > > > 
> > > > Always include a change log here after the cut-off line so we know what
> > > > changed since previous versions.
> > > > 
> > > > Also include the patch revision in the Subject (e.g. "[PATCH v3]
> > > > staging: greybus: ...").
> > > > 
> > > 
> > > Ok, but this is the first patch version that I submitted
> > > for greybus: arche-platform.
> > 
> > Ah, sorry. I thought this was an update of the arche-apb-ctrl patch.
> 
> Me too.
> 
> I am totally confused as to what is, and is not, the latest versions of
> all of these patches :(
> 
> Nishad, can you resend all of your pending greybus patches, as a patch
> series, as "v3" so that I know which to properly review?  I've dropped
> all of your others from my review queue now.
> 
> thanks,
> 
> greg k-h

Ok, I'll do that.

Thanks for the review.

Regards,
Nishad
