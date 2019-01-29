Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51E6C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841002177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfA2JQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:16:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49249 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2JQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:16:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D25E2FB03;
        Tue, 29 Jan 2019 10:16:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3gK_4hb_nCtb; Tue, 29 Jan 2019 10:16:51 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9CEA3435AD; Tue, 29 Jan 2019 10:16:51 +0100 (CET)
Date:   Tue, 29 Jan 2019 10:16:51 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
Message-ID: <20190129091651.GA8497@bogon.m.sigxcpu.org>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
 <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Jan 28, 2019 at 07:24:33PM +0100, Bastien Nocera wrote:
> On Mon, 2019-01-28 at 18:03 +0100, Guido Günther wrote:
> > From what I've seen in vendor trees it's fine to treat this as gt1x¹.
> > 
> > [1]: https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/input/touchscreen/mediatek/GT5688
> 
> Can you please point to the exact line of code that makes you say that?
> I'm not saying it's not compatible, but it's not the same driver that
> the current goodix.c was based on, or even goodix.c.
>
> Can you please elaborate?

I basically looked at the registers uses for the config update:

https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/include/gt1x_tpd_common.h#L152
https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/gt1x_generic.c#L430

That and the fact that the driver is doing it's job well made me believe
that's good for base support. Things like hotknot, gesture wakeup and
proximity sensor will need additional work.

> Finding that data in the specs would also be fine:
> https://github.com/hadess/gt9xx/tree/master/specifications

https://github.com/hadess/gt9xx/pull/3

Cheers,
 -- Guido
