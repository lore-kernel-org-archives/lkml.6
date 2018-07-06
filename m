Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FCFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE92170E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ilIi5uMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CE92170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeGFMdu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:33:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33532 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeGFMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:33:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w66CXQGr017730;
        Fri, 6 Jul 2018 07:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530880406;
        bh=Virzxj+LrQyTrEASzSq7FpJFNgCU1py7QxKAgEbqFzs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ilIi5uMlKpEVE5cpFfn1k8pErgqd7GKOy+G4Y7G60RmbpmXN7D5+G0gAOaY9kCQCo
         7+vE3C5IU73CL9xgmT2bIuk/ALtcdEsXlwPXGKi6Yi2DQ032VToeC+qj88NDe9uj0T
         ZZ2tt0TVKCpWILlSrZQKYSJqhsLXro4sQFNMvekA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w66CXQTm017358;
        Fri, 6 Jul 2018 07:33:26 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 6 Jul
 2018 07:33:25 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 6 Jul 2018 07:33:26 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w66CXM0g030177;
        Fri, 6 Jul 2018 07:33:23 -0500
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <t-kristo@ti.com>,
        <mark.rutland@arm.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
 <20180705154758.GA112168@atomide.com>
 <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
 <20180706103541.GC112168@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <46b0d881-e6ba-f314-e995-2848ab9fc429@ti.com>
Date:   Fri, 6 Jul 2018 18:05:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180706103541.GC112168@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 06 July 2018 04:05 PM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [180706 10:05]:
>> Hi,
>>
>> On Thursday 05 July 2018 09:17 PM, Tony Lindgren wrote:
>>> * Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
>>>> +static int sysc_reset(struct sysc *ddata)
>>>> +{
>>>> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
>>>> +	int val = sysc_read(ddata, offset);
>>>
>>> Can you please just warn and return early for now if no
>>> syss_mask is specified? Otherwise we'll have mysterious
>>> errors if somebody leaves out "ti,hwmods" for module types
>>> we do not yet support reset for.
>>
>> RESET write to sysconfig can still happen even if there's no syss_mask
>> right? Not all modules need to poll on reset status.
> 
> It can but we currently don't have anything similar to
> srst_udelay like we have in _ocp_softreset(). And we don't
> currently have suport for sysc reset done bit.
> 
> So we want to warn and return error except in the known
> working case for now.
> 

Ok.

Thanks,
Faiz
