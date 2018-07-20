Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A748ECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF0F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="fk2qS6gv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Whx79zcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF0F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeGTAxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:53:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34953 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbeGTAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:53:30 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D3942104C;
        Thu, 19 Jul 2018 20:07:58 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Thu, 19 Jul 2018 20:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=eGMzywVPQ7r7zEjVlJrRyAzk9WT3C
        BlsmFp2qjntQ/s=; b=fk2qS6gvH8KEUUWC9iUTbxAjowEmBZcIEg+uQYaqLxQai
        pZpBIFMUB3MilccYDk8uf712IHR1v1UN0LzCQ7pvwuwDfnVmMnvRoUgKjDJ6ooW1
        wgZ5AMT53EuijExCzgpnH1+f8rrUBhJfhrGdd52XNLRJsiYIPXIJfQgi4+Zs54zk
        48Nfd5pDOEzDeILWzKh/kdRjRqj80bOAZlT7DEJYFXgKz19ICD7Q+z0e9nvS+eT/
        MbOjOQiWazJWBWWgNbQKRLZChyF9A+QSZIodJdurDW158qhJRdXWxedm5NdyBAjK
        HnH7kk81nFyrAXbbMYwwpfqOKR5UOILdxRLQRBGmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eGMzyw
        VPQ7r7zEjVlJrRyAzk9WT3CBlsmFp2qjntQ/s=; b=Whx79zcGjf+0m1p1dL/TIR
        KPOZwqRPXoY/Ktp7EqBFrEzKqJJaISsa9xoGE2cWuvL9bNTXLkgooIRTBOy5fD5b
        4rmGJNw9UFWYXBo/9qTabEth+cXF0Ena4gzUFoHYUVofgOx6MloypSSWtTZVbBGF
        906Fcm+qOuNqbO00of9Qx9q+s07G/p0NnFyM4Rzfz/iShA5CrabhoVwUv5jXp9Cz
        G6YgjQ2LwCyZL5U8meq7KFtNe6ALadgEGAbYcnrerHsXCNNb465uHj7tv4Oj/iQi
        mgcVNKkq1bVTmfjrryzL6JKae6ft8pHatD69J8HrV/UJmF7F6oKqgX7gDgcMw/cw
        ==
X-ME-Proxy: <xmx:3CdRW7i9vpgP84_S-CDUjCgqqDBrkil23CXHttwhcRZMV1JEPm7zVQ>
    <xmx:3CdRW8q4eFI3Qz0jAZ2wWMYtxPL5-WTbem3Bp-mMycdL-PuLj2UBmw>
    <xmx:3CdRWzPBNNW11v0vh_Yj1gkbEmj6yhdUD2VCNXRoUk8_hVQam-_BYQ>
    <xmx:3CdRWyYj69WOCcvCk54Ru70SX-J7-_dL6dIdnZyIRmm1N9Q9r6Ez9A>
    <xmx:3CdRW9kv8408cIJYEmjxEHVaj6e373rnxVSZyQ6yOJ8qX7Gqj6EMFA>
    <xmx:3idRW-mNP5EGedi_ki8Uw4A3BCS3GVmUqK0qgWS0rCg8u0naoXFcjw>
X-ME-Sender: <xms:3CdRW0Rq3Q6klLQQkZaLU6aZqGv8JkqwapTGKChfd9islhRhCDJZAw>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 9AE899E100; Thu, 19 Jul 2018 20:07:56 -0400 (EDT)
Message-Id: <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>, Eugene.Cho@dell.com,
        a.amelkin@yadro.com
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-e74bb3a0
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
 <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
Date:   Fri, 20 Jul 2018 09:37:56 +0930
In-Reply-To: <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Andrew, can you start with a list that shows what you expect us to need
> on our systems ?
> 

Okay, our Witherspoon and Romulus platforms containing the ASPEED AST2500 currently need the following tuneables exposed:

From the SCU:
- Debug UART enable
- VGA DAC mux
- VGA scratch registers 0-7
- LPC SuperIO decode enable
- VGA MMIO decode enable

From the LPC controller:
- iLPC2AHB enable
- SuperIO scratch registers 0x20-0x2f

(The LPC controller is just as much of a collection of random bits as the SCU)

Lastly, our Palmetto platform uses an AST2400 which has fewer features compared to the AST2500. Its tuneable list is the same as the above with the exception of "Debug UART enable".

Tuneables that we may need to expose in the future include:

From the SCU:
- PCI VID/DID for the BMC PCIe device
- VGA device enable (may need to be disabled if the platform contains a discrete graphics processor)

From the LPC controller:
- UART mux

Alexander, Eugene, can you chime in with your platforms' needs?

Cheers,

Andrew
