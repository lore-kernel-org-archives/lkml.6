Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8029C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE8120693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKPqMplk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE8120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756004AbeFSGJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750917AbeFSGJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:09:16 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A776D208A1;
        Tue, 19 Jun 2018 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529388556;
        bh=gnYboGmOh99GKRD8ycTKR29b4eWi0Hw8uX56V1JsCrE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JKPqMplk2I13u1fA1HmMCA1IJVarGbOEaWZ+8ZHWBk6J4JNtb2IrKgw25DJIHC69v
         6tIO2q763n8jWdfq3yi8Ee6+iTOXUO7NN5XyX98tI+OjgfxYKXpubfrX71/9CSIVll
         sTlc5gknf9kYxmaMi5wmE8xACbHzT+u8CR9tSXY8=
Received: by mail-wm0-f42.google.com with SMTP id r125-v6so19645838wmg.2;
        Mon, 18 Jun 2018 23:09:15 -0700 (PDT)
X-Gm-Message-State: APt69E0ZMqwohRidYcXOwWzb4QLO8S+koBrhZpV5y/xtHEgNY9kP0ypA
        /dpmY9jP/ILOQfLBXc1OHjPCCgdkBeqFPztvw+g=
X-Google-Smtp-Source: ADUXVKK6sGjDQX22lDzZxNH48sF2/TT8RUhjhlTX8zO5UnOomRSsZNzXiCltAOZbgYtSXPhGvQo/Cs/OsrTfK6Jncss=
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr10024441wmi.135.1529388554156;
 Mon, 18 Jun 2018 23:09:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 23:09:13
 -0700 (PDT)
In-Reply-To: <8268db75d4698a4fba9aa11de7e8f6d6f20a0515.camel@perches.com>
References: <20180618191645.15247-1-krzk@kernel.org> <8268db75d4698a4fba9aa11de7e8f6d6f20a0515.camel@perches.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 19 Jun 2018 08:09:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdXv0449yHmsw9w4ASnjkwm2tF5hLc_F3VjvopD7LbJmQ@mail.gmail.com>
Message-ID: <CAJKOXPdXv0449yHmsw9w4ASnjkwm2tF5hLc_F3VjvopD7LbJmQ@mail.gmail.com>
Subject: Re: [PATCH] ARC: dts: Remove leading 0x from node unit addresses
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        devicetree@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 22:07, Joe Perches <joe@perches.com> wrote:
> On Mon, 2018-06-18 at 21:16 +0200, Krzysztof Kozlowski wrote:
>> Remove leading 0x from all node unit addresses with a sed command:
>>
>>     sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" arch/arc/boot/dts/*.dts*
>>
>> This fixes DTC warnings like:
>>
>>     Warning (unit_address_format): /cpu_card/dw-apb-gpio@0x2000: unit name should not have leading "0x"
>
> Do all of these need fixing?
>
> Aren't there dozens of these in arch/arm and elsewhere too?

Yeah, all of them need fixing too... and now I found patch from
Mathieu doing this for Arc:
https://patchwork.kernel.org/patch/10112715/
He also sent patches for other archs.

This patch can be ignored then.

Best regards,
Krzysztof
