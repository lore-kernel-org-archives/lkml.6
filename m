Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4176B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oZZg0KFY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PJndrxxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4176B20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbeGXIHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:07:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeGXIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:07:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 332E460B12; Tue, 24 Jul 2018 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532415758;
        bh=3lHI9iOOSuVXXibzegktnHz1Qyb70GXYn7x6mlN7YNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oZZg0KFYCddAu3UFIcwxACVhRm3H+By/KGKeTVAmnJpcOGdX0reP0FXauQ4FwmpUI
         N/w7cuO37VlOaAQE9/Xb3hNFSuk99euFEFjofM/TU03a0zSK6QoKZV6qdOF8FEH1F6
         n4hyqARUMtwMdbyObnKnu/N98tfr1MqwFpo36DZQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 400016021A;
        Tue, 24 Jul 2018 07:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532415756;
        bh=3lHI9iOOSuVXXibzegktnHz1Qyb70GXYn7x6mlN7YNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PJndrxxwyumjMXZT+ZM2kvyQpGStqye4QLhnIbub6EsWRQpZV3J8gn671hXNAoZBe
         ccyfpHmOZA0ezgG2E7ZXQxzMi7ExLN8zZkESwXUN5C72/B6SCuagEvgeiinfhPmbPg
         +Pio7g1Eo7ijYcEu/MoV1I0Zadtd8TxbUoeySi6E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 24 Jul 2018 12:32:36 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 4/7] Bluetooth: hci_qca: Add wrapper functions for
 setting UART speed
In-Reply-To: <20180723175611.GL129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-5-bgodavar@codeaurora.org>
 <20180723175611.GL129942@google.com>
Message-ID: <12b59e77a4ee99c3de7bbd73ff10ce4b@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-07-23 23:26, Matthias Kaehlcke wrote:
> On Fri, Jul 20, 2018 at 07:02:40PM +0530, Balakrishna Godavarthi wrote:
>> In function qca_setup, we set initial and operating speeds for 
>> Qualcomm
>> Bluetooth SoC's. This block of code is common across different
>> Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
>> a wrapper function to set the speeds. So that future coming SoC's
>> can use these wrapper functions to set speeds.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  drivers/bluetooth/hci_qca.c | 93 
>> ++++++++++++++++++++++++++++---------
>>  1 file changed, 70 insertions(+), 23 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 5f1c0a8fd5cd..5f8a74d65bec 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -119,6 +119,11 @@ struct qca_data {
>>  	u64 votes_off;
>>  };
>> 
>> +enum qca_speed_type {
>> +	QCA_INIT_SPEED = 1,
>> +	QCA_OPER_SPEED
>> +};
>> +
>>  struct qca_serdev {
>>  	struct hci_uart	 serdev_hu;
>>  	struct gpio_desc *bt_en;
>> @@ -923,6 +928,61 @@ static inline void host_set_baudrate(struct 
>> hci_uart *hu, unsigned int speed)
>>  		hci_uart_set_baudrate(hu, speed);
>>  }
>> 
>> +static unsigned int qca_get_speed(struct hci_uart *hu,
>> +				  enum qca_speed_type speed_type)
>> +{
>> +	unsigned int speed = 0;
>> +
>> +	if (speed_type == QCA_INIT_SPEED) {
>> +		if (hu->init_speed)
>> +			speed = hu->init_speed;
>> +		else if (hu->proto->init_speed)
>> +			speed = hu->proto->init_speed;
>> +	} else {
>> +		if (hu->oper_speed)
>> +			speed = hu->oper_speed;
>> +		else if (hu->proto->oper_speed)
>> +			speed = hu->proto->oper_speed;
>> +	}
>> +
>> +	return speed;
>> +}
>> +
>> +static int qca_check_speeds(struct hci_uart *hu)
>> +{
>> +	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
>> +	    !qca_get_speed(hu, QCA_OPER_SPEED))
>> +		return -EINVAL;
> 
> You changed this from:
> 
> 	/* One or the other speeds should be non zero. */
> 	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
> 	    !qca_get_speed(hu, QCA_OPER_SPEED))
> 		return -EINVAL;
> 
> There is no entry in the change log. What is the reason for this
> change?

[Bala] : My bad i missed to add the log,as the above  if for ROME chip, 
having INIT or OPER speed is fine.

-- 
Regards
Balakrishna.
