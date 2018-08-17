Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B0FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B4D21933
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="At501Eyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B4D21933
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeHQXAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:00:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56768 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeHQXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:00:22 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7HJtYGx011621;
        Fri, 17 Aug 2018 14:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534535734;
        bh=llMuZ94WEvEOXh2oSmwwifQDh1hx8UyhZVa4/msQHPE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=At501Eyojjnh9iF9YnMD1E5GOHu3kGTxbE7CvXFdGzWcmzAhJnZFIAHKCHVWyIFdc
         62u6C3OWJljJIrcmc1PfmkOkzPwp8wApmV6JWaB6mTLxziFa1OFJT2F8Yui1j6HFBJ
         Yn8Otp2tvTYTrRYkIYI/fk85I/QKJ8Vk6KdFuf4g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7HJtYZD032181;
        Fri, 17 Aug 2018 14:55:34 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 17
 Aug 2018 14:55:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 17 Aug 2018 14:55:34 -0500
Received: from [172.22.190.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7HJtXKk007133;
        Fri, 17 Aug 2018 14:55:33 -0500
Subject: Re: [PATCH v4 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <robh+dt@kernel.org>, <pavel@ucw.cz>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180816172058.31700-1-dmurphy@ti.com>
 <20180816172058.31700-2-dmurphy@ti.com>
 <9ef9cd25-5c73-964c-ac09-55c0c78e5dc9@gmail.com>
 <c751759a-d0c2-4ee7-2299-99d83538bdc4@ti.com>
 <24e05753-8ec7-e1b0-8671-8443bc20130a@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <9b82ae9f-330b-0150-f768-0c1955ab4582@ti.com>
Date:   Fri, 17 Aug 2018 14:55:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <24e05753-8ec7-e1b0-8671-8443bc20130a@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 08/17/2018 02:37 PM, Jacek Anaszewski wrote:
> Dan,
> 
> On 08/16/2018 10:44 PM, Dan Murphy wrote:
>> Jacek
>>
>> On 08/16/2018 02:58 PM, Jacek Anaszewski wrote:
>>> Dan,
>>>
>>> Thank you for the patch.
>>>
>>> I didn't review DT parsing details in v3, but now I've produced
>>> diff between v3 and v4 to check what has changed.
>>>
>>> I'm quite surprised realizing that you're not validating
>>> HVLED and control banks assignment, having in mind earlier
>>> discussions and your concerns about numerous DT configurations
>>> to check.
>>>
>>> Is it on purpose?
>>>
>>
>> Yes.  It was on purpose.  After sleeping on it and going through the overall
>> control to HVLED assignments I realized the user will know quite quickly
>> that their configuration is messed up.
>>
>> The suggestions actually simplified the code quite nicely which I am happier to have
> 
> Ack. Thanks for the v5 - I'll let it sit on the lists for a week anyway,
> until the merge window gets closed.
> 

Sounds good to me.

Dan

-- 
------------------
Dan Murphy
