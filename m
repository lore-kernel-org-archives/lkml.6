Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C56C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E433208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 14:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfACObb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 09:31:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60321 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730862AbfACOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 09:31:29 -0500
X-UUID: c864cd29932648dda29f502abaee4cac-20190103
X-UUID: c864cd29932648dda29f502abaee4cac-20190103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 506352543; Thu, 03 Jan 2019 22:31:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 22:31:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 22:31:23 +0800
Message-ID: <1546525883.6818.62.camel@mtksdaap41>
Subject: Re: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support
 for active state of scpsys on mt8183
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "James Liao" <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 3 Jan 2019 22:31:23 +0800
In-Reply-To: <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <20190103044852.l7sxfqeqnxx2xbp5@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: E3482CD29CEE3943E9B9F88CA41D95B3699B559D4770B3A9DE0F67F5EB47CBC42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-03 at 10:18 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
> > The patchsets add support for MediaTek hardware module named DVFSRC
> > (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> > a HW module which is used to collect all the requests from both software
> > and hardware and turn into the decision of minimum operating voltage and
> > minimum DRAM frequency to fulfill those requests.
> > 
> > So, This series is to implement the dvfsrc driver to collect all the
> > requests of operating voltage or DRAM bandwidth from other device drivers
> > likes GPU/Camera through 2 frameworks basically:
> > 
> > 1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
> >    requirements from different clients
> > 2. Active state management of power domains[1]: to handle the operating
> >    voltage opp requirement from different power domains
> 
> Honestly speaking I wasn't sure if anyone apart from Qcom will ever use this
> feature when I wrote it first and I am quite surprised and happy to see your
> patches.
> 
> They are mostly very neat and clean patches and I don't have complaints with
> most of them. Lets see what comments others provide on them.
> 
> Thanks.
> 

Thanks for your review and the comments.
Henry

