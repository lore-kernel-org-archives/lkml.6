Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0718C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45308208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPyeiHPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45308208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH1AgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:36:06 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36760 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1AgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:36:06 -0400
Received: by mail-oi0-f66.google.com with SMTP id r69-v6so644004oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fn1pXpN2U+DN1rHfpjRTaNy+wJdgncIVsmwMjBdUvPU=;
        b=JPyeiHPPqWBpq+3ZpwGFSoN14LQBdjisKI8fl5HQ0Zsk70dDy3imhqCIuDCAXS9Aj7
         zKUDGJ0Y/AKF1kNTpaUlfRgjFxKzIzjjF+var0UjxG9j6tNwgBgE2i5di8cl01ZFOcxn
         GCI1nBIc5DB62cTWu8kPk269lTov2P9mxys0f5razobX9B11uNcCc/KuFwkhc5W/d0+Q
         ykc560Syaxs3h0+06YCuLb2gAotIeEUno6fEUedtCt0l0FhZhY5AXSHTi5Nq4+edud8z
         EZl1Z8my68ttftZrRgcTU7JXcvkCTQCe7ndXIuRGqbpSkoBvNoiAO2acL3pBPFVMnOzQ
         A1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=Fn1pXpN2U+DN1rHfpjRTaNy+wJdgncIVsmwMjBdUvPU=;
        b=cd/Il1Qzvky4wfvvxn14nYOV3A7PUBT1N2B5d2VlU8z38ZT20G/1l9mBcx8hH1i+pj
         g47GQTMaAymXQ1sEeY0SgZMTGcFAPXWWWT4OJ7DCk5yGySrba9P06lzGcdTIsYWGW6W4
         mX/hWG75bbtwJBWg6Pzgq4hGVTIYaQ/qibB+EvXUawXudKtoXJgNlzlQefKGq7cXwyzN
         uQP5VYPVttiIkKAVgPCHO59M0gUVpuF9iXu8G5YOmPqbhI1eqZshW1W+LS5MEVKJFR7K
         JtAG78ahgYCe8yv738VIrIViJEOR330wwldbnRhNQGM0xEEv1syG6OkMaHZq5Y2vt+TS
         7o8w==
X-Gm-Message-State: APzg51A208lmdIJGSvnQs+jLDnjljzP8QKwO7XG6ZK9SRhfnKjEOLnu6
        UpwS6oRaIMu+/9RYwRWA0cJfiMQ=
X-Google-Smtp-Source: ANB0VdZw3EfRcR0CCKlkgzG2zu+5qH4Bqlbv/Xe5DjL4PFMtUxpa7KiDUeYL1hA4l7v9GONYeanlBw==
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr248953oif.235.1535402871322;
        Mon, 27 Aug 2018 13:47:51 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id x5-v6sm390163oix.3.2018.08.27.13.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:47:50 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:fcd1:4328:3a3e:96be] (unknown [IPv6:2001:470:b8f6:1b:fcd1:4328:3a3e:96be])
        by serve.minyard.net (Postfix) with ESMTPSA id 652373A8;
        Mon, 27 Aug 2018 15:47:49 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect
 call
To:     "Banman, Andrew" <abanman@hpe.com>
Cc:     "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "Ramsay, Frank" <frank.ramsay@hpe.com>,
        "Ernst, Justin" <justin.ernst@hpe.com>,
        Corey Minyard <cminyard@mvista.com>
References: <1535056623-26634-1-git-send-email-minyard@acm.org>
 <1535056623-26634-2-git-send-email-minyard@acm.org>
 <TU4PR8401MB0430BCEBB2F6C81611054555A60B0@TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <32b44854-93bd-57cd-2aab-f8cebc1bc0a9@acm.org>
Date:   Mon, 27 Aug 2018 15:47:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <TU4PR8401MB0430BCEBB2F6C81611054555A60B0@TU4PR8401MB0430.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 03:16 PM, Banman, Andrew wrote:
> Tested-by: Andrew Banman
>
> Ran through 100+ boots with no error with your 1st patch applied. I don't see any endcases to worry about.
>

Thanks for the testing, it's queued for the next release.

-corey

> Thanks Corey!
>
> Andrew
>
>> -----Original Message-----
>> From: Corey Minyard [mailto:tcminyard@gmail.com] On Behalf Of
>> minyard@acm.org
>> Sent: Thursday, August 23, 2018 3:37 PM
>> To: Banman, Andrew <abanman@hpe.com>
>> Cc: openipmi-developer@lists.sourceforge.net; linux-
>> kernel@vger.kernel.org; Anderson, Russ <russ.anderson@hpe.com>; Ramsay,
>> Frank <frank.ramsay@hpe.com>; Ernst, Justin <justin.ernst@hpe.com>;
>> Corey Minyard <cminyard@mvista.com>
>> Subject: [PATCH 1/2] ipmi: Move BT capabilities detection to the detect
>> call
>>
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> The capabilities detection was being done as part of the normal
>> state machine, but it was possible for it to be running while
>> the upper layers of the IPMI driver were initializing the
>> device, resulting in error and failure to initialize.
>>
>> Move the capabilities detection to the the detect function,
>> so it's done before anything else runs on the device.  This also
>> simplifies the state machine and removes some code, as a bonus.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> Reported-by: Andrew Banman <abanman@hpe.com>
>> ---
>>   drivers/char/ipmi/ipmi_bt_sm.c | 92 ++++++++++++++++++++++-------------
>> -------
>>   1 file changed, 48 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_bt_sm.c
>> b/drivers/char/ipmi/ipmi_bt_sm.c
>> index cbc6126..b4133832e 100644
>> --- a/drivers/char/ipmi/ipmi_bt_sm.c
>> +++ b/drivers/char/ipmi/ipmi_bt_sm.c
>> @@ -59,8 +59,6 @@ enum bt_states {
>>   	BT_STATE_RESET3,
>>   	BT_STATE_RESTART,
>>   	BT_STATE_PRINTME,
>> -	BT_STATE_CAPABILITIES_BEGIN,
>> -	BT_STATE_CAPABILITIES_END,
>>   	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
>>   };
>>
>> @@ -86,7 +84,6 @@ struct si_sm_data {
>>   	int		error_retries;	/* end of "common" fields */
>>   	int		nonzero_status;	/* hung BMCs stay all 0 */
>>   	enum bt_states	complete;	/* to divert the state machine */
>> -	int		BT_CAP_outreqs;
>>   	long		BT_CAP_req2rsp;
>>   	int		BT_CAP_retries;	/* Recommended retries */
>>   };
>> @@ -137,8 +134,6 @@ static char *state2txt(unsigned char state)
>>   	case BT_STATE_RESET3:		return("RESET3");
>>   	case BT_STATE_RESTART:		return("RESTART");
>>   	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
>> -	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
>> -	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
>>   	}
>>   	return("BAD STATE");
>>   }
>> @@ -185,7 +180,6 @@ static unsigned int bt_init_data(struct si_sm_data
>> *bt, struct si_sm_io *io)
>>   	bt->complete = BT_STATE_IDLE;	/* end here */
>>   	bt->BT_CAP_req2rsp = BT_NORMAL_TIMEOUT * USEC_PER_SEC;
>>   	bt->BT_CAP_retries = BT_NORMAL_RETRY_LIMIT;
>> -	/* BT_CAP_outreqs == zero is a flag to read BT Capabilities */
>>   	return 3; /* We claim 3 bytes of space; ought to check SPMI table
>> */
>>   }
>>
>> @@ -447,7 +441,7 @@ static enum si_sm_result error_recovery(struct
>> si_sm_data *bt,
>>
>>   static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
>>   {
>> -	unsigned char status, BT_CAP[8];
>> +	unsigned char status;
>>   	static enum bt_states last_printed = BT_STATE_PRINTME;
>>   	int i;
>>
>> @@ -500,12 +494,6 @@ static enum si_sm_result bt_event(struct si_sm_data
>> *bt, long time)
>>   		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
>>   			BT_CONTROL(BT_H_BUSY);
>>
>> -		bt->timeout = bt->BT_CAP_req2rsp;
>> -
>> -		/* Read BT capabilities if it hasn't been done yet */
>> -		if (!bt->BT_CAP_outreqs)
>> -			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
>> -					SI_SM_CALL_WITHOUT_DELAY);
>>   		BT_SI_SM_RETURN(SI_SM_IDLE);
>>
>>   	case BT_STATE_XACTION_START:
>> @@ -610,37 +598,6 @@ static enum si_sm_result bt_event(struct si_sm_data
>> *bt, long time)
>>   		BT_STATE_CHANGE(BT_STATE_XACTION_START,
>>   				SI_SM_CALL_WITH_DELAY);
>>
>> -	/*
>> -	 * Get BT Capabilities, using timing of upper level state machine.
>> -	 * Set outreqs to prevent infinite loop on timeout.
>> -	 */
>> -	case BT_STATE_CAPABILITIES_BEGIN:
>> -		bt->BT_CAP_outreqs = 1;
>> -		{
>> -			unsigned char GetBT_CAP[] = { 0x18, 0x36 };
>> -			bt->state = BT_STATE_IDLE;
>> -			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
>> -		}
>> -		bt->complete = BT_STATE_CAPABILITIES_END;
>> -		BT_STATE_CHANGE(BT_STATE_XACTION_START,
>> -				SI_SM_CALL_WITH_DELAY);
>> -
>> -	case BT_STATE_CAPABILITIES_END:
>> -		i = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
>> -		bt_init_data(bt, bt->io);
>> -		if ((i == 8) && !BT_CAP[2]) {
>> -			bt->BT_CAP_outreqs = BT_CAP[3];
>> -			bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
>> -			bt->BT_CAP_retries = BT_CAP[7];
>> -		} else
>> -			pr_warn("IPMI BT: using default values\n");
>> -		if (!bt->BT_CAP_outreqs)
>> -			bt->BT_CAP_outreqs = 1;
>> -		pr_warn("IPMI BT: req2rsp=%ld secs retries=%d\n",
>> -			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
>> -		bt->timeout = bt->BT_CAP_req2rsp;
>> -		return SI_SM_CALL_WITHOUT_DELAY;
>> -
>>   	default:	/* should never occur */
>>   		return error_recovery(bt,
>>   				      status,
>> @@ -651,6 +608,11 @@ static enum si_sm_result bt_event(struct si_sm_data
>> *bt, long time)
>>
>>   static int bt_detect(struct si_sm_data *bt)
>>   {
>> +	unsigned char GetBT_CAP[] = { 0x18, 0x36 };
>> +	unsigned char BT_CAP[8];
>> +	enum si_sm_result smi_result;
>> +	int rv;
>> +
>>   	/*
>>   	 * It's impossible for the BT status and interrupt registers to be
>>   	 * all 1's, (assuming a properly functioning, self-initialized BMC)
>> @@ -661,6 +623,48 @@ static int bt_detect(struct si_sm_data *bt)
>>   	if ((BT_STATUS == 0xFF) && (BT_INTMASK_R == 0xFF))
>>   		return 1;
>>   	reset_flags(bt);
>> +
>> +	/*
>> +	 * Try getting the BT capabilities here.
>> +	 */
>> +	rv = bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
>> +	if (rv) {
>> +		dev_warn(bt->io->dev,
>> +			 "Can't start capabilities transaction: %d\n", rv);
>> +		goto out_no_bt_cap;
>> +	}
>> +
>> +	smi_result = SI_SM_CALL_WITHOUT_DELAY;
>> +	for (;;) {
>> +		if (smi_result == SI_SM_CALL_WITH_DELAY ||
>> +		    smi_result == SI_SM_CALL_WITH_TICK_DELAY) {
>> +			schedule_timeout_uninterruptible(1);
>> +			smi_result = bt_event(bt, jiffies_to_usecs(1));
>> +		} else if (smi_result == SI_SM_CALL_WITHOUT_DELAY) {
>> +			smi_result = bt_event(bt, 0);
>> +		} else
>> +			break;
>> +	}
>> +
>> +	rv = bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
>> +	bt_init_data(bt, bt->io);
>> +	if (rv < 8) {
>> +		dev_warn(bt->io->dev, "bt cap response too short: %d\n", rv);
>> +		goto out_no_bt_cap;
>> +	}
>> +
>> +	if (BT_CAP[2]) {
>> +		dev_warn(bt->io->dev, "Error fetching bt cap: %x\n",
>> BT_CAP[2]);
>> +out_no_bt_cap:
>> +		dev_warn(bt->io->dev, "using default values\n");
>> +	} else {
>> +		bt->BT_CAP_req2rsp = BT_CAP[6] * USEC_PER_SEC;
>> +		bt->BT_CAP_retries = BT_CAP[7];
>> +	}
>> +
>> +	dev_info(bt->io->dev, "req2rsp=%ld secs retries=%d\n",
>> +		 bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
>> +
>>   	return 0;
>>   }
>>
>> --
>> 2.7.4


