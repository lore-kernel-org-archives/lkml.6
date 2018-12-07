Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF65DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F+knZ3tL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F89E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeLGPpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:45:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lqXGYpjRvUjMOS0V9Zew5Aq5Mvh6/agliz6E0R9pHHk=; b=F+knZ3tLSZW5x0XQydhnNULHr
        mSd7NhwbXeIiUwxWnMuxeicu3hrBNMbcV1dXYwFDO50V3Tf2lt4y/YrlK3u8tdVsEQ9ekLcxGBwQ3
        vUONlb/xcebSLIj8FXxgkUY1qt1qjlRPj9+zdu6u/lKJ2vNW6EQBJIGjIPet0RBTBXuYbjf7KpGUi
        KlUiTCoV3jqSj31dir/yhWFreWc/qAkhUV+zRvf9kxGw8vg548/LTHl8LBU6nonnVeTNv2C7BsWsA
        /mnP8VKlStwk3nwlF0Dk+0IooPll2P1u5FYLCQrhQlL80EM1oZ25P8pani75Jy6KwdmuYolLfF34L
        /5fKG3s6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVIJK-0005gJ-Hz; Fri, 07 Dec 2018 15:45:02 +0000
Date:   Fri, 7 Dec 2018 07:45:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 1/8] sh: dreamcast: rtc: push down rtc class ops into
 driver
Message-ID: <20181207154502.GA21335@infradead.org>
References: <20181207134824.300024-1-arnd@arndb.de>
 <20181207134824.300024-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207134824.300024-2-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 02:48:17PM +0100, Arnd Bergmann wrote:
> The dreamcast RTC support has an extra level of indirection to
> provide either the old read_persistent_clock/update_persistent_clock
> interface or the rtc-generic device for hctosys/systohc.

s/dreamcast/sh/ in the above sentence?  Also repeated in the other
patches.
