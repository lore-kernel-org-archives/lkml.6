Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90728C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4542B20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 03:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnGbVMcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeFUDDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 23:03:32 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44561 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754451AbeFUDD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 23:03:29 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so830419plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=YM0NyBKPrXdxiBVQwYPvyqesju+DKxUVC4RWfFvxMxY=;
        b=MnGbVMcbCQ1qSFdDjVq+II4ymtIbcbNMVzW6QxSLZwZKM/osggspp5mZ1FSnk3hBPE
         DnbIQK6+UCGcHruqeK3nNJ/NyU5fFWE0QglBODvKpxtEE0x6b7vaKloELyMhZmd11+KW
         X3A7LimfOa/GmOFnGSJ7S5ri4AvtxEEmkMykMo//PCeyGmcd4U1KN8Ti5S+vK1DLdEwF
         XapJNbc6HIz6+p9x0kjjqdHGX5w8vVEebKKUz6RJHKm8W9BzIfZzAPA7e6iHL6tnTCLT
         cvqYJUnU8SpmQbreQRxrbHAbSF6uSHuXcskNSrGheWKWK0t/NDOzrrNjfyaBami0tgv6
         zI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=YM0NyBKPrXdxiBVQwYPvyqesju+DKxUVC4RWfFvxMxY=;
        b=Gpem+p9lQtFg/SqGpIW+6nyE6NS3C6khiSMBKsQsyJCZ/IQZdtzObp3AtNAPbG0CvT
         QZ9XmBp+YDgZ2YRUJmaks/3Z2Y/R4vs4X4AfMooz3epUG2uxtLCmrvOgm6Q8g8S+Wt8d
         PGl0rnegYzeb0z8MTnReHN9zOoqFI2caKECfNemoJSUP9vYQCkjwfBU9wo8eMYlbz/yi
         Gqt0LdWPQQzNLRmTvfhMHNbL2xkhLFfD8Y7VyflZIjByoOR8zShTPAYLJvxlDugfDMm/
         QgInhOpOfQDNyq3X/oGFB77TdqVtIpLztSBGlLZ2xm6EIVimVoB4gqCFPa2N/OZyvZXx
         cq3Q==
X-Gm-Message-State: APt69E2Nqapb/xNVpSbrszp5y5mOWrzy/eCma/FBCdrr7W56gjSCbYUZ
        +XIgoYOhCYfM9I6U8pJ7ocsbrEco
X-Google-Smtp-Source: ADUXVKLz88sACpjalht3UC/VwX2QKhVuiKgvZFxV1fzKlCr0C0ywYP/aL7ffjV6Itu3qNMS5I3TkzQ==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr26870814plb.26.1529550208588;
        Wed, 20 Jun 2018 20:03:28 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.70.11? ([2402:f000:1:1501:200:5efe:a66f:460b])
        by smtp.gmail.com with ESMTPSA id t3-v6sm4990045pgs.91.2018.06.20.20.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 20:03:28 -0700 (PDT)
To:     axboe@kernel.dk, akpm@linux-foundation.or, jack@suse.cz,
        zhangweiping@didichuxing.com, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, christophe.jaillet@wanadoo.fr,
        aryabinin@virtuozzo.com
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] mm: backing-dev: a possible sleep-in-atomic-context bug in
 cgwb_create()
Cc:     linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <626acba3-c565-7e05-6c8b-0d100ff645c5@gmail.com>
Date:   Thu, 21 Jun 2018 11:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.
The function call path (from bottom to top) in Linux-4.16.7 is:

[FUNC] schedule
lib/percpu-refcount.c, 222:
         schedule in __percpu_ref_switch_mode
lib/percpu-refcount.c, 339:
         __percpu_ref_switch_mode in percpu_ref_kill_and_confirm
./include/linux/percpu-refcount.h, 127:
         percpu_ref_kill_and_confirm in percpu_ref_kill
mm/backing-dev.c, 545:
         percpu_ref_kill in cgwb_kill
mm/backing-dev.c, 576:
         cgwb_kill in cgwb_create
mm/backing-dev.c, 573:
         _raw_spin_lock_irqsave in cgwb_create

This bug is found by my static analysis tool (DSAC-2) and checked by my
code review.

I do not know how to correctly fix this bug, so I just report them.
Maybe cgwb_kill() should not be called with holding a spinlock.


Best wishes,
Jia-Ju Bai
