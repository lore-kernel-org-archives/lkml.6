Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77735C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0BA20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 14:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndqn/TIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfBWOfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 09:35:23 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43831 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBWOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 09:35:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so2425528pgq.10;
        Sat, 23 Feb 2019 06:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jreQ4oJvszilQdA+htxMf10gDFJmou34hWKtvLti/o=;
        b=ndqn/TIAP7K/jXIQjZhTljD3u7XawSqvj44hMY1J5fOdWN7Xz7cw9DrsWlAIdYvlmL
         aXT0tavhSOb7cK6HQMq/SxqLyZMgI/Anro1ETYH5IFT5Je6l0g05oBicf5vbcW1mpfWS
         n6sK074oSm6YR6cXbIFmxl/QV7/UZbS0DVBE9kRUPazc+y1Psx0KTE2fhafmQF2IynKr
         geCrRHCPswNNU0ObTYsC/n5j/yM55i1wE3RWkxZpa3QJbB+E5A5NFg9hYYAbWfBNA+Ku
         giIdbFNgtw5lYcnwaqhslsUZQ1AzQ8WOCZbFA3Zkj0ktZ/UFhY8Nx1azrX6JZSEudcqg
         lrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jreQ4oJvszilQdA+htxMf10gDFJmou34hWKtvLti/o=;
        b=SRM5Qjvz1wt2tueYpRlInJeHq5b2HK02W1N/2GEQqVYavR+Vs4zDro9/ypfWyYnvls
         fRBniWAD7+GqxySbH4eAwtkpFeGnqPj5V2D6H29e0tfwdO1njnDCwtA7sFVq0cz/F/tG
         fqAPJ8nv85uAxMpV6iKoaw7oO27wDWg3WUEbqMs+Knz1Ks0xcyXEx3uBobWeDaW8IWQI
         majGoAd5KeIkLYieyDI4kUPFajwLdtVHqaKDFAHY5okEzgCP6OqV0Vkgq8tirNLReQux
         Tb1y0M5lMDHe1irVKq7l1aJ1FmS3X0ACBBhXZya9Dfz1rmi8e/jZRgoLlafyJNABHHHz
         pY/Q==
X-Gm-Message-State: AHQUAuYsRijR60fOFz8T95D93qjH+7X9Psy7xrkmRGVruYV2CF9GbNwm
        AoDhGJ7OTGKBg0+bpoW5y0dqXnRik6z4IuMtOnA=
X-Google-Smtp-Source: AHgI3IZPjECKZlUv+hM8swavgxJ4ZDAqFXnD5o50PLSGQEvIHU1+qJuowwFKqH6/wZuK1qB+n8y5Ojgjz38kxduNYK8=
X-Received: by 2002:a62:41cc:: with SMTP id g73mr9495543pfd.145.1550932522161;
 Sat, 23 Feb 2019 06:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20190222104844.1847-1-Tianyu.Lan@microsoft.com> <20190222143220.GA12675@kroah.com>
In-Reply-To: <20190222143220.GA12675@kroah.com>
From:   Tianyu Lan <lantianyu1986@gmail.com>
Date:   Sat, 23 Feb 2019 22:35:11 +0800
Message-ID: <CAOLK0pxXNpL+_HV7TwAkquyfkGUNxmwLKkVcoVApZb7dG0DQ=w@mail.gmail.com>
Subject: Re: [PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        devel@linuxdriverproject.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, michael.h.kelley@microsoft.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 22, 2019 at 06:48:44PM +0800, lantianyu1986@gmail.com wrote:
> > From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> >
> > The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
> > is equal with how many entries of union hv_gpa_page_range can be populated
> > into the input parameter page. The origin code lacks parenthesis around
> > PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixs: cc4edae4b9(x86/hyper-v: Add HvFlushGuestAddressList hypercall support)
>
> Please use this format instead:
>
> Fixes: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
>
> And don't type it by hand, use a git alias for it:
>         git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"
>

OK. Will update. Thanks.

> You also messed up your To: line, keeping anyone from being able to
> respond to this message who do not know how to hand-edit the response
> line :(

I put all expected reviewers in the Cc line and will put into To line.

>
> thanks,
>
> greg k-h



-- 
Best regards
Tianyu Lan
