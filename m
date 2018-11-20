Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526B2C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC8420836
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 23:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC8420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeKUKav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:30:51 -0500
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:46091 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbeKUKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:30:51 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EA2D68368F10;
        Tue, 20 Nov 2018 23:59:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: neck69_31937302bb055
X-Filterd-Recvd-Size: 2114
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Nov 2018 23:59:00 +0000 (UTC)
Message-ID: <f3548de1f5204165748c92314fbd24a10e47b8c5.camel@perches.com>
Subject: Re: [PATCH v3] debugobjects: scale the static pool size
From:   Joe Perches <joe@perches.com>
To:     Qian Cai <cai@gmx.us>, Waiman Long <longman@redhat.com>
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com,
        arnd@arndb.de
Date:   Tue, 20 Nov 2018 15:58:59 -0800
In-Reply-To: <trinity-ce6c61be-cc03-4a9d-8f26-562694d048da-1542758061535@msvc-mesg-gmx023>
References: <20181120201432.2163-1-cai@gmx.us>
         <20181120232810.2503-1-cai@gmx.us>
         <e286be8a-7f0a-65ab-0275-15abcd33eb07@redhat.com>
         <trinity-ce6c61be-cc03-4a9d-8f26-562694d048da-1542758061535@msvc-mesg-gmx023>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 00:54 +0100, Qian Cai wrote:
> On 11/20/18 at 6:38 PM, Waiman Long wrote:
> > On 11/20/2018 06:28 PM, Qian Cai wrote:
> > > The current value of the early boot static pool size is not big enough
> > > for systems with large number of CPUs with timer or/and workqueue
> > > objects selected. As the results, systems have 60+ CPUs with both timer
> > > and workqueue objects enabled could trigger "ODEBUG: Out of memory.
> > > ODEBUG disabled". Hence, fixed it by computing it according to
> > > CONFIG_NR_CPUS and CONFIG_DEBUG_OBJECTS_* options.
[]
> > > +#define ODEBUG_POOL_SIZE	(ODEBUG_DEFAULT_POOL + CONFIG_NR_CPUS * \
> > > +(ODEBUG_TIMERS_PCPU_CNT + ODEBUG_WORK_PCPU_CNT))
> > 
> > Just a nit about indentation. There should be some indentation in the
> > continued line.
> 
> I am fine to add that, but checkpatch.pl complained
> that there should no spaces at the beginning of a
> newline. Guess we just ignore the warning?
> 
> “please, no spaces at the start of a line”

It wants tabs '0x09' and not spaces '0x20'

