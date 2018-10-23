Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279DE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Xm9bE9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279DE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeJWKSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 06:18:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42464 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJWKSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 06:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0V6x2i8OtkCKf0cXK9Pnzp/2djZjIbITpZBuQ53eW/0=; b=3Xm9bE9B9qDNQiVEeW1FnGugay
        fYFuvfFUgV4BJGk9w3ouOTYN00iTbvk9DouakkOlffrtb+tuSRdDHddOy0oJPpEDZJ0+ly6979CHG
        Mdf208ZreZQs0ySjChcN0ImHcakbiiUGQyYcYDlh9htnhYAGVbXl3xz3jGa8GWLK/a99yhP570rxe
        FIO7/YHiDhoMnjcrVcco0sVphwzSsfn67vB1oHnZWW8G9B1Rz1TC+gmcf7kmnhmjjY/u2Y9GeMsxH
        W+OdxczHMp71jpP8+941pXc+Ex+/qT4/6+aHDf9DeT7N0feNrULsPSj/euKfzI67RxkxgLDre1ab8
        g2XMdLyw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gElvv-0007N0-B8; Tue, 23 Oct 2018 01:56:36 +0000
Subject: Re: [PATCH 2/9] dax: kernel memory driver for mm ownership of DAX
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        ying.huang@intel.com, fengguang.wu@intel.com
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
 <20181022201320.45C9785C@viggo.jf.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ddd650d6-6a0f-6c57-f55f-af31264c4f44@infradead.org>
Date:   Mon, 22 Oct 2018 18:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022201320.45C9785C@viggo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 1:13 PM, Dave Hansen wrote:
> Add the actual driver to which will own the DAX range.  This
> allows very nice party with the other possible "owners" of

Good to see a nice party sometimes.  :)

> a DAX region: device DAX and filesystem DAX.  It also greatly
> simplifies the process of handing off control of the memory
> between the different owners since it's just a matter of
> unbinding and rebinding the device to different drivers.


-- 
~Randy
