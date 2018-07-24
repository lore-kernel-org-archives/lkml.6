Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9475120852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gq0Cf0Ko";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="neb7Cl/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9475120852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeGXIBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:01:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388245AbeGXIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:01:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B6BC6021A; Tue, 24 Jul 2018 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532415411;
        bh=0Ah+J2pk8Fpb/LvCSmHGrPfjsrMMRfnu1uL86mhbWTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gq0Cf0KoDioj9PcpNfL8Mt7aZKKLpqd4ybakW0JCZWbDtKZvHQ4CKLZEpW/8sFR1h
         IMGOvJ5Fo+112qbaPqpjWsUHRdVprYfTJeTBKp96uO4PUtf0tzeG5BC/dpRBSpTC1W
         X6sxwIs+2dnJ0KwDX7ueVPeviWLPTu4gXOG8JecM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 356376021A;
        Tue, 24 Jul 2018 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532415410;
        bh=0Ah+J2pk8Fpb/LvCSmHGrPfjsrMMRfnu1uL86mhbWTs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=neb7Cl/zozkEm4bhh1t0fMwQ0NFSxjdDVvl+1+C7oJJn8j3ef9BLhwRd+ZzCnTGMX
         z4zUYuL2FytpJe3YlNvacSWG7qjzAaL6cY42yd+xOnYc3BiDHL2mkghlo8nLKaqtM7
         54/rC0k98GzqrOO1fv/ya/GQ9M0mm6Iw78+FpJIc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Jul 2018 12:26:50 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to
 generic function.
In-Reply-To: <20180723174018.GK129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-4-bgodavar@codeaurora.org>
 <20180723174018.GK129942@google.com>
Message-ID: <d5764fcd8becc0b04373bc1113d2049a@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-23 23:10, Matthias Kaehlcke wrote:
> On Fri, Jul 20, 2018 at 07:02:39PM +0530, Balakrishna Godavarthi wrote:
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
>>  drivers/bluetooth/btqca.c   | 20 +++++++-------------
>>  drivers/bluetooth/btqca.h   | 13 +++++++++++--
>>  drivers/bluetooth/hci_qca.c | 10 +++++++++-
>>  3 files changed, 27 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index c5cf9cab438a..b556710ee1bd 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -85,6 +85,9 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 
>> *soc_version)
>>  out:
>>  	kfree_skb(skb);
>> 
>> +	if (err < 0 || *soc_version == 0)
>> +		bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> 
> You also have to set 'err' if soc_version is 0, so the caller can skip
> the check for soc_version == 0
> 
> I'd suggest:
> 
>   // directly after setting soc_version
>   if (*soc_version == 0)
>     err = -EILSEQ; // or should it be a different error code?
> 
>   ...
> 
>   if (err)
>     bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
> 
> You could also limit the error log to the 'if (*soc_version == 0)'
> branch, for all other errors there will already be a more specific log
> entry.
> 

[Bala]: will update.

     if(!err && *soc_version == 0)
         err = -EINVAL; // as soc_version zero is invalid.

    if (err)
       bt_dev_err(hdev, "QCA Failed to get version (%d)", err);

>> +
>>  	return err;
>>  }
> 
> Cheers
> 
> Matthias
-- 
Regards
Balakrishna.
