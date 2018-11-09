Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2628020825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jT7uWQkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2628020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeKJIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:21:12 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46801 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeKJIVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:21:12 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so2343288otm.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UBQZ3UPix5ecMKfxrx4oPXZzIm1CD4Si3oc6178k9EY=;
        b=jT7uWQkGTaclv0/w97aydBMPqMqq27yzFu/WqYoxGfQWnNQJLNeUof4t6dPMR0ac5L
         RhOaCAyweulEhhf+j+mF1qfbrjkpuR5KAnr0d+AOvUOpikNOhjLb/JrmLm1daf9Kh8AP
         0yjxxLAiJh3vrR2Zb5S//Z/FohaHEooKzTdPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UBQZ3UPix5ecMKfxrx4oPXZzIm1CD4Si3oc6178k9EY=;
        b=rGGr+tNVbuj7RVMVvPMXvvVQuGA0PwGMSTqQjHjLrhhJi26ImQDsyrve0dETvKtYxg
         TuEf7hwU0XvK9azmyWZZx7SH51sy9XbrzxVbA6tANN6aizZg0+SCFx4yXvXd+pZBZ/kz
         CTv5mCykYLFYaiYzmdRzcgtcZeMvXSNv3R/wNIgYsfnAgmh2fXE9i6bAGiFYEzjuZQ1g
         HZmIunvhx66ViXMefmZLL2fDwBmpL68iWvaPhSdO3tMPHukExlZ8Z8WuZc0QvEqn8fZT
         ouymNNFWX8o2k/vEROPznbOD1Jf/a0VARphbxrPmw2red6OQyNHVks3pepVXypOAlNNB
         dl9w==
X-Gm-Message-State: AGRZ1gIMgfqH+iapN2W1EoV3csNogqE4enLr9CCUxLetFHJPZ9KXFb76
        9kjclDBJoG2xeuQQFdsMK25R4A==
X-Google-Smtp-Source: AJdET5fa1/eQ8nM6AaAdjo3Pfz+TrNiL37wMzPrrJLJ1f81PjQ0p4wWL+nxa8k/4EJNdhGezTXfQqA==
X-Received: by 2002:a9d:6287:: with SMTP id x7mr6648197otk.304.1541803113362;
        Fri, 09 Nov 2018 14:38:33 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id q65-v6sm889234oif.6.2018.11.09.14.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:32 -0800 (PST)
Subject: Re: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-2-elder@linaro.org>
 <CAK8P3a1rXwADsgVJ4EAtV3u_qg840tfGnbKcyxuBXDB10sYi3Q@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <d5c89037-f4fa-6ab7-dbca-d63f64c90fdc@linaro.org>
Date:   Fri, 9 Nov 2018 16:38:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rXwADsgVJ4EAtV3u_qg840tfGnbKcyxuBXDB10sYi3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 5:50 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
>> device tree nodes.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
>>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
>>  2 files changed, 151 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> 
> I think this should go into bindings/net instead of bindings/soc, since it's
> mostly about networking rather than a specific detail of managing the SoC
> itself.

Done (in my tree--and will be reflected next time I send something out).

>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> new file mode 100644
>> index 000000000000..d4d3d37df029
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> @@ -0,0 +1,136 @@
>> +Qualcomm IPA (IP Accelerator) Driver
>> +
>> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
>> +certain network processing tasks (e.g. filtering, routing, and NAT) from
>> +the main processor.  The IPA currently serves only as a network interface,
>> +providing access to an LTE network available via a modem.
> 
> That doesn't belong into the binding. Say what the hardware can do here,
> not what a specific implementation of the driver does at this moment.
> The binding should be written in an OS independent way after all.

OK.

>> +- interrupts-extended:
>> +       Specifies the IRQs used by the IPA.  Four cells are required,
>> +       specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
>> +       from the modem; and the "ready for stage 2 initialization"
>> +       interrupt from the modem.  The first two are hardware IRQs; the
>> +       third and fourth are SMP2P input interrupts.
> 
> You mean 'four interrupts', not 'four cells' -- each interrupt specifier
> already consists of at least two cells (one for the phandle to the
> irqchip, plus one or more cells to describe that interrupt).

OK.

>> +- interconnects:
>> +       Specifies the interconnects used by the IPA.  Three cells are
>> +       required, specifying:  the path from the IPA to memory; from
>> +       IPA to internal (SoC resident) memory; and between the AP
>> +       subsystem and IPA for register access.
> 
> Same here and in the rest.

OK, I've fixed all of these.  Thank you.

					-Alex

> 
>       Arnd
> 

