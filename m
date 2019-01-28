Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42337C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F962147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUojEVs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfA1PeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:34:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39543 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfA1PeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:34:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so18531574wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ojsiZaqa9xTbU1uIH35HdiJgN+gf+woNQQLJ2Ygg4gs=;
        b=iUojEVs/xOA4v8qrWLdjrKBOAUb1ni5VT4ramcr9ZGOj5gXwlppElHpxRqJyXnqAaa
         2GjuPCeihZHJrqhf7fvYkbk9wKzLICneW9Ak+Y4ce0F2hNnNNmGYjtH7kaBpUDacvr45
         45weEbiGKqOAKFQGH8vvEeNpyM5jvjmpPhzIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojsiZaqa9xTbU1uIH35HdiJgN+gf+woNQQLJ2Ygg4gs=;
        b=NZjlo1VfYCyH1Uv9yXSMzLrNJFlxJTVXhRkboTv33DBQdZfJHym3R+IQvBhYYky8Ja
         mb3MxnRz91jS2bk6xqjvi7228qL+6Wsr3gO6fSnoIOuXBDOiYv7GEtx4012x+Hj+gwh3
         thsV4hQClp9j73zIj+vV0kj4/Zq0hsEIEC+DBR8/9P0942fwpoejk/8VMFeaIfi+B+us
         izMudHo6YISK8ePvnYHde8YdinU8a13GnvfYdiFy5IPWmi0qsHFmIidPUYpql6ON9P2R
         NjnXQH+WHmlX84jgtBr6ViPKd+s4PVPQtXkdf3p9mvTHLfprZFpBX8W2mKjhPBV4D3+M
         WK+Q==
X-Gm-Message-State: AJcUukeKSk/bLVSvmQ3nLdzm/1tB3FbB7dXtu3XgWDALdyxhSRjyfZcR
        Rm05KNmLnjOiMGXjW0zCN6nNF5zWIxs=
X-Google-Smtp-Source: ALg8bN5x20YFcgXX2WMs5dJswn2gg3j71Jy8A8Q/GI8/5x9Pss0bBOyPlpYyotUwEkSKEUQIV4yx2A==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr22791922wrw.34.1548689652422;
        Mon, 28 Jan 2019 07:34:12 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h10sm68088929wmf.44.2019.01.28.07.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 07:34:11 -0800 (PST)
Subject: Re: [<PATCH v1> 1/1] scsi: qcom-ufs: Add support for bus voting using
 ICB framework
To:     "Asutosh Das (asd)" <asutoshd@codeaurora.org>,
        subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1548312692.git.asutoshd@codeaurora.org>
 <d6aa4d9bd29bbb2c3ee78e6635d4704e4113a26e.1548312692.git.asutoshd@codeaurora.org>
 <e91d4007-edab-da66-e241-bdf55bcf58aa@linaro.org>
 <4f58c58a-aeb6-6cad-96ac-43f6843715ce@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <264ad328-a0d0-9e78-f7ae-bdc084bab38f@linaro.org>
Date:   Mon, 28 Jan 2019 17:34:09 +0200
MIME-Version: 1.0
In-Reply-To: <4f58c58a-aeb6-6cad-96ac-43f6843715ce@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asutosh,

On 1/25/19 12:27, Asutosh Das (asd) wrote:
> On 1/24/2019 5:16 PM, Georgi Djakov wrote:
[..]>>> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>> index a99ed55..94249ef 100644
>>> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
>>> @@ -45,6 +45,18 @@ Optional properties:
>>>   Note: If above properties are not defined it can be assumed that
>>> the supply
>>>   regulators or clocks are always on.
>>>   +* Following bus parameters are required:
>>> +interconnects
>>> +interconnect-names
>>
>> Is the above really required? Are the interconnect bandwidth requests
>> required to enable something critical to UFS functionality?
>> Would UFS still work without any bandwidth scaling, although for example
>> slower? Could you please clarify.
> Yes - UFS will still work without any bandwidth scaling - but the
> performance would be terrible.

Ok, thanks for clarifying! Then the properties should be optional. Maybe
we can also mention in the commit text how much the performance would
improve with this patch.

>>
>>> +- Please refer to Documentation/devicetree/bindings/interconnect/
>>> +  for more details on the above.
>>> +qcom,msm-bus,name - string describing the bus path
>>> +qcom,msm-bus,num-cases - number of configurations in which ufs can
>>> operate in
>>> +qcom,msm-bus,num-paths - number of paths to vote for
>>> +qcom,msm-bus,vectors-KBps - Takes a tuple <ib ab>, <ib ab> (2 tuples
>>> for 2 num-paths)
>>> +                The number of these entries *must* be same as
>>> +                num-cases.
>>
>> DT bindings should be submitted as a separate patch. Anyway, people
>> frown upon putting configuration data in DT. Could we put this data into
>> the driver as a static table instead of DT? Also maybe use ab/pb for
>> average/peak bandwidth.
> The ab/ib value change depending on the target - that's the reasoning
> for putting it in dts file. However, I'm open to ideas as to how else to
> handle this.

As Evan already suggested, it would be best if we can calculate the
bandwidth. Can we do that based on the number of lanes, clock rate and
ufs standard version?
If calculating is really not possible and we have strong arguments for
that, we could add a more specific compatible DT string - for example
qcom,sdm845-ufshc and use per SoC bandwidth tables.

Thanks,
Georgi
