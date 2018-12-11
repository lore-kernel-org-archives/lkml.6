Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E1AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FD120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FD120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLKPVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:21:30 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:57998 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeLKPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:21:29 -0500
Received: from office.codethink.co.uk ([148.252.241.226] helo=devhw0)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gWjqV-0002GA-PM; Tue, 11 Dec 2018 15:21:15 +0000
Received: from tpreston by devhw0 with local (Exim 4.89)
        (envelope-from <thomas.preston@codethink.co.uk>)
        id 1gWjqV-0002E9-0L; Tue, 11 Dec 2018 15:21:15 +0000
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     akpm@linux-foundation.org, pmladek@suse.com,
        andriy.shevchenko@linux.intel.com, rostedt@goodmis.org,
        geert+renesas@glider.be, corbet@lwn.net, me@tobin.cc,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH 0/2] vsprintf Stop using obsolete simple_strtoul()
Date:   Tue, 11 Dec 2018 15:21:11 +0000
Message-Id: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We've fixed a bug with sscanf(). When passing in a 16-digit hex-string like so:

	sscanf("fafafafa0b0b0b0b", "%8x%8x", &hi, &lo)

The resulting value in hi is always 0. This is because vsscanf() uses the
obsolete and broken functions simple_strtoul() and simple_strtoull(), which we
have replaced.

Many thanks,
Thomas

Thomas Preston (2):
  vsprintf: Specify type for union val members
  vsprintf: Stop using obsolete simple_strtoul()

 lib/vsprintf.c | 66 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

-- 
2.11.0

