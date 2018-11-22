Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B716C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5537F204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2j009Bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5537F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394769AbeKVWLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:11:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39919 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387910AbeKVWLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:11:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so7070434qtl.6;
        Thu, 22 Nov 2018 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IdRUlzepGVP794x2pG8/yBQBYE/Pwsou7Ugr3tNBFLw=;
        b=m2j009Bdw8tQXnVJdFacgNyreVw0SrzBMxEsts8DjEIgoK4PMU9cJRVx1jnAYpYzFS
         auDDrR06Psuu5Wx82y+kXng3RITryJ/8MlWM6zkrpHDyrnCQuMUFSSDALXw1BYGuCeXX
         fczvIymy3fsHKeONg/l9iGI/arf5QNoJkpXexAnnWKd7cRCISSkKDv2HHX8u2JNYXa24
         evJ6Tu1ykcL9zVZ/Wth2SKqeH7cp1pDS7+xF8rxvk6CcrlhZVq9HnvbyHIg0KMil2Td2
         45ggRxGarenIf8sVdLCPpq/LrE9uXsk2kZ91+ba83baaA3xDNTgN0qXulSnGFiFdRLVa
         utjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IdRUlzepGVP794x2pG8/yBQBYE/Pwsou7Ugr3tNBFLw=;
        b=L/Y3/+QT2YpFSM7a1317jCYTL+gCYydiSLb6AdWHDSOMZbvejBH2hFlruXFNa4jVu2
         bEKAPNLvL6pYk5GbCjRRHc27Uge1oIamAxtcHzt8XqKrW1yCWpQlY38Uij3+baaVgbzS
         qZOSm87cpXy1qxAHyS0uQKXOSaX9A9br5NL5bjjRz2fGp8Q1rdmqW/+AJZywUJ3QRWsd
         UMPafWZiHdxpTIpZaAhng1wU9eInHFIJHHQVO6pGHNSI+6nWUOXBOS77wObXHmRyA9b6
         KXudhWUEsfSGzTrLTL4mMSuwrfnuytnM9rM80PBniCAU5yQL9ICsSdcvT/AaEApNl3f0
         aOAg==
X-Gm-Message-State: AA+aEWYqvrt+4b48ELXQjmE+RAC3vv4uUEH6y9Lva2QRWrWY2hA0iBsT
        jep8zZ9VVnGJuYFN8/6xoeVuwxkgpQ1dgYreOQo=
X-Google-Smtp-Source: AFSGD/WLDOys+b5eg5clnEXPkjd5mYxWRXWH83rlXXtxU+yjR4PhtZ5iE/HhxtDb3U3iFkkA7TavjlH9aCBkSLLL9io=
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr9780724qvo.26.1542886342512;
 Thu, 22 Nov 2018 03:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org>
 <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
 <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com> <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu>
In-Reply-To: <20181121181042.4gzuniz2vzjikpwc@cs.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Nov 2018 13:32:11 +0200
Message-ID: <CAHp75VfZ1bRjPGC2_Czu1iTxvMsyb6gCBn=og2j4z3=7JdUkmQ@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 8:10 PM Jan Harkes <jaharkes@cs.cmu.edu> wrote:
>
> On Wed, Nov 21, 2018 at 06:41:13PM +0200, Andy Shevchenko wrote:
> > I'm not sure how you managed to miss people in this list (perhaps by
> > default you have suppress all Cc in your Git configuration), but I
> > guess we may gently ask Christoph to apply this in case Jan will not
> > appear.
>
> You have got to give me a little more than 10 minutes to respond before
> assuming that I would not appear...

Problem is, AFAICS, Sam's initial Cc list was not fulfilled. As I
guessed it might be configuration issue on his side.

> I don't think I've ignored any
> previous emails on this subject and the only issues has been some people
> not receiving my responses for unknown reasons (agressive spam filter?).

Personally I didn't get this one (Gmail "clever" spam filtering).

-- 
With Best Regards,
Andy Shevchenko
