Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0169C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937CB216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 21:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937CB216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeHOAQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 20:16:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41061 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeHOAQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 20:16:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E51F7207A3; Tue, 14 Aug 2018 23:27:32 +0200 (CEST)
Received: from localhost (unknown [37.169.151.69])
        by mail.bootlin.com (Postfix) with ESMTPSA id 893EE207C4;
        Tue, 14 Aug 2018 23:27:16 +0200 (CEST)
Date:   Tue, 14 Aug 2018 23:27:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Denis OSTERLAND <denis.osterland@diehl.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] rtc: isl1208: fixes, documentation and isl1219
 support
Message-ID: <20180814212710.GQ943@piout.net>
References: <20180724095437.6016-1-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180724095437.6016-1-Denis.Osterland@diehl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24/07/2018 11:31:21+0000, Denis OSTERLAND wrote:
> changes since v4:
>  - fix 'souces' typo and change interrupt documentation
>  - change "isil,ev-evienb" type to int and do not touch bit if not present
>  - pass ISL1219_REG_EV_EVEN directly instead of assigning it to rc
>  - fix module build by adding EXPORT_SYMBOL to rtc_add_group(s)
>  - use kcalloc
>  - return error if device is already registered
>  - include helper functions into rtc_add_groups
> 
> Michael Grzeschik (1):
>     rtc: isl1208: add support for isl1219 with tamper detection
> 
> Denis Osterland (4):
>     rtc: sysfs: facilitate attribute add to rtc device
>     rtc: isl1208: Add "evdet" interrupt source for isl1219.
>     rtc: isl1208: set ev-evienb bit from device tree
>     rtc: isl1219: add device tree docu
> 


I've now applied all the patches after fixing a few whitespace issues
here and there.

>  .../devicetree/bindings/rtc/isil,isl1219.txt       |  29 ++++
>  drivers/rtc/rtc-core.h                             |  13 ++
>  drivers/rtc/rtc-isl1208.c                          | 192 ++++++++++++++++++---
>  drivers/rtc/rtc-sysfs.c                            |  43 +++++
>  4 files changed, 254 insertions(+), 23 deletions(-)
> 
> Message-Id: 20180710090710.9066-1-Denis.Osterland@diehl.com
> 
> 
> 
> 
> 
> Diehl Connectivity Solutions GmbH
> Geschäftsführung: Horst Leonberger
> Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
> Nürnberg: HRB 32315
> ___________________________________________________________________________________________________
> 
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
> Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
