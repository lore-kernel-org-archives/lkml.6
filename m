Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEDDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98C520882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98C520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbeLMKZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:25:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17549 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLMKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:25:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3943B30A3AE1;
        Thu, 13 Dec 2018 10:25:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6D3F60C66;
        Thu, 13 Dec 2018 10:25:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0832F16E29; Thu, 13 Dec 2018 11:25:22 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:25:22 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     Tom Murphy <murphyt7@tcd.ie>, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix dma-buf/udmabuf selftest
Message-ID: <20181213102521.tunzbhq4rk5loxk2@sirius.home.kraxel.org>
References: <20181127103312.19368-1-murphyt7@tcd.ie>
 <81c4efd9-2ccd-53ec-98e7-663c95d6d5c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c4efd9-2ccd-53ec-98e7-663c95d6d5c4@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 13 Dec 2018 10:25:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 02:15:49PM -0700, shuah wrote:
> Hi Daniel,
> 
> On 11/27/18 3:33 AM, Tom Murphy wrote:
> > This patch fixes the udmabuf selftest. Currently the selftest is broken.
> > I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
> > file descriptor which is required by udmabuf and added the test to
> > the selftest Makefile.
> > 
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> 
> Does this change look good you? I plan to get this in for 4.21-rc1. Let me
> know if you have any objections.

Yes, it's fine.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

