Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBADC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE28218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfA3Niq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:38:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:34163 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfA3Nip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:38:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 05:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="139178088"
Received: from wchen25-mobl9.ccr.corp.intel.com ([10.249.173.109])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2019 05:38:42 -0800
Message-ID: <1548855520.2161.3.camel@intel.com>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael.Kao@mediatek.com
Date:   Wed, 30 Jan 2019 21:38:40 +0800
In-Reply-To: <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
References: <20190109055724.184692-1-pihsun@chromium.org>
         <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
         <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
         <CANdKZ0eDwTgKoFsAOboCz=q+nsUWepecXA7wmR=jGhkWEzLvnA@mail.gmail.com>
         <49dbd0af-975e-cafb-d1b9-4e491a6c9383@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 三, 2019-01-30 at 11:04 +0100, Daniel Lezcano wrote:
> On 30/01/2019 10:25, Pi-Hsun Shih wrote:
> > 
> > On Wed, Jan 30, 2019 at 3:44 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > > 
> > > 
> > > On 30/01/2019 07:04, Peter Shih wrote:
> > > > 
> > > > Adding Michael Kao to cc list.
> > > > 
> > > > On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.or
> > > > g> wrote:
> > > > > 
> > > > > 
> > > > > The mtk_thermal struct contains a 'struct mtk_thermal_bank
> > > > > banks[];',
> > > > > but the allocation only allocates sizeof(struct mtk_thermal)
> > > > > bytes,
> > > > > which cause out of bound access with the ->banks[] member.
> > > > > Change it to
> > > > > a fixed size array instead.
> > > Even if the fix is correct, it pushes back the bug later in time
> > > if a
> > > new board containing more than MAX_NUM_ZONES is introduced. I
> > > suggest to
> > > dynamically allocate the array with the 'num_banks' value.
> > > 
> > For the current code structure, those mtk_thermal_data are
> > statically declared,
> > so if there's new board containing more than MAX_NUM_ZONES of
> > bank_data, it
> > would actually be a compile error.
> > 
> > I'm fine with either way, but feel like that this is simpler than
> > manually
> > calculating the size needed for allocation.
> Right, I missed it can be caught at compile time.
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
As this is a bugfix, I will take it and queue it for next -rc.

thanks,
rui
> 
> 
