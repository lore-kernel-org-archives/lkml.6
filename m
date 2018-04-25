Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652610-2-2555625383513563532
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
    1524652609; b=UDO9Y4QijHJsNLmUtjKDkDEFjz/sbYnFbOgsr//I3TS71EsSPa
    ve4H8CHO5fsFDKYXAq1PLe/l/Fp99cVd59tCPTx702yqTpH88jTcWpuPk9vVM6UG
    wwzgfUXqAkpdub8hP4zPVknGDanE2cWxpHfwqEr/mM1oEXT/cngAwf7ay1JYbuCf
    OUKJM4Ean/2QrqxSNcT88lbfpNtT4hFgisptQKdnazLmbqEDcFf0l6AnkAM23dGY
    LJqB2NzQkQ9mYC2vsnrogbWn1YUMhBvrzAwUeJ3cKTSpOULYF/qcLKy0WadKR2zo
    EdTsjFEM+6lz/p9WRgdnFa+HPCtFbCXPBmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652609; bh=R8Tmc870lRaxpoF+a1ueEg6UHr2Fht
    NYsjYq/gr59Mo=; b=cuGKfzN9ZI/2/6sErPRGfKnM0rYz3hjvirBtnY7K3KHtSf
    SyJeaKfPQt8mhFLgSwqyisVGdK+9xzVblhwaAv8pPMTTodJ2aJAl/eGzleBxklHy
    nWmwE4tteNQx6dYQetpCsyAFPA6bVXDO4LPHyE7wNf/15ocuiMkFvriP19X6KD6X
    8W+kFF9HixW8C0lzx986ALs2uzKmdNgVf19ujRDJFQAsa83IM+fy6lmGrF1A2dJ7
    01QEAsH5p1LauWQUT1HP419c3vpGksa4ZBSGJ6XVzlWVpn0fI8atwavswDOzWFHr
    wtvD8M6yNQXWlaJwrkTsW+XCUTue7CZ2ZkFokniQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfFM5IfI7VTxCSMMXLXfS/T3HZeTzaDwQA2csn808mRtx5AMY55mgAPqoUX7pfnfDjuqnYu37oqBkBUtrbFYCO7cft7P7/DmMW5BivkJjVNNkcBlTkliM
    CZqze/jCyul3sfEbSxouDPdxozQP3PmNvWnoh3+ZkGNfXc573jOI/3zc5lFNHO2mrLD0Sgdn4Y51oenKeehIdjO/l97io5uRzWzMugxgjFXp8yDtaBS2I9Iu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=gu6fZOg2AAAA:8 a=hSkVLCK3AAAA:8 a=QyXUC8HyAAAA:8
    a=WfulkdPnAAAA:8 a=oGMlB6cnAAAA:8 a=JfrnYn6hAAAA:8 a=4RBUngkUAAAA:8
    a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=h3N0j7ODOtes0kd0OWgA:9 a=QEXdDO2ut3YA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=cQPPKAXgyycSBL8etih5:22 a=56QPVbyS4OZCpcuOg7Z9:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDYKgs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:36:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752797AbeDYKed (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.16 23/26] perf: Fix sample_max_stack maximum check
Date: Wed, 25 Apr 2018 12:33:32 +0200
Message-Id: <20180425103315.768833894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 5af44ca53d019de47efe6dbc4003dd518e5197ed upstream.

The syzbot hit KASAN bug in perf_callchain_store having the entry stored
behind the allocated bounds [1].

We miss the sample_max_stack check for the initial event that allocates
callchain buffers. This missing check allows to create an event with
sample_max_stack value bigger than the global sysctl maximum:

  # sysctl -a | grep perf_event_max_stack
  kernel.perf_event_max_stack = 127

  # perf record -vv -C 1 -e cycles/max-stack=256/ kill
  ...
  perf_event_attr:
    size                             112
    ...
    sample_max_stack                 256
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 4

Note the '-C 1', which forces perf record to create just single event.
Otherwise it opens event for every cpu, then the sample_max_stack check
fails on the second event and all's fine.

The fix is to run the sample_max_stack check also for the first event
with callchains.

[1] https://marc.info/?l=linux-kernel&m=152352732920874&w=2

Reported-by: syzbot+7c449856228b63ac951e@syzkaller.appspotmail.com
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: syzkaller-bugs@googlegroups.com
Cc: x86@kernel.org
Fixes: 97c79a38cd45 ("perf core: Per event callchain limit")
Link: http://lkml.kernel.org/r/20180415092352.12403-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/callchain.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -119,19 +119,22 @@ int get_callchain_buffers(int event_max_
 		goto exit;
 	}
 
+	/*
+	 * If requesting per event more than the global cap,
+	 * return a different error to help userspace figure
+	 * this out.
+	 *
+	 * And also do it here so that we have &callchain_mutex held.
+	 */
+	if (event_max_stack > sysctl_perf_event_max_stack) {
+		err = -EOVERFLOW;
+		goto exit;
+	}
+
 	if (count > 1) {
 		/* If the allocation failed, give up */
 		if (!callchain_cpus_entries)
 			err = -ENOMEM;
-		/*
-		 * If requesting per event more than the global cap,
-		 * return a different error to help userspace figure
-		 * this out.
-		 *
-		 * And also do it here so that we have &callchain_mutex held.
-		 */
-		if (event_max_stack > sysctl_perf_event_max_stack)
-			err = -EOVERFLOW;
 		goto exit;
 	}
 
