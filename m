Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE5AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89257206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="TsRlzgCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfBENP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:15:58 -0500
Received: from chill.innovation.ch ([216.218.245.220]:56762 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBENP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:15:58 -0500
Date:   Tue, 5 Feb 2019 05:15:57 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch CBC80640109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1549372557;
        bh=D+PVRtGJTWAzwNlvwg7309FOsRlPjkg0LaBYKfvrLgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsRlzgCFr+AapdZD55bpPKWsXTCzuYNYavYC0yzQ5xQXcMz3zY0jlQIzClADEsUO9
         jLTzkcCbHbRwaXq+fQiFIAlgedudg908B8Q5OnSUey6NT/k9IGXCR7N+fsikFiIb6V
         WwW/yqpVL4dA28mmuLcsQCUJvzxsBBHqhwwNJ3Y4jv4fZPB6VUWxCZ8pCwk0F289HZ
         CRoMzm95RviqxDoOPGXZVnQHe1flw2dMzg3dKm8EVOxl0FpHjXmhepWaTX6FdYDhVx
         OzYRbSNb7Wcd3onxVRqo99/Nu3HP19oz+ySWbQjaGWNCcn0Gz19ZB+je79aydXmWTY
         lMb4Koi84D63A==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190205131557.GB4225@innovation.ch>
References: <20190204081947.25152-3-ronald@innovation.ch>
 <20190205102110.GG2581@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190205102110.GG2581@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Dan,

On Tue, Feb 05, 2019 at 01:21:10PM +0300, Dan Carpenter wrote:
> Hi Ronald,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Ronald-Tschal-r/drm-bridge-sil_sii8620-depend-on-INPUT-instead-of-selecting-it/20190205-003319
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> 
> smatch warnings:
> drivers/input/keyboard/applespi.c:1551 applespi_get_saved_bl_level() warn: returning -1 instead of -ENOMEM is sloppy
[snip]
> cfa9f3705 Ronald Tschalär 2019-02-04  1549  	efivar_entry = kmalloc(sizeof(*efivar_entry), GFP_KERNEL);
> cfa9f3705 Ronald Tschalär 2019-02-04  1550  	if (!efivar_entry)
> cfa9f3705 Ronald Tschalär 2019-02-04 @1551  		return -1;

Agreed, that is sloppy. Fixed in for next version. Thanks!


  Cheers,

  Ronald

