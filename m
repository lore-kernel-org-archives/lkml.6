Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EE5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B452921019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fnpn/390"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B452921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeK3K7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:59:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57388 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeK3K7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:59:11 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATNpimc101196;
        Thu, 29 Nov 2018 17:51:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543535504;
        bh=tErd/PzWg968xjuFgC02pq+KxnMGvdMLs3JwC169iGs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fnpn/3908ztxbnCHzeeT6d05vWJLYgqtwec13i0DLVqLmBLJ1qU+oGHgSklp6ZDHB
         FFJosqAee1jQ+L0/rfvegV2K5tuG4a8smRZtRR6iFsK9bCqZFox1o/XapxmRmVb9y+
         XcHl2ivrElJBBX4F9AQPqATP9w/D20bxb+lKsOew=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATNpiGB083149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 17:51:44 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 17:51:43 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 17:51:43 -0600
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATNpheu018978;
        Thu, 29 Nov 2018 17:51:43 -0600
Subject: Re: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
To:     David Miller <davem@davemloft.net>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
References: <20181128220211.GA5037@lunn.ch>
 <0b70091e-3747-ee8f-15d6-4532e210278e@ti.com> <20181129002835.GB5037@lunn.ch>
 <20181128.172212.1033397162837638079.davem@davemloft.net>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <bc72c707-b4cc-8a02-6cfb-4d474f7fae03@ti.com>
Date:   Thu, 29 Nov 2018 17:51:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128.172212.1033397162837638079.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 11/28/18 7:22 PM, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Thu, 29 Nov 2018 01:28:35 +0100
> 
>> On Wed, Nov 28, 2018 at 04:43:40PM -0600, Grygorii Strashko wrote:
>>> Hi Andrew,
>>>
>>> On 11/28/18 4:02 PM, Andrew Lunn wrote:
>>>>> This is dynamic configuration related to ALE VLAN entries and
>>>>> I do not see the way to support its auto-detection with current driver,
>>>>> unfortunately.
>>>>
>>>> I think you can subscribe to switchdev events which will tell you.
>>>
>>> Thanks a lot for your review and comments.
>>>
>>> Unfortunately, we still do not have switchdev in place, but i need to resolve
>>> existing issue somehow. This patch is small, local to CPSW fix which can be
>>> backported to stable. So, if possible, and no strong objection, could we proceed with it?
>>
>> Hi Grygorii
>>
>> David is the person who generally says no to kernel module
>> parameters. You should ask him.
> 
> No module options.
> 
> You'll be stuck with it forever.

Thank you for your feedback.

-- 
regards,
-grygorii
