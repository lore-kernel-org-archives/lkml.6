Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0185CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA76A208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JJTl8D9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA76A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733242AbeKOCJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:09:37 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50022 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeKOCJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:09:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAEG5hsJ067879;
        Wed, 14 Nov 2018 10:05:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542211543;
        bh=3WTPWz+1TTR4/i9KSVVZSj+d6CJIfgMOvHBeie/VuDM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JJTl8D9MGicNc59Zm2tXYPw1e95JrD6JQ1BeRz9wZN04//WIscQfAYwDNIN1H0cWJ
         f4nF30er+tR68/HMvMwSC1Mb+/BONEhrZS4iXllChm/5YVuBv7Zq5o6iW0cMemr34z
         jBIOmHfnYiH66ipVBmAC7t1sKV23IIi6WBk6G5m8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAEG5hQc113581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 10:05:43 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 14
 Nov 2018 10:05:42 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 14 Nov 2018 10:05:42 -0600
Received: from [10.247.16.219] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAEG5gTF031251;
        Wed, 14 Nov 2018 10:05:42 -0600
Subject: Re: [PATCH net-next 0/4] net: ethernet: ti: cpsw: allow vlan h/w
 timestamping
To:     David Miller <davem@davemloft.net>, <ivan.khoronzhuk@linaro.org>
CC:     <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
 <20181113.163042.2086307929074044277.davem@davemloft.net>
From:   "Strashko, Grygorii" <grygorii.strashko@ti.com>
Message-ID: <b27e368e-54ff-1365-af7e-7ac924b4c1d5@ti.com>
Date:   Wed, 14 Nov 2018 10:05:42 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181113.163042.2086307929074044277.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/2018 6:30 PM, David Miller wrote:
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Date: Mon, 12 Nov 2018 16:00:19 +0200
> 
>> The patchset adds several improvements and allows vlan h/w ts.
>>
>> Based on net-next/master
> 
> Series applied, thanks.
> 

Sry, for delay.
Thank you.
