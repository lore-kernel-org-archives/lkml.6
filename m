Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6E220844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbfBEQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:19:49 -0500
Received: from muru.com ([72.249.23.125]:37710 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfBEQTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 11:19:49 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 124E7809C;
        Tue,  5 Feb 2019 16:19:56 +0000 (UTC)
Date:   Tue, 5 Feb 2019 08:19:45 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, s-anna@ti.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        woods.technical@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20190205161945.GS5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com>
 <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com>
 <5C59AEA3.1080400@ti.com>
 <124e9f09-fb60-071d-e2ba-ec6f7fb3955c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124e9f09-fb60-071d-e2ba-ec6f7fb3955c@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Murali Karicheri <m-karicheri2@ti.com> [190205 16:13]:
> On 02/05/2019 10:41 AM, Roger Quadros wrote:
> > What I'm suggesting here is that kernel remoteproc driver should have nothing to do
> > with the other PRU's data RAM.
> > 
> > The application driver if needs both PRUs then it can obviously access both DRAMs
> > as it has a phandle to both PRUs.
> > 
> That should be fine.

That sounds good to me too.

For dts, yeah please allocate the resources for the modules
where the resources belong to on the PRUSS internal interconnect :)
Devices can move around on the interconnect between SoCs and the
modules can get swapped or added.

Regards,

Tony
