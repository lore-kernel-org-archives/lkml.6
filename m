Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B762FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69130204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69130204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeGTHZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:25:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35628 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbeGTHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:25:13 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgP3U-00073R-69; Fri, 20 Jul 2018 08:38:20 +0200
Date:   Fri, 20 Jul 2018 08:38:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Wang <davidwang@zhaoxin.com>
cc:     rjw@rjwysocki.net, mingo@redhat.com, len.brown@intel.com,
        pavel@ucw.cz, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] Optimize C3 entry on Centaur CPUs
In-Reply-To: <1527588757-19229-1-git-send-email-davidwang@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1807200837380.1693@nanos.tec.linutronix.de>
References: <1527588757-19229-1-git-send-email-davidwang@zhaoxin.com>
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

On Tue, 29 May 2018, David Wang wrote:

> For new Centaur CPUs the ucode will take care of the preservation of cache coherence
> between CPU cores in C-states regardless of how deep the C-states are. So, it is not
> necessary to flush the caches in software befor entering C3.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

