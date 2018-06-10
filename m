Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AFMTK2YmHVvSeAAAmS7hNA
	; Sun, 10 Jun 2018 13:28:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D724B607E7; Sun, 10 Jun 2018 13:28:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvTRfH+Y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3B1A0605A5;
	Sun, 10 Jun 2018 13:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B1A0605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753689AbeFJN2R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 09:28:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41169 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeFJN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 09:28:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so17634146wrq.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z8yr9tsjnpNnflgofsc/hHyWtbtVqNZGpnc/o72AJio=;
        b=QvTRfH+YobiOa+OXfZC3gCE07BOoUekmfT7ikXa3FR4mQgPQkvlk6bD/2tdeuem7GT
         zPimq4ltFHleEuoeVI0q5dI+ELikGtqJtzU/hSkAWtElzir6o+coP4g+WbsaTGCXHvHH
         Dqg7Kv1FVGG4aTzGsU0C8+3RjtyMaq2gclV/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z8yr9tsjnpNnflgofsc/hHyWtbtVqNZGpnc/o72AJio=;
        b=YUIWhDYk5Tj46EK1GMX2WHSTQxcbeqaahjVf+OAdsx4nb6ZyDFTiQJcGlkyS3bfUNl
         6IB0q3m8HVb9VN08YrkIhGUSWbtVBU/HFrhmnO+uo2wZvIpajhfrK/3HuBV+unceet6T
         ngxcAwatxQ0GVv7jYPWJnSJNlWMd9Zr0LBnzKaRzdb4RLCMV9xW4SUEKMv2cuaAIAvyS
         YlU8nCd4EG/Rypw7+lPTv9cr2svZJFvbH5Pda7PrT57++IscVkKpW8hnmBJv56Ya7No9
         UaCeV0wXXmVX4afKGg/vcJGriQqpXrojy4Zsuzwnn/W7amyNUagIPof6g8GeYWNiirTZ
         vutA==
X-Gm-Message-State: APt69E3lUZIxvxaD2VtjsjYgAHSSaLl81Y4T/TR1PW/Uem1CR8jrbROh
        8KUn5Uj5J8CubuF+P0O9YCuaig==
X-Google-Smtp-Source: ADUXVKLRnFQ2yJ4oVcJh/UOCgzLyfDiKN2N2wvoc6NB7bUfXHjj2ba6IqdwvX64x9NgnLcElyUu2Tg==
X-Received: by 2002:adf:b219:: with SMTP id u25-v6mr10447101wra.1.1528637294352;
        Sun, 10 Jun 2018 06:28:14 -0700 (PDT)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id v31-v6sm99807820wrc.80.2018.06.10.06.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 06:28:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
To: Alban <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
 <344e0087-7410-aebb-8a66-c6976064df10@linaro.org>
 <20180417165420.423a691b@avionic-0020>
 <8c4b48ad-e99e-030a-a4ee-b6df0fa59c79@linaro.org>
 <20180417180040.04f53495@avionic-0020> <20180418134119.2e587621@avionic-0020>
 <9f7d2987-b33e-79b5-ae58-2985fd7334e4@linaro.org>
 <20180418143243.3c23493c@avionic-0020>
 <e34619a4-e9b6-9945-a1cc-a3680aac6819@linaro.org>
 <20180418153440.187ed16e@avionic-0020>
 <d30656d6-f17e-6ed0-251f-2b59d02cd202@linaro.org>
 <20180607184155.6da38a01@tock>
 <0fb0e8e9-e7b8-10c3-fcdd-399c73a33878@linaro.org>
 <20180608125938.4fd457a0@tock>
 <cd7a0085-66cd-308e-a950-cd0eb96db945@linaro.org>
 <20180608190717.55cb185c@tock>
 <02d3cba5-01a3-4d8f-55fc-9c7b7fd5e5c1@linaro.org>
 <20180610133611.51cf6651@tock>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5d1eaf2e-0b8d-3f09-a351-709a95a265eb@linaro.org>
Date: Sun, 10 Jun 2018 14:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180610133611.51cf6651@tock>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/18 12:36, Alban wrote:
> On Sun, 10 Jun 2018 11:32:36 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>> On 08/06/18 18:07, Alban wrote:
>>> On Fri, 8 Jun 2018 12:34:12 +0100
>>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
>>>    
>> ...
>>>
>>> I looked into this. It would work fine for the cells but not so nicely
>>> for the nvmem device API. The phandle for the nvmem device would have
>>> to reference the node passed here and not the real device. We would end
>>> up with a DT like this:
>>>
>>> flash@0 {
>>> 	compatible = "mtd";
>>> 	...
>>> 	nvmem_dev: nvmem-cells {
>>> 		compatible = "nvmem-cells";
>>> 		...
>>>           };
>>> };
>>>
>>> other-device@10 {
>>> 	...
>>> 	nvmem = <&nvmem_dev>;
>>> };
>>>
>>> Now if there is no cell defined we have this empty child node that make
>>> very little sense, it is just there to accommodate the nvmem API.
>>>    
>> NO. This just looks fine!
>> nvmem-cells is the nvmem provider node without which you would not have
>> any provider instance.
>> All this looks as expected!
>> Am not sure what is the problem here!
> 
> The problem is that DT should represent the hardware, not the OS API.
Exactly!! flash/mtd has nvmem provider which should be represented in 
the DT.

There is no change in DT side from your original patch vs the new 
approach. You still are going to have the same subnode.

Isn't it?

AFAIU, the new approach will make it explicit that there is a nvmem 
provider in the DT.
...
> What should be represented is that other drivers can access data stored
> on this device. It is my understanding that this wouldn't be an
> acceptable binding as the nvmem provider node would only exists because
> of how the NVMEM API currently works, a correct binding would just
> directly reference the storage device without this extra node.
> 
...

>> Having a subnode still sounds very fragile to me,
>> and this could be much specific case of MTD provider. We might have
>> instances where this could be sub-sub node of the the original provider
>> for other providers. Also I do not want to bring in Provider specifics
>> layout into nvmem bindings.
>>
>> I can not make myself any clearer than this, Its going to be a NAK from
>> my side for the above reasons!
> 
> I fully understand you concern but I think they are overblown. First I
> highly doubt that more layouts will ever be needed, using a compatible
> string pretty much guarantee that we won't clash with another binding.
> Furthermore even if you consider this extension "MTD specific" the
> amount of code is very small, non intrusive and only run once at
> registration time. I would understand if we were talking about pages of
> code nesting in various place, but not really when it is a single small
> if block with an obvious condition. And finally I don't see that as MTD
> specific as any other device could use this feature without any code
> change.
> 
>> Also, patch I shared should give enough flexibility to various range of
>> providers which have different child node layouts without touching the
>> nvmem bindings. If it works please use it.
> 
> It works from a code POV but it break the basic guidelines of DT
> bindings. As I want to have this done, I'm going to do a patch as you
> want, but I see a high chance that the binding is going to be rejected
> by the DT maintainers and we'll be back here again.

If you think the sub node is going to be a problem from MTD point of 
view then that is worth discussing.
Adding subnode in nvmem bindings is not going to help or make the 
situation any better.

Lets see how this goes!

thanks,
srini

> 
> Alban
> 
