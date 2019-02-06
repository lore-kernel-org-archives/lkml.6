Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E74C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDB020823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="py/EgKAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfBFMMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:12:52 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42350 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:12:52 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CCbGe119057;
        Wed, 6 Feb 2019 06:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549455157;
        bh=aTXJoHjZrTxB9HWsAqHtVH3z4yopcQx3yIgYgSypLXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=py/EgKAp02I+T/KsSisNwc4ec3pXBBo7y3xeTHBvrr38ZPOdvYIQAojBlHuKhc/lM
         kUV54PHz10js+UciB3ULOeVhKL+eZCnChFzInKVqHAQAjd1qR8I6UMe3etIFL45TsI
         RlPMywC9JdRMVN02hGJFw65RIPT+yCzGLVOOUs6Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16CCbKm044300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 06:12:37 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:12:37 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:12:37 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16CCW16020247;
        Wed, 6 Feb 2019 06:12:33 -0600
Subject: Re: [PATCH v3 6/8] scsi: ufs: qcom: Expose the reset controller for
 PHY
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
CC:     Stephen Boyd <swboyd@chromium.org>, Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
 <20190205185902.106085-7-evgreen@chromium.org>
 <10ea3fe2-e331-0342-cfad-eccce3753d2e@ti.com>
 <8d94b1ae-8084-ed06-19ed-36dd99837703@free.fr>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <720c0327-e6b7-67f8-7756-d3861d66dede@ti.com>
Date:   Wed, 6 Feb 2019 17:42:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8d94b1ae-8084-ed06-19ed-36dd99837703@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 06/02/19 5:24 PM, Marc Gonzalez wrote:
> On 06/02/2019 12:42, Kishon Vijay Abraham I wrote:
> 
>> On 06/02/19 12:29 AM, Evan Green wrote:
>>
>>> Expose a reset controller that the phy will later use to control its
>>> own PHY reset in the UFS controller. This will enable the combining
>>> of PHY init functionality into a single function.
>>>
>>> Signed-off-by: Evan Green <evgreen@chromium.org>
>>
>> I'd like to get ACK from scsi/ufs/ MAINTAINER Vinayak for me merge it in PHY tree.
> 
> Kishon, I haven't seen any messages from Vinayak in a while.
> 
> https://patchwork.kernel.org/patch/10795501/
> 
> New reviewers are Alim, Avri, and Pedro (haven't heard from Pedro yet).

Thanks for letting me know.

Alim, Avri,

Can you give your ACK for this patch?

Thanks
Kishon
> 
> Regards.
> 
