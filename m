Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F29C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DEB24A35
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DEB24A35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965297AbeGBKSu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:18:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:52421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753807AbeGBKSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:18:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 03:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="242298111"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 02 Jul 2018 03:18:43 -0700
Message-ID: <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 02 Jul 2018 13:18:42 +0300
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 

There are several serial IPs that have fractional divider built-in. None
is using any specific hooks. Why do you need in your case, esp. taking
into consideration that we have a custom ->set_termios() callback?

> patch1 introduces necessary hooks to 8250 core.
> patch2 implement the fractional divisor support for Synopsys DW 8250.
> 
> Jisheng Zhang (2):
>   serial: 8250: introduce get_divisor() and set_divisor() hook
>   serial: 8250_dw: add fractional divisor support
> 
>  drivers/tty/serial/8250/8250_core.c |  4 +++
>  drivers/tty/serial/8250/8250_dw.c   | 54
> +++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |  8 +++++
>  include/linux/serial_8250.h         |  7 ++++
>  4 files changed, 73 insertions(+)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
