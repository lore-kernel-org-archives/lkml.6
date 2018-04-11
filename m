Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477632-2-2411110891462609648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477632; b=MDED316DnJSHczPqqCg2k7VazD+BUV4eVj/gWZMyIWfIs2c+hh
    kpaidcGow70an1Yz+8yE/PLEzLbZyvTEqZ8V+wvIciKWO2owacQwF59BthbCPLig
    eniDRB78EMFDgEi1mucUoiZ3EBH9f8bwoJ6V8YHtXgnxmGIM6fxT2Myxrw5HcjEE
    CVsXM93TslyogV6gLaIhcNdyo+DTiOHoSZGoPzB7LspMNoVp8phLsHaDDyeKYXCW
    nXvHe1LSDUxym5fFDmonrNaUISoxLCALUtOll6GE9jIUsp7Z3Eg+1DWFMOd7Ynhs
    +zJccFPMFBkW71T1C/dSlQWONDDLWbMruUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477632; bh=EZrh37yBe25putkMX9c7uKdQgs50CY
    +jidUrKcvT420=; b=Imx5dyit5Y/pugPBtPJhEuAQDYKVexMFCqBt3OVEIFDTPM
    Df+j9KkgaM/t5HutLoQWvJX9/ozykPEYNux+j5qzuzkLn/WtnvYic6mbx3fcoGOi
    fmid2meXOgJnKXdOZD+PXQ79ZlHP09XsOLLBVO6pMPaHv9+0cxFLp3xU+O5e5UqH
    2LtOWk1nmXmgHWadpyjxhqOLrE1Bafagnf02UJYnrWQf6/YOrwyyAIMGXJs6XkLj
    tFBgGOti1u+MBFagoabtCT3eP6uB1GVC8+goBqFYozNtb6YLco3W2dLRtaDtwTI5
    6mt2rCEtmmCdn3qnMIcIhWDnWSKWw/KY2naSpNPg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFrHyXxicZg0s+L/cccWqhTbjxK5YzA4WP3se78no0bCvkL59a0IYDAfLp++qv/LMXC/lOYkGqULV57QOz3jvX37gxLm4yI74fRpO6KvrWN3oGP8YqgZ
    XGe2QHgqyx8jWw5m55PwfZL9IZuaFE6t5333f3nx0QmK+4315GMxpf7RkohdhSUvGTtVU7gpPmEYcEv7Q4XlfJy8TiHO9hrC9nK2mvy7tdr9YBZCWEjT7F5Y
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=drOt6m5kAAAA:8 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=5ZIf7ZDfmYngwTVeS3UA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeDKSxm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeDKSxl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 028/310] perf/callchain: Force USER_DS when invoking perf_callchain_user()
Date: Wed, 11 Apr 2018 20:32:47 +0200
Message-Id: <20180411183623.502566763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit 88b0193d9418c00340e45e0a913a0813bc6c8c96 ]

Perf can generate and record a user callchain in response to a synchronous
request, such as a tracepoint firing. If this happens under set_fs(KERNEL_DS),
then we can end up walking the user stack (and dereferencing/saving whatever we
find there) without the protections usually afforded by checks such as
access_ok.

Rather than play whack-a-mole with each architecture's stack unwinding
implementation, fix the root of the problem by ensuring that we force USER_DS
when invoking perf_callchain_user from the perf core.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/callchain.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -227,12 +227,18 @@ get_perf_callchain(struct pt_regs *regs,
 		}
 
 		if (regs) {
+			mm_segment_t fs;
+
 			if (crosstask)
 				goto exit_put;
 
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+
+			fs = get_fs();
+			set_fs(USER_DS);
 			perf_callchain_user(&ctx, regs);
+			set_fs(fs);
 		}
 	}
 
