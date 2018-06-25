Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34692565E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34692565E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754823AbeFYJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:07:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754537AbeFYJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:07:16 -0400
X-UUID: 01506ea2b8bb470da06a7139dfcdee91-20180625
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1642554823; Mon, 25 Jun 2018 17:07:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 25 Jun 2018 17:07:10 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 25 Jun 2018 17:07:11 +0800
Message-ID: <1529917631.17448.22.camel@mtkswgap22>
Subject: Re: Add system timer driver for Mediatek SoCs
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 25 Jun 2018 17:07:11 +0800
In-Reply-To: <dd36b094-b11c-e6ef-a0fc-b039785e74f2@linaro.org>
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
         <dd36b094-b11c-e6ef-a0fc-b039785e74f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-25 at 09:34 +0200, Daniel Lezcano wrote:
> On 25/06/2018 09:09, Stanley Chu wrote:
> > This patch adds a new driver for system timer on the Mediatek SoCs.
> 
> Please elaborate why we need yet another timer.
> 
> Is this timer present on all Mediatek platform ? Does it always co-exist
> with the existing one ?
> 
> 
> 
> 
Hi Daniel,

This new "system timer" only exists on recent Mediatek platforms,
for example, MT6765. We will upstream driver first, and then update
device tree on MT6765 later.

System timer is designed and optimized as a SoC timer for
tick-broadcasting. Besides timer IP has simpler register manipulation
and friendly low-power design.

There is no plan to remove existed "General Purpose Timer" now.

Thanks.
Stanley Chu


