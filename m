Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653297-2-16135912876796578834
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653297; b=RgqbOZSnEb5ipMAywrgPeqk6WeaNr1YSFoO0zpFGnHrOAcxdum
    Gcohaxu8KYwswgGmyeESv4/Kdm8Pzc2HnpcIq/FmZW7TS0pKYyFt5Gsmgol73e8x
    nZVf1Mx8rcqfz3ibQuxDmiGWSWmUHBT3vIMZTOYxNmU8zEopxr2p/iFhpuTx5t7/
    FnzFzxrVXwVBccx3R6HRbQo+FirfXPiSUHS1YaOqQE0EGQBSafAO7SxjDuuMx31t
    8I9GnX3djLZ4bn4Ju4Hh+BGIZKErE7QIQGcLXpFGYf+S7+a6ZSs4hqnvzpGo7xbt
    uNKM1y99xQEDUqrIGLaeX40uh/lyJtNxW9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653297; bh=z1FitC57LQkw3+KwP1tUtOUkK/GNed
    4Kyd9D8qcvyZU=; b=lIO0kJ4SI1wZ/Tp3RbO9tD73rxT/d59u4BC8HnsYeFvusJ
    8+yYU3nTK7CZOVuv7ejOCalECxCq1sX2buZ5bhK8oJCiq3NHIBy2f4JZm/pGmPLm
    +z1rCCEOFRtID5YQ3aQ7CTHPLfXnLY6dljdK3HdDNEL/5ON64CtVUS5URabu57J5
    MwbrOsUhXW6vwg4W7KY4HfXWT//KY9GLdwUsxlg+sjPdzFZwN3b34T9i1iWjo7Pp
    ToSjvbEDBb5y4lnMompCJKWtxMvxalWMk7yEdVIWFDGm0AJ3T605HFmpcT4VaAuY
    7eQR3VeaWfzV5ERIMeJSchSSDN+sRGIYrQ8Uz7zA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfPyVYdyRWTBvzy1BK3tNcNfze7ZUw5B6EkWHIkXEIkszNcmJsqmKwF/eNWepWuPNFHaaoMsI5SSuy+aNzBjEpUH/bQ6w231u7zSzfxEY4A7lkXA8y4jt
    4fW64vqLBoarTuexNMu1kpKCDNeiWnuR3Ko1F3/ED22TN/59NjpW48FMdCYkfXIkr1yxFcBoD9awGF5XB6v1phymHaK0Yo569o1GOrUxOZAWW/FQ7QPLY+r9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=WfulkdPnAAAA:8 a=oGMlB6cnAAAA:8
    a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=5pElJeHA-yHr_syu1SgA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=56QPVbyS4OZCpcuOg7Z9:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeDYKr7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:47:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbeDYKoy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:44:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 180/183] perf: Return proper values for user stack errors
Date: Wed, 25 Apr 2018 12:36:40 +0200
Message-Id: <20180425103249.732757973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 78b562fbfa2cf0a9fcb23c3154756b690f4905c1 upstream.

Return immediately when we find issue in the user stack checks. The
error value could get overwritten by following check for
PERF_SAMPLE_REGS_INTR.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 60e2364e60e8 ("perf: Add ability to sample machine state on interrupt")
Link: http://lkml.kernel.org/r/20180415092352.12403-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9750,9 +9750,9 @@ static int perf_copy_attr(struct perf_ev
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
