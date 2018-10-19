Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A377FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0702087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0702087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeJTBek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:34:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:27217
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727549AbeJTBek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:34:40 -0400
X-IronPort-AV: E=Sophos;i="5.54,400,1534802400"; 
   d="scan'208";a="282734461"
Received: from unknown (HELO hadrien) ([132.227.125.15])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 19:27:35 +0200
Date:   Fri, 19 Oct 2018 19:27:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Paul Walmsley <paul.walmsley@sifive.com>
cc:     linux-serial@vger.kernel.org, kbuild-all@01.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART (fwd)
Message-ID: <alpine.DEB.2.21.1810191926360.5513@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It looks like an unlock is needed before the return on line 562.

julia

---------- Forwarded message ----------
Date: Fri, 19 Oct 2018 18:12:04 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART

CC: kbuild-all@01.org
In-Reply-To: <20181018234352.26788-3-paul.walmsley@sifive.com>
References: <20181018234352.26788-3-paul.walmsley@sifive.com>
TO: Paul Walmsley <paul.walmsley@sifive.com>
CC: linux-serial@vger.kernel.org
CC: Paul Walmsley <paul.walmsley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi Paul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on v4.19-rc8 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Walmsley/dt-bindings-serial-add-documentation-for-the-SiFive-UART-driver/20181019-165529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
:::::: branch date: 77 minutes ago
:::::: commit date: 77 minutes ago

>> drivers/tty/serial/sifive.c:562:2-8: preceding lock on line 558

# https://github.com/0day-ci/linux/commit/15d0af7ab79ba53f984613f23e668cade495babb
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 15d0af7ab79ba53f984613f23e668cade495babb
vim +562 drivers/tty/serial/sifive.c

15d0af7a Paul Walmsley 2018-10-18  552
15d0af7a Paul Walmsley 2018-10-18  553  static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
15d0af7a Paul Walmsley 2018-10-18  554  {
15d0af7a Paul Walmsley 2018-10-18  555  	struct sifive_serial_port *ssp = dev_id;
15d0af7a Paul Walmsley 2018-10-18  556  	u32 ip;
15d0af7a Paul Walmsley 2018-10-18  557
15d0af7a Paul Walmsley 2018-10-18 @558  	spin_lock(&ssp->port.lock);
15d0af7a Paul Walmsley 2018-10-18  559
15d0af7a Paul Walmsley 2018-10-18  560  	ip = __ssp_readl(ssp, SIFIVE_SERIAL_IP_OFFS);
15d0af7a Paul Walmsley 2018-10-18  561  	if (!ip)
15d0af7a Paul Walmsley 2018-10-18 @562  		return IRQ_NONE;
15d0af7a Paul Walmsley 2018-10-18  563
15d0af7a Paul Walmsley 2018-10-18  564  	if (ip & SIFIVE_SERIAL_IP_RXWM_MASK)
15d0af7a Paul Walmsley 2018-10-18  565  		__ssp_receive_chars(ssp);
15d0af7a Paul Walmsley 2018-10-18  566  	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
15d0af7a Paul Walmsley 2018-10-18  567  		__ssp_transmit_chars(ssp);
15d0af7a Paul Walmsley 2018-10-18  568
15d0af7a Paul Walmsley 2018-10-18  569  	spin_unlock(&ssp->port.lock);
15d0af7a Paul Walmsley 2018-10-18  570
15d0af7a Paul Walmsley 2018-10-18  571  	return IRQ_HANDLED;
15d0af7a Paul Walmsley 2018-10-18  572  }
15d0af7a Paul Walmsley 2018-10-18  573

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
