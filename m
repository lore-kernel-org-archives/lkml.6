Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8553EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F4B20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 22:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTCu70ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeFQWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 18:54:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46976 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeFQWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 18:54:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so7212137pff.13;
        Sun, 17 Jun 2018 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lxETX4DhBQbKYLCrDPYmuMFE6cj3I8bZjDQzt70yHVA=;
        b=LTCu70akI2I7Umnh0baiy8ipDZsWOXOMYeeQhEFmwPOqVE5Y7qj/G6Wmgn7ftEHQKz
         mDpP9O3zcMfDP4EOSiYrLVgkIiglMH89jYXa+F1gO+6yQAWzsiK7ebkII9zxWzhvF/Fq
         AFiN9HxT5wMfN0jzSDauPkZI7Gmi+kSjlJFT44yEm7OyLZ167JX/hl1npE0MFiSzd+88
         7ntq+yhJIWjNPLkvogl4UkyzrZjUJPxBvOPToAsFQRHccMQgFJRgxPl6CkAFDfeI7Un8
         7gLeJGQ2tw8c4LoWo+xsDhhPQgJbWvzGzbkiML4gdj9TOvK1hV3fX+xTewh6FCij+oaw
         RXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lxETX4DhBQbKYLCrDPYmuMFE6cj3I8bZjDQzt70yHVA=;
        b=E2yPcEancVhjsFES8QWVqePt6/sluCRe1FepAKr1tR3ueVbsRvBgquMvKE/Ckgh/8O
         76xPJ8pqCaZsL+/7Su6U8PsxPY1uVl+1kCp9X3lLyFAMSEewF4C6WAKsX7JRu81YIBlC
         Xdczn0qVThIv/niRJw0sfSlCN/B8rkB1vaI5CMIBgDzif968PRDegYFuI2ZhR73g0ehn
         4it2WjQntNptQ/XRezbxOTgMi02eQGmYOCdJDEgDr5N/XWnElvXUaKeErBTgwkYULCGm
         n6gIDyqIYKNfK4s/Y6T6jAB1LKrZ1vw9kjctSNxNByPCIeWzUVqK6y3BqGvO5kZTydey
         AWgw==
X-Gm-Message-State: APt69E13RKTX/mX1qJtvDt30/KBxzv+FxSyyPYhMDbQFTRxUqxgIMjbe
        17mC+e/tuX27NVG64R9HSpRQCZdY
X-Google-Smtp-Source: ADUXVKLXHK0ldqyiU4eR4kcGdFiudH33CnP3eaE/QqbHAhU3PZXaeD+sbARNvzyA2JWMQ6PEpbqmRw==
X-Received: by 2002:a62:484d:: with SMTP id v74-v6mr11136702pfa.256.1529276090800;
        Sun, 17 Jun 2018 15:54:50 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id e1-v6sm16280707pgt.71.2018.06.17.15.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 15:54:49 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are
 friends"
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Meelis Roos <mroos@linux.ee>, netdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180615185645.8921-1-malat@debian.org>
 <fbb95c11-240c-1a11-0a62-0483908c577e@gmail.com>
 <CA+7wUsysaip70ARGQ7Byg1Zktfg0Y1esjEc9HxBGU4sKL8crhg@mail.gmail.com>
 <9d88677a-f2be-2089-79df-15df4e9a5dd6@gmail.com>
 <m2tvq1672p.fsf@linux-m68k.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e1a9b126-3226-72d0-82b2-b69ca5f59ccb@gmail.com>
Date:   Sun, 17 Jun 2018 15:54:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <m2tvq1672p.fsf@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/17/2018 03:27 AM, Andreas Schwab wrote:

> 
> That doesn't change anything.

OK, thanks !

Oh this is silly, please try :

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c642304f178ce0a4e1358d59e45032a39f76fb3f..54dd9c18ecad817812898d6f335e1794a07dabbe 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1845,10 +1845,9 @@ EXPORT_SYMBOL(___pskb_trim);
 int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
 {
        if (skb->ip_summed == CHECKSUM_COMPLETE) {
-               int delta = skb->len - len;
+               __wsum csumdiff = skb_checksum(skb, len, skb->len - len, 0);
 
-               skb->csum = csum_sub(skb->csum,
-                                    skb_checksum(skb, len, delta, 0));
+               skb->csum = csum_block_sub(skb->csum, csumdiff, len);
        }
        return __pskb_trim(skb, len);
 }


