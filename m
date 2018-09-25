Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FDB2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="GF5zqXXt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FDB2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeIYN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:57:23 -0400
Received: from 8bytes.org ([81.169.241.247]:60654 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbeIYN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:57:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 63519760; Tue, 25 Sep 2018 09:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1537861864; bh=NZEvsAeuP11md5AnRWAyYD6mYnhVrAUh5JP982D0f9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GF5zqXXtqE+1J/rpAbQzPleeAaeOdqX3rAt5lSW2waqBQiUWyx6/3bTwftoCGEPQf
         knxUfgwUcKYQ+l/auIuZxyEOrpTpMUW9uFSHr8keQdyxA2ZFbfpY8OOFyIuP9vuAXV
         sTva8dmIxcXga0J5esfpOCjM1+OyAK8dzauNRsXbx+zifX50PiRHMvoGIRwjJN3y0t
         ofqSapiOT8BkqCKIpYkW8hurhxLWvlM4LazzelZ4nU0uDjfGeBG42SvAYbECLHmROT
         i4erCprgEJfutUY7/yA2DcjFstA7C1Qs1A/hpqauyAIOLFlXQpGjfVBDxmjBuAAQHk
         qsAc+sG9gIhZA==
Date:   Tue, 25 Sep 2018 09:51:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     gary.hook@amd.com, Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Message-ID: <20180925075104.GA18287@8bytes.org>
References: <152883965482.1936.13657625103232933481.stgit@taos>
 <152883969032.1936.15155267369758178246.stgit@taos>
 <CAMuHMdVf-QDAVh-vHF_xyvX73_nsO9X7RnDc=yCK_FS68i6zTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVf-QDAVh-vHF_xyvX73_nsO9X7RnDc=yCK_FS68i6zTw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:56:50AM +0200, Geert Uytterhoeven wrote:
> If it is that bad, shouldn't this option be protected by some Kconfig
> trickery to avoid it being enabled in allmodconfig/allyesconfig builds?

It is fine to have it in allmodconfig/allyesconfig, I just don't want
any distro-kernel enable it so that these internals become a user-space
ABI or leak security sensitive data on everyones system. This is
intended to be a pure debugging feature for development.


Regards,

	Joerg
