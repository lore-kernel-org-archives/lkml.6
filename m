Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC8DC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A9420881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUxKiL3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A9420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeINDBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:01:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35485 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeINDBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:01:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7-v6so3365982pgf.2;
        Thu, 13 Sep 2018 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tpxnm4SPATDFDhHW7EJFbN4E6pNAuK1LkqCym6UiHMs=;
        b=pUxKiL3HC57TIILzELYYXIDj6ZT7UgEoCyJ8e7UzBXPlhST/DxMcbETyAYqTlPjW9M
         LmIaIbkFU4y0zFeeB3eDLTm95IzLLSKjIv/USLyLTUeSxIRpdLQzIMOXjYB6GZrnBOCP
         XE9GmmAo5P9rjcO4P6zjSJnkbh3HHVKCvWPINTZfntmIgKgqgA02h5XdRCeO8dA2sm/4
         723osRChaJAmWsvNvBzn1/QJPCGJHMeC6N0112+q/IYjz6mgOJToEA2fVhgJ9g9BzcPp
         IKtL5HhjWHW1H03fDvcfZ69esk87hIjTqjWGh9x58bnesJSi3059Pk1FYJx8d4F2jJu6
         w/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tpxnm4SPATDFDhHW7EJFbN4E6pNAuK1LkqCym6UiHMs=;
        b=nXwsTwKZnTx0hZzBOY1sz7kTubfRnp/wGOdUz9fWENXAbHDzmO3s8EZFXVI4iElbBr
         HEaRc9oItx3PcZ+7D0k7Zx2sVoR/IFLRn+iigMVw3fhquCNIm7evkueRy083v0EvLvtv
         p8YYWSlOu+rqQUr/B0blYtLs62bsYnpwBoLjH6a29HM0VWRSaBq/+tTQ3WpDpO+HV+SK
         sQBuHyhP6JVsMCaayYXSQguqlJ4BPouQ7jRb+4+qPLmjw4bf/lT3KCubsyLLMOQim9UC
         LQuWk2lWLDM2PZ0Kgx+7zXbb+e/HQIFq6LzoaVCsN95InWQqs8Umm2bdiOb0SQ7KOUPc
         M1jA==
X-Gm-Message-State: APzg51Cz8oRQluzm5XlSkGw9Fta8H8vCFLT55NBSzbm1Xg4o4zpoMHxj
        +oH2B1cOpMthUcaoKzePwvucaS28
X-Google-Smtp-Source: ANB0VdYFTZe3QJ/6D+M8ImxruOsWtxz+taukk0/g3Db3d9TvlTe3fS344aDkGi6aU5i7XDXvbY0VAQ==
X-Received: by 2002:a63:c00b:: with SMTP id h11-v6mr8708780pgg.279.1536875424730;
        Thu, 13 Sep 2018 14:50:24 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id o21-v6sm8052747pfi.165.2018.09.13.14.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:50:23 -0700 (PDT)
Subject: Re: Multi-parent IRQ domains
To:     Thierry Reding <thierry.reding@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180913155945.GA19903@ulmo>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ea9261a9-2c4d-7ca4-6dca-73f385aa46d5@gmail.com>
Date:   Thu, 13 Sep 2018 14:50:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913155945.GA19903@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/13/18 08:59, Thierry Reding wrote:
> Hi everyone,
> 
> I've been trying to implement a feature on recent Tegra chips that's
> called "wake events". These wake events are implemented as part of the
> power management controller (PMC) and they control which events can be
> used to wake the system from suspend. Events include things like an
> alarm interrupt from an RTC, or the GPIO interrupt hooked up to a
> power button for example.
> 
> We already have a driver for a couple of other things that the PMC does,
> so I thought it'd be natural to implement this functionality as an IRQ
> chip in the PMC driver. The way that this would work is that for all the
> devices that are wakeup sources, we'd end up specifying the PMC as the
> interrupt parent and the PMC would then itself have the main GIC as its
> parent. That way, the hierarchical IRQ domain infrastructure would take
> care of pretty much everything.
> 
> Unfortunately I've run into some issues here. One problem that I'm
> facing is that PMC could have more than one parent. For example, the RTC
> alarm interrupt goes straight to the GIC, but the power button GPIO goes
> through the GPIO controller first and then to the GIC. This doesn't seem
> to be something that's currently possible.
> 
> The way I imagine this to work from a DT perspective is as follows:

There is an interrupts-extended property which as a first cell takes a
phandle to the parent interrupt controller, e.g:

interrupts-extended = <&gic 73 GIPC_SPI IRQ_TYPE_LEVEL_HIGH>,
			<&pmc 10>;

(provided that I understood your problem and example correctly). We have
a similar use case on our STB chips where we have "main" interrupts
wired to the ARM GIC and wake-up interrupts wired to a specific wake-up
interrupt controller in an always-on domain. The two controllers have a
different #interrupt-cells specifier.

The interrupt infrastructure in Linux already knows how to deal with
that and whether you use of_get_irq() or platform_get_irq() you should
obtain the correct virtual interrupt numbers that you expected, parented
to the appropriate interrupt controller.

Hope this helps.
-- 
Florian
