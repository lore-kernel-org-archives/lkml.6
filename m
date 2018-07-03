Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE5DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AFF2242E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V7j1+Vh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AFF2242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeGCFKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:10:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56924 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753723AbeGCFKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:10:35 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w635AT3P117808;
        Tue, 3 Jul 2018 00:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530594629;
        bh=N+mip5XciUVSu1wWiIkrpbr8wx7syG6RmIQDn95LCpA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V7j1+Vh9dzn+BlX35H+09Y5O0yPqroVLvOVlwfDmTBB96XPgcjsyTc+a0enLzEPD+
         FhqCMaTXGyGkGKgZDaeKOf3wdLWwuEGCNyfqbRACMic++dwkLGg7lgEIVK+QZifrrf
         aKOleY7EQPtI7C7B/kNT5U5+iPngvep5Nm1oDJzo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w635ATbY001613;
        Tue, 3 Jul 2018 00:10:29 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 00:10:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 00:10:28 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w635AQOg026872;
        Tue, 3 Jul 2018 00:10:26 -0500
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
To:     Eduardo Valentin <edubezval@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Zhang Rui <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <10747698.EAsn0e6Ddm@amdc3058>
 <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
 <3318201.BAqn4C3t6k@amdc3058> <20180702163010.GA2380@localhost.localdomain>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
Date:   Tue, 3 Jul 2018 10:40:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180702163010.GA2380@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 02 July 2018 10:00 PM, Eduardo Valentin wrote:
> Keerthy,
> 
> On Fri, Jun 29, 2018 at 06:10:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
>>> Majority of this code (i.e. functions from ti-bandgap.c) has been
>>> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
>>> SoC thermal driver"). Just remove it altogether (in case it is needed
>>> it can be easily resurrected from git repo).
>>>
>>> While at it fix incorrect "not used" comments.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> ---
>>>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
>>>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
>>>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
>>>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
>>>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
>>>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
>>>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
>>>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
>>>  9 files changed, 5 insertions(+), 654 deletions(-)
>>
>> Gentle ping.
>>
>> It would be great to see this patch in v4.19.
> 
> Any objections on this removal / cleanup?

Tested the patch on dra72-EVM.
cpufreq cooling works well.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Keerthy <j-keerthy@ti.com>

Thanks for the clean up Bartalomiej!
> 
