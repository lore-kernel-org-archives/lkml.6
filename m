Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05553C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFAE21722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFAE21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeHTTJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:09:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:38244 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeHTTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:09:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 08:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,265,1531810800"; 
   d="scan'208";a="74240249"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2018 08:53:09 -0700
Received: from tjmaciei-mobl1.localnet (10.254.69.69) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 08:53:05 -0700
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: libtracevent build warnings on Clear Linux (gcc 8.2.0)
Date:   Mon, 20 Aug 2018 08:53:05 -0700
Message-ID: <1800559.mKxvYeAo7o@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <20180820133943.GB21100@kernel.org>
References: <20180820133943.GB21100@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.254.69.69]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 August 2018 06:39:43 PDT Arnaldo Carvalho de Melo wrote:
> Hi guys,

Hello

> Makefile.config:318: No libelf found. Disables 'probe' tool, jvmti and BPF
> support in 'perf record'. Please install libelf-dev, libelf-devel or
> elfutils-libelf-devel

You may want to install the user-basic-dev bundle.

> Makefile.config:518: Disabling post unwind, no support found.

Also present in user-basic-dev.

> Makefile.config:598: slang not found, disables TUI support. Please install
> slang-devel, libslang-dev or libslang2-dev

Ditto.

> Makefile.config:612: GTK2 not found, disables GTK2 support. Please install
> gtk2-devel or libgtk2.0-dev

This one is in desktop-dev. We don't have that enabled in our own build of 
perf, though.

> Makefile.config:666: No python interpreter was found: disables Python
> support - please install python-devel/python-dev

user-basic-dev too. We're almost rid of Python 2, do you need it?

> Makefile.config:750: No liblzma found, disables xz kernel module
> decompression, please install xz-devel/liblzma-dev

Assuming xz is sufficient for this, user-basic-dev.

> Makefile.config:814: No libbabeltrace found, disables 'perf data' CTF format
> support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev

user-basic-dev too.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel Open Source Technology Center



