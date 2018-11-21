Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA14420672
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gPn9b2/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA14420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeKURdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:33:50 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30033 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeKURdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:33:49 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id wAL70PxS009174;
        Wed, 21 Nov 2018 16:00:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com wAL70PxS009174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542783626;
        bh=uQUc3efkBE2+JzdfGzSWPMSXUakNoKFvRV5MKpjz8K0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gPn9b2/G2OYUNpyxaQfOrI4TqBpt/+bbXjAjNhrG9sh8/M/4kbiY56nfPQITwA4mM
         oVCDkI01ZI3HdVXAqFYIQVDsm5CprIV/42WTorAIBx83F72B4AG1Pa2he37TuLsic1
         LvmODq/WEoE88OT6/nogiiEkHufrKeMSy9aWbUWzK+NdvwfW2xL5SK/10RdkkRyAZA
         QLINnZZmDpN/vR5EMQesSIolw7OAU4p4mdD4Fm/bk5HclIXPXjWXOGNzZQ/R6oNsyX
         g+dCqVPymFlcdSQhzbv9Iga5QtjIloXBLNeEXSJT7lKJM4eKpYvsbqK2eCBVAjPCg9
         174R5KQYEpc9w==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id p9so1563214uaa.5;
        Tue, 20 Nov 2018 23:00:26 -0800 (PST)
X-Gm-Message-State: AA+aEWYP0kfOVwcAXZWezZYH0FUL0FEsy+0E7JDZDA8ncF24Yf30dWYe
        6yBWJDT1n65QvcpfMAJLy+S5O0odNghiZwEx3xc=
X-Google-Smtp-Source: AFSGD/UvJyeKJsOPGYd8mtDkCzoJQ9VmZi9Lu2tTm+EVkxSQj/UduxRXtziJnKVjgEvE8aCJyuIRj5DtFk+xbG/bfZE=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr2326747uap.6.1542783624937;
 Tue, 20 Nov 2018 23:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20181120144007.016e4998@endymion>
In-Reply-To: <20181120144007.016e4998@endymion>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Nov 2018 15:59:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATyF4GvvoMz0FphfBu739Qvy7L1KzdFcNyj5HhFsYK53Q@mail.gmail.com>
Message-ID: <CAK7LNATyF4GvvoMz0FphfBu739Qvy7L1KzdFcNyj5HhFsYK53Q@mail.gmail.com>
Subject: Re: Backed up kernels
To:     jdelvare@suse.de
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        martin.wilck@suse.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,


On Tue, Nov 20, 2018 at 10:40 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi Masahiro, Michal,
>
> When I run "make install", if a kernel by the same version number +
> flavor string already exists, a backup is created with ".old" appended.
> Over time, this adds many entries to my boot menu, makes some package
> updates take much longer (e.g. when all initrds must be regenerated),
> and ultimately confuses grub2, which fails to find the matching modules
> directory under /lib/modules.
>
> You could argue that grub2 could be fixed to find the right modules
> directory, but in fact there is no guarantee that the modules built for
> the new kernel are fully compatible with the old kernel. Keeping a
> backup copy of the old modules is also not possible, because both
> kernels have the same $(uname -r) and therefore the modules of both
> kernels must live under the same /lib/modules/$(uname -r), which
> collides.
>
> Given that, is there really any practical value in saving a backup of
> old kernels? I'm doing kernel development for 15 years and I can't
> remember ever booting one of these ".old" kernels. If my latest
> development kernel doesn't work for any reason, I will just boot back
> to the distribution kernel.
>
> Therefore I am asking, can we change "make install" so that it does NOT
> create a backup copy of an existing kernel?


I think your suggestion makes sense,
but "make install" is basically implemented
by arch-specific shell script.
(For example, arch/x86/boot/install.sh)

Will you talk to the maintainers
of architecture you are interested in?

(or send it to linux-arch@vger.kernel.org)


> Thanks,
> --
> Jean Delvare
> SUSE L3 Support



-- 
Best Regards
Masahiro Yamada
