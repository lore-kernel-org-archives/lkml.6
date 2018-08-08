Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5106DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3B21A53
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 20:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B3B21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeHHWjd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 18:39:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:39692 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729661AbeHHWjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 18:39:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 13:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,212,1531810800"; 
   d="scan'208";a="63392730"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2018 13:18:04 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.46]) with mapi id 14.03.0319.002;
 Wed, 8 Aug 2018 13:18:04 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: RE: sb_edac.c lacks PCI domain support?
Thread-Topic: sb_edac.c lacks PCI domain support?
Thread-Index: AQHUL1ODF6l17RqHC0aF62snEjUNaqS2SKvQ
Date:   Wed, 8 Aug 2018 20:18:03 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D3A370D@ORSMSX110.amr.corp.intel.com>
References: <20180808200747.GA219159@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180808200747.GA219159@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzI5Y2Y2ZTgtZjc3Mi00ZTM0LWFkNzYtMGE0OTdkY2M2YmJlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVUJcL2V1aHczdVhyOUJkZm93T1pUejdNZVdlYzRZbWJWSUVtVFByT1BPYmFKT2J0RzRUV3NuRGhVS00zN0M1RW4ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think sb_edac.c (and probably other EDAC stuff) lacks PCI domain
> support

There's a patch queued to fix this.

  https://marc.info/?l=linux-edac&m=153256485215534&w=2


> It looks like 88ae80aa609c ("EDAC, skx_edac: Handle systems with
> segmented PCI busses") fixes a similar problem; maybe that should
> be applied elsewhere in EDAC as well?
>
> Why doesn't EDAC use the standard pci_register_driver() interface?
> That would avoid issues like this.  It would also avoid the potential
> conflict of another driver operating on the device at the same time.

EDAC drivers get information to translate system physical addresses
to DIMM addresses from a whole bundle of different PCIe devices config
space.  Connections between different parts of the translation algorithm
depend on finding the devices that belong to the same memory controller
by matching up bus numbers (actually <segment,busnumber> tuples as
we are now finding).

Can pci_register_driver() cope with this odd usage?

-Tony
