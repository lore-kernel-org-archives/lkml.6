Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15253ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56562085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56562085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeJ0HhQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:37:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:30275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbeJ0HhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:37:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 15:58:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="275976854"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2018 15:58:21 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.20]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.14]) with mapi id 14.03.0319.002;
 Fri, 26 Oct 2018 15:58:20 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Firoz Khan <firoz.khan@linaro.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: RE: [PATCH v4 0/5] ia64: system call table generation support
Thread-Topic: [PATCH v4 0/5] ia64: system call table generation support
Thread-Index: AQHUbOpkghKucEByO0a+Z5GnhAF2tKUyJC4w
Date:   Fri, 26 Oct 2018 22:58:20 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D42C7D2@ORSMSX110.amr.corp.intel.com>
References: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDlmMmQxZjYtYmJmOC00ZjlmLWI0YzEtYzFiZGYzYmJkODM0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic0JqQUFETWJDdEtiWDJrbWQrbFwvdE8wNXNSYmNlOWN3VjBRWTRjZU54eHJFNnc0bjNiVU9BT0hHQkpZNUdWTXIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Finally, this is the ground work to solve the Y2038 issue. We need 
> to add two dozen of system calls to solve Y2038 issue. So this patch
> series will help to add new system calls easily by adding new entry 
> in the syscall.tbl.

You have great optimism that anyone will care about ia64 in 2038 :-)

Patches look good now.  If I don't see any comments in the next few
days I'll queue them for next merge window.

Thanks

-Tony
