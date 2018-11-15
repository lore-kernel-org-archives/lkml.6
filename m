Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF12087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBF12087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbeKOTkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:40:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49691 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbeKOTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:40:17 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gNE1S-0000Al-Gi; Thu, 15 Nov 2018 10:33:14 +0100
Message-ID: <1542274394.4915.6.camel@pengutronix.de>
Subject: Re: [PATCH][next] reset: fix null pointer dereference on dev by
 dev_name
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Nov 2018 10:33:14 +0100
In-Reply-To: <20181114214935.16038-1-colin.king@canonical.com>
References: <20181114214935.16038-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Wed, 2018-11-14 at 21:49 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to dev_name will dereference dev, however, dev is later
> being null checked, so there is a possibility of a null pointer
> dereference on dev by the call to dev_name. Fix this by null
> checking dev first before the call to dev_name
> 
> Detected by CoverityScan, CID#1475475 ("Dereference before null check")
> 
> Fixes: 2a6cb2b1d83b ("reset: Add reset_control_get_count()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thank you, applied to reset/next.

regards
Philipp
