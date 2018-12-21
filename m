Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB9A21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFBuax9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbeLUTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:38:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35584 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbeLUTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:38:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so3041210pfi.2;
        Fri, 21 Dec 2018 11:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zg8IBCyvdbP3FSmSDVhFlyLN8F9l7w4fDkG6UJ5MlO4=;
        b=AFBuax9ZFl+eODfPgC+PnEqpqvLFXvqhdi622ZYFwebTQpEGVxPB2vlNpa0EVDtl81
         cBRA9EyCq+gXOvV24hdTtM0qhwDb4ufmN4zG8k2Wk8QB2+gJ4zvYzLJTu8HPtbmTW7FK
         1zrr0vczV99JvKMIN2ST6MLpRdwWDwrodKTeLKr87MnyucEasP6rE/G5ooo1LwVDBk1M
         /4jx48ZQwjV1BdAyf/4swEkcwOLXwGeXqTgZc0fZHDTITZL3aj3SQoiLFQ0J0dfJMAxV
         eDOuktZ5hYNu3U9KeW/poxLel5vjxEtnxd8Q3+vaqzZno/dN/KSclsau3mwOzCy3jsOL
         pfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zg8IBCyvdbP3FSmSDVhFlyLN8F9l7w4fDkG6UJ5MlO4=;
        b=il8eESQdYaPzz2nvcZq+J2kRZ8n42kwNoH37k1l/7nVuot7b1GIgw9DXX0KbG7XcjE
         b1A/HleM7Gb85hh3cBKhPKTMZCFJhGl9aGEx4tHHT/i/76vCsferSKVm36/VCrHaHe1P
         bc7/PvVgnLm9Y81EaaqKFVD6Bfa7M4uc4tnO2h5VJQfTtsAH0A7XMXFbOq+Pl31cTtko
         XHecCD2R+6b4khQf/9RWNqYybbANFQvcgSDnkmege3IcbCW0CiFEqY+15LZ6VDm8LFau
         jta7VJ88sP5JIqcYZmFOeH5WhbDVny5YrGy6yJ1WXVMOL04m+Ctz2uwXGfKGivrsFllF
         tFBg==
X-Gm-Message-State: AA+aEWZ56rLnHD2nLIRrbuVV1sza3yRREeShBRZqrhBCpLllu9m1nUY5
        VsRQGayY14CJSB0MfS0KFF8=
X-Google-Smtp-Source: AFSGD/WTiHUOWqMMVwETBoR2uXmn1DpHwdjQmuSJ1gXgQ5l6CiAz+KeOQkuH/45aruSKaE90C5nZQg==
X-Received: by 2002:a62:6143:: with SMTP id v64mr3834408pfb.142.1545421098820;
        Fri, 21 Dec 2018 11:38:18 -0800 (PST)
Received: from [10.2.19.70] ([208.91.2.1])
        by smtp.gmail.com with ESMTPSA id r2sm40323787pgo.18.2018.12.21.11.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 11:38:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 03/12] __wr_after_init: generic header
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181219213338.26619-4-igor.stoppa@huawei.com>
Date:   Fri, 21 Dec 2018 11:38:16 -0800
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8474D7CA-E5FF-40B1-9428-855854CDDB5F@gmail.com>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-4-igor.stoppa@huawei.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 19, 2018, at 1:33 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> 
> +static inline void *wr_memset(void *p, int c, __kernel_size_t len)
> +{
> +	return __wr_op((unsigned long)p, (unsigned long)c, len, WR_MEMSET);
> +}

What do you think about doing something like:

#define __wr          __attribute__((address_space(5)))

And then make all the pointers to write-rarely memory to use this attribute?
It might require more changes to the code, but can prevent bugs.


