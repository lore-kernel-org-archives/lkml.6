Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B321C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E16F20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuAN3Mwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E16F20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJHPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:06:40 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45825 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:06:39 -0400
Received: by mail-lj1-f169.google.com with SMTP id j4-v6so13159597ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zA01YImvXjUTOzIym6Ew0H7c11/qtNZ9sVNn6i+n30k=;
        b=XuAN3Mwps8AZqpy272QQ1JuKDenCvI1gSwtLZ/0uz06qsqN7yiKSeCw2bxRe4pqJlz
         eu/Cqj5r9RHOq4OnkGqPaIZstwLPzo1C1LziIxMwIXHqHXgtRmxRG+XkjqajRZGnrpuv
         7OSU/dHUTHcnAgt/vwVXTTxiql00gzZR+WaHxDdMf975O3r1TzROfuDkYLnBvWfKVVcE
         DqAKBxxHpZkdjUs92OuIOW4vi516JLE+4LZaWKv8gMQ3+ymtIESKxZUm4szrImk/tQu7
         rxkDti4c2aa5JI56tC8B6VUtRxoZU3BBCysK9taOIhrhSX44KPdp+MQoHqqCN90iY/Gd
         u5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zA01YImvXjUTOzIym6Ew0H7c11/qtNZ9sVNn6i+n30k=;
        b=oEW9RtSumQelVXQX75N6FQtVSm+HyCrGMGmGh7X289LRRa8ZnogBPTcO4dbBjjGjuo
         zyQ+/k1np4RnyW+/5j88QAa5Ags0GpDW3lvknoICxcf0XLtscs82hlbV05+denC10K96
         H+Tij+2nFuO6eBy2fAPiLmDLAw6J5yDGNUhsUJEHx04toDE1ggfE3ccVS+h4G6wYOKrx
         lVfj8+ivOh2W6XMvMmVPurJKkIc+sZU25TEZ/l6luTiA2NZZWWlVPR2alGP8/+y3SsYx
         cdwHo7lJBhBiOTnQcbguXUQEpVEaXAwo8F4HY3GV9CQKELl4lpfv/0IaU9BKfn7/Ertv
         rNCw==
X-Gm-Message-State: ABuFfoh/5rt9oQRVvyAf4/jqYirug6/H0tXlwXWSF3Nk+npZEs5shhX/
        NFvZq9xzc0lipJuinDiTnWe02fJe
X-Google-Smtp-Source: ACcGV62rw7D31J845K1FlR/cd8mQpYe4b/zcflQ0mDK4k9ocNWE2OrIGJASfscyb6hUrXMW+ca+ybA==
X-Received: by 2002:a2e:20da:: with SMTP id g87-v6mr12178414lji.88.1538985372145;
        Mon, 08 Oct 2018 00:56:12 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-140.elisa-laajakaista.fi. [91.159.62.140])
        by smtp.gmail.com with ESMTPSA id f73-v6sm3449600lfl.80.2018.10.08.00.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 00:56:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
Subject: CHECKPATCH: strange warning on alignment modifier
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <15d77776-0551-5b7d-935e-16496c3800e2@gmail.com>
Date:   Mon, 8 Oct 2018 10:56:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following fragment of code:

+struct my_struct {
+       atomic_long_t l __aligned(sizeof(atomic_long_t));
+} __aligned(sizeof(atomic_long_t));


triggering this warning, when fed to checkpatch.pl:

WARNING: function definition argument 'atomic_long_t' should also have 
an identifier name
#19: FILE: path/to/file.h
+	atomic_long_t l __aligned(sizeof(atomic_long_t));


gcc [(Ubuntu 7.3.0-16ubuntu3) 7.3.0] seems to be happy about it

I am using the HEAD from mainline.

My intent is to specify the alignment of both the field and the 
structure (yes, probably redundant in this single-field case).

If I am doing something wrong, I can't figure out what it is, but I 
don't understand why the WARNING is mentioning a function definition.

--
igor
