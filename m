Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78792C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D789222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfA8Zpmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390205AbfBMIBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:01:41 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54384 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732831AbfBMIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:01:41 -0500
Received: by mail-it1-f193.google.com with SMTP id z9so1840654itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+gdoNhEYfSnrNFLACQuVQ3Mm3XkFfdwd01sBF5cnmw=;
        b=mfA8ZpmwtJTf9uxT8YQFa/vP9dxiJ8Y95QHXpsqJgU1KijxBqYLQHTY+bhn1TE/dsq
         cwN001ot4TsuCZfp9hZ+kBQIsiI34RBV32evQssy4IlSKUdUKZmr3oAX910eResIz6pp
         70EL+6DhF4pIjAPMq0VmxJVCyDA/YAaurlB5L8htClc9gzdtxs6tJesFeCczz33+2t3e
         9nw9HxM098F7zLNbaiSkLtLWugyIhAumWdcXiPhJgB5E5Ww4XxCnpr4g5nVlycXHZMda
         C2CFJHgeOdrh0/vFBytMclHl7Itd9ysi62A2WDmF7bQe7c/nzQ/NHXz60II1fzeRBSm0
         lH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+gdoNhEYfSnrNFLACQuVQ3Mm3XkFfdwd01sBF5cnmw=;
        b=szsKDemFpU+eYahGpWAy55/D856VwYjNPW7eDXK2t0umWVy4ppxdfxEthynSw0rtdO
         uayb0NzajT+77MxV5L3VKYbYgjfATAks8mHc+dVprnaWVEV6WLmJf+HQgyNLtc9l1l18
         377Q4kndJhgy82rtdzypqA1mFhB+ZiyzElgLF/62YQTd5AkxLNz2z/BLeBixQpft+qdo
         nB2gdiEibvoNZDdCdYibTkGTZFB8TBefd2QFmHwy/h5dlCn/i5I4hfnpl29RCYCrmtVb
         pkPMAVskc9R54TJQq48YuR3KHCUR+uE18j7tBXkFPjQvMwDr/iAuODqc8n2/8RYDOEV5
         /SuQ==
X-Gm-Message-State: AHQUAuZaoWuQ8ZKqRtvtGDXLfeP4wJTfN52i0BU3iM8r/+fU4WoFMSZa
        KEyZttOAfyM9iCOnMkHHPPwueIE82hTn7RI9/kmpjw==
X-Google-Smtp-Source: AHgI3IZSo55LRYHZ9EU5E0Zx05rmTFKpftCO9phe52l1Y2r3xvc4ZiHYpqYCyyqmo2ci5W/sl9USwOUffEP7rDL9oq4=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr4818151ioj.60.1550044899964;
 Wed, 13 Feb 2019 00:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain> <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic> <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
 <20190211112009.GE19618@zn.tnic> <20190213015429.GA12592@localhost.localdomain>
 <CFAC8B79-54C1-4E74-8660-31B0B88BF749@alien8.de> <20190213075825.GA1624@localhost.localdomain>
In-Reply-To: <20190213075825.GA1624@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Feb 2019 09:01:27 +0100
Message-ID: <CAKv+Gu9WWKZtgtdwv0y8giieiwzuKHdZ0Qaa2UA7WXZRkcEJNg@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in boot_params
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Boris Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        caoj.fnst@cn.fujitsu.com, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 08:59, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Wed, Feb 13, 2019 at 08:36:12AM +0100, Boris Petkov wrote:
> >On February 13, 2019 2:54:29 AM GMT+01:00, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> >>Yes, your PATCH really works well. I tried both efi32 OVMF and efi64
> >>OVMF, all boot.
> >
> >What about the real hardware you are normally testing on? Boots there too?
>
> I testet it in a real EFI machine, it booted, but from command:
> > cat /sys/firmware/efi/fw_platform_size
> 64
>
> We can see it's a 64-bit EFI firmware, and there is no 32-bit EFI firmware available.
>

Did you try booting 32-bit OVMF from 64-bit QEMU?
