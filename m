Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B05F9C07E80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DA52086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2oOBvfxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DA52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934261AbeFKS4L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932081AbeFKS4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:56:09 -0400
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com [209.85.214.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB08A208AF;
        Mon, 11 Jun 2018 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528743368;
        bh=uOuSeR04aB0L2xNI58oziZVGNpzvPImu9dU4RNiFZEU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=2oOBvfxgLi+yimW/LBGJ1noixd+W+2Ls/iSXG9rppMhVRpdHzEuENrpkMoTKA8lz3
         P0OpSP36ZVU4URVagnmEReGbUKM15UzLxqrLpa3yZbL4Yzpc0O0nmwkINj+DAeUNGd
         xkKJPZw+JvJPcpKHWC6199x6y38QA5Hl6sMT1hBo=
Received: by mail-it0-f46.google.com with SMTP id v83-v6so12272077itc.3;
        Mon, 11 Jun 2018 11:56:08 -0700 (PDT)
X-Gm-Message-State: APt69E0o8q7RowW5WCP08Uw0//Mj0FZeApo7JGFntj3paxFRQuIUpKBG
        MFoFuNk1iU2AwhwdYqAahOg9TCJ4x/U4zO933g==
X-Google-Smtp-Source: ADUXVKLHfb1NzFhVt+bY0i5KyLmxs5EYPa5oF6EP5td7WkO2bi4dI7fg4F6aiSB5b5jHuQyLpuhI0Qz/OkAzkCeRnWc=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr186427itc.19.1528743368188;
 Mon, 11 Jun 2018 11:56:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 11:55:47
 -0700 (PDT)
In-Reply-To: <CAKKbWA4gm1x8VazdMjZ6a9bwGmt=_mZYS2S3FnB2x36Ng+cjCQ@mail.gmail.com>
References: <20180607145821.322979-1-avifishman70@gmail.com>
 <20180607145821.322979-3-avifishman70@gmail.com> <20180611181646.GA5537@rob-hp-laptop>
 <CAKKbWA4gm1x8VazdMjZ6a9bwGmt=_mZYS2S3FnB2x36Ng+cjCQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Jun 2018 12:55:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJYafGzpr8+VQSYJcE5EMo1xZ8NrXTyGBS-7GhU-X+PVg@mail.gmail.com>
Message-ID: <CAL_JsqJYafGzpr8+VQSYJcE5EMo1xZ8NrXTyGBS-7GhU-X+PVg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: new ehci-npcm7xx dt
To:     Avi Fishman <avifishman70@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        James Hogan <jhogan@kernel.org>, Alban <albeu@free.fr>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tony Lindgren <tony@atomide.com>, baolu.lu@linux.intel.com,
        Alex Elder <elder@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 12:24 PM, Avi Fishman <avifishman70@gmail.com> wrote:
> On Mon, Jun 11, 2018 at 9:16 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Jun 07, 2018 at 05:58:20PM +0300, avifishman70@gmail.com wrote:
>>> From: Avi Fishman <AviFishman70@gmail.com>
>>>
>>> Device Tree documentation for Nuvoton npcm7xx EHCI.
>>>
>>> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Rob, if I understand you want me to add another version (v5) with the
> above line (only on the dt)?

No need to *only* do that. Maintainers will collect them on the last
version when they apply patches. You just can't expect that
maintainers will go look at prior versions and collect them.

>>> ---
>>>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
>>
>> Please add acks/reviewed-bys when posting new versions.
>>
>> Rob
