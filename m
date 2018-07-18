Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23389ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O3i1u5Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeGRSPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:15:06 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44479 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbeGRSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:15:05 -0400
Received: by mail-vk0-f66.google.com with SMTP id 125-v6so2926691vke.11;
        Wed, 18 Jul 2018 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FGK/ZoAFfyL0Roxt3qwwrCKC+MZZbpLflgiJfbRVq9E=;
        b=O3i1u5Ha28JuBidX3wiyUzNfY0F5n/exoEAA9OmlzGkFyObkZnEsH9PumZ8uShuTLV
         KTxRp6bRxlKdP4sYewYE9Rad/i0kTLxDyW9MKa9TBB6iSxxYK4ImtsiQERobZsssDdyu
         EguJI2JoHWai3cGqzqWYr4Nl5YKoU1OChxlLv5JSn8qMTegUL02FXdYvsczIYBK27ji1
         XUjinG6O3Wkm9pjJ3uUk5xWFVYSCrgfhFyPoXC2hT775ckvE40wdiqTUkIHxhyExrYgM
         dna543IXkcjonq7hzaMKvJfLQPTTUdaNP1qRf+mdt43kPqjqU4FH3hVn4w5k6OfofAQO
         tK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=FGK/ZoAFfyL0Roxt3qwwrCKC+MZZbpLflgiJfbRVq9E=;
        b=G+jG1dqMtGw5A4LAHVSH3ivTVz/KZJeGUwszl2bc0ET0poicy1wOqO0suITIBP/oqg
         maV2R8gmtliXshqJXLJkVnyqzZDueLji3frlPySbSKRd3BgMdfaQiZupHjzDhnKB1yJ4
         OFggAH5okA/IzogXanXfE1RtRHwiskLJOPVet/CGBI8uNjNx66KirLFoVdwIjIZa8pNK
         S2ta0zmwmokZSP6nDJW8muC8pKVfJAQHN/UdLwWItXToMgzWlAps7S9+3I3blQI08IvX
         oDFdjmQZA4RbQJMLhkaO8bwY3FRgRk5jG89DrvYgkkKUbE2m0XZOtX7tO079tOls12PD
         0Fcg==
X-Gm-Message-State: AOUpUlErgmykMSpho7guxK+HkgrvGcd/Fe++2haGT707/2mUuZ+L8EoP
        WLaOHA5jQhwa1VJZaamGmcqELCUUQGv3kcQMnac=
X-Google-Smtp-Source: AAOMgpdWZVlvYq09JRGJ5UASBfv/Y5BGXNiax9bM6UxHbkpgyyuvdInY1txImuVe6STfoOmviThfgUNXt4EnnwpT7Ik=
X-Received: by 2002:a1f:19c8:: with SMTP id 191-v6mr3897430vkz.162.1531935369433;
 Wed, 18 Jul 2018 10:36:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:d012:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 10:36:08
 -0700 (PDT)
In-Reply-To: <20180718015154.GE3489@thunk.org>
References: <20180718014344.1309-1-tytso@mit.edu> <20180718015154.GE3489@thunk.org>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Wed, 18 Jul 2018 18:36:08 +0100
Message-ID: <CANVEwpY2H+OBnYNAf15bRRbmepFCerWrisLiLQ=h3+_692MY7A@mail.gmail.com>
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 02:51, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Jul 17, 2018 at 09:43:44PM -0400, Theodore Ts'o wrote:
>> This gives the user building their own kernel (or a Linux
>> distribution) the option of deciding whether or not to trust the CPU's
>> hardware random number generator (e.g., RDRAND for x86 CPU's) as being
>> correctly implemented and not having a back door introduced (perhaps
>> courtesy of a Nation State's law enforcement or intelligence
>> agencies).
>>
>> This will prevent getrandom(2) from blocking, if there is a
>> willingness to trust the CPU manufacturer.
>>
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

(Apologies if this is a duplicate reply, I misread the tiny text in gmail a=
sking
me if it was ok to send non plain text (dunno what caused that), so I guess
the first version went to /dev/null, at least as far as the list is concern=
ed.)

On my haswell, since 4.16.4 and the corresponding 4.17-rc. my (sysv)
bootscript to start unbound hangs for a couple of minutes unless I use the
keyboard. Same on my kaveri.  Those both lack spinning rust, but on two
other SSD-only machines (ryzen, phenom) the security fix did not slow down
the boot.

So, since I've got better things to do than _worry_ about than whether my
government, or yours, is spying on me, I would prefer to have the option to
take the risk on the machines that will then boot faster.

=C4=B8en
