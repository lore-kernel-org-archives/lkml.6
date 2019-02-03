Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3938C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71721773
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549178446;
	bh=NYk2/w8NFc9KntzXwgaJ6rZ+QHz1zwAqsPOMK/U+nh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yhCubSefL/TbtI0+j4gA2mlcRFcOpbCr2TtBTSpp3+627MAZ4Sc/N+A8D6jXk1W8w
	 Krez5HhqQ0FDtC/gusfP+C+qjlpgdLufGhxjGDbFyFcbbbBpLTNBAM91BVre/kl1T7
	 XPjsFezWIYhYO7Yd3iMsSCi+pBBiBQIk6ksdmswA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfBCHUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:20:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfBCHUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:20:45 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C862084A;
        Sun,  3 Feb 2019 07:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549178444;
        bh=NYk2/w8NFc9KntzXwgaJ6rZ+QHz1zwAqsPOMK/U+nh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Agl1cztn/tmrzq3sqtj2ubBhY3kV/makjWyJbx+wTSOVi5dlghpA+2UVDVekb1Izj
         b4hmz6s7d74o4voLbQPspManJWBDXZ9nCIINusLqW+fCFsg0LyHuMo+yrRMf/VbVu+
         h1gb+d5nRyl4v72pE9zsfucvXkhrvNNawkFqeAgc=
Date:   Sun, 3 Feb 2019 08:20:32 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Ingenic JZ4780 NAND patchset v2
Message-ID: <20190203082032.6e37c523@bbrezillon>
In-Reply-To: <20190202231926.2444-1-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Feb 2019 20:19:17 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
> 
> As requested by Boris, I added a patch to move all the Ingenic NAND
> drivers to their own directory.
> 
> In this V2 I added support for the JZ4740 SoC. The combo of the
> jz4780-nemc, jz4780-nand and jz4740-bch now obsolete the old and dusty
> jz4740-nand driver.

Any plan to get the old driver removed? I guess you want to migrate the
boards to DT first.

> 
> To support the only upstream JZ4740-based board we have, the Ben
> Nanonote, I added an option to specify the OOB layout of that device
> from a device property string.
> 
> Finally, I dropped the last two patches that moved the platform NAND
> code to devicetree; I will upstream them as part of a different
> patchset.
> 
> Cheers,
> -Paul
> 

