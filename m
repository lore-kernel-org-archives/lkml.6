Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAABC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91122178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 16:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLsoN2FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91122178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeHDSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 14:40:48 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38465 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeHDSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 14:40:48 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so3875222plq.5;
        Sat, 04 Aug 2018 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rp8MvqlqYPWt7o7P6A3tnK8Veogq9jC96VdtoIG4WuQ=;
        b=ZLsoN2FWYitiACS2kR4Sk1bbABiMRRo2nJdNCM+yFtjv1urUTgCYYnwZyAFt5N9jd8
         14nMzzEUm2IHae8kIzuGQRgA6PlcxSwPQbCYPrlPqdsKO6l8zZ5xwr1HipS1RSS3WLWH
         cSNSoSCNP1RQX4whRKr4kaKGHCXbxFcJMU+YRHS58gw3AWyyR7qy+mMSw6b3xtdei6fE
         Jl9RmKv5QtWmrB9j7ZvMmDSkKR8w4v/4Ih12wb/Zf0jWA0SgCBUsicIcgziR1/C0dPEt
         tUiFmiS+AgTbBZ/9y638ZxmAcUtFst0EKhX6UDsVhV6vIZ0GejoOiXYhCtBzwVUsx6N2
         rp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rp8MvqlqYPWt7o7P6A3tnK8Veogq9jC96VdtoIG4WuQ=;
        b=pGbEJ7+1LTURjlSLMx9UdOAkuywrGbNNgj8/yw12tGsNtENytzkpvSPPo9PgQCW8hU
         EgMIPtv7Rrxfbm0Zmljn7KNi+pzpuD6pWy5p1AQ9vD6dAdv3eMUegGvCNH3LDIQJ9vZM
         M/1JlaJyGQeE+t+Us0vFNLApB+yzc2fO9bGzCixH9In6YLrGqH/vFV0x89cwiuFSeXf4
         w807znXw2fJM0XDo+64k39k0miQ9Gd2RYwXUbVGa7S/lg/q0fx7PwSfCFSlCL4B0BvD0
         zjOoCcAEXJ+js2EiECZ/qIlF4saKUypHIbAh9PPxAMwxGzp2q9KPsqPr7pkuONkjGnRO
         pROQ==
X-Gm-Message-State: AOUpUlFYtzu55rtM1BTYhe39nYnBfEv5x5ItseFW/aKqumDVNpJP3PbH
        Xo3Me1M6MKk69eaZNOWnOxaljE4j
X-Google-Smtp-Source: AAOMgpfthfxRseLEHBfYR0m3o8F/4liEDObmJnfJsF+w4WxwQn1F6oib+MtzLLLUNuhI4f5GJQuaDw==
X-Received: by 2002:a17:902:4906:: with SMTP id u6-v6mr7851065pld.44.1533400773942;
        Sat, 04 Aug 2018 09:39:33 -0700 (PDT)
Received: from [192.168.1.54] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id o21-v6sm12396793pfa.54.2018.08.04.09.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 09:39:32 -0700 (PDT)
Subject: Re: [PATCH v6 03/17] media: v4l2: async: Add
 v4l2_async_notifier_add_subdev
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-4-git-send-email-steve_longerbeam@mentor.com>
 <20180803151346.GG4528@w540>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <e465780e-823c-c59e-29d1-f62f3a0e1673@gmail.com>
Date:   Sat, 4 Aug 2018 09:39:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803151346.GG4528@w540>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,


On 08/03/2018 08:13 AM, jacopo mondi wrote:
> Hi Steven,
>     I've a small remark, which is probably not only related to your
>     patches but was there alreay... Anyway, please read below..
>
>
> On Mon, Jul 09, 2018 at 03:39:03PM -0700, Steve Longerbeam wrote:
>> <snip>
>> +static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>> +{
>>   	struct v4l2_async_subdev *asd;
>>   	int ret;
>>   	int i;
>> @@ -399,29 +445,25 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
>>
>>   	mutex_lock(&list_lock);
>>
>> -	for (i = 0; i < notifier->num_subdevs; i++) {
>> -		asd = notifier->subdevs[i];
>> +	if (notifier->subdevs) {
>> +		for (i = 0; i < notifier->num_subdevs; i++) {
>> +			asd = notifier->subdevs[i];
>>
>> -		switch (asd->match_type) {
>> -		case V4L2_ASYNC_MATCH_CUSTOM:
>> -		case V4L2_ASYNC_MATCH_DEVNAME:
>> -		case V4L2_ASYNC_MATCH_I2C:
>> -		case V4L2_ASYNC_MATCH_FWNODE:
>> -			if (v4l2_async_notifier_has_async_subdev(
>> -				    notifier, asd, i)) {
>> -				dev_err(dev,
>> -					"asd has already been registered or in notifier's subdev list\n");
>> -				ret = -EEXIST;
>> +			ret = v4l2_async_notifier_asd_valid(notifier, asd, i);
>> +			if (ret)
>>   				goto err_unlock;
>> -			}
>> -			break;
>> -		default:
>> -			dev_err(dev, "Invalid match type %u on %p\n",
>> -				asd->match_type, asd);
>> -			ret = -EINVAL;
>> -			goto err_unlock;
>> +
>> +			list_add_tail(&asd->list, &notifier->waiting);
>> +		}
>> +	} else {
>> +		i = 0;
>> +		list_for_each_entry(asd, &notifier->asd_list, asd_list) {
>> +			ret = v4l2_async_notifier_asd_valid(notifier, asd, i++);
> Here the call stack looks like this, if I'm not mistaken:
>
> list_for_each_entry(asd, notifier->asd_list, i) {
>          v4l2_async_notifier_asd_valid(notifier, asd, i):
>                  v4l2_async_notifier_has_async_subdev(notifier, asd, i):
>                          list_for_each_entry(asd_y, notifier->asd_list, j) {
>                                  if (j >= i) break;
>                                  if (asd == asd_y) return true;
>                          }
> }
>
> Which is an optimization of O(n^2), but still bad.
>
> This was there already there, it was:

Agreed, it should be safe to remove the check for duplicate
asd's at notifier registration, since this check is done now
in v4l2_async_notifier_add_subdev().

Steve

> for (i = 0; i < notifier->num_subdevs; i++) {
>          v4l2_async_notifier_has_async_subdev(notifier, notifier->subdevs[i], i):
>                  for (j = 0; j < i; j++) {
>                          if (notifier->subdevs[i] == notifier->subdevs[j])
>                                  return true;
>                          }
>                  }
> }
>
> We're not talking high performances here, but I see no reason to go through
> the list twice, as after switching to use your here introduced
> v4l2_async_notifier_add_subdev() async subdevices are tested at endpoint
> parsing time in v4l2_async_notifier_fwnode_parse_endpoint(), which
> guarantees we can't have doubles later, at notifier registration time.
>
> If I'm not wrong, this can be anyway optimized later.
>
> Thanks
>     j
>
>

