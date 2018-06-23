Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDEC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A9524A23
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 00:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyLi1dw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A9524A23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934387AbeFWAAQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 20:00:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeFWAAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 20:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q4RjFe4BYqo5N96EDU8QPGoAdJwwvPe+Dw/7HYhM5LE=; b=KyLi1dw8z41O26D13bsuKUyum
        StQfr2V6NVfDVdl5e9SBf3Kuj0g6aI9iGjZLCXCVYrQG1rMCi7xfhY70XUshZ3So0bw8ojYzA2THy
        DW+6iK/AveLgFGj7VrzvDvmmYd4aGsFZVg5YTUZl+JPjCCc6SujOwn1BHd82qoYxsKZmoesUhklbZ
        srOea+9sOV3zw7PUR/jkXTEl4MDMomf4ceSEYqnqvxoNyGaZJv2/W5ximcY4/dEC3m2Y2+3VMDeZg
        /PO5eZfHmO9G3+uxjowVRRGukAOkV3QeIA0zmltkly9YQs/E2yznI3UmNxzphGKHAMpymFiDhbAFX
        7bgsDlYdg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWVyN-0008Cx-T5; Sat, 23 Jun 2018 00:00:11 +0000
Date:   Fri, 22 Jun 2018 17:00:10 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Ike Panhc <ike.pan@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Apply no_hw_rfkill to
 Y20-15IKBM, too
Message-ID: <20180623000010.GF27466@fury>
References: <20180622085917.22969-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622085917.22969-1-tiwai@suse.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 10:59:17AM +0200, Takashi Iwai wrote:
> The commit 5d9f40b56630 ("platform/x86: ideapad-laptop: Add
> Y520-15IKBN to no_hw_rfkill") added the entry for Y20-15IKBN, and it
> turned out that another variant, Y20-15IKBM, also requires the
> no_hw_rfkill.
> 
> Trim the last letter from the string so that it matches to both
> Y20-15IKBN and Y20-15IKBM models.
> 
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1098626
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks Takashi, queued.

-- 
Darren Hart
VMware Open Source Technology Center
