Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCDC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000B52145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000B52145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeLNBg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:36:59 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12073 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728203AbeLNBg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:36:58 -0500
X-UUID: 4e53319cd3b347c6b8a4d4806cbd0fe0-20181214
X-UUID: 4e53319cd3b347c6b8a4d4806cbd0fe0-20181214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1151234597; Fri, 14 Dec 2018 09:36:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:36:50 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:36:49 +0800
Message-ID: <1544751409.6417.22.camel@mtksdaap41>
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
Date:   Fri, 14 Dec 2018 09:36:49 +0800
In-Reply-To: <20181213104247.kosguuoukoi645pf@vireshk-i7>
References: <1543906760-15631-1-git-send-email-Nick.Fan@mediatek.com>
         <20181204082158.rb7uzdiwmcotwoxh@vireshk-i7>
         <1544445372.3502.42.camel@mtksdaap41>
         <20181213063850.c5nu3bbe7gm647ca@vireshk-i7>
         <1544697412.6417.13.camel@mtksdaap41>
         <20181213104247.kosguuoukoi645pf@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: D4DF624EBD6D7B04A695D61FDB931F35F20E6E4C300937F86511965A967BB6602000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 16:12 +0530, Viresh Kumar wrote:
> On 13-12-18, 18:36, Nick Fan wrote:
> > This new API is suitable for the users that required to access for
> > multiple regulators. And I am one of users who uses this API, but I am
> > not able to upstream the GPU kernel driver which uses the new API.
> 
> Look at it from mainline's perspective..
> 
> - We don't (can't) care about non-mainline stuff. Actually we do care,
>   but we can't add code to mainline which is not going to be used by
>   any mainline user.
> 
> - I am fine with introducing the new API, but that will happen only if
>   there is going to be a mainline user as well.
> 
> - As you are going to maintain your GPU driver offline, you can
>   maintain this patch too.
> 
> Sorry Nick.
> 
It's OK.
I got your ideas.
Thanks a lot for the explanation and review on this patch.

--
Nick Fan


