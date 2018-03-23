Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803677-2-9073518109780080818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803677; b=O60ASWTBZCw3gECtPJUAMxEr3K6f8CCR0sPqmKRE7ijlMWs
    tMXRLrpTow4n/pED9AACf0jOS5ddcwr3YjPcsJ0GSWAWEYgoulIOeD/18B3+rtH0
    v2vDPS+fWeWG/BMyt3F56Zs1pS1EModJKbppGipIf/DXq33+6c5wi/0y1k8XXZrp
    M45emfShhuihj4jUkl1wDhXGDo3Xe09/QqcTZ7Emhs3Y48HnWBb2QrCBo5iuPI61
    gnWYjNYGHb53CRTguCZVatvnjAhBPwOTKfQqQ+UZVuqaTKsQm67zoKtMlYSzvFTD
    jXxasmy+2T7Vxh0IOE10FX8YAwMks3Bqgk6KNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803677; bh=E6fHxJePO40+jYJ8ebnsnvZiNH
    KE2YirXYQTGXheBmE=; b=AgL6JkQ0kWmb2X4Bld647VPxd76OewEsJV3kx7o/JN
    V8sBz+hOHPjGrpQNHPgACZwZK6WjwTpHcp5rXgS5BtKs+G1ivDBrdxlWOZoaQR6l
    5NzzJxO+b1tLiY3jz2i6J8orLScuynvMeSdRi8NkVkx8ZpVA6HPKa2YNtgIRwxFd
    Ffy9GdgNz/owD1kTZ9KVww8HY12RERbJqCgRh/aSR3E/b/+dP+tDnoAGfLoRaty1
    DFpHx6Dy3d2quSTj6oKd1fuCf4tBKJ8i4gjFHBTSVSrL07HbuWoaGWgh9hcXQepV
    RGLZQ17le15ZXbTe4EgYQvuRxHRlrZBgXa3yC/cwAciw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932665AbeCWKKS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeCWKKQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 132/177] perf tests kmod-path: Dont fail if compressed modules arent supported
Date: Fri, 23 Mar 2018 10:54:20 +0100
Message-Id: <20180323094211.048722429@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Kim Phillips <kim.phillips@arm.com>


[ Upstream commit 805b151a1afd24414706a7f6ae275fbb9649be74 ]

__kmod_path__parse() uses is_supported_compression() to determine and
parse out compressed module file extensions.  On systems without zlib,
this test fails and __kmod_path__parse() continues to strcmp "ko" with
"gz".  Don't do this on those systems.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 3c8a67f50a1e ("perf tools: Add kmod_path__parse function")
Link: http://lkml.kernel.org/r/20170503131402.c66e314460026c80cd787b34@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/kmod-path.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/tests/kmod-path.c
+++ b/tools/perf/tests/kmod-path.c
@@ -61,6 +61,7 @@ int test__kmod_path__parse(int subtest _
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_KERNEL, true);
 	M("/xxxx/xxxx/x-x.ko", PERF_RECORD_MISC_USER, false);
 
+#ifdef HAVE_ZLIB_SUPPORT
 	/* path                alloc_name  alloc_ext   kmod  comp  name   ext */
 	T("/xxxx/xxxx/x.ko.gz", true     , true      , true, true, "[x]", "gz");
 	T("/xxxx/xxxx/x.ko.gz", false    , true      , true, true, NULL , "gz");
@@ -96,6 +97,7 @@ int test__kmod_path__parse(int subtest _
 	M("x.ko.gz", PERF_RECORD_MISC_CPUMODE_UNKNOWN, true);
 	M("x.ko.gz", PERF_RECORD_MISC_KERNEL, true);
 	M("x.ko.gz", PERF_RECORD_MISC_USER, false);
+#endif
 
 	/* path            alloc_name  alloc_ext  kmod  comp   name             ext */
 	T("[test_module]", true      , true     , true, false, "[test_module]", NULL);
