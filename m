Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B2C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799BA20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJBWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9119 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbeJBWZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:25:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCF9556E3;
        Tue,  2 Oct 2018 15:41:33 +0000 (UTC)
Received: from tonnant.bos.jonmasters.org (ovpn-123-70.rdu2.redhat.com [10.10.123.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CD60611DD;
        Tue,  2 Oct 2018 15:41:30 +0000 (UTC)
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
 <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
From:   Jon Masters <jcm@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jcm@redhat.com; keydata=
 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
 yrXvw9qg2waGcnb8WuoS+g==
Subject: Re: [PATCH 2/2] x86/speculation: Provide application property based
 STIBP protection
Message-ID: <1a501628-a232-a126-166e-814c26243f2d@redhat.com>
Date:   Tue, 2 Oct 2018 11:41:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0c55c162a077aadbfd57878e2694e35292c1a29c.1537392876.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 02 Oct 2018 15:41:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/18 5:35 PM, Tim Chen wrote:
> This patch provides an application property based spectre_v2
> protection with STIBP against attack from another app from
> a sibling hyper-thread.  For security sensitive non-dumpable
> app, STIBP will be turned on before switching to it for Intel
> processors vulnerable to spectre_v2.

A general comment. I think in practice this will be similar to the
speculative store buffer bypass (aka "variant 4") issue in terms of
opt-in mitigation. Many users won't want to take the performance hit of
having STIBP by default for peer threads. We should make sure that we
don't force users into a mitigation but retain an option. Whether it's
default-on or not can be debated, though I think the vendors lean toward
having default-off with an opt-in, and customers will probably agree. So
anyway, I encourage a pragmatic approach similar to that for SSBD.

Jon.

-- 
Computer Architect | Sent with my Fedora powered laptop
