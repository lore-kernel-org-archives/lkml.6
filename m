Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93CC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D26B20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpM5fR/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D26B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbeKJIVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:21:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34479 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:21:18 -0500
Received: by mail-oi1-f194.google.com with SMTP id i138-v6so2837369oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dOQ3tPkDMpUlJmxWJePmN1CQ4nHQycoPB3YCgpj7c/c=;
        b=EpM5fR/xbXVexK9sX3QPVsEqznzhUvpgYUtCPiJxtLc55JTNwx10KMMMSZtXSCLdXg
         o9EQTt+q4bpkmEKsvFc2ZiiKsA1M3r+UhD0l70vah/jdkJcoZq1JQwRww7t1isys8lIb
         Pty4PkTJAa527aVBwXyPdlzmlLq/5JOa+6URM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dOQ3tPkDMpUlJmxWJePmN1CQ4nHQycoPB3YCgpj7c/c=;
        b=hTmL9iDl88wpVvUxsEwYOvVlErxlD6JiOrnw6ppa6CURYMhq/XY0r110uvFH5nt+Fh
         Z22hIFJgN/+b1/CpeXObnzj8xtGrBi2NA39dDhARHIaIEtjCFDfEGEY3mUvGDk/q/tuG
         /hmAJUEtTS9m8ZqdqppnA55o25iUekketT8hY6InaCZSLfgqVnDDyit7xEZV+RZbpmuI
         qPzKzPbywcOzbyMhwNuStqYojEUQ2eHH9qXDynuyl8Xwv22/7QrhBgTQ3Dxd+RcVSM10
         a2gOw5wxOu730Taf3+KuE3Vk66Koj2VjTWhPGwoGIamaP/0BXhP8mzVHTElCm7UcA63d
         kdCg==
X-Gm-Message-State: AGRZ1gJXQ0yyC7rktb1pvbaUOUPjixdSbr2hKm+/W9e/CF+ve9VHh3bW
        8GqghLve/dSyzPTg2ffAqpUmsQ==
X-Google-Smtp-Source: AJdET5d+TxtFgnrpNU1rgFoaPyqfV8gV/kOJjp2PsjdXY9SsNeeJBIkuuRz8w9LqEoUCGh8yWoKfAQ==
X-Received: by 2002:aca:d0c:: with SMTP id 12-v6mr5696878oin.19.1541803119743;
        Fri, 09 Nov 2018 14:38:39 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id e191-v6sm3022437oig.39.2018.11.09.14.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:38:39 -0800 (PST)
Subject: Re: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, davem@davemloft.net,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ilias.apalodimas@linaro.org, netdev <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-2-elder@linaro.org>
 <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <a4c9f0f8-d7c7-2756-cfdf-b67ce9f1ca3b@linaro.org>
Date:   Fri, 9 Nov 2018 16:38:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:59 AM, Rob Herring wrote:
> On Tue, Nov 6, 2018 at 6:33 PM Alex Elder <elder@linaro.org> wrote:
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
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> new file mode 100644
>> index 000000000000..d4d3d37df029
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>> @@ -0,0 +1,136 @@
>> +Qualcomm IPA (IP Accelerator) Driver
> 
> Bindings are for h/w not drivers.

OK.  I'll drop " Driver".

>> +
>> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
>> +certain network processing tasks (e.g. filtering, routing, and NAT) from
>> +the main processor.  The IPA currently serves only as a network interface,
>> +providing access to an LTE network available via a modem.
>> +
>> +The IPA sits between multiple independent "execution environments,"
>> +including the AP subsystem (APSS) and the modem.  The IPA presents
>> +a Generic Software Interface (GSI) to each execution environment.
>> +The GSI is an integral part of the IPA, but it is logically isolated
>> +and has a distinct interrupt and a separately-defined address space.
>> +
>> +    ----------   -------------   ---------
>> +    |        |   |G|       |G|   |       |
>> +    |  APSS  |===|S|  IPA  |S|===| Modem |
>> +    |        |   |I|       |I|   |       |
>> +    ----------   -------------   ---------
>> +
>> +See also:
>> +  bindings/interrupt-controller/interrupts.txt
>> +  bindings/interconnect/interconnect.txt
>> +  bindings/soc/qcom/qcom,smp2p.txt
>> +  bindings/reserved-memory/reserved-memory.txt
>> +  bindings/clock/clock-bindings.txt
>> +
>> +All properties defined below are required.
>> +
>> +- compatible:
>> +       Must be one of the following compatible strings:
>> +               "qcom,ipa-sdm845-modem_init"
>> +               "qcom,ipa-sdm845-tz_init"
> 
> Normal order is <vendor>,<soc>-<ipblock>."

I'll use "qcom,sdm845-ipa-modem-init" and "qcom,sdm845-ipa-tz-init".
(Or just "qcom,sdm845-ipa", depending on the outcome of the discussion
below.)

> Don't use '_'.

OK.

> What's the difference between these 2? It can't be detected somehow?

There is some early initialization, including loading some firmware,
that must be done by trusted code.  That can be done by either Trust
Zone or the modem.  If it's done by the modem, there is an additional
step required during initialization so the modem can tell the AP
that it has done its part, and the AP can finish IPA initialization.

There  is no way of detecting (e.g. by probing hardware) which is
in effect so we use DT.  I discussed this with Bjorn, who said that
this was a situation seen elsewhere and that using compatible strings
was the way he suggested to address it.

> This might be better expressed as a property. Then if Trustzone
> initializes things, it can just add a property.

A Boolean property to distinguish them would be fine as well, but
I would like to address this "common" problem consistently.

Bjorn, would you please weigh in?

>> +
>> +-reg:
>> +       Resources specyfing the physical address spaces of the IPA and GSI.
> 
> typo
> 
>> +
>> +-reg-names:
>> +       The names of the address space ranges defined by the "reg" property.
>> +       Must be "ipa" and "gsi".
>> +
>> +- interrupts-extended:
> 
> Use 'interrupts' here and describe what they are and the order. What
> they are connected to (and the need for interrupts-extended) is
> outside the scope of this binding.

I used interrupts-extended because there were two interrupt parents
(a "normal" interrupt controller and the interrupt controller implemented
for SMP2P input).  A paragraph here:
    bindings/interrupt-controller/interrupts.txt
recommends "interrupts-extended" in that case.

I have no objection to using just "interrupts" but can you tell me what
I misunderstood?  It seems like I need to do "interrupts-extended".

>> +       Specifies the IRQs used by the IPA.  Four cells are required,
>> +       specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
>> +       from the modem; and the "ready for stage 2 initialization"
>> +       interrupt from the modem.  The first two are hardware IRQs; the
>> +       third and fourth are SMP2P input interrupts.
>> +
>> +- interrupt-names:
>> +       The names of the interrupts defined by the "interrupts-extended"
>> +       property.  Must be "ipa", "gsi", "ipa-clock-query", and
>> +       "ipa-post-init".
> 
> Format as one per line.

Done.  And I did this throughout the file where there was more than
one name.  One per line, no comma, no "and".

>> +
>> +- clocks:
>> +       Resource that defines the IPA core clock.
>> +
>> +- clock-names:
>> +       The name used for the IPA core clock.  Must be "core".
>> +
>> +- interconnects:
>> +       Specifies the interconnects used by the IPA.  Three cells are
>> +       required, specifying:  the path from the IPA to memory; from
>> +       IPA to internal (SoC resident) memory; and between the AP
>> +       subsystem and IPA for register access.
>> +
>> +- interconnect-names:
>> +       The names of the interconnects defined by the "interconnects"
>> +       property.  Must be "memory", "imem", and "config".
>> +
>> +- qcom,smem-states
>> +       The state bits used for SMP2P output.  Two cells must be specified.
>> +       The first indicates whether the value in the second bit is valid
>> +       (1 means valid).  The second, if valid, defines whether the IPA
>> +       clock is enabled (1 means enabled).
>> +
>> +- qcom,smem-state-names
>> +       The names of the state bits used for SMP2P output.  These must be
>> +       "ipa-clock-enabled-valid" and "ipa-clock-enabled".
>> +
>> +- memory-region
>> +       A phandle for a reserved memory area that holds the firmware passed
>> +       to Trust Zone for authentication.  (Note, this is required
>> +       only for "qcom,ipa-sdm845-tz_init".)
>> +
>> += EXAMPLE
>> +
>> +The following example represents the IPA present in the SDM845 SoC.  It
>> +shows portions of the "modem-smp2p" node to indicate its relationship
>> +with the interrupts and SMEM states used by the IPA.
>> +
>> +       modem-smp2p {
>> +               compatible = "qcom,smp2p";
>> +               . . .
>> +               ipa_smp2p_out: ipa-ap-to-modem {
>> +                       qcom,entry-name = "ipa";
>> +                       #qcom,smem-state-cells = <1>;
>> +               };
>> +
>> +               ipa_smp2p_in: ipa-modem-to-ap {
>> +                       qcom,entry-name = "ipa";
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <2>;
>> +               };
>> +       };
>> +
>> +       ipa@1e00000 {
> 
> ipa@1e40000

Oops.  Fixed.

>> +               compatible = "qcom,ipa-sdm845-modem_init";
>> +
>> +               reg = <0x1e40000 0x34000>,
>> +                     <0x1e04000 0x2c000>;
>> +               reg-names = "ipa",
>> +                           "gsi";
>> +
>> +               interrupts-extended = <&intc 0 311 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
>> +                                     <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +                                     <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>> +               interrupt-names = "ipa",
>> +                                 "gsi",
>> +                                 "ipa-clock-query",
>> +                                 "ipa-post-init";
>> +
>> +               clocks = <&rpmhcc RPMH_IPA_CLK>;
>> +               clock-names = "core";
>> +
>> +               interconnects = <&qnoc MASTER_IPA &qnoc SLAVE_EBI1>,
>> +                               <&qnoc MASTER_IPA &qnoc SLAVE_IMEM>,
>> +                               <&qnoc MASTER_APPSS_PROC &qnoc SLAVE_IPA_CFG>;
>> +               interconnect-names = "memory",
>> +                                    "imem",
>> +                                    "config";
>> +
>> +               qcom,smem-states = <&ipa_smp2p_out 0>,
>> +                                  <&ipa_smp2p_out 1>;
>> +               qcom,smem-state-names = "ipa-clock-enabled-valid",
>> +                                       "ipa-clock-enabled";
>> +       };
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
>> new file mode 100644
>> index 000000000000..3d0b2aabefc7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
>> @@ -0,0 +1,15 @@
>> +Qualcomm IPA RMNet Driver
>> +
>> +This binding describes the IPA RMNet driver, which is used to
>> +represent virtual interfaces available on the modem accessed via
>> +the IPA.  Other than the compatible string there are no properties
>> +associated with this device.
> 
> Only a compatible string is a sure sign this is not a h/w device and
> you are just abusing DT to instantiate drivers. Make the IPA driver
> instantiate any sub drivers it needs.

Yeah I have been thinking this but hadn't followed through on
doing anything about it yet.  I'll remove this node entirely.
It's possible it had other properties at one time, but in the
end this  represents a soft interface and can be implemented
within the IPA driver.

Thanks a lot for the review.

					-Alex
> 
> Rob
> 

