Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD31EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B83D2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=contabo.de header.i=@contabo.de header.b="xzK3Ivkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B83D2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=contabo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732728AbeG0Nfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:35:38 -0400
Received: from mail.contabo.com ([91.205.175.50]:35769 "EHLO mail.contabo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbeG0Nfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=contabo.de;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g7/TnCNoBLFIK3JP0uN10aVX+Xrsx2lI3xqesWbpf4A=; b=xzK3Ivkz5a4hkoU67+CAWoLo/A
        IZSHVv9BDw3vhq76ZfDzScrY/42YsirGRU7ulrNHQvcjxqgEThexGS6VNPAMXPfoTn+Ew4ckE5RXt
        hf6KRamzmY0g6s1TAmP0hu6YPvbrU5UuD/jXx2Td5UHJXUNAMW76ktAdLu9xEVVQ/mlG5wiZ36vtG
        0CsA9PYtuixiSW+NHwYbGLs/jxr/CctMrs8kfnzUqADubjSUZnmDDB2nVwzqr0epObXpILQ3pFZ2i
        uNFgVLU3cJ7OgfxnyCZkAXTbKA4H52a7DvZg845CYyoh2SrFkHf7rQpLKF/04QbbBMUK3Rgn/slKd
        PbYGzdTQ==;
Received: from [178.238.239.246] (port=31756 helo=[192.168.178.123])
        by mail.contabo.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <tino.lehnig@contabo.de>)
        id 1fj1d7-0002IV-AL; Fri, 27 Jul 2018 14:13:57 +0200
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
To:     Minchan Kim <minchan@kernel.org>
Cc:     ngupta@vflare.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725132126.GA2893@rodete-laptop-imager.corp.google.com>
 <d07348bb-3102-30f0-d138-de23449e23df@contabo.de>
 <20180726020351.GA221405@rodete-desktop-imager.corp.google.com>
 <1684cefc-c920-d53c-8d2d-c32da213a045@contabo.de>
 <15e3a0af-7e02-83fb-4b72-b05f6d7ded71@contabo.de>
 <20180726103001.GC221405@rodete-desktop-imager.corp.google.com>
 <b914205b-f3eb-7c0e-cd60-88c34341f84a@contabo.de>
 <20180727091431.GA229060@rodete-desktop-imager.corp.google.com>
 <4e0ab1cd-ea7a-0916-eb85-0396c61bd949@contabo.de>
 <20180727120517.GB229060@rodete-desktop-imager.corp.google.com>
From:   Tino Lehnig <tino.lehnig@contabo.de>
Message-ID: <54eddd07-9fe5-0a83-0d2f-556726f64516@contabo.de>
Date:   Fri, 27 Jul 2018 14:13:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727120517.GB229060@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mail.contabo.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - contabo.de
X-Get-Message-Sender-Via: mail.contabo.com: authenticated_id: tino.lehnig@contabo.de
X-Authenticated-Sender: mail.contabo.com: tino.lehnig@contabo.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 02:05 PM, Minchan Kim wrote:
> And bad page is always with writeback enable?
> 
> writeback enable means "echo "some dev" > /sys/block/zram0/backing_dev,
> not just enable CONFIG_ZRAM_WRITEBACK.

Yes, the bug only appears when backing_dev is set.

-- 
Kind regards,

Tino Lehnig
