Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523472134-2-383815722280525914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472134; b=M4k2KvuaO9+01YI6CJlBQYwy1/9YU+iuT5MDqQtejjAiSUafS3
    BWoFp10l5T8kS6AXM8JVml7r9Avy8/RQAEiWwKxU0OjmHc0mC3Zf+5UvhQcC402U
    Sci1EkYSpQYgQYkA3aEsBuiMDAIiNfxCMrgQXoZCED/QZEb20WK5YjFH5mDCmmOV
    b6dRk36wFywYsLtO5RgidUBbJsjAp7cojZ2mpt6ANFrIeoimNs3iS9U9zxdcSjjP
    Lvy3UlMuj+MJ2uoY4tMq2IWkPoxWMz55pEDX0vqnBTHS9wKxeIT82CLrV8pbYhXT
    B9shgEmV9MuUyjSgnXkvNntzeNC1R93s8byQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:mime-version
    :content-type:content-transfer-encoding:message-id:sender
    :list-id; s=fm2; t=1523472134; bh=Nag3PRnWir7rNUij/dijaw4/q0CqeX
    Xwfv1aqSOzLrI=; b=dSz4QvYZhSy2kJtx256JArxPmcGs89MITjnWF4IdZis0kE
    Hrcgy/xqcxXO3B2Rs7Cim1EE/tBXrvqYRSMpl90nLMBWTgED65sMbqmWCsceM5De
    VYkkK+Xvfih1GKRzt5xlMc4SqQLO3+khPLmrWkte38f+yPJ8cdjBmFm7Nhyakfh9
    jptBDUwRHo4zFyYWD0jbkw3L7jLyO3wEioFOvOTEiP5qgcb/AzUjXDIx6XmAz/Ww
    He4SVIQLVSUkzOxNBeB0jFwIM+19Egfu3j9DhPM4QbelbAtSWK5V9VxXESjoLgwq
    4baZpEhIdDEbpe6mm4J7toQ5BYFu1Y+wLO708l+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK1GYwuD97Gh7uErn8rnTlspaaf1VC9iFRDwWRJjcon7V+bCi/gcfqcTT8Ue/Y4Jbl8QvnalFerVUxBPYWdVIHc/U5lsHTFsny1VAJbswlLdXgEUdHLU
    Dajk4tvGxMkIjqN8DXyd66W7fLumvP5G0Jls0PWeG+ly2QisyEM4RtUTT99kpT8NAmaq7Jx74LiSzEHKK8Gge6quwZBkSfgmaORE/MDiL2QjJ9jvJqbUgBg0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
    a=ag1SF4gXAAAA:8 a=i0EeH86SAAAA:8 a=hGzw-44bAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=cm27Pg_UAAAA:8 a=VnNF1IyMAAAA:8 a=9uckbzzr4DivCenPrbwA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=HvKuF1_PTVFglORKqfwH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754965AbeDKSmJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:42:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754962AbeDKSmD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:42:03 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        He Kuang <hekuang@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH] perf session: Fix undeclared 'oe'
Date: Wed, 11 Apr 2018 15:41:35 -0300
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041118-0056-0000-0000-0000043B1269
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008838; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016456; UDB=6.00518362; IPR=6.00795704;
 MB=3.00020523; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-11 18:41:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041118-0057-0000-0000-0000087D2E01
Message-Id: <20180411184135.27664-1-muriloo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110172
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using linux-3.18.y branch, perf build fails with the following:

    $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
    [...]
    util/session.c: In function ‘__perf_session__process_pipe_events’:
    util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
      ordered_events__set_copy_on_queue(oe, true);
                                        ^
    util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in

This patch fixes it for linux-3.18.y branch.

Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")
Cc: <stable@vger.kernel.org> # 3.18.x
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Cc: Simon Que <sque@chromium.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 tools/perf/util/session.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dc3d3b1b813e..c2d4a7ec40df 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1073,6 +1073,7 @@ volatile int session_done;
 static int __perf_session__process_pipe_events(struct perf_session *session,
 					       struct perf_tool *tool)
 {
+	struct ordered_events *oe = &session->ordered_events;
 	int fd = perf_data_file__fd(session->file);
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
-- 
2.14.3
