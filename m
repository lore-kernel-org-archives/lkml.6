Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZqIgkdk+y9aIit3M5sKk3KJySJ0u4vYdeKZL2hgHhEWHqy2vEwZLQaIHXOUq1eatQimCe8r
ARC-Seal: i=1; a=rsa-sha256; t=1524793391; cv=none;
        d=google.com; s=arc-20160816;
        b=yUU6+hrrOXF8+9C5zK6bQ8T4tdP5QNpOvZfBDlqGbJq6UCjZBPFlJRdmZUpBNKKBLM
         D61KRN/ZpK4aN+ZTEmvXMwCVnGoPSaAM/x4xtt7S5PITYyQEuBL6h8NJMGMUIzFr2Woj
         foA85/mND22Vuq3IG59w6IF0pnMJdlx8bw4/jSAbEzDDCmk177NzHWaCiLtAwv6SANe2
         2j1/1sNnHjKeIMTfpNtqGA1lwJHPLcxOTXLbvUBlukiJ7Mj4kuxe8i9TFmmTvJnWq+in
         yAIdh2agQangHA+QE+oUdZ3z3Qsm8TuFcn1vI+fYcDkvHqJ1PWsjonNvcwKcD5V71KMS
         kKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=de13XsWADow/Lk9vN8VZ7+Oj62x5a7nMFp6RHx1lccQ=;
        b=c+usOFxw4UagUFBBPcLQSZ7G/ZogD7JxGovcb97UK0DORiYIjfvnPLaUU2SFgjajoy
         IU569AcYBDJ43lHdhN84PpCrFpSM5DiztSQymhVzSL4zNw9HlBVFPy28UsLhcfNTUMSj
         Jp+O+6I5wwNh1XDKkmMnfdQC5xzEmXpu97PltKmFxDANHrIzb8S91iZblZ3vD6T0kNsU
         19qjwnSCeQlhv0p4OUYUIhEpfaNnRrWK1oIs2TdKpQ8m338lkOCKsSU5gp85SGaPDVc1
         uNYVXVpR2Z1jeQBI62Lveplf+aQbnok8s3EMNLBSDEhawAey//5PADkITUhr5fVe0g9D
         VPLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757133AbeD0Bm5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 26 Apr 2018 21:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756973AbeD0Bm4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Apr 2018 21:42:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8E22184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 26 Apr 2018 21:42:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-ID: <20180426214253.64ec8762@gandalf.local.home>
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720408935389499?=
X-GMAIL-MSGID: =?utf-8?q?1598861755432020431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018 21:16:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This is the 7th version of the fetch-arg improvement series.
> This includes variable changes on fetcharg framework like,
> 
> - Add fetcharg testcases (syntax, argN, symbol, string and array)
>   and probepoint testcase.
> - Rewrite fetcharg framework with fetch_insn, switch-case based
>   instead of function pointer.
> - Add "symbol" type support, which shows symbol+offset instead of
>   address value.
> - Add "$argN" fetcharg, which fetches function parameters.
>   (currently only for x86-64)
> - Add array type support (including string arrary :) ) ,
>   which enables to get fixed length array from probe-events.
> - Add array type support for perf-probe, so that user can
>   dump partial array entries.
> 

Masami,

Thanks for posting this! I'm currently trying to get a set of patches
in the -rc releases, and this would be for 4.18 (or 5.0?), I'll try to
get some time next week to look at this.

Thanks!

-- Steve
