Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D48C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5222188D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5222188D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeHQTA3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:00:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:56007 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbeHQTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Aug 2018 08:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,251,1531810800"; 
   d="scan'208";a="81151546"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2018 08:56:24 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 17 Aug 2018 08:56:24 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.41]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.164]) with mapi id 14.03.0319.002;
 Fri, 17 Aug 2018 08:56:23 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "jchandra@broadcom.com" <jchandra@broadcom.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Subject: RE: how to fix acpi_pci_root_remap_iospace?
Thread-Topic: how to fix acpi_pci_root_remap_iospace?
Thread-Index: AdQ1ogY0Ns2AKmc+RseoCIXE9twQpAAPjfSA//+wrwCAARIPAIAAAlCAgAABJfA=
Date:   Fri, 17 Aug 2018 15:56:23 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D3B3159@ORSMSX110.amr.corp.intel.com>
References: <20180816204506.GA21144@agluck-desk>
        <CAK8P3a2vAMzL22ds=kM1WRZgATzOrAz_y8Yk6edqJTVRJJFydw@mail.gmail.com>
        <20180816232639.GA25889@agluck-desk>
        <CAK8P3a0hFDv2kvVN=QobTVaZxAX-M+YZzkBU_b=vDGLbCLziNg@mail.gmail.com>
 <20180817105551.100d6e0a@bbrezillon>
In-Reply-To: <20180817105551.100d6e0a@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTE1NmQ0ZmQtN2Q4Yi00ZmM4LTg4ZGQtZGE4MDBlNGM1N2E0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUjhCZXFtNjg3aE03dzZVVUV3V05obzVyeXlrSGZEblJxbkJkNGJCY1dMQ3Iwc09wc21FMm15MGp2UXRhZk96ciJ9
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

>> - Some targets don't have any support for I/O space on their PCI bus and just
>>    want to get things to compile by setting PCI_IOBASE to zero, this still opens
>>     up some of the same problems as above, but doesn't really help otherwise.

That sounds horrible. Why would you want to have a driver that can't possibly
work on your platform compile cleanly? That's just asking for trouble. Sombody
might load that driver, and ... all the outb/outw/outl calls just corrupt low memory.

> Hm, maybe it's just easier to revert the patch since we got rid of
> patches adding COMPILE_TEST to drivers which were using read/writesl()
> (it turned out ia64 and sparc were not the only archs to not implement
> readsx/writesx() variants, and fixing them is not that easy).

That sounds like a better course of action.

-Tony
