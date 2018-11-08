Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2612ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FDD204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTfHpvj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FDD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKIGUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:20:05 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44326 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeKIGUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:20:05 -0500
Received: by mail-pf1-f182.google.com with SMTP id j13-v6so9824780pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 12:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOJXW1uWbsQNHAIwh39a5IFzYLnntdwn3DbyVSi29Iw=;
        b=oTfHpvj+We/KinuHO9Hg4YFoZ9CHkF/C/qkDI2huzLPL+CX2MI0MfE1J3IamstNVkc
         MaN/KhDu0ae6RVb4lisGyMsWJa0MeTa6Xm4+dK/+vTb8Kipi2BX/rdKlWFXSpO4W5vfG
         xrO25kdKxqWqjn2KcjnJdyI1PTcSgqcCm3BLVtJ7z1u8oO3QaEujPiqTsIgSVcVgpW/r
         7qiZnWeOpaF0z+/eWzq5/7NEXU+gk4wGULYbP4SjMISE7hEZG74P4B1mfb9wToWyrRil
         zpywVfJyl9lVnpTm9S5bxKAE7Sycx+PUMOGiBB2lthd3RoNezQB9MVyhXjd6RBj7zm9Y
         RPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOJXW1uWbsQNHAIwh39a5IFzYLnntdwn3DbyVSi29Iw=;
        b=FjNkPttYcC3pvCmbVjf0C9auzefG4h/tqb8UJ9Puc8Xt4TpmaTIjfC3HMWBh2bXS/2
         oWfHMNdlNqLtzw70bxHulY/n/4H8t4oP0FGZDd7w65qo+BUzj9HXrzFvhXq/fGKSih6I
         43AKvF26aTh1uIGJ6WhN1FDblieXpPi9eqjlptFcp/MdyC3bvQTckyI1esNfXY9OC51E
         cSTu44jLDp23yFvJS2BZp5o6abMk95OTDBij0bVxSxBnTf4tcTHODM7+WM4vldohxFjG
         QxrcSO8yJGnp7N4U88BWTUmzMTBjWoG9hz/V63XZVzxgap/618IP22zHd1nVTBDRdsi8
         0z0w==
X-Gm-Message-State: AGRZ1gIVOiFPjjQ3d5ziVI46ZxcAe/EM+IiDllrhkLBjuu8OBOWZLrB+
        rRe0BP24IZ5BzjuesugzL2Zf9yJv0bVHxB5qnxlyjQ==
X-Google-Smtp-Source: AJdET5eTioCsvze3KwvgZuo/BHMRLqje35TyKHSEKgvJ4fGE1lysVu5BibkCb9pKFPXAfSHC63OhmuVYTeBPU0z0pfs=
X-Received: by 2002:a63:e156:: with SMTP id h22mr5038317pgk.255.1541709773111;
 Thu, 08 Nov 2018 12:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20181013010348.6740-1-natechancellor@gmail.com>
 <20181023175309.GA3384@flashbox> <CA+icZUXsS53RANWBNWw7_HcRRGyzVW1EepBU-K1pumrue6bYtg@mail.gmail.com>
 <CAKv+Gu8eJxLcNkvSzzKf0P+gjhtGRdLQW9J+gcDRhhGCi-pHJg@mail.gmail.com>
 <CA+icZUUK_B-_Brdr7LpiexEHJTytquhKN+4uidc+GmyMkJN8Og@mail.gmail.com> <CAKv+Gu_JdioRGRM5DiinK9a+2koK-NZLa858OAdap9PGe8vCtA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_JdioRGRM5DiinK9a+2koK-NZLa858OAdap9PGe8vCtA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Nov 2018 12:42:41 -0800
Message-ID: <CAKwvOdm5wv-DLqSYSq6NDTrKezTfS_DJXgcAmTcrX8ejpf7bsg@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: Disable some warnings for x86{,_64}
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     sedat.dilek@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-efi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 6:16 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 6 November 2018 at 14:15, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Thanks Ard.
> > This means efi-for-4.21 / efi-for-5.0?
> >
>
> Yes

Thanks for picking up this patch, Ard.  Is there any way to get it into 4.20?
-- 
Thanks,
~Nick Desaulniers
