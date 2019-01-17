Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6130D20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfAQOAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:00:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43813 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfAQOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:00:42 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gk8Dn-0004LU-71; Thu, 17 Jan 2019 15:00:39 +0100
Message-ID: <1547733638.4009.11.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] drm/imx: imx-ldb: add missing of_node_puts
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:00:38 +0100
In-Reply-To: <1547369264-24831-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1547369264-24831-1-git-send-email-Julia.Lawall@lip6.fr>
         <1547369264-24831-3-git-send-email-Julia.Lawall@lip6.fr>
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

Hi Julia,

On Sun, 2019-01-13 at 09:47 +0100, Julia Lawall wrote:
> The device node iterators perform an of_node_get on each
> iteration, so a jump out of the loop requires an of_node_put.
> 
> Move the initialization channel->child = child; down to just
> before the call to imx_ldb_register so that intervening failures
> don't need to clear it.  Add a label at the end of the function to
> do all the of_node_puts.

Thank you, I've applied the patch to the imx-drm/fixes branch.

regards
Philipp
