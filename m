Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523481291-2-7102457598379352864
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
    1523481291; b=LAr5wn8cqMdxMF+z8xWs48FS+We37UjFuf7NWoZPtVuGUFSMQ2
    QdZiDniEazAMDlnnZt7W4lBr+CIwxqyMEOQ/PXNp2aIjVsTU3bPPvMAETKNlZEfD
    e2rWZ0f9DvAZRv4H07ovVO2SEer/wqxasxv/TrvTcLNHCzCy4or0vdNVd/Wg3Gy5
    zcF0rJBuMqQMt0I+h/v9HsPvd8OB9vrWhh7YlH3QscroF6aFw7LrUEfe3JuMomzd
    KPPFr7XylCHUXCBmrfGiuqBl4ubo86QQEETgBhetH17t7dGEPf03ksT0KAbMxKMH
    hzs8sP3gjuWT0FO2/VqRHdV1kw97HqsUOOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481291; bh=kIksq0bmVtT0phxGcW+Mx2hSAJrKGH
    4mx9yGBdkqh1E=; b=mDDo0tJxroezqKJPLbNcgbGp0+O2mZC6qQry4ZiPr+VTtP
    rL7lD6CqARYn6nhQXcCVRmPipqnKj4SG2/h9buQu5fBcKstMaJRD2j8WdfACITBN
    YHtNZWQt0c87hJ/et/COOisw+0a8RCKJQqtdit6Hf3bUxfkLhWWaFBliMuVtC9cM
    CiaaY8/JwxgByKgM3yHaBPj227hNhpY8fMB0KL+IqXuCsbhBYfT0rVuljYqRbguh
    +l761x0WPLslCKkRQdMIhM4+9dUgrasbQo7MPCERMCKkQhmz7Ul9IBtNym6wlmd3
    oMV+RgbKYquEwHanGqNfrzErxOybaCE16RHPJzvw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfO3zmV3O1pCIkhzZu5jefo2rVYNKqkevpom9vI1gzU6HWx/k9rICihkxzEH5wueEBblQyxYJExV8ZQPOxlLTk/cfouHXtYh+KC2S8ZpNFz3WJa/qDLtp
    Y3sNxVvpOfR5mw+OKFxGGqdkJNTAw75+sh1NRb2C49GAbyFLnr5a4DgVzNu5dOWVJH4L+dEVObMgrxfOSG1DV5WDqg0p2zfFYVwe2vpdI2oJNnPXZIIqDco3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=G2B6q9MqAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=dFICDcurLW7UVEJXWl4A:9 a=QEXdDO2ut3YA:10
    a=Xmodrq67gIfclZDjVswV:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754735AbeDKSk4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56608 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDKSkx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 069/121] perf report: Ensure the perf DSO mapping matches what libdw sees
Date: Wed, 11 Apr 2018 20:36:12 +0200
Message-Id: <20180411183500.374507734@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milian Wolff <milian.wolff@kdab.com>


[ Upstream commit 2538b9e2450ae255337c04356e9e0f8cb9ec48d9 ]

In some situations the libdw unwinder stopped working properly.  I.e.
with libunwind we see:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	           608f3 _GLOBAL__sub_I_kdynamicjobtracker.cpp (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
	            f199 call_init.part.0 (/usr/lib/ld-2.25.so)
	            f2a5 _dl_init (/usr/lib/ld-2.25.so)
	             db9 _dl_start_user (/usr/lib/ld-2.25.so)
~~~~~

But with libdw and without this patch this sample is not properly
unwound:

~~~~~
heaptrack_gui  2228 135073.400112:     641314 cycles:
	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
	           ed94c KDynamicJobTracker::KDynamicJobTracker (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so.5.35.0)
~~~~~

Debug output showed me that libdw found a module for the last frame
address, but it thinks it belongs to /usr/lib/ld-2.25.so. This patch
double-checks what libdw sees and what perf knows. If the mappings
mismatch, we now report the elf known to perf. This fixes the situation
above, and the libdw unwinder produces the same stack as libunwind.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20170602143753.16907-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/unwind-libdw.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -37,6 +37,14 @@ static int __report_module(struct addr_l
 		return 0;
 
 	mod = dwfl_addrmodule(ui->dwfl, ip);
+	if (mod) {
+		Dwarf_Addr s;
+
+		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
+		if (s != al->map->start)
+			mod = 0;
+	}
+
 	if (!mod)
 		mod = dwfl_report_elf(ui->dwfl, dso->short_name,
 				      dso->long_name, -1, al->map->start,
