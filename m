Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73954ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E5208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377E5208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeGMKVF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:21:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:63220 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeGMKVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 03:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="64424440"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2018 03:07:02 -0700
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.225]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.124]) with mapi id 14.03.0319.002;
 Fri, 13 Jul 2018 11:06:39 +0100
From:   "Metzger, Markus T" <markus.t.metzger@intel.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [bug] kpti, perf_event, bts: sporadic truncated trace
Thread-Topic: [bug] kpti, perf_event, bts: sporadic truncated trace
Thread-Index: AdQZxQrLJqR+Gl12Q6mi7nedU16ktAAeoDuAABQtLrA=
Date:   Fri, 13 Jul 2018 10:06:38 +0000
Message-ID: <A78C989F6D9628469189715575E55B236B3308EE@IRSMSX104.ger.corp.intel.com>
References: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com>
 <alpine.LSU.2.11.1807121743050.5425@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1807121743050.5425@eggly.anvils>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOGM5YmZkZTQtN2RlOS00NzhkLThmNjMtNTEzMjFkNTI1ZDcwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmVGZTBcL3RqR0l5YThnZnpmTDlWaDdYaE1MRzNrWmVjUkJMa3c2TGZ1Q2MxWTV5OG1JcE5Oc2lTK3d6R1oxN3oifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hugh,

> A little "optimization" crept into alloc_bts_buffer() along the way, which now
> places bts_interrupt_threshold not on a record boundary.
> And Stephane has shown me the sentence in Vol 3B, 17.4.9, which says "This
> address must point to an offset from the BTS buffer base that is a multiple of the
> BTS record size."
> 
> Please give the patch below a try, and let us know if it helps (if it does not, then I
> think we'll need perfier expertise than I can give).
> 
> Hugh
> 
> --- 4.18-rc4/arch/x86/events/intel/ds.c	2018-06-03 14:15:21.000000000 -0700
> +++ linux/arch/x86/events/intel/ds.c	2018-07-12 17:38:28.471378616 -0700
> @@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
>  	ds->bts_buffer_base = (unsigned long) cea;
>  	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
>  	ds->bts_index = ds->bts_buffer_base;
> -	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
> -	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
> -	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
> +	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
> +	ds->bts_absolute_maximum = ds->bts_buffer_base +
> +					max * BTS_RECORD_SIZE;
> +	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
> +					(max / 16) * BTS_RECORD_SIZE;
>  	return 0;
>  }
> 

Your patch fixes it.

Will you send it to the list for inclusion?  I'd appreciate if it could also be backported
to 4.15, 4.16, and 4.17.

Thanks,
Markus.

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

