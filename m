Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvT8EOmJQCqmW0J3ME0uEgI8myJkHV+oHWzIYMB7xTRDTpGtgm23HhdYfB+1JD1fTvB6e74
ARC-Seal: i=1; a=rsa-sha256; t=1521821985; cv=none;
        d=google.com; s=arc-20160816;
        b=t7IppEeQ8obsL6vxDM8YruLfbC/IbXEP6CtHyRVUXzGUesMEsU/Rp7SFUm1JwkPGNR
         4W+ESSkxOSJb8+QLddNCtpNFx5SS7N4fV2bHfojAwdgoboJxepMq6kC6Hjkg68uZRPhD
         jeMzQ0Z0tExMq4YFpx3c09K4gy72UmmtmaTbEqd6D+rfrn2D8wfbaz8joZlqyFptno6+
         qNH8aZ+0oIbKIJunC9iaBPkru9EObVMjaQ7cTTBwZYQhNkIeFThvLMLjOdMgkNWjrI6X
         G4xi+9r0Qgw22ae0VQ5l9C9zta69GLr4QcCIUlWrE5NX3w43T4y7atWD4ENWcP9XW9+A
         qDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=JCyA/zP1OaRapE8KUieb81D0LZEJ5ilbzCbxpqexSd0=;
        b=s2lgu8J5kFCxAUGfcBWUqQ/UP2JIyPzEpg0WVySbkBBW9fDgSIyYzf86MsPuxe/Bzc
         rYWVVuZqnoIFdL7XFPYt8KR0cr0sRAUDtZHuSgpN41Lv76yn2uWv89T5i1xGHcOpCz/1
         Y4a+GB0Go/5x58Oi6WnxT4lF0lioiNASfWqS3aZK1KIOM/Zes4ZA6JCFAACWU03R5KN3
         FIiPmGL4mchDsOC+v+xXq9T2FAupJlkmbCw31d6w5DUcnx7ui2c/uSA0lCumq0/XUcqo
         vGWQtQ+V1c0f2euEbca2hY31ChSzy6NSpvYzwf80zWgkF3HzV7KejGZKf6koasHBwhtm
         gsmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeCWQTo (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 23 Mar 2018 12:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751806AbeCWQTn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Mar 2018 12:19:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180F92177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 12:19:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 04/21] selftests: ftrace: Add a testcase for
 probepoint
Message-ID: <20180323121940.44cb79af@gandalf.local.home>
In-Reply-To: <152129043097.31874.14273580606301767394.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129043097.31874.14273580606301767394.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188678577462103?=
X-GMAIL-MSGID: =?utf-8?q?1595746009901037287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 21:40:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for probe point definition. This tests
> symbol, address and symbol+offset syntax. The offset
> must be positive and smaller than UINT_MAX.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>

I've pulled the first 4 patches into my urgent tree and I'm currently
testing it. When it finishes the tests (and I'm sure they will pass ;-)
I'll push it to Linus.

-- Steve
