Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F7EC43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C12D213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jSk9lX0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C12D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390634AbeGKWDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:03:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46178 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732823AbeGKWDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bhkLhC7GECmVvKfcMME+58UGBptaFYX+s48LJu1JnDI=; b=jSk9lX0UElZJ9hDmIpPW7loRY
        3RmXWqmFXd5V9xrpdVcqnGwE/BWa54kU0uTEkBkfLuQTb+eH9k6anrIFauevtiE3G6nsiyfm5Bzco
        gZ0sJtrJ4ZjbD4wsTZFTKFH/EmxYSoxRx7WZ7HeczT3+uVPQV3vk+rjY0MpEgbFjIgox8=;
Received: from flint.armlinux.org.uk ([2001:4d48:ad52:3201:201:2ff:fe14:8fad]:42316)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1fdN6R-0003Hq-8X; Wed, 11 Jul 2018 22:56:51 +0100
Received: from rmk by flint.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <rmk@flint.armlinux.org.uk>)
        id 1fdN6N-0004vE-1Q; Wed, 11 Jul 2018 22:56:47 +0100
Date:   Wed, 11 Jul 2018 22:56:44 +0100
From:   Russell King <rmk@armlinux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm-current
 tree
Message-ID: <20180711215644.GA18831@flint.armlinux.org.uk>
References: <20180712073803.7bfbbf1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712073803.7bfbbf1a@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 07:38:03AM +1000, Stephen Rothwell wrote:
> Hi Russell,
> 
> Commit
> 
>   6ef09e48c2bc ("ARM: 8780/1: ftrace: Only set kernel memory back to read-only after boot")
> 
> is missing a Signed-off-by from its author.

Thanks for spotting, but it's worse than that.  It does have a sign-off
from its author, but the authorship wasn't preserved by Stefan Agner
(no From: line in the email body, as there was in Steven's original
post to the mailing list.)  I'll fix that in the next few days.

-- 
Russell King
ARM architecture Linux Kernel maintainer
