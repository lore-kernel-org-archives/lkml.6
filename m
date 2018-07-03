Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205ADC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E3924A6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="ny2o5vZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E3924A6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeGCPk3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:40:29 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:59942 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeGCPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dwcp1Sgd3kyrBbBGB/TF96dfsCdhJDZd5DXRGUm9U2A=; b=ny2o5vZFduYX2AvecitCoBhyaM
        fL/oeG/uuHJIOMbXHNiH+fdJ61gHxDWPGVWGB/e3oimKDUQRqdLo4tuBtbkMo36HGM2r34dLydpAc
        zmHAy10mxTDuZkEvMtfYUJ2s6TqggsE9fsAX+mmdJw/e/qsPzsn4n9fbPSPv1ZdGMXoP2cP5OzyIS
        rYKG0WccgH28PDeuUDvD0S1D/7+ZJVddF+TrALbkMflPTkXAgaDMq1MkYHwUlJNoOa1270h8XA3GG
        zFdGqaMoNZXGpqPhDXcQP1Ry0MnxEmDZJICyid4T7UDnTXjZUiEJw2+SonMu2RoqHzAZ3O4O2ao6F
        xWFOMBNA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:38406 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1faNPn-001C5l-Vo; Tue, 03 Jul 2018 15:40:28 +0000
Date:   Tue, 3 Jul 2018 08:40:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fsi/sbefifo: Add dependency on OF_ADDRESS
Message-ID: <20180703154027.GA1180@roeck-us.net>
References: <1530625429-5506-1-git-send-email-linux@roeck-us.net>
 <fb51cbf8adfe2b50ce2b3fe0e6851ef5982d12db.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb51cbf8adfe2b50ce2b3fe0e6851ef5982d12db.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:23:20AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-03 at 06:43 -0700, Guenter Roeck wrote:
> > The driver calls of_platform_device_create() which is only available
> > if OF_ADDRESS is enabled. When building sparc64 images, this results
> > in
> > 
> > ERROR: "of_platform_device_create" [drivers/fsi/fsi-sbefifo.ko] undefined!
> > 
> > Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks Guenter ! I'll include this into the fsi tree.
> 
> (I was wondering what that kbuild report on sparc64 was about... I must
> have misread the code, I didn't realize of_platform_device_create
> wasn't under CONFIG_OF alone).
> 
No worries; pretty much everyone using one of the affected functions
falls into that trap.

Guenter
