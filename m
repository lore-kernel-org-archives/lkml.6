Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B7720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B7720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=etezian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeIEPlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:41:10 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:48946 "EHLO
        20.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeIEPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:41:10 -0400
X-Greylist: delayed 1811 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 11:41:09 EDT
Received: from player771.ha.ovh.net (unknown [10.109.146.19])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9C39C17A6D2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Sep 2018 12:34:39 +0200 (CEST)
Received: from etezian.org (unknown [194.136.86.45])
        (Authenticated sender: andi@etezian.org)
        by player771.ha.ovh.net (Postfix) with ESMTPSA id C03F084009B;
        Wed,  5 Sep 2018 12:34:28 +0200 (CEST)
Date:   Wed, 5 Sep 2018 13:34:28 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] input: egalax_ts: add system wakeup support
Message-ID: <20180905103428.GA29158@jack.zhora.eu>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Ovh-Tracer-Id: 12771927069021029059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedriedtgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, Sep 05, 2018 at 05:26:46PM +0800, Anson Huang wrote:
> This patch adds wakeup function support for egalax touch
> screen, if "wakeup-source" is added to device tree's egalax
> touch screen node, the wakeup function will be enabled, and
> egalax touch screen will be able to wakeup system from suspend.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I think you messed up the order of the patches, this patch
whould come after the PATCH 2/2.

You first create the property and then use it. If someone checks
out right here, he would find an inconsistency between the dts
property and this code.

You can either send a version 2 with the correct order or check
if Dmitry and Rob are willing to sync for who takes first the
patch first.

Andi
