Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5BAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF2A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cfbqAIGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF2A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeFTI7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:59:20 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:50518 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbeFTI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:59:10 -0400
Received: by mail-it0-f47.google.com with SMTP id u4-v6so4393902itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RG9/riHP9Ot2rtL5IhT+XtLfzMMpBWt6m1/S5JBL+a8=;
        b=cfbqAIGkeMwUPBdSc4n01ABbAlVVxh4XD7ZJlt55nJmJbIF4W0oCFpqwqr4PYvjZlO
         Lwj5lEBRC9ZEi8oW6igj5+bkDLTmKQXGZZxGKaxYRjjJDTWx6qxXfHUXsTUku3hLDK+g
         SRpRFN7kzdTiSGmYGrqQmwkKxDCNX9EYF0XTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG9/riHP9Ot2rtL5IhT+XtLfzMMpBWt6m1/S5JBL+a8=;
        b=WtWGiJBPmK5rqdCScXkO8n3BYagLN/98UaYpixu0FTZjkcGg6ulEX9+4rvMcp4wFxM
         fNIl1kUNxNkgrg7Je+0Nf8RmU05Ir50bKWckuG/ac/CqbrXJIQ6sUxB9nBB1/gEzkRea
         GMQ35xTnDIEiOZvUoVf+UYVM9q/v0dOJHV9988b+cj7Ph5ZGM1Ycp1D2gdPo1okJS05Y
         Ddet9t2rbnlLdS9MgHPi7WyTtmH8FBAw2hxbwQ/asEdRZvXGgY/JwlK2Ca8zv/W2OBOP
         WafaPK6Pdb1agGW0nDeO9P4T6Vi2HCkFIxDKlgSfY2r1HztnUk7DgRan67Ws+7d7SWYX
         K9TA==
X-Gm-Message-State: APt69E1o1CIvwl5UDRLb6dksjVyYz3sJbpyHAdo7rWgbDMVDQ2JekUqx
        ElfQiXYWNK2Dxn6g1+SDvwi1mbjgCuhpiuvxpCDyFG1k
X-Google-Smtp-Source: ADUXVKIieidjYIEcCdNIO9ITqX6FvjfRGXti0cM/dCIw6TT/S6WYi57+h1+Ep3jURH4MaAJbQ/aCHROCYMI/83qdInw=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr616317ita.113.1529478755121;
 Wed, 20 Jun 2018 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1806191356280.6203@cbobk.fhfr.pm>
 <CA+55aFx1o8+ZTAqVQNH7Wq8tm90XYTUEx5By2wWo3KJDR3g2MQ@mail.gmail.com>
 <nycvar.YFH.7.76.1806200611290.6203@cbobk.fhfr.pm> <b952c1f6-5866-d25e-32c2-ac0ded1812e2@redhat.com>
In-Reply-To: <b952c1f6-5866-d25e-32c2-ac0ded1812e2@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jun 2018 16:12:24 +0900
Message-ID: <CA+55aFwCt9WZoBHEbsR65h=BRJ-GhqwWgU87wd2o4A_TzxQW2Q@mail.gmail.com>
Subject: Re: [GIT PULL] HID fixes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Julian Sax <jsbc@gmx.de>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
>
> Julian let me know if you need any help with this,
> to format the HID descriptor take a file with
> the raw descriptor in binary format and do:
>
> cat descriptor.bin | hidrd-convert -o code

But what is the *source* of this binary crud?

Because no way in hell do we take binary crud from random places, and
then add it to the kernel.

NOT EVEN IF IT WENT THROUGH SOME "hidrd-convert" PHASE!

And yes, now that I google for that hidrd-convert pattern, I see that
we already have other broken chunks like this.

Not ok. At least some of them seem to mention where the data comes from, eg

   "This is the original report descriptor as reported by lsusb -vd 046d:c294"

but this one has no such information.

So guys, you need to think about where things come from, and document
how some random garbage came to be. Not just add it to the kernel.

                     Linus
