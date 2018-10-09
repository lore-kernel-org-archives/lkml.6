Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F4BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF762085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF762085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJJEOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:14:31 -0400
Received: from mleia.com ([178.79.152.223]:43364 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbeJJEOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:14:30 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id CBBD741E8F8;
        Tue,  9 Oct 2018 21:55:42 +0100 (BST)
Received: from [172.30.65.24] (nat-ies.mentorg.com [192.94.31.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 5A5C041E8F7;
        Tue,  9 Oct 2018 21:55:41 +0100 (BST)
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-2-vz@mleia.com>
 <5631ac17-a1c1-af12-8b30-314880af42df@gmail.com>
 <4569f3e3-3812-f423-eda9-51e7a4d56a58@mleia.com>
Message-ID: <d7536af1-d78f-6d20-81a0-288be1d67f25@mleia.com>
Date:   Tue, 9 Oct 2018 23:55:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4569f3e3-3812-f423-eda9-51e7a4d56a58@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181009_215542_860371_A517EA49 
X-CRM114-Status: GOOD (  11.23  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 02:11 PM, Vladimir Zapolskiy wrote:
> Hi Marek,
> 
> On 10/09/2018 03:13 AM, Marek Vasut wrote:
>> On 10/08/2018 11:11 PM, Vladimir Zapolskiy wrote:
>>> From: Sandeep Jain <Sandeep_Jain@mentor.com>
>>>
>>> The change adds device tree binding description of TI DS90Ux9xx
>>> series of serializer and deserializer controllers which support video,
>>> audio and control data transmission over FPD-III Link connection.
>>>

[snip]

>>> +Optional properties:
>>> +- reg : Specifies the I2C slave address of a local de-/serializer.
>>> +- power-gpios : GPIO line to control supplied power to the device.
>>
>> Shouldn't this be regulator phandle ?
> 
> It could be, right. I'll ponder upon it.
> 

No, it can not.

The property describes PDB "Power-down Mode Input Pin", it is a control
pin with the predefined voltage, so regulator phandle is not applicable
here.

--
Best wishes,
Vladimir
