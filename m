Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3574DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9832082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9832082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeKCCr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:47:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:10317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbeKCCr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:47:57 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 10:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="277858421"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2018 10:40:00 -0700
Date:   Fri, 2 Nov 2018 10:39:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: skx_edac: add ACPI dependency
Message-ID: <20181102173959.GA27709@agluck-desk>
References: <20181102153232.1450251-1-arnd@arndb.de>
 <20181102161013.GG14602@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102161013.GG14602@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:10:13PM +0100, Borislav Petkov wrote:
> On Fri, Nov 02, 2018 at 04:32:06PM +0100, Arnd Bergmann wrote:
> > We cannot currently select ACPI_ADXL without also enabling the top-level
> > ACPI option:
> > 
> > WARNING: unmet direct dependencies detected for ACPI_ADXL
> >   Depends on [n]: ACPI [=n]
> >   Selected by [y]:
> >   - EDAC_SKX [=y] && EDAC [=y] && PCI [=y] && X86_64 [=y] && X86_MCE_INTEL [=y] && PCI_MMCONFIG [=y] && (ACPI_NFIT [=n] || !ACPI_NFIT [=n])
> 
> That should fix the issue too:
> 
> https://marc.info/?l=linux-acpi&m=154102117706500&w=2

I have to say that Arnd's fix is prettier. With it, we can go back
to

	select ACPI_ADXL

instead of

	select ACPI_ADXL if ACPI

-Tony
