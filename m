Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KusKH34gGVtpNAAAmS7hNA
	; Thu, 07 Jun 2018 12:09:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 70101608BA; Thu,  7 Jun 2018 12:09:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EB10D601B4;
	Thu,  7 Jun 2018 12:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EB10D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeFGMJc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:09:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbeFGMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:09:31 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fQtjG-0002eh-J0; Thu, 07 Jun 2018 14:09:22 +0200
Date: Thu, 7 Jun 2018 14:09:17 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Li RongQing <lirongqing@baidu.com>
cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/acpi: fix the comments in acpi_parse_lapic
In-Reply-To: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
Message-ID: <alpine.DEB.2.21.1806071407050.1596@nanos.tec.linutronix.de>
References: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018, Li RongQing wrote:

> This should be permit to preallocate memory for all NR_CPUS

No. The comment is correct. The whole magic is there to size
num_possible_cpus correctly so that we can avoid allocating for NR_CPUS
which is most of the time larger than num_possible_cpus.

Thanks,

	tglx
