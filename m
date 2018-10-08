Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7368BC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C18204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C18204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbeJHVsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:48:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeJHVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:48:52 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 132FFA6103F01;
        Mon,  8 Oct 2018 22:36:46 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 8 Oct 2018
 22:36:42 +0800
Subject: Re: [PATCH v2] staging: erofs: add SPDX identifer
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Loic Tourlonias <loic.tourlonias.lkml@gmail.com>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20181008141409.2624-1-loic.tourlonias.lkml@gmail.com>
 <20181008142228.GB13359@kroah.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e9620bf6-5f3f-108d-b9f1-91af1ad603d6@huawei.com>
Date:   Mon, 8 Oct 2018 22:36:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181008142228.GB13359@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/10/8 22:22, Greg Kroah-Hartman wrote:
> Why delete that line?
> 
> But wait, why do we even have this file at all?  What's wrong with the
> lib/lz4/ code that we have in the kernel today?  Shouldn't the code
> using these files be moved over to use the lib/ code instead and this
> file be deleted?

EROFS uses customized LZ4 decompression code for now (which has been offically
supported in lz4 1.8.3, I have updated it in
https://ozlabs.org/~akpm/mmots/broken-out/lib-lz4-update-lz4-decompressor-module.patch
if it is shown up in Linux 4.20, I will remove all the customized LZ4 decompression code),
but lib/ code lz4def.h isn't export to include/.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
