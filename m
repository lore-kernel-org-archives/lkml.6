Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4796DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BA520652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BA520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbeIFM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:28:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32806 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFM2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:28:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fxp7a-0008PE-RS; Thu, 06 Sep 2018 09:54:34 +0200
Date:   Thu, 6 Sep 2018 09:54:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 00/22] Linux 4.14.63-rt41-rc1
Message-ID: <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905122754.443196118@goodmis.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-05 08:27:54 [-0400], Steven Rostedt wrote:
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.14.63-rt41-rc1.
> 
> Please scream at me if I messed something up. Please test the patches too.
> 
> The -rc release will be uploaded to kernel.org and will be deleted when
> the final release is out. This is just a review release (or release candidate).
> 
> The pre-releases will not be pushed to the git repository, only the
> final release is.
> 
> If all goes well, this patch will be converted to the next main release
> on 9/7/2018.

Your tree (v4.14.63) has
  80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
  0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
                 inline softirq")

which means that the patch "nohz: Prevent erroneous tick stop
invocations" can be reverted / dropped. It might have clashed during the
emerge of the stable tree.

Sebastian
