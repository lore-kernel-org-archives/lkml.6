Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ECEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414EB263EB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0CUQ1/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414EB263EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935224AbeFZBcb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:32:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40894 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934678AbeFZBc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:32:29 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so15152257ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e72w0o9gI89/t/pZz4hJ+u++mCuRgrJcsLVDa0HcpzQ=;
        b=N0CUQ1/X3dBC96i0w8hB0ZPGpV98P3MUFEihpFaUCQz1I7NXY+YNc3qu24HabLbVxV
         0XolkM5CeN6rnMF3jxNky6f7/Q1OVzPmD1pGJNgAYPLqQSQhpKuEyyuO6pZFeQzNGOCD
         TRikKdZPIuj92+e90H84SJVeLZu1ttnIF/RBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e72w0o9gI89/t/pZz4hJ+u++mCuRgrJcsLVDa0HcpzQ=;
        b=tpfV7EErDx6BheMyDrCDmVu33A7p+uuo0DTM8/feSypsKtdU9ziSLc2D7ulvq/iDWz
         zPApc+eEtDS9xset+ZPp5V8l9b1ksW8x2P39plFN+qocWiEmH5V6fEplScfJ0K5Bk6MM
         qtrzO5clsF7KUmevRW9eiuciQSxrLvMW2vKTSQXgoNYithOPJH3660ug2HV7S8YrOWRL
         rPouLdSrjLqtjafmP2x56De96oX/SlFVXf7PTj3AtoQKkk4K+/SdX5V7w6O/C5uJJsdC
         44qhRzFHYq5WkO262oqs4BmdotWAzLQ1BW5jh8B8m1FbV/re0ALqrEAWZ3PIVpJIDnn+
         NDEw==
X-Gm-Message-State: APt69E258egaC7raG11qAN1DYshp+tll+JEb2K9B85kLi5ucCS+4mMho
        NhVBC1fFQbSHn6Qhe8kkh86oAz51OBM=
X-Google-Smtp-Source: AAOMgpceRglNM+Z1BBQosc31DthGe8bklBkNC4xownd79+WCOY3VCj8W2hrqdhuvx+/RZ2+qssm1dQ==
X-Received: by 2002:a02:3758:: with SMTP id r85-v6mr12028589jar.76.1529976748623;
        Mon, 25 Jun 2018 18:32:28 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id h81-v6sm5288922ith.2.2018.06.25.18.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 18:32:27 -0700 (PDT)
Subject: Re: [PATCH 4/5] remoteproc: rename subdev probe and remove functions
From:   Alex Elder <elder@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180515205345.8090-1-elder@linaro.org>
 <20180515205345.8090-5-elder@linaro.org>
 <dc10f869-48fb-84da-9df2-409d6c3568dc@st.com>
 <726fa7c1-dab8-c1e5-721a-2f60d7f967d8@linaro.org>
Message-ID: <62d746d5-5cfb-11e4-17ba-e3d8f4eeb659@linaro.org>
Date:   Mon, 25 Jun 2018 20:32:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <726fa7c1-dab8-c1e5-721a-2f60d7f967d8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 06:53 AM, Alex Elder wrote:
> On 05/29/2018 04:12 AM, Arnaud Pouliquen wrote:
>> Hello Alex
>>
>>
>> We have the same needs (prepare unprepare steps) on our platform. We
>> tested you core patches and they answers to our need.
> 
> I'm very glad to hear that.  Would you offer your "Tested-by" on these?
> 
> On your comment below, yes, I will re-send v2 and will separate the
> core from the glink code.

Arnaud, despite what I said above, I'm about to resend the code but
will *not* be separating the core code from glink code.  It turns
out that the glink code (and smd and ssr) are really part of the
core code at the moment.  So after talking with Bjorn I agreed to
just send the code without splitting them.

Sorry.

					-Alex

> Thanks.
> 
> 					-Alex
> 
>> Just a remark below
>>
>> On 05/15/2018 10:53 PM, Alex Elder wrote:
>>> Rename functions used when subdevices are started and stopped to
>>> reflect the new naming scheme.
>>>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>  drivers/remoteproc/qcom_common.c     | 16 ++++++++--------
>>>  drivers/remoteproc/remoteproc_core.c |  8 ++++----
>>>  2 files changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
>>> index 4ae87c5b8793..6f77840140bf 100644
>>> --- a/drivers/remoteproc/qcom_common.c
>>> +++ b/drivers/remoteproc/qcom_common.c
>>> @@ -33,7 +33,7 @@
>>>  
>>>  static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
>>>  
>>> -static int glink_subdev_probe(struct rproc_subdev *subdev)
>>> +static int glink_subdev_start(struct rproc_subdev *subdev)
>>>  {
>>>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>>>  
>>> @@ -42,7 +42,7 @@ static int glink_subdev_probe(struct rproc_subdev *subdev)
>>>  	return PTR_ERR_OR_ZERO(glink->edge);
>>>  }
>>>  
>>> -static void glink_subdev_remove(struct rproc_subdev *subdev, bool crashed)
>>> +static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>>>  {
>>>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>>>  
>>> @@ -64,8 +64,8 @@ void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink)
>>>  		return;
>>>  
>>>  	glink->dev = dev;
>>> -	glink->subdev.start = glink_subdev_probe;
>>> -	glink->subdev.stop = glink_subdev_remove;
>>> +	glink->subdev.start = glink_subdev_start;
>>> +	glink->subdev.stop = glink_subdev_stop;
>>>  
>>>  	rproc_add_subdev(rproc, &glink->subdev);
>>>  }
>>> @@ -129,7 +129,7 @@ int qcom_register_dump_segments(struct rproc *rproc,
>>>  }
>>>  EXPORT_SYMBOL_GPL(qcom_register_dump_segments);
>>>  
>>> -static int smd_subdev_probe(struct rproc_subdev *subdev)
>>> +static int smd_subdev_start(struct rproc_subdev *subdev)
>>>  {
>>>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>>>  
>>> @@ -138,7 +138,7 @@ static int smd_subdev_probe(struct rproc_subdev *subdev)
>>>  	return PTR_ERR_OR_ZERO(smd->edge);
>>>  }
>>>  
>>> -static void smd_subdev_remove(struct rproc_subdev *subdev, bool crashed)
>>> +static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>>>  {
>>>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>>>  
>>> @@ -160,8 +160,8 @@ void qcom_add_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>>>  		return;
>>>  
>>>  	smd->dev = dev;
>>> -	smd->subdev.start = smd_subdev_probe;
>>> -	smd->subdev.stop = smd_subdev_remove;
>>> +	smd->subdev.start = smd_subdev_start;
>>> +	smd->subdev.stop = smd_subdev_stop;
>>>  
>>>  	rproc_add_subdev(rproc, &smd->subdev);
>>>  }
>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>> index ca39fad175f2..2ede7ae6f5bc 100644
>>> --- a/drivers/remoteproc/remoteproc_core.c
>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>> @@ -301,14 +301,14 @@ void rproc_free_vring(struct rproc_vring *rvring)
>>>  	rsc->vring[idx].notifyid = -1;
>>>  }
>>>  
>>> -static int rproc_vdev_do_probe(struct rproc_subdev *subdev)
>>> +static int rproc_vdev_do_start(struct rproc_subdev *subdev)
>>>  {
>>>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>>>  
>>>  	return rproc_add_virtio_dev(rvdev, rvdev->id);
>>>  }
>>>  
>>> -static void rproc_vdev_do_remove(struct rproc_subdev *subdev, bool crashed)
>>> +static void rproc_vdev_do_stop(struct rproc_subdev *subdev, bool crashed)
>>>  {
>>>  	struct rproc_vdev *rvdev = container_of(subdev, struct rproc_vdev, subdev);
>>>  
>>> @@ -399,8 +399,8 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
>>>  
>>>  	list_add_tail(&rvdev->node, &rproc->rvdevs);
>>>  
>>> -	rvdev->subdev.start = rproc_vdev_do_probe;
>>> -	rvdev->subdev.stop = rproc_vdev_do_remove;
>>> +	rvdev->subdev.start = rproc_vdev_do_start;
>>> +	rvdev->subdev.stop = rproc_vdev_do_stop;
>>>  
>>>  	rproc_add_subdev(rproc, &rvdev->subdev);
>>
>> Could you split in 2 patches one for the core another, the other for the
>> glink driver?
>>
>> Regards
>> Arnaud
>>
> 

