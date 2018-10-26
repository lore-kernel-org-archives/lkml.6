Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28052C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D314120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="emXd9Rx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D314120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mork.no
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeJZRit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:38:49 -0400
Received: from canardo.mork.no ([148.122.252.1]:34947 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeJZRit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:38:49 -0400
Received: from miraculix.mork.no ([IPv6:2a02:2121:281:75f0:c8fa:53ff:fe7c:53d8])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id w9Q92TZi028067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 11:02:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1540544550; bh=7Z7xn0ocEEjSYuc4MEyVNHPJabjKED6DGoLleKmzC5g=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=emXd9Rx8LLzsvEv62BtoQU496Ajb775gsUoWpENsY4791FVBFARvyJMtIFAzXOz5+
         m3qi0TAldaHxaaG/KbVH/ggdowZxffluchbtrpLxRJWdI9Mba3USQDGF0CPS+CC3pC
         B/Do25jjudx31bBAH1rx8ttw9XECESO0CrMP7RhE=
Received: from bjorn by miraculix.mork.no with local (Exim 4.89)
        (envelope-from <bjorn@mork.no>)
        id 1gFy0e-0008Ns-Q8; Fri, 26 Oct 2018 11:02:24 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 3.18 04/98] USB: qcserial: Fix support for HP lt4112 LTE/HSPA+ Gobi 4G Modem
Organization: m
References: <20181025141853.214051-1-sashal@kernel.org>
        <20181025141853.214051-4-sashal@kernel.org>
        <20181026084920.GB27852@localhost>
Date:   Fri, 26 Oct 2018 11:02:24 +0200
In-Reply-To: <20181026084920.GB27852@localhost> (Johan Hovold's message of
        "Fri, 26 Oct 2018 10:49:20 +0200")
Message-ID: <87ftwt5bdr.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.100.2 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> writes:

> Note that the stable tag above lacks a version comment (e.g. "# 4.19"),
> but I can see how that may be too subtle to convey this (and not all
> maintainers use those). Perhaps an explicit comment should just be added
> in such cases.

I have always thought that the inclusion of a "Fixes" tag made such
comments redundant. A simple "git tag --contains .." returns the same
info, and is more likely to be correct...

Or am I missing something?

I see the problem with matching up fixes to backported commits, but I've
assumed the stable maintainers all keep a small "database" of backported
commits to make such tasks easier.  That's what I would have done, and
they are much smarter than me ;-)



Bj=C3=B8rn
