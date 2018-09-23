Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE64ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C28C2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28C2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIWT3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:29:05 -0400
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:52236 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbeIWT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:29:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 04BCD100E86C0;
        Sun, 23 Sep 2018 13:31:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spark24_47d26681ec13d
X-Filterd-Recvd-Size: 2047
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Sep 2018 13:31:33 +0000 (UTC)
Message-ID: <b0f415b5b9655571374ab30e37406b494d07bc45.camel@perches.com>
Subject: Re: [PATCH v2] staging: mt7621-mmc: Fix single statement macros in
 sd.c
From:   Joe Perches <joe@perches.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?ISO-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sun, 23 Sep 2018 06:31:32 -0700
In-Reply-To: <20180923093805.GA20870@nishad>
References: <20180923093805.GA20870@nishad>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-09-23 at 15:08 +0530, Nishad Kamdar wrote:
> This patch fixes a few single statement macros in sd.c.
> It converts two macros to inline functions. It removes
> five other macros and replaces their usages with calls to
> the function being called in the macro definition.
> Issue found by checkpatch.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
> Changes in v2:
>   - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
>   - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
>     msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
>     with calls to the function being called by these macros.

Nishad, do please look again for uses of these functions
you are changing.

Please try removing all the #if 0 blocks instead, and then
see if there are also now unused functions from those removed
blocks that could also be removed.

And Greg, if you look at this, look at the odd license of
these files.

It's possible the license is incompatible with the GPL.

