Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B183A213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVV5eY/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B183A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeK1Hck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:32:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36225 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbeK1Hcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:32:39 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so23355690qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSKni4hqVMfPoJEIvllgQczdPa00tmXzhiLDZBY8kVo=;
        b=VVV5eY/HPghrJy83Ie+bVUJPlaZj7fcyS7zwwrsLxMhfbQI41tqW9JSMWo6S31d68H
         mmMtM76e2W1gwgK3JeGJqUrYKIl5twcz2OupX8575PnQ2xfOx1q6WdQ/UAgqhXhLoXdm
         0AWies0URFxqhHsuAWp+Njp0hw0TNciNRi8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tSKni4hqVMfPoJEIvllgQczdPa00tmXzhiLDZBY8kVo=;
        b=gehIm0Qe7H2xRhR7N7834hxHw58F3Zd32G7U8JfgRElsF6Se1H1leQ919LTI5Rv2Je
         fHz0f5PgI9kw3sWUTGqhzTPwo+JAHkT0Gxv1CP13rWaPKAasJj4mV4jhB7+V/bKQf2+i
         uJOCoeK2ZRsn5DFCOxDKS8mBWbV1lk5Gc2O4O80zp3OwHq2nTROGCN/BLrvZgF9NvPcr
         VxdS7TdSx49axzCMABzm/hYjUWaCr/v6yp62U4K4UZ2Kiap6BtQ3JE/x+6fUMm/kqRjb
         A+CNBW7SD+KWfKIcajup5J61GEifM+n/XvDOIn8pek9XC08v5fUJ2I0j1oNTPPr4C6tA
         1Tuw==
X-Gm-Message-State: AGRZ1gLwYTwjCf538lvSzGe6A+sHLj+uDQUxjNHs7Nj+YFOIgKlTi3aj
        qN3bHQQ9prB8P/uGfqVAGZFhjA==
X-Google-Smtp-Source: AFSGD/Wm30KpK0w3t2lct6lq3glzLL/bZIdds+bB/xVv/Iuu8VobETXC1Y7ozGy8FXxOwq157hBfDw==
X-Received: by 2002:aed:3b76:: with SMTP id q51mr32364873qte.229.1543350813782;
        Tue, 27 Nov 2018 12:33:33 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id d198sm1977639qkc.47.2018.11.27.12.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:33:32 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH v2] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To:     linux@armlinux.org.uk
References: <20181025134344.GZ30658@n2100.armlinux.org.uk>
 <20181121001150.405-1-rafael.tinoco@linaro.org>
 <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <93b0cce5-4ceb-14ab-5987-af54f15958f2@linaro.org>
Date:   Tue, 27 Nov 2018 18:33:29 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 10:18 PM, Rafael David Tinoco wrote:
> 
> Russell,
> 
> I have tried to place MAX_POSSIBLE_PHYSMEM_BITS in the best available
> header for each architecture, considering different paging levels, PAE
> existence, and existing similar definitions. Also, I have only
> considered those architectures already having "sparsemem.h" header.
> 
> Would you mind reviewing it ?

Should I re-send the this v2 (as v3) with complete list of
get_maintainer.pl ? I was in doubt because I'm touching headers from
several archs and I'm not sure who, if it is accepted, would merge it.

Thank you
-- 
Rafael D. Tinoco
Linaro Kernel Validation
