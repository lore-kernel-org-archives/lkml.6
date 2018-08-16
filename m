Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD26C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F6E214EE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 00:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHzferOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F6E214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeHPDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 23:22:00 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36213 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbeHPDWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 23:22:00 -0400
Received: by mail-pf1-f170.google.com with SMTP id b11-v6so1199616pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBk9RQaq+lMTTEAGMeqfrjS4Y2wc11lMss9K78HA19s=;
        b=FHzferOZ4xbe59W3W7G6rUC0Qw6+KPEFuuFQ/ly/osqXfznwzjpYsVrRhTHAcA+Cq0
         jbGG0/if6n0YzFz5Bbv9oxsgLqqrj+aBy2iTk9vS2u6Z6oi057U2r01lJk469EeNkWDS
         Fe7+PnR+3QKsxCc8+cG6832l2eavk1SAvS4vitFSWGn7YzowWpbs3AeeLZAmamtUijP/
         SEPcGMLUtr/v4SllqqBVx/MnJHmGgMbT2EnN2Cj9NucU8jMZQS41jDJAtK8/gslK+rtJ
         h+nUxuzGy19X6oDrtkg4gZ/4K6mZsqF3Tp7Dw6mokCER1mbryDgcHNs5Ms6mZFEuYLMA
         RdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBk9RQaq+lMTTEAGMeqfrjS4Y2wc11lMss9K78HA19s=;
        b=to0ILgdGv4NS3rXTMkQCgBcxe3lMPXsH3ESP9u3+oYI/8dhBzRMYt8kCahQHx4YbeW
         FnZmpmu2/fcsSKy+LyChFWB6M3/UDtHNku/hmR9ZPngC5CU1dynhplbtfieqU+VvD3Yf
         HVpENpVZA8Ql+06MiC+I5Vc8L3jq9mjDsHRciD3bmR5arCXD3skUlrfOh3Z7UCll+N9L
         RWNdGR2Qh+ndGwgSy2hMYy+bkuZKh4wPwjIA1qFyge8Eu9HqR8iukBghnW2mZA8D+MPA
         +CBV1u+Nu+FHfQVYtdUlQQhi+6fmbZeMK+Dxm/xSf7u/SQbXOYSDKyQgD4ovdh23JfBV
         Z7xg==
X-Gm-Message-State: AOUpUlGEfwOxdZ8bhDCqnYq8y5ix+9TIkTxwJjcgKWowM7EZYCpj7G2m
        ED40QYrXV4jLmM+zZC1j0Zg=
X-Google-Smtp-Source: AA+uWPyANWdWfhZb269KZZejs+5k+Z85aGUFzoSK3ZeasdYT0qc0XLt0TVbKbSGl5ZsEfvX2RwaiGA==
X-Received: by 2002:a62:3001:: with SMTP id w1-v6mr29824783pfw.19.1534379240288;
        Wed, 15 Aug 2018 17:27:20 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x24-v6sm28015858pfh.67.2018.08.15.17.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 17:27:19 -0700 (PDT)
Subject: Re: Build failures with gcc 4.5 and older
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180814170904.GA12768@roeck-us.net>
 <CA+55aFy0SFGaNmzCcpwMCeY_f3ZTG54NmV3SosbK6=QdE20=5A@mail.gmail.com>
 <20180814173623.GA5117@roeck-us.net>
 <CA+8MBbJ=09jAHNZTFrwMFFGbUSWEMYCDxKTMvM2XE+daVa599g@mail.gmail.com>
 <CA+8MBbLrxj5e6cifAt9h0mR7n8x+8KEtu7Mq-gUSOrpCmkZXsg@mail.gmail.com>
 <CA+55aFwD28QmLZv4qMut89nAr7gskfJv-8ANvBDsnq9ZB3qCyQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4d42fec4-0ce7-7d8d-8cad-cb01f725e41c@roeck-us.net>
Date:   Wed, 15 Aug 2018 17:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFwD28QmLZv4qMut89nAr7gskfJv-8ANvBDsnq9ZB3qCyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 09:34 AM, Linus Torvalds wrote:
> On Wed, Aug 15, 2018 at 9:09 AM Tony Luck <tony.luck@gmail.com> wrote:
>>
>> I did manage to build 4.6.4.
>>
>> 4.6.4 built git HEAD* that failed yesterday using 4.3.4. It boots OK.
> 
> Good. 4.6 is what we'd suggest be the new baseline, and we can
> hopefully keep that for a while.
> 

So, just for the record, I stopped building (or, rather, I stopped trying
to build) unicore32 images for mainline and linux-next today.

Guenter
