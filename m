Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171CA20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELLgaTsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfBYRjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:39:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfBYRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:39:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so10927537wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EP73t9niexugmVLGxxDvOP8RKBRTJ0JEVc4EokqAYoA=;
        b=ELLgaTsAHGr1gArpOBWvDQKio4ZsTrsFRYkNqjS2PnCLYNkfb3sjE+36NDGgZGSK1i
         RdgOWNbdUC11k6+Zi6S3hSSKtHgSroVkB1xdyBf1ik41e/ptO0wxfqYL3K06YePVhc+/
         ZCwC9UX6tGW8LVArrhBm1ON9dXJueYap8je4P+LO585mZ7I+Q39V5/9Qd5hCKybmOJtJ
         s3hSEGE0AYd0Etf7rnqUXL7ZQZnhxJaFxyZYiDMPxGw7YjSS4/GVloDbyrpsHcm43hT4
         gkIZj9oDQdkjQClOPLsFXlO3jG28vP+r1FKiVl4whbMwIKzO9zIg0fS9KW/MP4Pj8Nf5
         NOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EP73t9niexugmVLGxxDvOP8RKBRTJ0JEVc4EokqAYoA=;
        b=fbL7sNwOKxrcGJWKhqycfrXSgFeo6+XcZtg3JNXndz/cnP4/YAdHHvIcCJgxeEg7ay
         nhLWP2VxJ0T/71lqwJXS5hBNYl5qPwGLRVi69Gt4Sl+6fujo27WTZST1zVAcWUTCjCl6
         ask7embn04LDi4JFhdMHZzWzyxd59XG9dHJYjNGbWv3fu0hHv/GgP4GkCXTqLApL+WhR
         WMOYXnwSaJN8qRjObQXSNpmPkglm+FM89UWsmFl/75Zd+NyfmMdERKrKqDER00NztZNh
         EbvmzFmcs0F7UMRW0FZmQZX700yG3xKEu//4rMcHURSckubEMAkLSWeGKrtGQzBA/BaK
         Aw6A==
X-Gm-Message-State: AHQUAuasQlpwSgpo5iozNG7RYrTERQ/a3AIkWoKdxg9SWsco9Alxko/E
        Pui27+HmcAHug2SooHFdWMTlmg==
X-Google-Smtp-Source: AHgI3IZEEvvprW81GnqcK5xQz+ZYy7Fj0a1HOAP8wvyUWzZubZMpemcldxzfgioMZ/RsIho7m3xOWQ==
X-Received: by 2002:a5d:4149:: with SMTP id c9mr13866684wrq.58.1551116379880;
        Mon, 25 Feb 2019 09:39:39 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 132sm26928016wmd.27.2019.02.25.09.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:39:39 -0800 (PST)
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: Add interconnect binding for
 GENI QUP
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        swboyd@chromium.org
References: <1548138816-1149-1-git-send-email-alokc@codeaurora.org>
 <1548138816-1149-2-git-send-email-alokc@codeaurora.org>
 <20190123170758.GB512@tuxbook-pro>
 <5ca1ce61-c458-5550-f89d-ab361f1ec456@linaro.org>
 <20190223002655.GA6631@bogus>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <9318130e-0c2c-c1c1-6ad1-b8bc8ec0c223@linaro.org>
Date:   Mon, 25 Feb 2019 19:39:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190223002655.GA6631@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/19 02:26, Rob Herring wrote:
> On Wed, Jan 23, 2019 at 08:41:20PM +0200, Georgi Djakov wrote:
>> Hi,
>>
>> On 1/23/19 19:07, Bjorn Andersson wrote:
>>> On Mon 21 Jan 22:33 PST 2019, Alok Chauhan wrote:
>>>
>>>> Add documentation for the interconnect and interconnect-names bindings
>>>> for the GENI QUP as detailed by bindings/interconnect/interconnect.txt.
>>>>
>>>> Signed-off-by: Alok Chauhan <alokc@codeaurora.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> index dab7ca9..44d7e02 100644
>>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
>>>> @@ -17,6 +17,12 @@ Required properties if child node exists:
>>>>  - #address-cells: 	Must be <1> for Serial Engine Address
>>>>  - #size-cells: 		Must be <1> for Serial Engine Address Size
>>>>  - ranges: 		Must be present
>>>> +- interconnects:	phandle to a interconnect provider. Please refer
>>>> +			../interconnect/interconnect.txt for details.
>>>> +			Must be 2 paths corresponding to 2 AXI ports.
>>>> +- interconnect-names:	Port names to differentiate between the
>>>
>>> s/Port names/Path names/
>>>
>>>> +			2 interconnect paths defined with interconnect
>>>> +			specifier.
>>>
>>> These two names are significant in that they must match what the driver
>>> expects, hence you must actually specify them here.
>>>
>>> And as the scope of these strings are local to the QUP node you can omit
>>> "qup" from them, so make them "memory" and "config" (or perhaps iface,
>>> to match the clock naming?).
>>
>> Actually there was a discussion in the past where we decided include
>> both the src and dst endpoint names in this property so that there is
>> some symmetry with the "interconnects" property. It would be nice to be
>> consistent across different drivers at least for now.
>> If we want to denote the master and slave ports here, my two cents would
>> be for "qup-mem" and "cpu-qup" or something similar?
> 
> Well, there's a proposal from Maxime to add 'dma-memory' or something. 
> You all need to sort this out.

Agree. I haven't commented on the latest MBUS patches yet. Meanwhile i
am trying to get a better understanding of the hardware. In general if
there are no better suggestions, i am fine with adding a specific name
to handle this kind of dma transfers.

> I assume config or cpu-qup is for register access? Why is this needed? 
> That should get described thru the DT tree. The interconnect stuff was 
> supposed to be for the non-cpu centric view (i.e. DMA masters). Maybe 
> it's fine, but that's not my initial reaction.

Yes, cpu-qup should be for register access. Alok, please correct me if i
am wrong, but I believe this is a separate bus used only for
configuration access to some HW blocks. This bus might be disabled by
default and we may need to request some bandwidth in order to enable it.
It's described as a separate path in DT and we are trying to give it a
meaningful name.

Thanks,
Georgi
