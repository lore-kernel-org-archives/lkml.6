Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E15C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAB420C0A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQw9MscY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAB420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeGGVJ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:09:26 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35522 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754329AbeGGVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:09:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so9876497pff.2;
        Sat, 07 Jul 2018 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QMx9lRtf6A3RQ/HxUEXasZkEUJZb6R90xLt7CbJ1FdU=;
        b=YQw9MscYsyJvuCkDY/p6HDAYOrkkYwiaMN8R5X+79+fq4YWsHesmtFBLOiPMJe08/+
         A04Eol8UCSRzMn5luFCoKuQ8vqni3kycdhdswCC51C+Q/OlN+cdox2N0tHhq3BwldQy0
         bPMsmVaSp4MqYNo11lVUwiqX5EPzIEb5PJajiqFlQj5y9ZGiVw0xSPgPcmXncQQzwLKA
         faWhDWuZOldtvdmKnsLIE6O/aAtJk6OxDdWVvoiaTDDl8zbNxcqZeuJUBgdKprkhYex+
         9lcYhrb82D7QWinnB82bxSpFJsuVE1E8RFk5dzdWG65ajMWRc6uLGu7vGv32MMRkL74K
         bNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QMx9lRtf6A3RQ/HxUEXasZkEUJZb6R90xLt7CbJ1FdU=;
        b=nhJiQwfu68F63qAQkQImFogSzdc/SxBohqhOdp0wv5y57aVLU6Stbcj0RvfyfNQCJ9
         GL88ArGF+BRrG2GaC0vkPgbb/iXK20v14b6MNLZMeKyfbfR2Ms4uxHsVYSO5w3BFoLWa
         mIivPx1ePcqnr9q30HGZZg7sV2JY8JBy5sO98lSpBsgYbYyRL8rCnDWZIGutP5LoRhzs
         xAhA6qDvhcmj2/oaKYcn30m1PjZwCFl+8JJSUHBUpqlmx3a+nKRrhrhlGv2tuAJgC78v
         qjlQCv/adwF36aeWI/a7d3Aw5ODTxxmTFJntoWllD0pQcbotjeGyGcx5CucwTqHSOBJd
         1YAQ==
X-Gm-Message-State: APt69E3JmOG8lGyITWS9j1S5ZErLKiU0LuvVSgMdfnVUhJ+lTW7Ou3ke
        4+nGAnEX9TPBEAZxKAxthwkC9Ykq
X-Google-Smtp-Source: AAOMgpchNXurAOdcHaifpFVaj9uIeliwl/PC+9jlV1ptfXwFQKUNw/MG8o5/dQPZ7OVjozJHSxUu6w==
X-Received: by 2002:a63:4283:: with SMTP id p125-v6mr13993301pga.142.1530997763522;
        Sat, 07 Jul 2018 14:09:23 -0700 (PDT)
Received: from [192.168.1.54] (c-24-5-209-231.hsd1.ca.comcast.net. [24.5.209.231])
        by smtp.gmail.com with ESMTPSA id f24-v6sm20054220pfe.39.2018.07.07.14.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 14:09:22 -0700 (PDT)
Subject: Re: [PATCH v5 15/17] media: platform: Switch to
 v4l2_async_notifier_add_subdev
To:     Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
 <1530298220-5097-16-git-send-email-steve_longerbeam@mentor.com>
 <20180702112327.3rzfxmhghoakbcyz@valkosipuli.retiisi.org.uk>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <83f950df-7f5b-2dda-3f48-ac25d67e5069@gmail.com>
Date:   Sat, 7 Jul 2018 14:09:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702112327.3rzfxmhghoakbcyz@valkosipuli.retiisi.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,


On 07/02/2018 04:23 AM, Sakari Ailus wrote:
> On Fri, Jun 29, 2018 at 11:49:59AM -0700, Steve Longerbeam wrote:
>> diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
>> index a96f53c..8464ceb 100644
>> --- a/drivers/media/platform/davinci/vpif_capture.c
>> +++ b/drivers/media/platform/davinci/vpif_capture.c
>> @@ -1553,7 +1553,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>>   					    sizeof(*chan->inputs),
>>   					    GFP_KERNEL);
>>   		if (!chan->inputs)
>> -			return NULL;
>> +			goto err_cleanup;
>>   
>>   		chan->input_count++;
>>   		chan->inputs[i].input.type = V4L2_INPUT_TYPE_CAMERA;
>> @@ -1587,28 +1587,30 @@ vpif_capture_get_pdata(struct platform_device *pdev)
>>   			rem->name, rem);
>>   		sdinfo->name = rem->full_name;
>>   
>> -		pdata->asd[i] = devm_kzalloc(&pdev->dev,
>> -					     sizeof(struct v4l2_async_subdev),
>> -					     GFP_KERNEL);
>> -		if (!pdata->asd[i]) {
>> +		pdata->asd[i] = v4l2_async_notifier_add_fwnode_subdev(
>> +			&vpif_obj.notifier, of_fwnode_handle(rem),
>> +			sizeof(struct v4l2_async_subdev));
>> +		if (IS_ERR(pdata->asd[i])) {
>>   			of_node_put(rem);
>> -			pdata = NULL;
>> -			goto done;
>> +			goto err_cleanup;
>>   		}
>>   
>> -		pdata->asd[i]->match_type = V4L2_ASYNC_MATCH_FWNODE;
>> -		pdata->asd[i]->match.fwnode = of_fwnode_handle(rem);
>> -		of_node_put(rem);
>> +		of_node_put(endpoint);
> You end up putting the same endpoint twice in the successful case.
>
> One way to address that would be to get the OF node's remote port parent
> (i.e. the device) immediately so you can forget OF node use counts in error
> handling.
>

Thanks for catching. I ended up doing what you suggested, moved the get
of remote port parent to just after getting local endpoint node, and removed
node puts in the done and cleanup paths, in vpif_capture_get_pdata().

Steve

