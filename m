Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B870020874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BoHS+y2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfAKK2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:28:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58638 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfAKK2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:28:53 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BASKJi075001;
        Fri, 11 Jan 2019 04:28:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547202500;
        bh=+zDvpcwvNs2Tzut97PtVsFJa5+nb/1iMKUfpE6GKYR8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BoHS+y2pKmjB2Aw+8dFH4CqAPJZxXGAPJOa8YSm9BbtIX7yIjjTMQB5lfFLGKvwhV
         99vS5/75xQsoMGZpfO5PfcElpYPR/xMDUkWk9UITPGiLG0c2u7zpESrm8CsRF7iZ+s
         dtRtIX0coRZwlGtzWUuWxoGzO/vrgUVOgE1eybtg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BASKta120605
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 04:28:20 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 04:28:19 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 04:28:19 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BASFEE014716;
        Fri, 11 Jan 2019 04:28:16 -0600
Subject: Re: [PATCH v4 00/13] Add support for TISCI irqchip drivers
To:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <620377f9-719f-0ce2-2b70-87fb6aa5d764@ti.com>
Date:   Fri, 11 Jan 2019 15:58:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181227060829.5080-1-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 27/12/18 11:38 AM, Lokesh Vutla wrote:
> TI AM65x SoC based on K3 architecture, introduced support for Events
> which are message based interrupts with minimal latency. These events
> are not compatible with regular interrupts and are valid only through
> an event transport lane. An Interrupt Aggregator(INTA) is introduced
> to convert these events to interrupts. INTA can also group 64 events
> into a single interrupt. Now the SoC has many peripherals and a large
> number of event sources (time sync or DMA), the use of events is
> completely dependent on a user's specific application, which drives a
> need for maximum flexibility in which event sources are used in the
> system. It is also completely up to software control as to how the
> events are serviced.
> 
> Because of the huge flexibility there are certain standard peripherals
> (like GPIO etc)where all interrupts cannot be directly corrected to host
> interrupt controller. For this purpose, Interrupt Router(INTR) is
> introduced in the SoC. INTR just does a classic interrupt redirection.
> 
> So the SoC has 3 types of interrupt controllers:
> - GIC500
> - Interrupt Router
> - Interrupt Aggregator
> 
> Below is a diagrammatic view of how SoC integration of these interrupt
> controllers:(https://pastebin.ubuntu.com/p/9ngV3jdGj2/)
> 
> Device Index-x               Device Index-y
>            |                         |
>            |                         |
>                       ....
>             \                       /
>              \                     /
>               \  (global events)  /
>           +---------------------------+   +---------+
>           |                           |   |         |
>           |             INTA          |   |  GPIO   |
>           |                           |   |         |
>           +---------------------------+   +---------+
>                          |   (vint)            |
>                          |                     |
>                         \|/                    |
>           +---------------------------+        |
>           |                           |<-------+
>           |           INTR            |
>           |                           |
>           +---------------------------+
>                          |
>                          |
>                         \|/ (gic irq)
>           +---------------------------+
>           |                           |
>           |             GIC           |
>           |                           |
>           +---------------------------+


Can you please take a look at the MSI changes and provide your feedback? There
are few places(mentioned in the respective patches) where I felt I am hacking
around. It would be really helpful if you give any direction for such hacks.

Thanks and regards,
Lokesh
