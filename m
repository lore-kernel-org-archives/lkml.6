Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163360AbeCAXkf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:40:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:2935 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163211AbeCAXkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:40:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="31774823"
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@suse.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] x86/mce: Save microcode revision in machine check
 records
Thread-Topic: [PATCH] x86/mce: Save microcode revision in machine check
 records
Thread-Index: AQHTsbXtzcRyDWfzp0yxyUIRnj/IiaO8CT2g
Date: Thu, 1 Mar 2018 23:40:31 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B388EF7@ORSMSX110.amr.corp.intel.com>
References: <20180301233449.24311-1-tony.luck@intel.com>
In-Reply-To: <20180301233449.24311-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTAyNDEwYWMtYTNlMC00NjMzLTlkODgtMDE2NzUzYjZkZmM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJaMlhmXC9lQ3ZYcGxGaisxOVFUNUFNQkEzYm9KS0I2MWJENldndXlPcnZ0dHY4OFQxSzg4Q1FNU0cyQUJQUG5tTyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+	c = &cpu_data(m->cpu);

Bother. Breaks on systems with >255 cpus because "cpu" is __u8.

s/m->cpu/m->extcpu/

-Tony
