Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941CBC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1C21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9pkL7GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E1C21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeHIQmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:42:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40986 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIQmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:42:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so5294063wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zvx5CPVfAtRzTBCtPDGuo7OxSEQKUPVWD5ZaLpE7Hjc=;
        b=A9pkL7GXzU2mSyq2lDGqKpC9rM1W6wGMj/5sCq1suUlAgLHZboC5Prj2J/VmB1gWj5
         ZsiuaYnjznXHL5f2Wy5NmpYA2SP5FOnYyOgM/EQRhllEHgPOsexgxf0NdwQPHjyzVF/j
         0Sq2EAvrxu9xL3vbUoWH99LF/iLNsZIcR7FAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zvx5CPVfAtRzTBCtPDGuo7OxSEQKUPVWD5ZaLpE7Hjc=;
        b=nvi1iJaZjswHswJ0RBJsqy+jc95S1UPFGaIeLpV9c3SQTaeg2E+db76+1pO7xE0Swi
         Cm/MVEa0t3ohRIpuBKp/qzvNhbgf5uh0rK3MFM1OQH94cfcQ9OpE7FkJrDx18hFtn/zT
         1BYQiJjJjYVF4gFy9KG6H0B57pb4iDaonnaoWfS+4dyftT9zBT2u9oDTUKj/yBnXO5Ih
         xmWUrRXctk9ie8u+dRuYBgZBhu60RcN5TMzhEzZOPqx5h2wOQPpEmWbvNAnCHCHrVEER
         L3tuyC78xOlTPSD1SdZj/bazlNIeuN2CWIjW/rm7BiiAHhq124ZtdrGe2roS76+wXZe8
         ml+A==
X-Gm-Message-State: AOUpUlGdqaPhy/Ky7KMOzLrAUZNRArmKRqa9vI4Ly5j/XQFW3kUPsNmd
        aWEqiot3QCn+vh4EK7wIQk3jbQ==
X-Google-Smtp-Source: AA+uWPxcA6qk6GHmloerPi9IHLJcx6Jgc5ziwfQBHQ4aYi8NZQcTSm05VYVzecmcqIzw2I5hs29/TQ==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr1696649wrg.211.1533824262884;
        Thu, 09 Aug 2018 07:17:42 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z5-v6sm4909396wrv.2.2018.08.09.07.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 07:17:40 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
To:     skannan@codeaurora.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
 <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
 <3a7bb27a-0609-133b-08e9-8864f1ccc4bc@linaro.org>
 <37ac189618cda02567977f65570d15d3@codeaurora.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <df517d56-a181-b72b-2fb4-cb58bb817a99@linaro.org>
Date:   Thu, 9 Aug 2018 17:17:37 +0300
MIME-Version: 1.0
In-Reply-To: <37ac189618cda02567977f65570d15d3@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On 08/02/2018 10:12 PM, skannan@codeaurora.org wrote:
> On 2018-08-02 05:07, Georgi Djakov wrote:
>> Hi Saravana,
>>
>> On 08/02/2018 01:57 AM, skannan@codeaurora.org wrote:
>>> On 2018-07-31 09:13, Georgi Djakov wrote:
>>>> Currently we support only platform data for specifying the interconnect
>>>> endpoints. As now the endpoints are hard-coded into the consumer driver
>>>> this may lead to complications when a single driver is used by multiple
>>>> SoCs, which may have different interconnect topology.
>>>> To avoid cluttering the consumer drivers, introduce a translation
>>>> function
>>>> to help us get the board specific interconnect data from device-tree.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>> ---
>>>>  drivers/interconnect/core.c  | 62 ++++++++++++++++++++++++++++++++++++
>>>>  include/linux/interconnect.h |  7 ++++
>>>>  2 files changed, 69 insertions(+)
>>>>
>>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>>> index 9fef180cf77e..d1b6adff0a3d 100644
>>>> --- a/drivers/interconnect/core.c
>>>> +++ b/drivers/interconnect/core.c
>> [..]
>>>> --- a/include/linux/interconnect.h
>>>> +++ b/include/linux/interconnect.h
>>>> @@ -17,6 +17,7 @@ struct device;
>>>>
>>>>  struct icc_path *icc_get(struct device *dev, const int src_id,
>>>>               const int dst_id);
>>>> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>>>>  void icc_put(struct icc_path *path);
>>>>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>>>>
>>>> @@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct
>>>> device *dev, const int src_id,
>>>>      return NULL;
>>>>  }
>>>>
>>>> +static inline struct icc_path *of_icc_get(struct device *dev,
>>>> +                      const char *name)
>>>> +{
>>>> +    return NULL;
>>>> +}
>>>> +
>>>
>>> Might want to return PTR(-ENODEV) or some error code so that client
>>> doesn't have to do NULL check AND an error check?
>>>
>>> -Saravana
>>
>> NULL is returned when CONFIG_INTERCONNECT=n. Configuration of
>> interconnects by consumer drivers could be optional and that's why null
>> is returned instead of an error. The consumer drivers decide how to
>> proceed in this case and if there is a hard requirement for interconnect
>> support, then i would suggest to express it as a dependency in Kconfig.
> 
> Ehh... you could make the same argument with an error. If it's not
> mandatory for functioning, they can ignore a specific error and
> continue? At a minimum, these stub functions returning NULL doesn't
> match with the documentation that says these APIs will only ever return
> ERR_PTR().
> 
> -Saravana

Here i am trying to align with other frameworks, which provide some
resources to consumers. The regulator/clock/reset frameworks return
NULL, so i prefer to do the same here. Drivers are free to handle NULL
specifically, but they don't have to. This NULL may also mean that
interconnects have been already configured by bootloader or firmware.
Of course i accept the comment to update the documentation to mention this.

Thanks,
Georgi
