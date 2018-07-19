Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80F20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B80F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeGSPlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:41:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730922AbeGSPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:41:44 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgANc-0001VJ-My; Thu, 19 Jul 2018 16:58:08 +0200
Date:   Thu, 19 Jul 2018 16:58:08 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jeremy Cline <jcline@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scripts: Add Python 3 compatibility to spdxcheck.py
In-Reply-To: <20180717190635.29467-1-jcline@redhat.com>
Message-ID: <alpine.DEB.2.21.1807191656450.1693@nanos.tec.linutronix.de>
References: <20180717190635.29467-1-jcline@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Jeremy Cline wrote:

> "dict.has_key(key)" on dictionaries has been replaced with "key in
> dict". Additionally, when run under Python 3 some files don't decode
> with the default encoding (tested with UTF-8). To handle that, don't
> open the file in text mode and decode text line-by-line, ignoring
> encoding errors.
> 
> This remains compatible with Python 2 and should have no functional
> change.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
