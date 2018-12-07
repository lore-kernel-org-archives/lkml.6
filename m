Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EEFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59420850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 04:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qm+1WkYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E59420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLGEcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:32:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41252 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 23:32:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB74Vx3O026431;
        Thu, 6 Dec 2018 22:31:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544157119;
        bh=4pqQDszV9eB7pWQQz9A4RljAqst4q3FprFXuzUBEN28=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qm+1WkYau01gDunC7sWXHnPpHJ8NSeHszgOLZxFgE/kwxf56SuAHQG/FgctNPqmn7
         z4JvRXYLbUJpE/h3TNMev6KQR+i68BOKEF1RQ0o4pOEmSBy7WsHJPzlw8n2C7m7IOf
         wlj4N4rwQDituk0vst2PHLM1H7AcUMsxhdT5g0mI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB74Vxkr040133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 22:31:59 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 22:31:59 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 22:31:58 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB74Vr7F014709;
        Thu, 6 Dec 2018 22:31:55 -0600
Subject: Re: [PATCH v10 0/6] Support for Qualcomm UFS QMP PHY on SDM845
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
CC:     Subhash Jadavani <subhashj@codeaurora.org>,
        <asutoshd@codeaurora.org>, <evgreen@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        robh+dt <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
 <CAFp+6iH9sz3NsejvxLdgAy+E-6Rff9RDA74EtnSidWOuZN=q9w@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2835270c-79aa-81fc-574a-5cb48a542260@ti.com>
Date:   Fri, 7 Dec 2018 10:01:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFp+6iH9sz3NsejvxLdgAy+E-6Rff9RDA74EtnSidWOuZN=q9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/12/18 12:31 PM, Vivek Gautam wrote:
> On Tue, Oct 23, 2018 at 10:07 AM Can Guo <cang@codeaurora.org> wrote:
>>
>> This patch series adds support for UFS QMP PHY on SDM845 and the
>> compatible string for it. This patch series depends on the current
>> proposed QMP V3 USB3 UNI PHY support for sdm845 driver [1], on
>> the DT bindings for the QMP V3 USB3 PHYs based dirver [2], and also
>> rebased on updated pipe_clk initialization sequence [3]. This series
>> can only be merged once the dependent patches do.
>> [1] http://lists-archives.com/linux-kernel/29071659-dt-bindings-phy-qcom-qmp-update-bindings-for-sdm845.html
>> [2] http://lists-archives.com/linux-kernel/29071660-phy-qcom-qmp-add-qmp-v3-usb3-uni-phy-support-for-sdm845.html
>> [3] https://patchwork.kernel.org/patch/10376551/
> 
> Besides my comment for PATCH 4/6, I have already reviewed the entire series,
> and it looks good.
> If adding new bindings for sdm845 needs a further review, can you separate out
> just the phy patches from this series (patch 1, 2, 3 & 6), and re-send them.
> We can ask Kishon if he can pull them in for this merge window.
> Thanks.

Looks like the PHY patches has gone in the previous merge window itself. If
there are any changes, please post only the diff as a separate patch.

Thanks
Kishon
> 
> best regards
> Vivek
> 
>>
>> Changes since v9:
>> - Incorporated review comments from Rob.
>>
>> Changes since v8:
>> - Add one new change to support ufs core reset.
>> - Incorporated review comments from Evan, Vivek.
>>
>> Changes since v7:
>> - Add one new change to update UFS PHY power on sequence
>> - Incorporated review comments from Evan, Vivek and Manu.
>>
>> Changes since v6:
>> - Add one new change to clean up some structs and field
>> - Updates the PHY power control sequence.
>> - Incorporated review comments from Vivek and Manu.
>>
>> Changes since v5:
>> - Updates the PHY power control sequence.
>> - Updates UFS PHY power on condition check.
>>
>> Changes since v4:
>> - Adds 'ref_aux' clock back to SDM845 UFS PHY clock list.
>> - Power on PHY before serdes configuration starts.
>> - Updates the UFS PHY initialization sequence.
>> - Updates a few UFS PHY registers.
>> - Incorporated review comments from Vivek and Manu.
>>
>> Changes since v3:
>> - Incorporated review comments from Vivek and Rob.
>>
>> Changes since v2:
>> - Incorporated review comments from Vivek and Rob.
>> - Remove "ref_aux" from sdm845 ufs phy clock list structure.
>>
>> Changes since v1:
>> - Incorporated review comments from Vivek and Manu.
>> - Update the commit title of patch 2.
>>
>> Can Guo (5):
>>   phy: Update PHY power control sequence
>>   phy: General struct and field cleanup
>>   phy: Add QMP phy based UFS phy support for sdm845
>>   scsi: ufs: Power on phy after it is initialized
>>   dt-bindings: phy-qcom-qmp: Add UFS phy compatible string for sdm845
>>
>> Dov Levenglick (1):
>>   scsi: ufs: Add core reset support
>>
>>  .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   4 +-
>>  drivers/phy/qualcomm/phy-qcom-qmp.c                | 216 +++++++++++++++++++--
>>  drivers/phy/qualcomm/phy-qcom-qmp.h                |  15 ++
>>  drivers/scsi/ufs/ufs-qcom.c                        |  34 +++-
>>  drivers/scsi/ufs/ufs-qcom.h                        |   1 +
>>  drivers/scsi/ufs/ufshcd-pltfrm.c                   |  22 +++
>>  drivers/scsi/ufs/ufshcd.c                          |  13 ++
>>  drivers/scsi/ufs/ufshcd.h                          |  12 ++
>>  8 files changed, 296 insertions(+), 21 deletions(-)
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 
> 
