Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C2CC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB062086B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB062086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbeJ0Ttm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 15:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbeJ0Ttl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 15:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17F98309708F;
        Sat, 27 Oct 2018 11:09:06 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CBDF5D763;
        Sat, 27 Oct 2018 11:09:02 +0000 (UTC)
Date:   Sat, 27 Oct 2018 19:08:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Petr Tesarik <ptesarik@suse.cz>, lijiang <lijiang@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dyoung@redhat.com
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027110858.GB14493@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
 <20181027093917.GA14493@MiWiFi-R3L-srv>
 <20181027101221.GC1046@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181027101221.GC1046@nazgul.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sat, 27 Oct 2018 11:09:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/18 at 12:12pm, Borislav Petkov wrote:
> On Sat, Oct 27, 2018 at 05:39:17PM +0800, Baoquan He wrote:
> > Not very sure about this, we have arch_crash_save_vmcoreinfo() in
> > arch/x86/kernel/machine_kexec_64.c to export arch-specific stuffs
> > outside. Is there any special reason about a mask in one architecture
> > when expose it out?
> 
> Yes, we don't export random arch-specific details to the outside which
> we then cannot change later. So vmcoreinfo needs to define its own.

OK, then it's fine to get the bit number, e.g calling
find_first_bit(sme_me_mask, BITS_PER_LONG), and export it to
vmcoreinfo. Thanks.
