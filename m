Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63534C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F87E20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfBAIWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:22:42 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57926 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728654AbfBAIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:22:41 -0500
X-UUID: f4d92ad28de54b6c9112fb1693ab0264-20190201
X-UUID: f4d92ad28de54b6c9112fb1693ab0264-20190201
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2114098548; Fri, 01 Feb 2019 16:22:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 16:22:33 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 16:22:33 +0800
Message-ID: <1549009353.22634.6.camel@mtksdaap41>
Subject: Re: [PATCH v3 12/12] clk: mediatek: Allow changing PLL rate when it
 is off
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>
Date:   Fri, 1 Feb 2019 16:22:33 +0800
In-Reply-To: <154482488309.19322.1300826887966936368@swboyd.mtv.corp.google.com>
References: <20181210073240.32278-1-weiyi.lu@mediatek.com>
         <20181210073240.32278-14-weiyi.lu@mediatek.com>
         <154482488309.19322.1300826887966936368@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 323FA7B1E94B6F4E0691E4A862BF236DC171CD9DE8FDF8AAEDC9BCDAB7A414842000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2018-12-14 at 14:01 -0800, Stephen Boyd wrote:
> Quoting Weiyi Lu (2018-12-09 23:32:40)
> > From: James Liao <jamesjj.liao@mediatek.com>
> > 
> > Some modules may need to change its clock rate before turn on it.
> > So changing PLL's rate when it is off should be allowed.
> > This patch removes PLL enabled check before set rate, so that
> > PLLs can set new frequency even if they are off.
> > 
> > On MT8173 for example, ARMPLL's enable bit can be controlled by
> > other HW. That means ARMPLL may be turned on even if we (CPU / SW)
> > set ARMPLL's enable bit as 0. In this case, SW may want and can
> > still change ARMPLL's rate by changing its pcw and postdiv settings.
> > But without this patch, new pcw setting will not be applied because
> > its enable bit is 0.
> > 
> > (am from https://patchwork.kernel.org/patch/9411983/)
> 
> Remove this.
> 

OK, I'll remove it.

> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > Acked-by: Michael Turquette <mturuqette@baylibre.com>
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>



