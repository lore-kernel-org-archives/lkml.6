Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652790-2-2059604730136718680
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
    1524652789; b=YGKo2wHt9FjKX15Aa20IxkQu695PYrdkOXfhrNh9qWW9PfmqBk
    9FeYW/mMQ+ROHOHMqWwtLYZf+3vAd/1BsyUH2zbRxsCzQO+0KHvJ4A6SuFthBVsr
    qgw0qBJmhim0RrjXZf7oZJKVE/IXPyHLTicWOKpqjcQRbTEIMF1X3BBqHX65kQZR
    EyXgF6seBjYvbBmidwMLULjjrRzdIThrQ61O8ybc8qdQV7ZBlrn1kOWh4XmGiD3v
    eAE/GAL39g3i7n+VSieozbClow43IPmnBF/hWZdrM/5rKprqVaIlbZ3s3eX2b5ez
    rzNOw8LQ1Hmy8GuZJhdmrGpAsJX0fE8XMTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652789; bh=7IFqM+nvvSXntBnMAYPrhI0tMJ+mpD
    ECcouC8Uoc65U=; b=dPl06D7oH7FpAjmjEhO8eD9sGD5zda0YsZI9CpLKJt9Wrb
    DKutpy7Nd3A7zg+UHHJAT4QfuqS0z2BQoMjO0BFWqZonJPTVQDGXai9RFuIlcVII
    EzzutR2rqJk8YP9T8MGfuaLdOdyEzDPv3QMM9mhW4UIn80pqta+t2HUvt9ac5vpm
    yr33q2+WvhwJUmXPxxE7nwUyK5yh5vvC38qE+sIGMbT4bpAvG0s4wbN4sUlobLpO
    aE94H3fs7nUDM2vTupEOtEWfhEoYL6gDMgufTQAluKNCYozeyNBLtcrYtmmYoPUc
    HYbbOfmcKF46UUAQ+vXi0ADEWuu42YKlF/m1cv8A==
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
X-CM-Envelope: MS4wfI6AheBhx9KFLQUinpuIOxUTJqDXDHdtDQuxZhSnveuYD5XJjvOTAYsVqX9U7fW6oqPCOVPKE2lvYJZAVWN+r2Nq8O2HNK7JdvKY1edwxYOfILxkkKu1
    0wWbt5tS6MW+HTdc34haHxKTKo76Irt2FYW6Ngl/XbXH45YIjgNj5d7yMP717ovXwF/swRe566BCxeb2t1djZPqCclLMTArrVJhZktkRWdP6rShzwxeMSWrI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=meVymXHHAAAA:8 a=hD80L64hAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=txkOq09wrb2B0RYtGNkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeDYKjq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:39:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeDYKjm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:39:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 030/183] selftest: ftrace: Fix to pick text symbols for kprobes
Date: Wed, 25 Apr 2018 12:34:10 +0200
Message-Id: <20180425103243.798462067@linuxfoundation.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>


[ Upstream commit 5e46664703b364434a2cbda3e6988fc24ae0ced5 ]

Fix to pick text symbols for multiple kprobe testcase.
kallsyms shows text symbols with " t " or " T " but
current testcase picks all symbols including "t",
so it picks data symbols if it includes 't' (e.g. "str").

This fixes it to find symbol lines with " t " or " T "
(including spaces).

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Russell King <linux@armlinux.org.uk>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
@@ -12,8 +12,8 @@ case `uname -m` in
   *) OFFS=0;;
 esac
 
-echo "Setup up to 256 kprobes"
-grep t /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
+echo "Setup up kprobes on first 256 text symbols"
+grep -i " t " /proc/kallsyms | cut -f3 -d" " | grep -v .*\\..* | \
 head -n 256 | while read i; do echo p ${i}+${OFFS} ; done > kprobe_events ||:
 
 echo 1 > events/kprobes/enable
