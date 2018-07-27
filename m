Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E339BC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AE12088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OLDSIJjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AE12088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbeG0RH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:07:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52172 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbeG0RH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gpoB32Wvm6OaGwTjwxc0VjbDNl0yfbzRxyn1eiviIUY=; b=OLDSIJjLSe4Sul3aUhgKxOUzKo
        02dGQNEIslqnQgdMqNTmHZFPmLcKW5fAiQOliqZ5Ra3DAJ3Z1P35cZR8H0AzIa7cNpf7ex+bbnfwm
        xDIFf9nYxMA5ekcF8MYcINIYAgwujil36FJDmZWUhDR68+DWaw0bZ88YRhXdobHVLkgRwZ4dotGWN
        wa7440+rb0X3UtEQSe12dMv1RNTvTFg7fUF06C9K4Xjj9lWoIpSHeBKmYPp/6u5uZGDXOsUv7NNIX
        etCUqwjZOL9diIXjI4CjUVFYI/z0HeEa7a3XeXW5zXdfyspLJH76nH2WXWfphcWIj4HJlgW5yOYGF
        PmWnaxKg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj4vI-0004Kt-Gi; Fri, 27 Jul 2018 15:44:56 +0000
Subject: Re: [PATCH 03/10] atmel: hide unused procfs helpers
To:     Kalle Valo <kvalo@codeaurora.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     simon@thekelleys.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        davem@davemloft.net
References: <20180713064658.10340-1-yuehaibing@huawei.com>
 <ded55181-e1b0-99e9-ac68-2d93fb6168c0@huawei.com>
 <87va91vxnr.fsf@codeaurora.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e6100005-2c8e-b1b9-2870-b8ca2d61fe30@infradead.org>
Date:   Fri, 27 Jul 2018 08:44:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87va91vxnr.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 02:24 AM, Kalle Valo wrote:
> (fixing top posting)
> 
> YueHaibing <yuehaibing@huawei.com> writes:
> 
>> On 2018/7/13 14:46, YueHaibing wrote:
>>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>>
>>> drivers/net/wireless/atmel/atmel.c:1402:12: warning: ‘atmel_proc_show’ defined but not used [-Wunused-function]
>>>  static int atmel_proc_show(struct seq_file *m, void *v)
>>>             ^
>>> fix this by adding #ifdef around it.
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>
>> pls ignore this,my bad.
> 
> Why should I drop this? Does the patch have something wrong which I'm
> missing?
> 
> I'm asking because I prefer this over Randy's version:
> 
> https://patchwork.kernel.org/patch/10512913/

Take it.  I don't mind.

-- 
~Randy
