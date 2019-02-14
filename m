Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA13CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54EE222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407630AbfBNP4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:56:46 -0500
Received: from muru.com ([72.249.23.125]:38844 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBNP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:56:45 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D708A80EA;
        Thu, 14 Feb 2019 15:56:53 +0000 (UTC)
Date:   Thu, 14 Feb 2019 07:56:40 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@lechnology.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>, dan@kulp.com,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
Message-ID: <20190214155640.GD5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <16001a6f-faed-ee14-5ade-79d5462f6d51@ti.com>
 <5C654C39.2030308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5C654C39.2030308@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190214 11:09]:
> Suman is mainly concerned about the following changes in v2
> 1) pruss node does not contain reg property representing entire ICSS.
> 2) pruss node does not contain interrupts.
> 
> Both of these are required if drivers/uio/uio_pruss.c or in future if
> VFIO is to be used.
> 
> The beagleboard community is a primary user of this driver and we need to
> find a solution so that PRUSS is usable either via remoteproc or via UIO.
> 
> Ideal case should allow user to use either of the drivers by just doing
> a unbind and bind.
> 
> I don't have a better idea than having a encapsulating node that has
> the appropriate reg and interrupt properties.

If there are existing use cases that need to be supported
you should list them as non-standard usage in the binding
and not recommended for future use. Rob may have some
comments on how to deal with this.

Then you can have device driver that needs to pass them
parse them from the PRUSS parent node. That does not mean
there needs to be a top level device driver for PRUSS,
the child control module can just parse the non-standard
bindings for compability from the parent node.

And naturally in addition to handling the non-standard
binding we need to have a proper standardized binding
too :)

Regards,

Tony
