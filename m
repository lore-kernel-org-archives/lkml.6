Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479519-2-7503565865287110660
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
    1523479518; b=MP2yF9tm1vDhW120/9nm6sQv47m2X13A0Pj3Ju7IwBQWp3kTw3
    fEo0VBErq+MfW1mRBRglZgW8vPM243bwarIwBQTZuzpEkVSxnqar+n2wLt4l5DQW
    6YfHyD+YLMR4RtH0NcDSh90iPr1/ooDykPjm1PabhuX95nojv+nDTvUzwb6mTgBP
    x6TOcZ9PM8QiBjgBzhZc5XFvoEh1BAWMPNWxQadRfu7f2iyqknHttITUTNfD0SOX
    GqVEV3ZAP5z7WMMmeoW99G0eWdwupsoUvU4Tj/BIkskmaEHhj7F8uD4hL9/a6vHy
    sz1AaZm0D0UjrBVUW3F0UePOy9RnjgDJc61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479518; bh=VPFDHU6+yzCmS4VfT+zAS3tuDczIxI
    NhJL6JuGVc//o=; b=xAYSL3aKv7DtwygA2Pb1PW0/ui8Kg1QfD0flnkqm2ShJkq
    yR0e+ZWbZf5DT42PvgWXmdNpk7amUfG7hiYnyLkDV51/bAhDV2xy4ngJ69xTzCxE
    qRCZ5YK895j4QV3rVEZqcA7WdrVtrabZCodEcj4Vo0p8vBnf0PbYJE0vWmOjrrwz
    FEIHyxf+5i2M1MBtQbYzPO/QNAWS9VgmcDrDgapR83/JjciCyyz+mwjBr9ZubmJV
    3d9bx6ZQn5YlaQubH18C0Gp3vTLM1jMdLxyxARqSP/tL3bAFpZ5I5aNHjcqvYnSj
    KJasQ3OIkzJSDF/KNRcIWGaXkzE4p38igzx8SwqA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfP0P9tvxNZxBVfIM3ve8FPDFO8wwatfzlNy+KFsLKP/3N4wM1yDil+MlzVeh6eGbzpJz8Mb5HN6r6Te5vHqvJ9A1w6g+n+m40Y+YrbY0/mjTvLT+Kqla
    +DjC1pk99+BEVrhIOQucVOO21Pppsjd80ozXc5U24gfr5iaSB3BCZkaAF4oh/ctDmV5VsL1+q5upXYnub8PKUURyGvPfPnXMus46+WO0apkFxMUw/b2UDC6s
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=XY9_J5gOtC_FUSJH_rwA:9
    a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755849AbeDKUpC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:45:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755832AbeDKSrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Paul Clarke <pc@us.ibm.com>,
        bhargavb <bhargavaramudu@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 083/190] perf probe: Add warning message if there is unexpected event name
Date: Wed, 11 Apr 2018 20:35:29 +0200
Message-Id: <20180411183555.454699178@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit 9f5c6d8777a2d962b0eeacb2a16f37da6bea545b ]

This improve the error message so that user can know event-name error
before writing new events to kprobe-events interface.

E.g.
   ======
   #./perf probe -x /lib64/libc-2.25.so malloc_get_state*
   Internal error: "malloc_get_state@GLIBC_2" is an invalid event name.
     Error: Failed to add events.
   ======

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: bhargavb <bhargavaramudu@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Link: http://lkml.kernel.org/r/151275040665.24652.5188568529237584489.stgit@devbox
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/probe-event.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2349,6 +2349,14 @@ static int get_new_event_name(char *buf,
 
 out:
 	free(nbase);
+
+	/* Final validation */
+	if (ret >= 0 && !is_c_func_name(buf)) {
+		pr_warning("Internal error: \"%s\" is an invalid event name.\n",
+			   buf);
+		ret = -EINVAL;
+	}
+
 	return ret;
 }
 
