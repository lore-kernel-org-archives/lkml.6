Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31968C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92BF21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqmTnlrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92BF21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeHMG0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:26:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39957 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeHMG0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:26:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so6341547plp.7;
        Sun, 12 Aug 2018 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=mZ13BgQ7A+fMK8pLrAYHdApld+51Qh8czR212ar1lx4=;
        b=lqmTnlrShqJx86C0UQL3ncE+/YFf88dPYrQzZC/xwvLfvI4M/KCUZtpfDZ0P2/UJWy
         m62bwMEhAlwgvXnNoau9l2bzAXOFFgGMZ1egXWSbosmCqBCgKxI5J+OAlTKGmXmyL0jm
         fS9ZpRcziPrz3CtqLLiDvzWfmvxtwnHZqX7BK9iU/Bz3EVsCEkY5zH9m8Of879OgooJh
         NXBniUCYnPg45EYN70AH+zkFPha76Ipy6u3R/q5mN2Bc1qg+g165JqcB6++pNzHEjpCr
         LFVoZzPv2cPxNlPxKp2mRN0E2lgWaaBDX0B9pGNopgJT1tZMuPGRCxS88pCBLOasLwqp
         fbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=mZ13BgQ7A+fMK8pLrAYHdApld+51Qh8czR212ar1lx4=;
        b=qFgjrvwlyVf0osFudeVTQL35QDD+LUsM0cZ+ZruLcH5yXsAsoaA5CrnJ0KLLP/TWz2
         gv4Fm8Y9tyjJ6hSI2PK/0SXreM8oCzOIgETMuH+n1wKrFDNcO6TsdXEzBu6SdSxlmhbV
         9hXsMFh1KumJLf7Q0Ugpm6SoNtipj15Hyy8WW7Cq0RttaSDEKW0g3kG+wJkGEco7yC+l
         hM0+QSP1ADg+hbnLTe0/bnNXTGlH2XwahncRwN9j6vnPPGeiyj3fXRbyqBfqJIEA2NEY
         xA7pfNGwhHE04sRdmECDAHvrWVmC8+yMGu+H2ZVcMKPUp3VGGwyD3wUIAFYNcGLhhjQ4
         fHAA==
X-Gm-Message-State: AOUpUlG6W39H9VNtSrvhlIOOUhNawAl7/Oncbwx92DanhXcpck/HdBUw
        Judq4Z9BcVpjkxgmWK6361xvtYl2
X-Google-Smtp-Source: AA+uWPyWMCE7HNxg80AlgpJOsVMLTMoG7816Nhda1xSNhYCIdI2CELazrmPtRtREEwRNTiv+E1+s8w==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11-v6mr15051295plp.333.1534131992631;
        Sun, 12 Aug 2018 20:46:32 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id w72-v6sm30333112pfa.26.2018.08.12.20.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:46:32 -0700 (PDT)
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: nfs: pnfs_nfs: a possible sleep-in-atomic-context bug in
 pnfs_generic_recover_commit_reqs()
Message-ID: <6e0b1c99-bfe5-29a9-51b1-1c71fe0b91b4@gmail.com>
Date:   Mon, 13 Aug 2018 11:46:28 +0800
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

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] mutex_lock_nested
fs/nfs/write.c, 1045: mutex_lock_nested in nfs_scan_commit_list
fs/nfs/pnfs_nfs.c, 145: nfs_scan_commit_list in 
pnfs_generic_recover_commit_reqs
fs/nfs/pnfs_nfs.c, 154: spin_lock in pnfs_generic_recover_commit_reqs

I do not find a good way to fix, so I only report.
This is found by my static analysis tool (DSAC).


Thanks,
Jia-Ju Bai
