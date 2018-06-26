Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE29C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F7E25FEB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F7E25FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeFZIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:03:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752169AbeFZIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:03:45 -0400
X-UUID: c5f6c9f62a104778841a2ebfc228662f-20180626
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 799738630; Tue, 26 Jun 2018 16:03:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 26 Jun 2018 16:03:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 26 Jun 2018 16:03:38 +0800
Message-ID: <1530000218.17448.28.camel@mtkswgap22>
Subject: Re: Add system timer driver for Mediatek SoCs
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Tue, 26 Jun 2018 16:03:38 +0800
In-Reply-To: <561c2c41-ea92-3ad8-a1d7-aeef46cdc601@linaro.org>
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
         <dd36b094-b11c-e6ef-a0fc-b039785e74f2@linaro.org>
         <1529917631.17448.22.camel@mtkswgap22>
         <561c2c41-ea92-3ad8-a1d7-aeef46cdc601@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 09:31 +0200, Daniel Lezcano wrote:
> On 25/06/2018 11:07, Stanley Chu wrote:
> > On Mon, 2018-06-25 at 09:34 +0200, Daniel Lezcano wrote:
> >> On 25/06/2018 09:09, Stanley Chu wrote:
> >>> This patch adds a new driver for system timer on the Mediatek SoCs.
> >>
> >> Please elaborate why we need yet another timer.
> >>
> >> Is this timer present on all Mediatek platform ? Does it always co-exist
> >> with the existing one ?
> >>
> >>
> >>
> >>
> > Hi Daniel,
> > 
> > This new "system timer" only exists on recent Mediatek platforms,
> > for example, MT6765. We will upstream driver first, and then update
> > device tree on MT6765 later.
> > 
> > System timer is designed and optimized as a SoC timer for
> > tick-broadcasting. Besides timer IP has simpler register manipulation
> > and friendly low-power design.
> > 
> > There is no plan to remove existed "General Purpose Timer" now.
> 
> It is unclear what "General Purpose Timer" and "System Timer" differ
> except they are different timers running on different platforms.
> 
> Merge them into a single timer-mediatek.c file.
> 
Hi Daniel,

Yes, they are different timers running on different platforms.

"System Timer" can replace "General Purpose Timer" in recent platforms,
for example, MT6765.

Thanks.
Stanley Chu

