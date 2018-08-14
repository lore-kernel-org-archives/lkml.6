Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7648C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EED2173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 05:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hxkrzHLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EED2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeHNIGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 04:06:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60662 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeHNIGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 04:06:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7E5L0Jb063919;
        Tue, 14 Aug 2018 00:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534224060;
        bh=zL8uW+2v4vezwygo5hDXLtQB6H1rbJz/qx66AvbSGIE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hxkrzHLi8ZAx48TRQbpPAHQEiac2/u/3J7LMx9aNPQOYyWoXf+dHFY44o68TWGopM
         FpgW+NDE+v2ujQuaumucI65AkE6eC7V/jff8qq5sFZWc5b+wSnxawzRFszV1Z2vcDg
         A6kCKS7hx5FYT6hEhVClXWSETWCV16AfbXKyO9m8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E5L0Hh024445;
        Tue, 14 Aug 2018 00:21:00 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 14
 Aug 2018 00:20:59 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 14 Aug 2018 00:20:59 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7E5Ktjm003486;
        Tue, 14 Aug 2018 00:20:56 -0500
Subject: Re: [PATCH] remoteproc/davinci: Mark error recovery as disabled
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180723232757.9147-1-s-anna@ti.com>
 <0550997f-8e32-fb56-2a70-74235b969ce2@ti.com> <20180813185224.GG5090@builder>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <5a6e69f7-7da1-1b8e-d082-18f39d5139dc@ti.com>
Date:   Tue, 14 Aug 2018 10:50:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813185224.GG5090@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Tuesday 14 August 2018 12:22 AM, Bjorn Andersson wrote:
> On Mon 13 Aug 08:11 PDT 2018, Suman Anna wrote:
> 
>> Hi Bjorn,
>>
>> On 07/23/2018 06:27 PM, Suman Anna wrote:
>>> The Davinci remoteproc driver does not support error recovery at
>>> present, so mark the corresponding remoteproc flag appropriately
>>> so that the debugfs flag shows the value as 'disabled' by default.
>>>
>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>
>> Can you pick up this minor patch for 4.19 please, I do not see this in
>> your rproc-next branch?
>>
> 
> Of course, the patch is applied now, will send my pull request in a few
> days.

Can you also please pick patch 1/4 here:

https://patchwork.kernel.org/patch/10479365/

Thanks,
Sekhar
