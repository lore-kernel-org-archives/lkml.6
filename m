Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71E2C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8596E20834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8596E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbeLBIvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:51:42 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:59276 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLBIvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:51:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 34869607BD8A;
        Sun,  2 Dec 2018 09:51:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j-tSn2askJu9; Sun,  2 Dec 2018 09:51:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C3F6D607BD9A;
        Sun,  2 Dec 2018 09:51:35 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NcuQ0ND0WUNk; Sun,  2 Dec 2018 09:51:35 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 46C46607BD8A;
        Sun,  2 Dec 2018 09:51:35 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Greg KH <greg@kroah.com>
Cc:     Martin Kepplinger <martin.kepplinger@ginzinger.com>,
        stable@vger.kernel.org, dedekind1@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Juergen <juergen.lachmann@harman.com>
Subject: Re: [PATCH] ubi: fastmap: Check each mapping only once
Date:   Sun, 02 Dec 2018 09:51:34 +0100
Message-ID: <1676802.TThbbZSlzy@blindfold>
In-Reply-To: <20181129080923.GE13859@kroah.com>
References: <20181126103842.3249-1-martin.kepplinger@ginzinger.com> <20181129080923.GE13859@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Am Donnerstag, 29. November 2018, 09:09:23 CET schrieb Greg KH:
> On Mon, Nov 26, 2018 at 11:38:42AM +0100, Martin Kepplinger wrote:
> > From: Richard Weinberger <richard@nod.at>
> > 
> > [ Upstream commit 34653fd8c46e771585fce5975e4243f8fd401914 ]
> > 
> > This commit got merged along with commit 781932375ffc
> > ("ubi: fastmap: Correctly handle interrupted erasures in EBA") upstream but
> > only the latter has been applied to stable v4.14.54 as commit a23cf10d9abb.
> > This resulted in a performance regression. Startup on i.MX platforms is
> > delayed for up to a few seconds depending on the platform.
> > This fixes ubi fastmap to be of the same performance as it has been before
> > said fastmap changes.
> > 
> > Fixes: a23cf10d9abb ("ubi: fastmap: Correctly handle interrupted erasures in EBA")
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> > 
> > Richard, although this fixes a major slowdown regression in -stable, do you
> > consider this "stable" too?
> > 
> > This applies and is tested only for the 4.14 stable tree. It seems to be
> > equally relevant for 4.9 and 4.4 though.
> 
> Now queued up for 4.14.y, thanks.

can you *please* slow a little down?

There are times (e.g. when I travel, visit customers on-site, being sick, etc...)
where I don't have the resources to monitor the mailinglists
in detail. Adding patches to stable on shout asks for trouble.

As Sudip points out, this patch needs a further fix patch:
25677478474a ("ubi: Initialize Fastmap checkmapping correctly")

Thanks,
//richard


