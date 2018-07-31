Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13D6208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UeM9j80D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NF1gqko4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13D6208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGaMAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:00:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36588 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbeGaMAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:00:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E4D08606AC; Tue, 31 Jul 2018 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533032459;
        bh=2XriKMqP55PKRooATG3UH3pkFezmRYjtk0efEMQkWow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UeM9j80DZiuBiUt6MdSk23ga5drD88RdKW1rdXnE9T1rZ27UGQE/rqSDgwBaWUOsC
         Sj/OpN9Z/uxkQm8Phc6wm5/7OFMzQ40BQMcq4yVeUCvAZ1xzCMaenY0VNytJKJ3PUU
         tEh2K6dei4gCYsAR8uSq5WodNgoWu1Wd25FpmF6c=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 052DD60397;
        Tue, 31 Jul 2018 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533032458;
        bh=2XriKMqP55PKRooATG3UH3pkFezmRYjtk0efEMQkWow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NF1gqko4XeszfDaS0zEu2rfeZ4KrGbcof0npXhJUTCKqRi/7MNqRorge3pMuiJ4de
         BsQRiFE2d7MZwDFEbrCObvomVn/iZGLmRPMjCouZO96IgWmFEFEecPViV4+/erUH66
         zkp2mtg6n/DYYsaMLNE9OZfFnCLZHMqbS0n9QKsM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 15:50:57 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v11 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180730183708.GA68975@google.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
 <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
 <20180730183708.GA68975@google.com>
Message-ID: <c82dd36d4935a2fad015847a9fd49fc0@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-31 00:07, Matthias Kaehlcke wrote:
> On Fri, Jul 27, 2018 at 07:43:16PM +0530, Balakrishna Godavarthi wrote:
>> From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> 
>> Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
>> SoC, to use the same function instead of duplicating the function.
>> Added new arguments soc_type and soc_ver to the functions.
>> 
>> These arguments will help to decide type of firmware files
>> to be loaded into Bluetooth chip.
>> soc_type holds the Bluetooth chip connected to APPS processor.
>> soc_ver holds the Bluetooth chip version.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> Changes in v11:
>>       * added error log in qca_read_soc_version() instead of 
>> qca_setup()
>> ---
>>  drivers/bluetooth/btqca.c   | 23 ++++++++++-------------
>>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>>  3 files changed, 30 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index c5cf9cab438a..b2163bf75b95 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -85,6 +85,12 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 
>> *soc_version)
>>  out:
>>  	kfree_skb(skb);
>> 
>> +	if (!err && *soc_version == 0)
>> +		err = -EILSEQ;
> 
> nit: better do this right after assigning SoC version. No need to
> respin the series just for this though.

[Bala]: will update.

-- 
Regards
Balakrishna.
