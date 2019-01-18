Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA42C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED220896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fJNMA9M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfARMz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:55:56 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51696 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARMzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:55:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0ICtmxA029338;
        Fri, 18 Jan 2019 06:55:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547816148;
        bh=3sG7OW1OYoA862WFpuBhQaQvpPEZfIvVz7qnFiyJYoM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fJNMA9M1Pl6MgBK2Phm3hPXNKUW9lktMZhPF+ikUAXXYYPg2L+1fGLMtRbO6IvI9T
         gdDOSwh5uSBRzxBrViHbGQS+GWEG1OmLJWFvlgLlstQkmUSM1szPg+T9ZN789tB8Dj
         yUkp3sL/Yjwe4FQEMs9ABnunPIZ+lNCh9c6Q2NZU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0ICtlZY015237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 06:55:48 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 06:55:47 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 06:55:47 -0600
Received: from [172.22.105.109] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0ICtlZc001129;
        Fri, 18 Jan 2019 06:55:47 -0600
Subject: Re: [PATCH v4 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190117200601.16416-1-dmurphy@ti.com>
 <aa72c1a7-ee16-dbde-0b75-96f9632ec431@ti.com>
 <641ae2ce-def9-6032-b8dc-cc71311bc993@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <82d9f82c-1da6-2374-062b-538840afcc44@ti.com>
Date:   Fri, 18 Jan 2019 06:55:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <641ae2ce-def9-6032-b8dc-cc71311bc993@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 1/18/19 12:56 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 17.01.19 um 21:08 schrieb Dan Murphy:
>> Wolfgang
>>
>> On 1/17/19 2:05 PM, Dan Murphy wrote:
>>> Create a m_can platform framework that peripherial
>>> devices can register to and use common code and register sets.
>>> The peripherial devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>  drivers/net/can/m_can/m_can.c          |   6 +
>>>  drivers/net/can/m_can/m_can_platform.c | 209 +++++++++++++++++++++++++
>>>  drivers/net/can/m_can/m_can_platform.h | 163 +++++++++++++++++++
>>>  3 files changed, 378 insertions(+)
>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.h
>>>
> 
> ... snip ...
> 
>> This patch set is working for the TCAN and at least boots on io-mapped devices.
>> We have a couple of customers who are looking at using this implementation and we would like to
>> start moving this patch set along in the review.
>>
>> I did not put a change log in here as there have been no comments for the last 3 patch sets I sent.
>>
>> This v4 squashes a few bugs I found during testing across all the files.
> 
> OK, after a very busy week I will try to find time for the review...
> finally.
> 

Thanks.  I anticipate a v5 as we debug the io mapped code and continue to test the TCAN code.

Dan

> Thanks,
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
