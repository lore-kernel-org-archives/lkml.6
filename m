Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3065C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C9D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C9D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeJXDFy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:05:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:5922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:05:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="97906363"
Received: from irsmsx108.ger.corp.intel.com ([163.33.3.3])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2018 11:41:18 -0700
Received: from irsmsx106.ger.corp.intel.com ([169.254.8.45]) by
 IRSMSX108.ger.corp.intel.com ([169.254.11.187]) with mapi id 14.03.0319.002;
 Tue, 23 Oct 2018 19:41:18 +0100
From:   "Hunter, Adrian" <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Thread-Topic: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Thread-Index: AQHUaqaeWJRZYosv3UW89nQIvhP4TKUtEc0AgAATeyA=
Date:   Tue, 23 Oct 2018 18:41:17 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
 <20181023181218.GB6114@kernel.org>
In-Reply-To: <20181023181218.GB6114@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTBhNWI1OTAtYjk0ZC00ZjgyLWFlODgtYzI0NzA0YThkZDI2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWWVCZGxGMlFRVFVxMGRWV2s2U3ZPQnZ0UVhjdVE5WVQrbnNcL1dzR2dqRmxYRm91WkE5bHpFWXJoWG1nc21FUUYifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> Sent: Tuesday, October 23, 2018 9:12 PM
> To: Hunter, Adrian <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
> Add All branches report
> 
> Em Tue, Oct 23, 2018 at 10:59:49AM +0300, Adrian Hunter escreveu:
> > Add a report to display branches in a similar fashion to perf script.
> > The main purpose of this report is to display disassembly, however,
> > presently, the only supported disassembler is Intel XED, and
> > additionally the object code must be present in perf build ID cache.
> >
> > To use Intel XED, libxed.so must be present. To build and install
> > libxed.so:
> > 	git clone https://github.com/intelxed/mbuild.git mbuild
> > 	git clone https://github.com/intelxed/xed
> > 	cd xed
> > 	./mfile.py --share
> > 	sudo ./mfile.py --prefix=/usr/local install
> > 	sudo ldconfig
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >
> >
> > Changes in V2:
> >
> > 	Fix branch report not appearing for kernel-only or user-only tracing:
> > 	Find branch events named like "branches:k" or "branches:u" as well
> as
> > 	just plain "branches", by splitting the name at the colon. i.e.
> > 	event = event.split(":")[0]
> 
> So, I followed the instructions then ended up with:
> 
> [acme@seventh perf]$ find /usr/local -name "*xed*" | head
> /usr/local/lib/libxed.so /usr/local/lib/libxed.a /usr/local/lib/libxed-ild.so
> /usr/local/lib/libxed-ild.a /usr/local/include/xed /usr/local/include/xed/xed-
> syntax-enum.h
> /usr/local/include/xed/xed-attributes.h
> /usr/local/include/xed/xed-build-defines.h
> /usr/local/include/xed/xed-cpuid-rec.h
> /usr/local/include/xed/xed-flags.h
> [acme@seventh perf]$
> 
> Ran ldconfig as root, etc:
> 
> [acme@seventh perf]$ ldconfig -v -N | grep xed
> ldconfig: Can't stat /libx32: No such file or directory
> ldconfig: Path `/usr/lib' given more than once
> ldconfig: Path `/usr/lib64' given more than once
> ldconfig: Can't stat /usr/libx32: No such file or directory [acme@seventh
> perf]$
> 
> [acme@seventh perf]$ file /usr/local/lib/libxed.so
> /usr/local/lib/libxed.so: ELF 64-bit LSB shared object, x86-64, version 1
> (SYSV), dynamically linked,
> BuildID[sha1]=09cf45310a731f727b4575582a638052b8f3e3bb, not stripped
> [acme@seventh perf]$ file /usr/local/lib/libxed-ild.so
> /usr/local/lib/libxed-ild.so: ELF 64-bit LSB shared object, x86-64, version 1
> (SYSV), dynamically linked,
> BuildID[sha1]=a5601603e305bb7b7f8edc7da0e78acbc9b63eba, not stripped
> [acme@seventh perf]$
> 
> Tried with:
> 
> export LD_LIBRARY_PATH=/usr/local/lib/
> 
> But so far couldn't get it to show the disassembly.
> 
> The "All Branches" is there, wasn't in v1 of this patch.
> 
> Ideas?

The "All Branches" report is a 2-level tree, and the disassembly displays when the next level of the tree is opened
i.e. click the arrow at the start of the line.

Have you tried both kernel and user space?

The script looks for dsos in the build id cache.  The dsos can be viewed by selecting dsos_view from the Tables menu,
so you could check if that information looks right.

Also the script has a variable "have_disassembler", so you could hack the script to print that to find out if XED is working.


