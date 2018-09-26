Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41465C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4FC2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awx/r/KL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4FC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeIZUzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:55:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33678 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeIZUzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:55:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10-v6so6280392wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X9qAK/EHVtOPpzFnGz6jfQWV6x8EeAkgSU6li2EAqc4=;
        b=Awx/r/KLPTTZcg421KhZne9x6lKum1jP+Maba7m9qs+lHt6jt5P+4JnMMY+KG5DGhb
         dX82rQRXRSJvBC+WzLngVgox48yrK4Q4/S8n9NC02OX35xCzNJGdumGKeKJDc3CXiKP9
         2YAGEg6U5cWd0PTs75+UbpVzLP0vxS2J/jXgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9qAK/EHVtOPpzFnGz6jfQWV6x8EeAkgSU6li2EAqc4=;
        b=tIL+7BVMVHXq73Eut/Rp1/+aR+CA5yZCakvzNYXpK/bpQNWzqJS/FskS73CuGTTW1V
         cbc4FJEtHvz86251dO9ZBXmWfFZQM+uM/c4I7wXbjsv8epEcyeKV+QWrgwggA2B47AHu
         GgNaaCeessmlI5WQy+bHEjNcW0GoXmXUnnzXI8I8lVhPmx+1+zHKPR0wWFcZ8WgFJ5ju
         oHbPoAK8thlXDIEIGNwXPYjc7qn6vcuuyeUwFNE9jIl7YzlWSJQfd8ChnKeHlOoPDcmn
         6hQI+gzkykIYhjfzRuQ87HqF975LwV6USXk7gLb6N693yzH3QXCQ27Ob7m/reesDhQEn
         rccA==
X-Gm-Message-State: ABuFfoi7MDxSLuk2IevUnag8ttjYcG55WbrFQBOs7GLesmB8h7vT+MZE
        DjdFo53Y9o3TimVM+oQJfVrr58xjytw=
X-Google-Smtp-Source: ACcGV61aBc6C+LTzPGYB9HUutueR9PpH5DW4TcGWmflUcxC3Dm8QP9UMUHsbY7xRPV9z3qS91We6iw==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr5435938wrx.157.1537972939337;
        Wed, 26 Sep 2018 07:42:19 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y203-v6sm4883869wmd.1.2018.09.26.07.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:42:18 -0700 (PDT)
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
Date:   Wed, 26 Sep 2018 17:42:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180925180215.GA12435@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the comments!

On 09/25/2018 09:02 PM, Rob Herring wrote:
> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>> This binding is intended to represent the relations between the interconnect
>> controllers (providers) and consumer device nodes. It will allow creating links
>> between consumers and interconnect paths (exposed by interconnect providers).
> 
> As I mentioned in person, I want to see other SoC families using this 
> before accepting. They don't have to be ready for upstream, but WIP 
> patches or even just a "yes, this works for us and we're going to use 
> this binding on X".

Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
currently using this binding, there is ongoing work from at least two
other vendors that would be using this same binding. I will check on
what is their progress so far.

> Also, I think the QCom GPU use of this should be fully sorted out. Or 
> more generically how this fits into OPP binding which seems to be never 
> ending extended...

I see this as a further step. It could be OPP binding which include
bandwidth values or some separate DT property. Jordan has already
proposed something, do you have any initial comments on that?

BR,
Georgi

>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> new file mode 100644
>> index 000000000000..5cb7d3c8d44d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -0,0 +1,60 @@
>> +Interconnect Provider Device Tree Bindings
>> +=========================================
>> +
>> +The purpose of this document is to define a common set of generic interconnect
>> +providers/consumers properties.
>> +
>> +
>> += interconnect providers =
>> +
>> +The interconnect provider binding is intended to represent the interconnect
>> +controllers in the system. Each provider registers a set of interconnect
>> +nodes, which expose the interconnect related capabilities of the interconnect
>> +to consumer drivers. These capabilities can be throughput, latency, priority
>> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
>> +depending on the use case. Interconnect providers can also be interconnect
>> +consumers, such as in the case where two network-on-chip fabrics interface
>> +directly
> 
> missing '.'
> 
>> +
>> +Required properties:
>> +- compatible : contains the interconnect provider compatible string
>> +- #interconnect-cells : number of cells in a interconnect specifier needed to
>> +			encode the interconnect node id
>> +
>> +Example:
>> +
>> +		snoc: snoc@580000 {
>> +			compatible = "qcom,msm8916-snoc";
>> +			#interconnect-cells = <1>;
>> +			reg = <0x580000 0x14000>;
>> +			clock-names = "bus_clk", "bus_a_clk";
>> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
>> +		};
>> +
>> +
>> += interconnect consumers =
>> +
>> +The interconnect consumers are device nodes which dynamically express their
>> +bandwidth requirements along interconnect paths they are connected to. There
>> +can be multiple interconnect providers on a SoC and the consumer may consume
>> +multiple paths from different providers depending on use case and the
>> +components it has to interact with.
>> +
>> +Required properties:
>> +interconnects : Pairs of phandles and interconnect provider specifier to denote
>> +	        the edge source and destination ports of the interconnect path.
>> +
>> +Optional properties:
>> +interconnect-names : List of interconnect path name strings sorted in the same
>> +		     order as the interconnects property. Consumers drivers will use
>> +		     interconnect-names to match interconnect paths with interconnect
>> +		     specifiers.
> 
> specifier pairs.
> 
>> +
>> +Example:
>> +
>> +	sdhci@7864000 {
>> +		...
>> +		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
>> +		interconnect-names = "ddr";
>> +	};
