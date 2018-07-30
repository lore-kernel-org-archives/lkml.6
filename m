Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B4BC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBFE208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PiEx1+i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BBFE208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeGaAhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:37:19 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41568 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730983AbeGaAhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NAaF4WPJu8rWInIdetYTuraNJevDc/hKTOdQbZCr8E8=; b=PiEx1+i1EHuOKd0roppo38AQ3
        sD0eeJ5F71bTLmL4X9DXHGnzB9qqPy/OaYn9SjwyuXFOG53vNAlpc6pJiEqtNhb0ZYc8uyaKxTsMr
        WvofwvaaeXn017Hz+ihKNEK/KTS5JVC2SvV2AozNtQgBEVveZhUYTa9mMFVW+DJVRFzgw=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:33316)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkH8Q-0002pm-6e; Mon, 30 Jul 2018 23:59:26 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkH8N-0005Gk-GO; Mon, 30 Jul 2018 23:59:23 +0100
Date:   Mon, 30 Jul 2018 23:59:22 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
Message-ID: <20180730225921.GE17271@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I only have this message, and patches 5 and 6.  This is meaningless
for me to review - I can't tell what you've done as far as my comments
on your previous iteration.

Please arrange to _at least_ copy all patches the appropriate mailing
lists for the set with your complete patch set if you aren't going to
copy everyone on all patches in the set.

On Mon, Jul 30, 2018 at 06:50:28PM -0400, Alexei Colin wrote:
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.

... which means, as it stands, I've no idea what you actually came up
with for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
