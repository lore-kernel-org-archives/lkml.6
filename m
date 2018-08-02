Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E04C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7ED2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pIvw0sJl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mTw9t8tP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7ED2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeHBVEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:04:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43684 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeHBVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:04:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 53E2160B1A; Thu,  2 Aug 2018 19:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533237136;
        bh=3aLpg1hLRwwHGdEZpD9a1kC8Fj5QM0FiMSD8tHIzrCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pIvw0sJlcnpT2C425PCY3IzCYOcwsFjt68woN9bX2rofcAZXg5XmrJYdSGP9E0pfY
         m+Wk/27RGtkzXnWK7cCcfM/vlysM7ZsJyggVWkpdb4uukibHmPCyiw741n00v/CDwp
         QsVqlx5NaEmUdQO6rQGgVsFQ0CGjB38JiUpz1x7M=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1F0A0602D7;
        Thu,  2 Aug 2018 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533237135;
        bh=3aLpg1hLRwwHGdEZpD9a1kC8Fj5QM0FiMSD8tHIzrCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mTw9t8tPwECo2weCGIxbvA7JiOG9DaKRWb4PCimc4htiZ/9BU/PfFwTi2m0aakRCt
         XRshIiD9sbdh+Uydn4a4vS2TFgSP1yfmXbQEU74JvNIcxBwas0PVmJMWjerRDFsVAp
         ys6kLTuaX13w6osYQM2jWdYR+jCiEdNcTuyXDLuw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 02 Aug 2018 12:12:15 -0700
From:   skannan@codeaurora.org
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] interconnect: Allow endpoints translation via DT
In-Reply-To: <3a7bb27a-0609-133b-08e9-8864f1ccc4bc@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-9-georgi.djakov@linaro.org>
 <804925d5927ccb6927b16f7e9a4aa05c@codeaurora.org>
 <3a7bb27a-0609-133b-08e9-8864f1ccc4bc@linaro.org>
Message-ID: <37ac189618cda02567977f65570d15d3@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-02 05:07, Georgi Djakov wrote:
> Hi Saravana,
> 
> On 08/02/2018 01:57 AM, skannan@codeaurora.org wrote:
>> On 2018-07-31 09:13, Georgi Djakov wrote:
>>> Currently we support only platform data for specifying the 
>>> interconnect
>>> endpoints. As now the endpoints are hard-coded into the consumer 
>>> driver
>>> this may lead to complications when a single driver is used by 
>>> multiple
>>> SoCs, which may have different interconnect topology.
>>> To avoid cluttering the consumer drivers, introduce a translation
>>> function
>>> to help us get the board specific interconnect data from device-tree.
>>> 
>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>> ---
>>>  drivers/interconnect/core.c  | 62 
>>> ++++++++++++++++++++++++++++++++++++
>>>  include/linux/interconnect.h |  7 ++++
>>>  2 files changed, 69 insertions(+)
>>> 
>>> diff --git a/drivers/interconnect/core.c 
>>> b/drivers/interconnect/core.c
>>> index 9fef180cf77e..d1b6adff0a3d 100644
>>> --- a/drivers/interconnect/core.c
>>> +++ b/drivers/interconnect/core.c
> [..]
>>> --- a/include/linux/interconnect.h
>>> +++ b/include/linux/interconnect.h
>>> @@ -17,6 +17,7 @@ struct device;
>>> 
>>>  struct icc_path *icc_get(struct device *dev, const int src_id,
>>>               const int dst_id);
>>> +struct icc_path *of_icc_get(struct device *dev, const char *name);
>>>  void icc_put(struct icc_path *path);
>>>  int icc_set(struct icc_path *path, u32 avg_bw, u32 peak_bw);
>>> 
>>> @@ -28,6 +29,12 @@ static inline struct icc_path *icc_get(struct
>>> device *dev, const int src_id,
>>>      return NULL;
>>>  }
>>> 
>>> +static inline struct icc_path *of_icc_get(struct device *dev,
>>> +                      const char *name)
>>> +{
>>> +    return NULL;
>>> +}
>>> +
>> 
>> Might want to return PTR(-ENODEV) or some error code so that client
>> doesn't have to do NULL check AND an error check?
>> 
>> -Saravana
> 
> NULL is returned when CONFIG_INTERCONNECT=n. Configuration of
> interconnects by consumer drivers could be optional and that's why null
> is returned instead of an error. The consumer drivers decide how to
> proceed in this case and if there is a hard requirement for 
> interconnect
> support, then i would suggest to express it as a dependency in Kconfig.

Ehh... you could make the same argument with an error. If it's not 
mandatory for functioning, they can ignore a specific error and 
continue? At a minimum, these stub functions returning NULL doesn't 
match with the documentation that says these APIs will only ever return 
ERR_PTR().

-Saravana
