Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7957725741
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 10:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVCnZ9SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7957725741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755219AbeFYKLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 06:11:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39367 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbeFYKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 06:11:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so9283109wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ru3hr/gRvD/nBDYeonPRClEZqe0mxIyV9HLOXn7XRsk=;
        b=NVCnZ9SLfod72NjgAQSgXBGejdW/NBTeOwbEyktpc+BfCa5ap6CdqNjGvJnw8s7o30
         hvbxAIyCPB0c3A/L+UtLc7a75kdipsFV8pR4Ei0BTypsOWzGkAXmDcvvn4M3DFibd18J
         MdRXJH5+bfSzZZnery3yqiDZRloX4U522T0mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ru3hr/gRvD/nBDYeonPRClEZqe0mxIyV9HLOXn7XRsk=;
        b=r0/EvKO2LY0gWT8DaEOwOOXEPFTSHqSDvqNoDMk460XpbCT8XOjgQDbz+MZpK02jBE
         lkXU9W9cDAzLzcAGsN1QB5Ba9nNUrAIvE6zHpjRaIcb5NJAbFoahpZhwTf9yiGDywDS+
         FZJgw9VLHdJFMpP3CflduGFZwSUJzqITPRoNMZs62daqCJEyice/CPMWUErAF4JIz6i7
         Sj/SpYFYe97eycLqSz1+Em67P3nVZiVXNdnZ7hP5w1QUvouNCVfV/IBf4AQa271thnff
         XhaoNgibete7MmQLrPR7k7h5y4O31UZpz7IE2jMAABk9AgeRciM/rh73QjL7Om7btXVt
         4L7w==
X-Gm-Message-State: APt69E1CPypSvomoA4SrCHsyEMdu4EGouuvkUuL/W7CE4XY6if6tSSxJ
        BN5wC5m5GYagH9ZSj6YPk8mhGw==
X-Google-Smtp-Source: AAOMgpcrQBDbdEdLPaNOs0ybfAzoixXiya0tiJTl3mBGejo6eYBmv1TP+xGAW6kDXzMauJyszvis4A==
X-Received: by 2002:a1c:d884:: with SMTP id p126-v6mr461669wmg.110.1529921491401;
        Mon, 25 Jun 2018 03:11:31 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id d14-v6sm1783902wro.24.2018.06.25.03.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 03:11:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] slimbus: ngd: add stream support
To:     Vinod <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, broonie@kernel.org,
        sdharia@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        ctatlor97@gmail.com
References: <20180621134009.27116-1-srinivas.kandagatla@linaro.org>
 <20180621134009.27116-3-srinivas.kandagatla@linaro.org>
 <20180625044306.GA2404@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6531aff8-4d18-4c6c-f23f-5759829808e2@linaro.org>
Date:   Mon, 25 Jun 2018 11:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180625044306.GA2404@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for review.

On 25/06/18 05:43, Vinod wrote:
> On 21-06-18, 14:40, Srinivas Kandagatla wrote:
> 
>> +	if (txn->mt == SLIM_MSG_MT_CORE &&
>> +		(txn->mc == SLIM_MSG_MC_CONNECT_SOURCE ||
>> +		txn->mc == SLIM_MSG_MC_CONNECT_SINK ||
>> +		txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)) {
>> +
>> +		txn->mt = SLIM_MSG_MT_DEST_REFERRED_USER;
>> +		if (txn->mc == SLIM_MSG_MC_CONNECT_SOURCE)
>> +			txn->mc = SLIM_USR_MC_CONNECT_SRC;
>> +		else if (txn->mc == SLIM_MSG_MC_CONNECT_SINK)
>> +			txn->mc = SLIM_USR_MC_CONNECT_SINK;
>> +		else if (txn->mc == SLIM_MSG_MC_DISCONNECT_PORT)
>> +			txn->mc = SLIM_USR_MC_DISCONNECT_PORT;
> 
> How about a switch case for this
Will give that a go.
> 
>> +		i = 0;
>> +		wbuf[i++] = txn->la;
>> +		la = SLIM_LA_MGR;
>> +		wbuf[i++] = txn->msg->wbuf[0];
>> +		if (txn->mc != SLIM_USR_MC_DISCONNECT_PORT)
>> +			wbuf[i++] = txn->msg->wbuf[1];
>> +
>> +		txn->comp = &done;
>> +		ret = slim_alloc_txn_tid(sctrl, txn);
>> +		if (ret) {
>> +			dev_err(ctrl->dev, "Unable to allocate TID\n");
>> +			return ret;
>> +		}
>> +
>> +		wbuf[i++] = txn->tid;
>> +
>> +		txn->msg->num_bytes = i;
>> +		txn->msg->wbuf = wbuf;
>> +		txn->msg->rbuf = rbuf;
>> +		txn->rl = txn->msg->num_bytes + 4;
>> +	}
>> +
>>   	/* HW expects length field to be excluded */
>>   	txn->rl--;
>>   	puc = (u8 *)pbuf;
>> @@ -830,6 +869,19 @@ static int qcom_slim_ngd_xfer_msg(struct slim_controller *sctrl,
>>   		return -ETIMEDOUT;
>>   	}
>>   
>> +	if (txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
>> +		(txn->mc == SLIM_USR_MC_CONNECT_SRC ||
>> +		 txn->mc == SLIM_USR_MC_CONNECT_SINK ||
>> +		 txn->mc == SLIM_USR_MC_DISCONNECT_PORT)) {
> 
> how about precalculate this check and use:
>          bool something = txn->mt == SLIM_MSG_MT_DEST_REFERRED_USER &&
>                                txn->mc == SLIM_USR_MC_CONNECT_SRC ||
>                                txn->mc == SLIM_USR_MC_CONNECT_SINK ||
>                                txn->mc == SLIM_USR_MC_DISCONNECT_PORT;
> 
> and then use in this case and previous one, make code better to read
> 
Yep. Will do.
>          if (something) {
>> +		timeout = wait_for_completion_timeout(&done, HZ);
>> +		if (!timeout) {
>> +			dev_err(sctrl->dev, "TX timed out:MC:0x%x,mt:0x%x",
>> +				txn->mc, txn->mt);
>> +			return -ETIMEDOUT;
>> +		}
>> +
>> +	}
>> +
> 
> [...]
> 
>> +		struct slim_port *port = &rt->ports[i];
>> +
>> +		if (txn.msg->num_bytes == 0) {
>> +			int seg_interval = SLIM_SLOTS_PER_SUPERFRAME/rt->ratem;
>> +			int exp;
>> +
>> +			wbuf[txn.msg->num_bytes++] = sdev->laddr;
>> +			wbuf[txn.msg->num_bytes] = rt->bps >> 2 |
>> +						   (port->ch.aux_fmt << 6);
>> +
>> +			/* Data channel segment interval not multiple of 3 */
>> +			exp = seg_interval % 3;
>> +			if (exp)
>> +				wbuf[txn.msg->num_bytes] |= BIT(5);
>> +
>> +			txn.msg->num_bytes++;
>> +			wbuf[txn.msg->num_bytes++] = exp << 4 | rt->prot;
>> +
>> +			if (rt->prot == SLIM_PROTO_ISO)
>> +				wbuf[txn.msg->num_bytes++] =
>> +						port->ch.prrate |
>> +						SLIM_CHANNEL_CONTENT_FL;
>> +			else
>> +				wbuf[txn.msg->num_bytes++] =  port->ch.prrate;
>> +
>> +			ret = slim_alloc_txn_tid(ctrl, &txn);
>> +			if (ret) {
>> +				dev_err(&sdev->dev, "Fail to allocate TID\n");
>> +				return -ENXIO;
>> +			}
>> +			wbuf[txn.msg->num_bytes++] = txn.tid;
>> +		}
>> +		wbuf[txn.msg->num_bytes++] = port->ch.id;
>> +	}
>> +
>> +	txn.mc = SLIM_USR_MC_DEF_ACT_CHAN;
>> +	txn.rl = txn.msg->num_bytes + 4;
>> +	ret = qcom_slim_ngd_xfer_msg_sync(ctrl, &txn);
>> +	if (ret) {
>> +		slim_free_txn_tid(ctrl, &txn);
>> +		dev_err(&sdev->dev, "TX timed out:MC:0x%x,mt:0x%x", txn.mc,
>> +				txn.mt);
>> +		return ret;
>> +	}
>> +
>> +	txn.mc = SLIM_USR_MC_RECONFIG_NOW;
>> +	txn.msg->num_bytes = 2;
>> +	wbuf[1] = sdev->laddr;
>> +	txn.rl = txn.msg->num_bytes + 4;
>> +
>> +	ret = slim_alloc_txn_tid(ctrl, &txn);
>> +	if (ret) {
> 
> what about tid allocated in previous loop.. they are not freed here on
> error and seems to be overwritten by this allocation.
Successful transaction tids will be freed once we receive response to 
that message.

In this error case we failed to allocate TID, but the last transaction 
has been submitted successfully, so I tid to be released once we get 
response for the previous message.

thanks,
srini
> 
