Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8607BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400272088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPBRAaKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400272088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeIQSlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:41:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeIQSlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:41:22 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D47214D5;
        Mon, 17 Sep 2018 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537190045;
        bh=wFuk1DTq3XdS8jqqRNZ7TiKnxtrStG2OBFzBPtw5lWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gPBRAaKLk1PNJ/KRut0qwi3aad1CuFEDEGxEciTo5rDERPFC+z2Aa1BwPg1xFksgY
         xi799XOXbPAJV1h1gqHbP2h/4vXEz2PU+v+ip5RPN/JAr1AK1tyFJgz24A1kdFAKVk
         +PDluEruBHvQnu3AYPUF2JR/sihjcqW60iY0ckBk=
Received: by mail-wr1-f44.google.com with SMTP id s14-v6so17254695wrw.6;
        Mon, 17 Sep 2018 06:14:04 -0700 (PDT)
X-Gm-Message-State: APzg51DM3xsOLv/Xowa20TzJpCSqblz/uXP3ObpKhCqyE9qJMgkvKO+X
        ++GT3s0FYJAXtx8cqHVVZi1369FtZ+dlbGMTJgg=
X-Google-Smtp-Source: ANB0VdbqjkAcewnHgmaGM52B29t2QLTKSmXYAoUt1QsCwtelHJR/xvVNejMgiNCJiVX0Oqo73z3FPXafbn192xa51xM=
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr19065687wrx.226.1537190043402;
 Mon, 17 Sep 2018 06:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b@eucas1p2.samsung.com>
 <1536825522-6027-1-git-send-email-c.manszewski@samsung.com> <20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b~T5q_dx0q42420924209eucas1p2D@eucas1p2.samsung.com>
In-Reply-To: <20180913075859eucas1p2bba2f5ab32fea5c4f832abaacaed6c8b~T5q_dx0q42420924209eucas1p2D@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 17 Sep 2018 15:13:52 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe_y7gvgAYAdewtdwhWb=bwk2ni8=_p89ps5Ge6i+pJfg@mail.gmail.com>
Message-ID: <CAJKOXPe_y7gvgAYAdewtdwhWb=bwk2ni8=_p89ps5Ge6i+pJfg@mail.gmail.com>
Subject: Re: [PATCH 3/4] crypto: s5p-sss: Minor code cleanup
To:     c.manszewski@samsung.com
Cc:     linux-crypto@vger.kernel.org, vz@mleia.com,
        k.konieczny@partner.samsung.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Christoph for patches!

On Thu, 13 Sep 2018 at 09:59, Christoph Manszewski
<c.manszewski@samsung.com> wrote:
>
> Modifications in s5p-sss.c:
>
> - remove unnecessary 'goto' statements,
>

No need of empty lines here.

> - change uint_8 and uint_32 to u8 and u32 types,

Please add rationale for this, e.g.: "for consistency in the driver
and making code shorter".

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
