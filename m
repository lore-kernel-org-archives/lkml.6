Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F881ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574662098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SWyTQ2om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574662098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJRQ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:27 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59540 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbeJRQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ha+yvnti3ZQhQfgTsKawrjwVhtS+fRMmqhLuqiyOCFU=; b=SWyTQ2omooXd6TzfFBIWYt7S1
        XY4gqSGUtVd02Y84BPHrqNZmrgRwpI7ST0YpOViYzysGTk8/0LH/dCps5mUxPeFIrZeB5nnzO48NC
        C4gOFtRopbr+tQP5I2zN2mvx8PtIOIUYJUuubdEQehFqjI733HpEbr70lkSupdR8kGKdc=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:58014)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gD46Q-0000Td-Vm; Thu, 18 Oct 2018 09:56:23 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gD46K-0000LT-0D; Thu, 18 Oct 2018 09:56:16 +0100
Date:   Thu, 18 Oct 2018 09:56:09 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Teng Fei Fan <tengfei@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
Message-ID: <20181018085609.GI30658@n2100.armlinux.org.uk>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
> This patch adds support for cacheinfo on 32bit ARMv8 platform.
> Add support for detecting cpu cache information cpu cache information
> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
> can get from /sys/devices/system/cpu/cpuX/cache.

You don't explain why this is needed.

We don't do this for previous 32-bit CPUs, so why should we do this
for ARMv8 running on a 32-bit kernel?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
