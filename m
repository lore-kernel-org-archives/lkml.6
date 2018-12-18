Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2214C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A520C21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5rfGhzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeLRUJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:09:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeLRUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:09:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so8302737plp.9;
        Tue, 18 Dec 2018 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyWGhIgQOc61DdnDkWjIQzAgTj6rHv0lRZFswbXsJJI=;
        b=h5rfGhzf9/Alc86yO/8ZryNI0WfslpBeSgbFeNAP59vDDsT+KQpdBDguA/vVVZoR1u
         YINUP6jf1zBN5R5P8UdNS1tmpkWeBqead/FCM/LBDyZINECejEO1jBafNjHNrb02RM0+
         9jHpyscfL7Qg8B5JvpsKT28U/RZMzBRrOEhHOeOwYRD9QKMt2IUlY0Ia8gX+V+MWuwbD
         D/jM3rJUASGIDvSPjNxEbBb8PDUkDq3eVFReonrWouLfAupD8NJstEXTbR+WN+GZMcVr
         +mEd01LQDrFPkooo74SgoVonJGnSFqTixNWEVlEMUbRkZ7WK5WRHsnV8aFWYlNu/QSoD
         ItGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyWGhIgQOc61DdnDkWjIQzAgTj6rHv0lRZFswbXsJJI=;
        b=N7LNUpdAOGs9tVrnKo+GYXyzzOh28gt/roPh6eN4SibFyUWaQguCBC99uU2R5e590f
         v7U9y8gNkmWQG1Mlutkj6pCgpd2E9stGqIq9LjMGlgv77NV1pKCKfNu+vdCaD83fVIAA
         HAHfqbm9w5xokZ886jugRAbhIdXxVmjsuHTefzReW+N9t1h9tEQqfN8MNQkusEeLbauN
         5VeIshrQJLqTZz09nywu2thA02PodEDs8ZuHirHxfD0xQpJu38XZZJUi2F4X6vBNuiQC
         P1PQ2oaEHLjTRgacnG4tAn28NnBdeHp9s1apM7/J46AbnDT/wF+WjfEgohBnDJoKv4l6
         OVUA==
X-Gm-Message-State: AA+aEWbCwiGSsFUSQ1wE1yJe7tK+czPTbnDXAtzVLaMZCcz4Y+k1dT5h
        YGII2dwxBYzjB7RMAKG5SRc=
X-Google-Smtp-Source: AFSGD/UsNAKrnxb0sHDqgY283PYTwHaHL31JGhTKDHgb/+FJbjDUvN64OlWf4ybU/+rLuM2WO/1gRg==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr4053456plh.78.1545163745558;
        Tue, 18 Dec 2018 12:09:05 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id q195sm17353256pgq.7.2018.12.18.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 12:09:04 -0800 (PST)
Subject: Re: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle
 cache
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
 <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
 <871s6gv30z.fsf@concordia.ellerman.id.au>
 <b81f9268-a36c-963d-5b1e-d81b38b05143@gmail.com>
 <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <893d9327-4353-066d-2efa-414a3db4c282@gmail.com>
Date:   Tue, 18 Dec 2018 12:09:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLjc-tWYOT7ga4oAsgx=rpcWX6_cj80pih-kt=KbFVV=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 12:01 PM, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 12:57 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 12/17/18 2:52 AM, Michael Ellerman wrote:
>>> Hi Frank,
>>>
>>> frowand.list@gmail.com writes:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> Non-overlay dynamic devicetree node removal may leave the node in
>>>> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
>>>> will incorrectly find the stale entry.  Remove the node from the
>>>> cache.
>>>>
>>>> Add paranoia checks in of_find_node_by_phandle() as a second level
>>>> of defense (do not return cached node if detached, do not add node
>>>> to cache if detached).
>>>>
>>>> Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>>> ---
>>>
>>> Similarly here can we add:
>>>
>>> Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
>>
>> Yes, thanks.
>>
>>
>>> Cc: stable@vger.kernel.org # v4.17+
>>
>> Nope, 0b3ce78e90fc does not belong in stable (it is a feature, not a bug
>> fix).  So the bug will not be in stable.
> 
> 0b3ce78e90fc landed in v4.17, so Michael's line above is correct.
> Annotating it with 4.17 only saves Greg from trying and then emailing
> us to backport this patch as it wouldn't apply.

Thanks for the correction.  I was both under-thinking and over-thinking,
ending up with an incorrect answer.

Can you add the Cc: to version 3 patch comments (both 1/2 and 2/2) or do
you want me to re-spin?

-Frank

> 
> Rob
> 

