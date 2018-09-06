Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3EDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A9F2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A9F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIFVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbeIFVUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:20:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5C62075E;
        Thu,  6 Sep 2018 16:43:50 +0000 (UTC)
Date:   Thu, 6 Sep 2018 12:43:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <20180906124349.56b89024@gandalf.local.home>
In-Reply-To: <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
References: <20180905122754.443196118@goodmis.org>
        <20180906075434.xa64dy7d6p4yolyi@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 09:54:34 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-09-05 08:27:54 [-0400], Steven Rostedt wrote:
> > Dear RT Folks,
> > 
> > This is the RT stable review cycle of patch 4.14.63-rt41-rc1.
> > 
> > Please scream at me if I messed something up. Please test the patches too.
> > 
> > The -rc release will be uploaded to kernel.org and will be deleted when
> > the final release is out. This is just a review release (or release candidate).
> > 
> > The pre-releases will not be pushed to the git repository, only the
> > final release is.
> > 
> > If all goes well, this patch will be converted to the next main release
> > on 9/7/2018.  
> 
> Your tree (v4.14.63) has
>   80d20d35af1ed ("nohz: Fix local_timer_softirq_pending()")
>   0a0e0829f9901 ("nohz: Fix missing tick reprogram when interrupting an
>                  inline softirq")
> 
> which means that the patch "nohz: Prevent erroneous tick stop
> invocations" can be reverted / dropped. It might have clashed during the
> emerge of the stable tree.
>

My tree also has this:

commit 5536f5491a2e098 

    softirq: keep the 'softirq pending' check RT-only
    
    The patch "nohz: Prevent erroneous tick stop invocations" was merged
    differently upstream. The original issue where a slow box could lock up
    with a pending timer remained. I currently assume that this is a RT only
    issue and keep the patch as RT only.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>


What needs to be done?

-- Steve
