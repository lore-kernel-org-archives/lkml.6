Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD7C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B9C20989
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QNOlhw9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfAZVGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:06:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42054 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v1pUe8U3koPCbUGEXyabYzj4Vrle2C0B15qKtiK8qfY=; b=QNOlhw9+UnVErXJA/rMeONvSc
        RO1/s9w5rspj6lmouLBQEVdjt/cSt1xkhCQVO8E2scrQAbAtp8W/phbtgQRD7eGfl4x+axmjp3Wts
        r2/CILGFqWwDX5RMz224h9rZA+NfoHt57POHuHI7P2AvZX73gvakQ0+kbKVYPVm8Vv1yXwk1aJnPq
        9nu6QbMdoZzNAUVe19ys66zxN5BvKosWoLn8GF0VSClq3vVnMI7UXz23HSQMnC8t8WqvaAmubO0pQ
        YM61/CBApjrZnZl/JpRHZ6azI7GeTyJ3UQVQgwSsAY8s+Du3CIm1lff1+y7Bxtrz3ZywwVReOZhh+
        Nj4SRUaGw==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnV9x-0001wr-6d; Sat, 26 Jan 2019 21:06:37 +0000
Date:   Sat, 26 Jan 2019 13:06:34 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     andy@infradead.org, mario.limonciello@dell.com,
        michal.lkml@markovi.net, mjg59@srcf.ucam.org, pali.rohar@gmail.com,
        yamada.masahiro@socionext.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] platform/x86: wmi: add WMI support to
 MODULE_DEVICE_TABLE()
Message-ID: <20190126210634.GB13882@wrath>
References: <cover.1547827336.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547827336.git.2pi@mok.nu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 12:55:52PM +0100, Mattias Jacobsson wrote:
> This patchset adds WMI support to MODULE_DEVICE_TABLE().

Hi Mattias,

Thanks for the patch series. I've reviewed and found no major issues - but what
I'm missing from this cover letter and each commit message is the why. What is
the problem this series is intended to address? This should be clear in the
commit messages so developers reading the git history have the necessary context
to understand why the change was made and the intent behind them were.

The only advantage that I see by the end of the series is removing the need for
driver authors to prefix the modules alias  with "wmi:" - which is an advantage
and avoids careless errors. Is that the only goal? It adds some complexity by
spreading the implementation across more files and more directories, so we need
to document the justification.

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
