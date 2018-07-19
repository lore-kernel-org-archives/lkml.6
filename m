Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62CAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278F2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GJ82OvY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278F2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeGSKnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:43:45 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54402 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeGSKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QUG90RfdbvUh/JohGyvpw3u01oT9TZtGCKW95LYmh3U=; b=GJ82OvY6tTfDvon/RZX0r5V5A
        m1KQXTFwdae94C215oJ9gY9OVKfZGYZbJxINwBkx7+I+SllgH1t2X6YUWmXA7uA7NjWYdvVgXC36V
        l/8rLnuB8cPUi1gh5iBfLw1SZmYX145yaGAgFExUR24a67HEtftfnXQf/RpHvneV7ZWSE=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:60047)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fg5kM-0004xq-Om; Thu, 19 Jul 2018 11:01:18 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fg5kH-0000lS-V3; Thu, 19 Jul 2018 11:01:14 +0100
Date:   Thu, 19 Jul 2018 11:01:10 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: arm: v4.18-rc5 with cpuidle on TC2 (A7 boot) spectre v2 issue
Message-ID: <20180719100109.GH17271@n2100.armlinux.org.uk>
References: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2abc6c11-2e8c-a4ea-6911-0f495d90ace6@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:42:50AM +0200, Dietmar Eggemann wrote:
> Hi,
> 
> running v4.18-rc5 (plus still missing "power: vexpress: fix corruption in
> notifier registration", otherwise I get this rcu_sched stall issue) on TC2
> (A7 boot) with vanilla multi_v7_defconfig plus
> CONFIG_ARM_BIG_LITTLE_CPUIDLE=y gives me continuous:
> 
> ...
>  CPUX: Spectre v2: incorrect context switching function, system vulnerable
> ...
> 
> messages.
> 
> Work around is to disable CONFIG_HARDEN_BRANCH_PREDICTOR.

or disable big.Little if you want the hardening.

The choices are currently either protection against Spectre or big.Little
support since the two are mutually exclusive at the moment.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
