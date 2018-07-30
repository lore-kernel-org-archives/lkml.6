Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0013F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8DE20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sivOO85I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8DE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbeG3Oa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:30:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42273 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731047AbeG3Oa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:30:56 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so20982122oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g9VSiufxoTVg9kkflyBAqaVUYuRCwSab36rQdFSxntM=;
        b=sivOO85It6GR/x8OElM+V3mKKlbQuMgZMptbXRVbEvdFVn/SJqVAqEvFnAsYjoNEAf
         DH/lDDgxzhjP8qE+CkxP45Tjor/EluBqR8N0pLdYATf8EcFIZyhqA6cfjbBUf+yP35oR
         f4UWDCAL+197VHAW1FNhzAqZAPQm4QrODaHPS3DM0p1RUnUY1Za81Qc7Yq1FITtfjQr2
         o0g/TAA4I2T4az+dKwabklAAzBi5KEXFDgdHbLRvw0Z5lH+XGqNdiHSzqAWLQpeEA4KJ
         XiWwJTXkPZCMgyQPdkDt6WRNDOLadaAqlYbiDxLJLyCC/XKzudPiDJb+gOlPt/LRk602
         XA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=g9VSiufxoTVg9kkflyBAqaVUYuRCwSab36rQdFSxntM=;
        b=Z7W74zGx9s8xq7nBGHkjq4Iw9URNAVk1tB6+Pi/vY3/oFAMhG2NVyzUDZfJ3WdFTAT
         7ewyjbQnEmJrdVmJ16suHAfrwfg8H9GOC10mODOlDLfYqXWz3lQ5Zp+D2/YvKeBTyQfL
         5FSUZ4yoJJQMZOwh/6HYvC8Uk7gk2Yb61HBxNfGrSzXGF7Pj4PNARAF4QqelcXCHwozo
         vqeNlmd6M0xpfM4lcuZ+8RO1BY0Z0StpyX8U2uenwJEiTxVjaQFyQzPmkhiNeIlk+OnG
         QQatJPU4DrL/aE4C4IqO6KIqLhcDNNFzCKCVrR+u/gaPJmuWMFLotc1pH3KF0S4jXoJX
         HhUQ==
X-Gm-Message-State: AOUpUlFUZ5svqloH6fUxaHh1AtxTFaRyUIOcTE15bnOdQfaXpdoH0j2E
        FNJFW1zpvWHWD0hrLxed4oMh7+g=
X-Google-Smtp-Source: AAOMgpdWfhBtw2mxwCIz4zgZq1yX51L0vrYIXQvn3+WFKEOki95CPs5crs0+416qSRQVevrN0vJg2g==
X-Received: by 2002:aca:d609:: with SMTP id n9-v6mr16600569oig.357.1532955364376;
        Mon, 30 Jul 2018 05:56:04 -0700 (PDT)
Received: from serve.minyard.net ([47.184.142.199])
        by smtp.gmail.com with ESMTPSA id o206-v6sm7895167oif.7.2018.07.30.05.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 05:56:03 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id 086157A2;
        Mon, 30 Jul 2018 07:56:03 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v3] ipmi: update ssif max_xmit_msg_size limit for
 multi-part messages
To:     Kamlakant Patel <kamlakant.patel@cavium.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@cavium.com>,
        jayachandran.nair@cavium.com
References: <1532947868-21907-1-git-send-email-kamlakant.patel@cavium.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <28921428-369d-4892-6bc2-b7e3f418c920@acm.org>
Date:   Mon, 30 Jul 2018 07:56:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532947868-21907-1-git-send-email-kamlakant.patel@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 05:51 AM, Kamlakant Patel wrote:
> Currently, by setting the xmit_msg_size to 63, the ssif driver never
> does a SSIF_MULTI_n_PART, it falls back to only SSIF_MULTI_2_PART.
> Due to this all IPMI commands with request size more than 63 bytes
> will not work.
>
> As per IPMI spec 2.0 (section 12.15, Table 10), SSIF supports message
> length up to 255 bytes. In a multi-part message, the first part must
> carry 32 bytes with command 06h. All intermediate ("middle") parts must
> carry 32 bytes with command 07h and the number of message data bytes in
> the End transaction can range from 1 to 32 bytes with command 08h.
>
> Update ssif max_xmit_msg_size to handle multi-part messages up
> to 255 bytes.
> Enable command(08h) for End part transaction.

You don't think it's a good idea to test what the BMC is capable of 
doing, per
the patch I sent you earlier?

-corey

> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> Suggested-by: Robert Richter <robert.richter@cavium.com>
> Reported-by: Karthikeyan M <karthikeyanm@amiindia.co.in>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 38 +++++++++++++++++++++++++++-----------
>   1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 18e4650..ada59b7 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -60,6 +60,7 @@
>   #define	SSIF_IPMI_REQUEST			2
>   #define	SSIF_IPMI_MULTI_PART_REQUEST_START	6
>   #define	SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE	7
> +#define	SSIF_IPMI_MULTI_PART_REQUEST_END	8
>   #define	SSIF_IPMI_RESPONSE			3
>   #define	SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE	9
>   
> @@ -88,6 +89,8 @@
>   #define SSIF_MSG_JIFFIES	((SSIF_MSG_USEC * 1000) / TICK_NSEC)
>   #define SSIF_MSG_PART_JIFFIES	((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
>   
> +#define SSIF_MAX_MSG_LENGTH	255
> +
>   enum ssif_intf_state {
>   	SSIF_NORMAL,
>   	SSIF_GETTING_FLAGS,
> @@ -887,28 +890,39 @@ static void msg_written_handler(struct ssif_info *ssif_info, int result,
>   		 */
>   		int left;
>   		unsigned char *data_to_send;
> +		int command;
>   
>   		ssif_inc_stat(ssif_info, sent_messages_parts);
>   
>   		left = ssif_info->multi_len - ssif_info->multi_pos;
> -		if (left > 32)
> -			left = 32;
> +
>   		/* Length byte. */
> -		ssif_info->multi_data[ssif_info->multi_pos] = left;
> +		ssif_info->multi_data[ssif_info->multi_pos] =
> +						left > 32 ? 32 : left;
>   		data_to_send = ssif_info->multi_data + ssif_info->multi_pos;
> -		ssif_info->multi_pos += left;
> -		if (left < 32)
> +		ssif_info->multi_pos += left > 32 ? 32 : left;
> +		command = SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE;
> +		if (left <= 32) {
>   			/*
>   			 * Write is finished.  Note that we must end
> -			 * with a write of less than 32 bytes to
> -			 * complete the transaction, even if it is
> -			 * zero bytes.
> +			 * with a write up to 32 bytes to complete the
> +			 * transaction, even if it is zero bytes.
> +			 * The number of message data bytes in the End
> +			 * transaction can range from 1 to 32 bytes.
> +			 * As per IPMI spec 2.0(section 12.15,Table 12-10),
> +			 * the BMC Multi-part Write commands are:
> +			 * Start-first part	- 06h
> +			 * Middle-part(s)	- 07h
> +			 * End-part		- 08h
> +			 * Update command for END part transaction.
>   			 */
>   			ssif_info->multi_data = NULL;
> +			command = SSIF_IPMI_MULTI_PART_REQUEST_END;
> +		}
>   
>   		rv = ssif_i2c_send(ssif_info, msg_written_handler,
>   				  I2C_SMBUS_WRITE,
> -				  SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
> +				  command,
>   				  data_to_send,
>   				  I2C_SMBUS_BLOCK_DATA);
>   		if (rv < 0) {
> @@ -1499,9 +1513,11 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   			 * start and the next message is always going
>   			 * to be 1-31 bytes in length.  Not ideal, but
>   			 * it should work.
> +			 * As per IPMI spec 2.0, SSIF interface supports
> +			 * message size up to 255 bytes.
>   			 */
> -			if (ssif_info->max_xmit_msg_size > 63)
> -				ssif_info->max_xmit_msg_size = 63;
> +			if (ssif_info->max_xmit_msg_size > SSIF_MAX_MSG_LENGTH)
> +				ssif_info->max_xmit_msg_size = SSIF_MAX_MSG_LENGTH;
>   			break;
>   
>   		default:


