Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A9C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E7E2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt8z5qjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E7E2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIFCuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:50:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34746 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIFCub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:50:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so4127772pgv.1;
        Wed, 05 Sep 2018 15:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ex08hm4w9nAx3zvUGW9GbVESQYtyOd1a270dkRQLd/g=;
        b=Pt8z5qjgnJWUL3E0RZxB7aBaRkZigpA9QyX/IDYQwO7uoX/Q4gUDlcKvKJytvWTDR6
         YSvPJKwqQY02sICaZc1QFTCajPVKxieP04AcSgaSbW8L8nSLxTE/GnO4PrYJQIuo43RZ
         NK4H/MaIa5Z5MG+tx1ZvKPrSTnKmFzA7XlzMUmnwBx2IyNPayiPz672KY8PCWFdT4FWQ
         Wq0b+Ybtmux1Qer/FcUbovykmxpTgqriYE/0ClvGLNy31rM2uGL/obyPyVswxu7gkfPn
         SzhxDYZvinWUOG+Iyv+++oIAKyvxXljhlmn1/nK5eOWNYrIKHB3OO8OFTu7vh095rbZ7
         iR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ex08hm4w9nAx3zvUGW9GbVESQYtyOd1a270dkRQLd/g=;
        b=QjUA//RwGFzfSfOdIGhhalr4kHD+gPjbn9Cep1lUShEZQj9Uf+dw4vj8Q9TkYWCtJn
         ULPCQQYQsK0bUl2vvAsaYjC2N16Xu018eF/a0nfTNnHB6f/SwF3JMin4sWKHVP44g9Q1
         SvlYW1vCsDsHXavCd1eo7mKxD2jNY99ACHCj0kPonbcX7UbmeY/EPxGMGX2zbGJKQIbz
         D8J9y23G/EV74L8NkQaLjNatIlgU7cUqAe9VPh3arJNKBCpPQUj4T5FWCoTg6GHcGdUY
         09Tm9B63HOk63bbm85QC0WBfAGizkNpt8E0EgKU0XAkLwo3wsxbiqMFsm6vCPTQIKW/7
         Ab4A==
X-Gm-Message-State: APzg51AJTV/Oviwz7c9joCuOEy9xnCVt8Si4y2cqgZb+2uRAVbCgljoi
        o1IgvkYHYSd2zqf2HVK+ZwE=
X-Google-Smtp-Source: ANB0VdYBW+mott4pXn1WZCvW4hRqlFln8Mlgo1yvVREA3HV7KrCkWC+T4aA9mH/a7mMC6Y3RKwestQ==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr43077400pfg.69.1536185896499;
        Wed, 05 Sep 2018 15:18:16 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id d19-v6sm4319360pfe.42.2018.09.05.15.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 15:18:15 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:18:02 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 3/3] mm: optimise pte dirty/accessed bit setting by
 demand based pte insertion
Message-ID: <20180906081802.210984d7@roar.ozlabs.ibm.com>
In-Reply-To: <20180905142951.GA15680@roeck-us.net>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-4-npiggin@gmail.com>
        <20180905142951.GA15680@roeck-us.net>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Sep 2018 07:29:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
>=20
> On Tue, Aug 28, 2018 at 09:20:34PM +1000, Nicholas Piggin wrote:
> > Similarly to the previous patch, this tries to optimise dirty/accessed
> > bits in ptes to avoid access costs of hardware setting them.
> >  =20
>=20
> This patch results in silent nios2 boot failures, silent meaning that
> the boot stalls.
>=20
> ...
> Unpacking initramfs...
> Freeing initrd memory: 2168K
> workingset: timestamp_bits=3D30 max_order=3D15 bucket_order=3D0
> jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
> random: fast init done
> random: crng init done
>=20
> [no further activity until the qemu session is aborted]
>=20
> Reverting the patch fixes the problem. Bisect log is attached.

Thanks for bisecting it, I'll try to reproduce. Just qemu with no
obscure options? Interesting that it's hit nios2 but apparently not
other archs (yet).

Thanks,
Nick
