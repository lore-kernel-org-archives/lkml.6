Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D5EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AFC206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="2Ikd8S8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbeLQK7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:59:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLQK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:59:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5945113pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 02:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HCRVfPc+8euivZcx8DvOeAt/hoZ7BKtn/0PNVNt4DFI=;
        b=2Ikd8S8X/e75L7f7iAijpT2q1cfcP2pRK5pLybR3cZtUnq2Y5OKOURt6SVoATPmSHo
         Nn2oxoUcFVsvv5knY5cdShOz85BJ2adBnXgjBYSoQet2Cf2U2gSd01SP/OcNMxinHw16
         tBi+AdWnbv1cBIHdw0EZocshguno8AESdxCvn1mjb8/Hp0X/OEqQ+FQzA8weRnKMMb2c
         ffBzlhYugclMqE43cU/LBhWNcv9EUJTFhzRHnkx4RN18dfz7G2IGYWHk2dN9F8w/3O56
         /xQxQwacADWKIBNUxS0v5ORWqPTt5JfW4GiQrne/Os1IOZgAqL0th2tdKyckMERguRA8
         +O1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HCRVfPc+8euivZcx8DvOeAt/hoZ7BKtn/0PNVNt4DFI=;
        b=U9etAa5HdRlnXJMp900IQ3KJ/yYJX4aqPRpEqyQqNWZeZsbfi9zxI8N96cdQZmE/37
         5CSS8Ka5K8LhzPkrHkzPureUJu97v7pMfARIap3T8gsqUHFll0Q2RJgLnfcbsBqxOOQt
         DFfKbcDMRA9iFYeSQRQBB2qIq2S+vJzHgYs4q7TDP80WXaSbYR7gpZ3ma4Xi0W1Fu/mK
         4lEIUltzTshWGvaPgay8NrAAi2sM+CTA6af2kDe5j/rczpXJ2MM/ecMqe3Cr6nNcZ3iB
         dyceDknhIBcuMo2rfWME9pNaFt96ZAM7fgXTUxYbuFrNXryk7aH0CNM49wC7y3qIGhxX
         6fHA==
X-Gm-Message-State: AA+aEWZb/A5OOjkdT2Osw+/XUYPDCmq3RtGEZCSe81v1MZNRg89FGH2l
        xeJma2aAKsZWzOcwDAa+fCA/iw==
X-Google-Smtp-Source: AFSGD/X87cQkZoV3i2W3tK/EWCfTVWQOgPsl7jjy/YfVaE25lP2g5f7QWBMOfZPtKKAFlBgy+WHG1A==
X-Received: by 2002:a62:2e46:: with SMTP id u67mr12168681pfu.3.1545044390161;
        Mon, 17 Dec 2018 02:59:50 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id d69sm16433919pfg.168.2018.12.17.02.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 02:59:49 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 713A7300316; Mon, 17 Dec 2018 13:59:44 +0300 (+03)
Date:   Mon, 17 Dec 2018 13:59:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hsiangkao@mail.ru,
        kirill.shutemov@linux.intel.com, stable@vger.kernel.org,
        zhangjun <openzhangj@gmail.com>
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
Message-ID: <20181217105944.a7eylrxi5pni4mqq@kshutemo-mobl1>
References: <20181215150130.19381-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215150130.19381-1-richard@nod.at>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 04:01:30PM +0100, Richard Weinberger wrote:
> The page migration code assumes that a page with PG_private
> set has its page count elevated by 1.
> UBIFS never did this and therefore the migration code was unable
> to migrate some pages owned by UBIFS.
> The lead to situations where the CMA memory allocator failed to
> allocate memory.
> 
> Fix this by using get/put_page when changing PG_private.

Looks good to me.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> Cc: <stable@vger.kernel.org>
> Cc: zhangjun <openzhangj@gmail.com>
> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")

It is fair to reference the commit here. But I believe the bug itself
predates the commit and relevant not only for migration.

We might make it clear in the commit message.

-- 
 Kirill A. Shutemov
