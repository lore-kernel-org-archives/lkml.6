Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A984C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A65206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RtJ10vbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391666AbfAKOvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:51:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39388 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391569AbfAKOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:51:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so13302267edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 06:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2i0ppf7CAf/jvrh/jSQZ36qIB3g7wMRHadBL6BmbMc=;
        b=RtJ10vbmpx00ZwzDrjlYyrC1b7KiYEnG5wqwVfpOBzjaLADR+S0Jw+fp6xxSNByyEg
         4rE3CEjMdSzGMm6og5n4SBMzNlo5yS0BGox8SOeWAJgNU60YbwNE8Q91hu5l+fWrTRV7
         X77xfZOQtqW7KFEP/J7ndnMgB7svmdO6jK2jD6Qn7Tivg0exdSCvA1YVYbDLMKq/zg+Q
         SZoAgSRXwmE6lWVuykh0w8oGBKwqpUGoPkMx1ZbF2+yvDGhAt7AhxdUjZY4ehTu9H9mM
         RHGtgi7f4GVFFuwn4BumNYQVIvbvZtKUJIv3R64kF8gko7zUc6VUk6IP5xZRaZ9xBmVu
         KOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2i0ppf7CAf/jvrh/jSQZ36qIB3g7wMRHadBL6BmbMc=;
        b=GfYLDx8E8cTw9FOwE+yGpu6n2xRXEzwP2GYtebSUY7QPw8us/yXl9Mcwc3hLS8RHnh
         di6f6+v+jJ+dkKRklvclRlxugD09YAdDzY7m/kVdurfoLNM9A7GdZTne0PeBLsAmwvj1
         WTUMZhcuGAFQxaKJlWAvJN5Q+M8BIEfWjP8IvIdWUzv1/aAB496M36O3q9AZVVrEQ4mV
         eWKUxuVt+aLGcZWtOlqr8AZomggtZySXCANmFNJH+P4t3THg+Om/cucOIKChYSn+tIbL
         913+5BoU4E1ZHSGomVCDW3tgznbmP8qr5LCeLziRvZz/B5nn0Fn3HqdMoXhYReSXELCy
         aqpw==
X-Gm-Message-State: AJcUukfBS++UnNrC5b1M8Z0HoR7LKH30Ja+ER7Vkvp8zgXrn38QsTg98
        S28WQK0D3pVpQsyj/7Ns6NlvaA==
X-Google-Smtp-Source: ALg8bN6jvQn14MmlxYxtjZkhYk8ItEPBz52Vmh9bdpdnNI7fFFwMOjgGMYXf+O/uv3lx8BXjXhC5Rg==
X-Received: by 2002:a50:a395:: with SMTP id s21mr13934696edb.1.1547218303692;
        Fri, 11 Jan 2019 06:51:43 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:2520:8b:922b:4c43])
        by smtp.gmail.com with ESMTPSA id x58sm2330754edm.10.2019.01.11.06.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:51:43 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:51:41 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        akpm@linux-foundation.org
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20190111145140.lbmiz3w2f255uf65@brauner.io>
References: <20190107222700.15954-1-christian@brauner.io>
 <20190107222700.15954-3-christian@brauner.io>
 <20190108070110.GA7998@light.dominikbrodowski.net>
 <20190110145004.zhc2t42aasni7wnq@brauner.io>
 <20190110145559.relfx37ocq5xu4by@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110145559.relfx37ocq5xu4by@isilmar-4.linta.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:55:59PM +0100, Dominik Brodowski wrote:
> On Thu, Jan 10, 2019 at 03:50:05PM +0100, Christian Brauner wrote:
> > On Tue, Jan 08, 2019 at 08:01:10AM +0100, Dominik Brodowski wrote:
> > > On Mon, Jan 07, 2019 at 11:27:00PM +0100, Christian Brauner wrote:
> > > > @@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> > > >  				break;
> > > >  			if (neg)
> > > >  				continue;
> > > > +			if ((max && val > *max) || (min && val < *min)) {
> > > > +				err = -EINVAL;
> > > > +				break;
> > > > +			}
> > > >  			val = convmul * val / convdiv;
> > > >  			if ((min && val < *min) || (max && val > *max))
> > > >  				continue;
> > > 
> > > This is a generic change which affects all users of
> > > do_proc_doulongvec_minmax() that have extra1 or extra2 set. In sysctl.c, I
> > > do not see another user of proc_doulongvec_minmax() that has extra1 or
> > > extra2 set. However, have you verified whether your patch changes the
> > > behaviour for other files that make use of proc_doulongvec_minmax() or
> > > proc_doulongvec_ms_jiffies_minmax(), and not only of the file-max sysctl?
> > 
> > Sorry for the delayed reply. I did look at the callers. The functions
> > that are of interest afaict are:
> > 
> > proc_doulongvec_ms_jiffies_minmax
> > proc_doulongvec_minmax
> > 
> > So this could be visible when users write values that would overflow the
> > type used in the kernel.
> >
> > I guess your point is whether we are venturing into userspace break
> > territory. Hm... We should probably make sure that we're not regressing
> > anyone else! What do you think if instead of the above patch we did:
> 
> Hm, I prefer the original patch -- as the same (valid) reasons which apply
> for the file-max sysctl might also apply to other users of this function
> where extra1 and/or2 extra2 are set.
> 
> If there are no other users of this function where extra1 or extra2 are set,
> just add a comment in the commit message:
> 
> 	While this changes the behaviour of __do_proc_doulongvec_minmax(),
> 	no other existing users in the kernel are affected by this change.
> 
> If there are other users of this function where extra1 or extra2 are set,
> you would need to generalize the commit message overall.

Andrew, can you please drop this patch

[RESEND PATCH v3 2/2] sysctl: handle overflow for file-max

from your tree (It should be located at [1] from what I can gather.).
I'll resend it based on Dominik's observation and will generalize the
commit message and also error out *after* the conversion has been done
and not before.
The first patch 1/2 is correct and can be kept.

Thanks!
Christian

[1]: https://www.ozlabs.org/~akpm/mmots/broken-out/sysctl-handle-overflow-for-file-max.patch
