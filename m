Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAB9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4554E208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4554E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeGaHjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:39:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:39326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbeGaHjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:39:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="62075616"
Received: from zhedache-mobl1.ccr.corp.intel.com ([10.255.30.53])
  by orsmga006.jf.intel.com with ESMTP; 30 Jul 2018 23:00:55 -0700
Message-ID: <1533016858.2550.21.camel@intel.com>
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
From:   Zhang Rui <rui.zhang@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 31 Jul 2018 14:00:58 +0800
In-Reply-To: <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
         <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2018-07-31 at 10:21 +0530, Viresh Kumar wrote:
> On 05-07-18, 10:39, Viresh Kumar wrote:
> > 
> > Hi,
> > 
> > This is an attempt to fix the broken or partially defined DT
> > bindings
> > for cooling-maps. We should list every device that participates in
> > cooling down at a certain trip point, instead of just the first in
> > the
> > list as that depends on certain ordering of events to work
> > properly.
> > 
> > The first patch extends the binding to allow a list of phandles in
> > "cooling-device" property and the second patch fixes one of the
> > platform's DT.
> > 
> > This will be followed up by fixing all platform DT bindings that
> > have
> > these issues after this set is accepted.
> > 
> > The kernel also requires some changes to handle the phandle list,
> > but
> > wouldn't break with these changes as it reads the first phandle in
> > the
> > list for now. We can update that separately.
> @Zhang: Are you going to apply this for 4.19-rc1 ? There are lot of
> patches that
> I am holding up until this gets merged,
> 
I suppose this patch should go via Eduardo' tree.
Eduardo, can you please take a look at this patch set?

thanks,
rui
