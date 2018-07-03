Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4342D24513
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4342D24513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753407AbeGCNDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:03:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:50184 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753272AbeGCNDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:03:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 06:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,303,1526367600"; 
   d="scan'208";a="51685078"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2018 06:03:41 -0700
Message-ID: <c9bf4c643f51ab222dbc0221acc47773ee3d1a9a.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Jul 2018 16:03:40 +0300
In-Reply-To: <20180703104816.031abbfc@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
         <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
         <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
         <20180703102257.678db6a8@xhacker.debian>
         <20180703104816.031abbfc@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 10:48 +0800, Jisheng Zhang wrote:
> On Tue, 3 Jul 2018 10:22:57 +0800 Jisheng Zhang wrote:

> patching struct uart_port seems a bit overhead. After reading the code
> again, I propose another solution, similar as what dl_write() is used
> in
> 8250 core:
> 
> 1.introduce the hook to struct uart_8250_port as my previous patches
> do, 
> 
> 2.rename current serial8250_set_divisor() as
> default_serial_get_divisor()
> then introduce a new serial8250_set_divisor() as:
> static inline void serial8250_set_divisor(struct uart_8250_port
> *up,....)
> {
> 	up->set_divisor();
> }
> 
> and point up->set-divisor to default_serial_get_divisor
> 
> what do you think about this solution?

Disagree. See my previous answer for details.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
