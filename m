Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B403C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3FC20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3FC20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gherkin.frus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeGaBIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:08:12 -0400
Received: from gherkin.frus.com ([192.158.254.49]:49080 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbeGaBIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:08:12 -0400
X-Greylist: delayed 1126 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2018 21:08:12 EDT
Received: by gherkin.frus.com (Postfix, from userid 500)
        id 0FDF63CFF1; Mon, 30 Jul 2018 18:12:10 -0500 (CDT)
Date:   Mon, 30 Jul 2018 18:12:10 -0500
From:   Bob Tracy <rct@gherkin.frus.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, debian-alpha@lists.debian.org
Subject: [FTBFS] 4.18-rc7 bitsperlong.h issue on alpha
Message-ID: <20180730231210.GA20813@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an alpha system, got the following build error on the 4.18-rc7
mainline kernel source tree:

  HOSTCC  net/bpfilter/main.o
In file included from tools/include/uapi/asm/bitsperlong.h:17,
                 from /usr/include/asm-generic/int-ll64.h:12,
		 from /usr/include/alpha-linux-gnu/asm/types.h:24,
                 from tools/include/linux/types.h:10,
                 from ./include/uapi/linux/bpf.h:11,
                 from net/bpfilter/main.c:9:
tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size.  Check asm/bitsperlong.h
 #error Inconsistent word size.  Check asm/bitsperlong.h
  ^~~~~
scripts/Makefile.host:107: recipe for target 'net/bpfilter/main.o' failed
make[2]: *** [net/bpfilter/main.o] Error 1
scripts/Makefile.build:558: recipe for target 'net/bpfilter' failed
make[1]: *** [net/bpfilter] Error 2
Makefile:1029: recipe for target 'net' failed
make: *** [net] Error 2

Encountering this kind of error is not unusual on alpha.

--Bob
