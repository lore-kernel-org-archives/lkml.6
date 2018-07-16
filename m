Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85770ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340B4208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 00:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="L9EsC5KK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="INubpysV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340B4208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeGPBWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:22:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34007 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbeGPBWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:22:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B5FC320D12;
        Sun, 15 Jul 2018 20:57:33 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Sun, 15 Jul 2018 20:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=XEAg+bgFTMCgKyEUQISkbEtNSiOja
        W1S8UioMM3vWSs=; b=L9EsC5KK35t+tvbnt5m0qkrP4TYBJjN320siJHQa1ylZR
        NxwITUGEENdkS8fkIFIJLk7MlJSa8W3tN3DZ0JG7s/6d4UJ1JRe9cAM2JqrZ5wS/
        ZCqur5OsKFUw6M3LPX5CJWZc5wuvniqWijaE4YnZErPlIFD6Rs+HnK58BF8OYHN+
        6JHeght0ZfHUxp4YTyCGp6mxJ77jt4NaDd1DHRprjPSKajQsFuqg6IEc0EI6HoeL
        03a1b8nxpTmTwl7MTcbOsz45ejM9QWdHxhArKjeQ9XYr+fyf6zhyvyGzNcpc5SRK
        dctmZ4DyIMXNzS9LeVRNXGS08AZAFCQ5es4e53uEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XEAg+b
        gFTMCgKyEUQISkbEtNSiOjaW1S8UioMM3vWSs=; b=INubpysVMkoFrSWKwpEM8c
        fg+A+0budXBp/JpMV8HS4TR4Wax+eroTdVGPOUAZIgzxXXwpAaTiF32u0rStz7x0
        aNKfR8D6HN6rYqlbYjXoewgJm/hk005JaBfIdWFC0HOUj96q06N5PpDGpUVQp18b
        1cFVCWCLc9q8TdGVBjpjcYzjIgpaCpjG7p7HjtcTGHoimP54UNkzz0qEBgb7zdwG
        p8y41Wd8MUBylGC6C1FrAMD2plHqg1noGM8JAXsOljae14sMJyH8rrPzuiXWI5Pz
        y4LMcCzbxCtr4EKR0xaHC7avLmKbgVM2lw9r35hRUUjoq+jd1cZ3iB4/gQxLrm8A
        ==
X-ME-Proxy: <xmx:e-1LWz_xXiSxjzPa1wXni9Dj_I_R7dfH-POzMJU9U1x5-KL8OZABfg>
    <xmx:e-1LWy956v24dH0qGI0kaiXMEGpQ9TA6sJOEd1oLajm3BoKbn6_9fw>
    <xmx:e-1LW1E_mUi_2FGjK7aqJZQNG0IfNABm3pexooQxpejtQseUkRH84A>
    <xmx:e-1LW5f2Wf34svlcBSur6tzpm22hdFHQ1wnCFuJturPB6IGxo5VM6A>
    <xmx:e-1LW8K6i_J89DpnImV2TEas51MXl-1UQWbyRV7stVSHWfhT36w28Q>
    <xmx:fe1LWysyvQtI3_LywCUZhnKFGVWNMIOcBrhJBYIqeBHiZvlmK-LnfA>
X-ME-Sender: <xms:e-1LW3T6vPR7GMiASaA-y2EHu5RS38fpnTd4B9zw5FyFjCmrmaujqg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 08FE49E0F5; Sun, 15 Jul 2018 20:57:31 -0400 (EDT)
Message-Id: <1531702650.981120.1441646240.2E63DD09@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Alexander Amelkin <a.amelkin@yadro.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>, stewart@linux.ibm.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, avi.fishman@nuvoton.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-957169fa
Date:   Mon, 16 Jul 2018 10:27:30 +0930
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
In-Reply-To: <a521b9fc-4c10-06c1-fd73-5c64379538f6@yadro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

I've rearranged your reply slightly :)

On Sat, 14 Jul 2018, at 00:44, Alexander Amelkin wrote:

> 
> So I'm writing this to support your position in this discussion and to
> let Rob and other reviewers know that this feature is actually needed.

Thanks.

So to summarise some other replies so far, YADRO (Alexander) and Dell (Eugene) - platform vendors integrating BMCs - are interested in a solution, and the patches are seen useful for ASPEED and Nuvoton (Avi) BMCs.

> 
> From the discussion it looks to me like Rob is not familiar with
> specifics of BMC-managed servers and tries to apply to them the rules
> that have proven to be good for workstations and laptops.
> 

Whatever Rob's familiarity with BMCs or other systems, I'm keen to listen to, explore and gain from his experience. I was certainly expecting push back on these patches and in different circumstances I'd probably say no to them as well. The argument for them needs to stand up to scrutiny, and if that scrutiny leads to alternative solutions (that, ideally, are not /dev/mem) then that's fine.

Currently I think we need what I've proposed despite it looking like a violation of abstractions, because the hardware itself doesn't have a neat, abstract design. But we could be thinking about it wrong, e.g. maybe what we need instead are no devicetree bindings and simply some in-kernel helpers that allow arbitrary drivers to instantiate the sysfs interface I've proposed for these fields under their control. That removes the need for explicit description in the devicetree, though may lead to the creation of a number of unique drivers (and bindings) that each cover only the functions we're trying to generalise over here.

It would be good to have some feedback on the proposed sysfs interface as well - as explored above we could feasibly live without the bindings in their current form but taking away the sysfs interface would nuke the series.

Cheers,

Andrew
