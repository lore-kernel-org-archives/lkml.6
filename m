Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90003C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C68221A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9JIPWaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C68221A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeHFNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:45:21 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55346 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730245AbeHFNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:45:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so13463036wmc.5;
        Mon, 06 Aug 2018 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LPHI3IEQyYtaUcBBSRaH4Q8GPGi6S2O8Wb5ShdvyMJM=;
        b=s9JIPWaDt2+m1jztU6XWSYsznG6Kt0XX3EwSg4hcrWSfNRxaOUQKN+1MICK0lsRftb
         R/5xv9tJDVsftSwAGj6BCOgPIVbU6UEcrdAGV3eAOF/xCEpMH3jW/IX/F6eIYdUhL1Ij
         Bh3lXzQ6dnMiNRk6zxMEKURYYKkJZtpCcnYY6HngF3IFAYxR3XGNKYgqGJCx1WlUW2w9
         GTK5NhoUEyDXJb44y6X/l+0GSS9zyuRWEnSTxfXQfSj4W7jC1c6z64wp+Fw/GYk//f4E
         bLGtw6o0Y4OTf0IsrEkXM6TWdbR43DS4pRHvjG5eQprjo/S4KJuhgVZ0TGsF+9ol/TVd
         SHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPHI3IEQyYtaUcBBSRaH4Q8GPGi6S2O8Wb5ShdvyMJM=;
        b=dPUg/CWMxojMfXkNR69NjvuD3W2Q4lRGvKS6LXtsQYC1/hQICYLQOCWFIZiBpufgzp
         mXMShF7RGHaCF0DL3MxZkV/jIZ/ctM93ZPn++kIIGDdev4Ftsc7QWbRkqE18+4gGMKau
         TPNhWPFSRq9HccZfuf/4xh0tFcruk9BvhAN+62uoqqtIDAJaC4Yc5PjrN9dlQiV+pBsS
         JifVFC1ZtVqETdoczmaAn1Zf6Ete3l34pF9h1WptnH7NP9TKR/Dpwigmm0GUWyIHCtDf
         xs9panlh/Ub27GMm82qLP28s27y36KakIZBsYYUmgaoivR9pKlEdV1oOBTPEnphD/ydn
         NYGA==
X-Gm-Message-State: AOUpUlEfvudiACDL9qS2JuSANRRib9J51L0Gr7UeSfpYs8WB/qp8W/d0
        qolNwStMpPpMt/d9+xVoR+0=
X-Google-Smtp-Source: AA+uWPy2xPtEvqYGpLCqth6AeY0xqBzM3nEb+75Of+Kd+xv3F68RqJWyqbTAroL2cphcVMNKDx3cpg==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr1614294wmf.161.1533555394538;
        Mon, 06 Aug 2018 04:36:34 -0700 (PDT)
Received: from [10.10.14.115] ([91.199.104.6])
        by smtp.gmail.com with ESMTPSA id 31-v6sm21228337wra.26.2018.08.06.04.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 04:36:33 -0700 (PDT)
Message-ID: <1533555392.28014.25.camel@gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
From:   Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
To:     Darren Hart <dvhart@infradead.org>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        andy@infradead.org, platform-driver-x86@vger.kernel.org,
        Mario.Limonciello@dell.com
Date:   Mon, 06 Aug 2018 14:36:32 +0300
In-Reply-To: <20180622232730.GA27466@fury>
References: <20180620213141.GA8957@beast> <20180620233736.GA3250@fury>
         <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
         <20180621001721.GB3250@fury>
         <3974cbadd027497982b5a52c765fb698@ausx13mpc120.AMER.DELL.COM>
         <20180622232730.GA27466@fury>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

On Fri, 2018-06-22 at 16:27 -0700, Darren Hart wrote:
> On Thu, Jun 21, 2018 at 01:24:34AM +0000, Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Darren Hart [mailto:dvhart@infradead.org]
> > > Sent: Wednesday, June 20, 2018 7:17 PM
> > > To: Kees Cook
> > > Cc: LKML; Andy Shevchenko; Platform Driver; Mihai Donțu; Limonciello, Mario
> > > Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
> > > 
> > > On Wed, Jun 20, 2018 at 04:43:14PM -0700, Kees Cook wrote:
> > > > On Wed, Jun 20, 2018 at 4:37 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > > > On Wed, Jun 20, 2018 at 02:31:41PM -0700, Kees Cook wrote:
> > > > > > The probe handler_data was being allocated with __get_free_pages()
> > > > > > for no reason I could find. The error path was using kfree(). Since
> > > > > 
> > > > > v4 of Mario's series used kmalloc:
> > > > > https://patchwork.kernel.org/patch/9985827/
> > > > > 
> > > > > This was changed in v10 to use __get_free_pages:
> > > > > https://patchwork.kernel.org/patch/10018023/
> > > > > 
> > > > > But... I'm not finding the discussion that led to this change.... Mario,
> > > > > do you recall? Something about contiguous memory? We had a similar
> > > > > discussion on an earlier series:
> > > > > 
> > > > > https://patchwork.kernel.org/patch/9975277/
> > > > 
> > > > FWIW, kmalloc gets you contiguous memory...
> > > 
> > > Yeah, I'm not finding a valid reason to use __get_free_pages over kmalloc in
> > > this case. I'll give Mario a chance to respond in case I'm just missing
> > > something, but otherwise will plan to apply this patch.
> > 
> > I think it was for contiguous memory, so if kmalloc is giving that I agree
> > no need to keep __get_free_pages instead.
> > 
> > Acked-by: Mario Limonciello <Mario.limonciello@dell.com>
> 
> Confirmed, kmalloc in physically contiguous.
> 
> Queued up, and tagged for stable. Thanks everyone.
> 

Would it be possible to queue this for 4.18 or is it too late? I just
noticed it has not reached 4.17.12 either.

Thanks,

-- 
Mihai Donțu

