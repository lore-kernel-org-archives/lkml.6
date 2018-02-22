Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227Po0Vw045YdbZ/GzS5PsqhPGTMrnxC4/90KvsPjJ4Fi6S3hNi4t0n7CIvGB716l9EzlkRx
ARC-Seal: i=1; a=rsa-sha256; t=1519281319; cv=none;
        d=google.com; s=arc-20160816;
        b=RWNzmTv6NM8CZQ7s1id8p0RbKEoTDBMUX7+Ndgv82KHByH9XUuLHOBYI9MAI7SuX41
         YiYRY3pdS+nAk9hzlcUk+4M0m0q3tj42uBu1RInigewekOIf3yvJAQlgpk5tFiYxqVFn
         UT3dZgiZwGeFZMkKZQsuqY3aFMiLwJaBDXEaDTwYFj041iP2qfsQNe6qC3/N2RmbwVK5
         y3GK4+PW3ETiaOHRoPJZDiROiZ9CJnMFcrf2rTW9krj20ZWT7PxroXDwJkPb9QlZVpOd
         HxasN/tUIIkdyFhz+ecVbPliwjUiouBI53oE65bZvCPfz23DYYCA1YAKzRQt03nQzrNK
         1GXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=MC2oS9n2W5ji2sUaDSN5h6DfpHkgUsHy5OH6B+HzcRo=;
        b=ECntpIiM6Z4wHDIZe5JI3bMkmRfjGNBuvR8SjPuHINGI2R93vAEhy2X1YQBOM98P3x
         nCteVD9f4nQejhwOZ6WYaeDZQGIabFjeSlYAGoNuZrhnn5rKg6kHa57v5IExA0cucIgx
         zX0CaKpC5f7/xiB0jCP8XuO+rcKNlmddaYq5ySrvbtiL8Hi8V2JGVa7DiIZrQLRQYlrF
         Z+2GGlP29xzLIyI7kHQdmgYqg5dzvEgkCDzkMsEUTHjjsoQTvn7sRtRw3awo7VN32k3c
         9juMR35aIwHoPv9FtntV5og8Bswp8fY/7/yyXK8BVkRi0EPI9i+X+nkWcq8veog0M4xu
         FcIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeBVGfS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Feb 2018 01:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbeBVGfS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Feb 2018 01:35:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D235A205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 22 Feb 2018 15:35:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 01/17] tracing: probeevent: Fix to support minus
 offset from symbol
Message-Id: <20180222153514.db309d98bbd2b741f7a76dd6@kernel.org>
In-Reply-To: <20180221205341.3fd69b35@gandalf.local.home>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
        <151922487738.6217.16114601174401123273.stgit@devbox>
        <20180222084153.e057d86729063fe39b8232f0@kernel.org>
        <20180221205341.3fd69b35@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593081929846390781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 20:53:41 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 22 Feb 2018 08:41:53 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Could you pick this separately since this is a bugfix?
> >
> 
> Yes definitely. I'll have to run my tests on it too, and I'll send it
> as urgent (current -rc release). 
> 
> Although you didn't mark it for stable. Which commit does it fix?

Wait, it actually fixes the 2fba0c8867af ("tracing/kprobes: Fix 
probe offset to be unsigned") but I found that I was doing the 
opposite thing...

OK, I'll update this to add a sanity check for kprobe.offset.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
