Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3811B20811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3811B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeLMKhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:37:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35447 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727374AbeLMKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:37:06 -0500
X-UUID: c7018cb76d6f456486b61b52de923e7e-20181213
X-UUID: c7018cb76d6f456486b61b52de923e7e-20181213
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1319961276; Thu, 13 Dec 2018 18:36:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 18:36:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 18:36:52 +0800
Message-ID: <1544697412.6417.13.camel@mtksdaap41>
Subject: Re: [PATCH] opp: Add API for getting voltage from supplies
From:   Nick Fan <nick.fan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <tfiga@chromium.org>,
        <Chiawen.Lee@mediatek.com>, <erin.lo@mediatek.com>
Date:   Thu, 13 Dec 2018 18:36:52 +0800
In-Reply-To: <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
         <1544445372.3502.42.camel@mtksdaap41>
         <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 78CCB12E74F777C9693E009A464E04C08DD8F271AD16BE63588021EC15F8549E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 12:08 +0530, Viresh Kumar wrote:
> On 10-12-18, 20:36, Nick Fan wrote:
> > For the users who only use one supply, they can use
> > dev_pm_opp_get_voltage to get the voltage data from an opp.
> > But if the users who use more than one supply, they will need this API
> > to get their voltage data from OPP.
> > The users should know about the supply count while creating opp table by
> > using dev_pm_opp_set_regulators function.
> > By using this API, the users can get the voltages by using index to
> > specify which supplies they want.
> > 
> > The following is a simple example to get multiple regulators by this
> > API.
> > for (i = 0; i < regulator_num; i++)
> > 	target_volt[i] = dev_pm_opp_get_voltage_supply(opp, i);
> 
> Fair enough. I couldn't find anything wrong with the patch. Will it be
> possible to send this patch as part of a series which uses the new API
> ? So that we are sure of somebody using it eventually.
> 
This new API is suitable for the users that required to access for
multiple regulators. And I am one of users who uses this API, but I am
not able to upstream the GPU kernel driver which uses the new API.

--
Nick Fan

