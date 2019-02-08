Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B7C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBCE20821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549651824;
	bh=BTc2u7SxFnsagENWJ8nMiwJNbm9NmWyPVwwWXaKU5bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kkdWVGv2gdW+hWcDHWehk/u1yYn2hPoRXdUGPMAd87pVO53stquxXxFBXs2303456
	 39O/qFd4t35C6dZSgaI0CkhmZndc5Ftq0onAZBf5Z2Vnr13DRwqrJYro4Rw8BOYeVN
	 nh3ItQXMvefhzPW9nyTznTUqvc1DGAIfm2oYEnHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBHSuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfBHSuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:50:22 -0500
Received: from localhost (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128892081B;
        Fri,  8 Feb 2019 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549651822;
        bh=BTc2u7SxFnsagENWJ8nMiwJNbm9NmWyPVwwWXaKU5bM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PRgZ2pUtzDANZi64oI6zGUUZSXFZ3nGjaXxv5D8UBlBhFNis95xf0Rh8fbDlSRdLx
         IMWLvHRDX8WxWSiGYZjNqRicXF6lYdb7hYTtI1DXsEq/WAYNWG225ELQSuHEOFa2bi
         2WubGBpgMxLDDiH0KGTOUlOuKkBeFnysPwEv++jA=
Date:   Fri, 8 Feb 2019 19:50:15 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation
 HWCPAS
Message-ID: <20190208195015.16087f59@kernel.org>
In-Reply-To: <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
        <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
        <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <20190208184718.3c488d0d@kernel.org>
        <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 18:43:26 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:

> Hi,Boris 
> I sent three times, seems last time is successful. would you check that is correct?

That's much better now, thanks!
