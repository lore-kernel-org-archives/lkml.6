Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4312FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC332133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfB0WZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:25:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfB0WZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:25:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFC0C7C08A;
        Wed, 27 Feb 2019 22:25:19 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46117679DC;
        Wed, 27 Feb 2019 22:25:19 +0000 (UTC)
Subject: Re: [PATCH] x86/stacktrace: export save_stack_trace_tsk_reliable
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        x86@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
References: <20190227211748.9545-1-joe.lawrence@redhat.com>
 <alpine.DEB.2.21.1902272219160.1644@nanos.tec.linutronix.de>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <07491738-dfdb-deb4-7e25-f1c173dda773@redhat.com>
Date:   Wed, 27 Feb 2019 17:25:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902272219160.1644@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 27 Feb 2019 22:25:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 4:31 PM, Thomas Gleixner wrote:
> On Wed, 27 Feb 2019, Joe Lawrence wrote:
> 
>> The ppc64le implementation of save_stack_trace_tsk_reliable() is
>> exported, so do the same with x86.
> 
> And what's the in tree module user of this? I can't find one and just
> because PPC has an export with no user is not a convincing argument to add
> another one. The proper solution is to remove the unused PPC export.
> 

Good point.

For that matter, I do see in-tree modules making use of 
save_stack_trace, but who is calling save_stack_trace_tsk (exported by 
most arches) and save_stack_trace_regs (exported by openrisc, powerpc, 
s390)?

-- Joe
