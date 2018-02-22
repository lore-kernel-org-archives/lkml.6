Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227U4wjNwYIQkAxeZAw8HHuZqFmbMrSnAHUgwd1J026k2UxwcG6K0GFar1UShvAZYQXD93HC
ARC-Seal: i=1; a=rsa-sha256; t=1519264425; cv=none;
        d=google.com; s=arc-20160816;
        b=FOPxZmZlxHgMXk1+2Nr6WMeqD2DenTwFxy9ICGD/iJPLslsU/+swptQObgGcpjSAgq
         PS31Lhok+kaChsNGFpGaLvLPE4SUD3TgCMHFuXGNotxxKN0wH7RyDyoI4tzDRFr+7FGK
         eV1gtsLn6as8hsPZIHA7SWAB325Jkk/UbPoAWLltZGRCH+Unb0/727hA+OpsP3ho7XXH
         gsinu4CQdG+TQwMnKyyYrf42+f86jO4uXpPGiWuVtpJfeSZJ7BD1AxesFVuupvzCTzNq
         Mm8rDGB8vVh6ypF7a6UFSKkTXUoR1a/Is14X6WGT2rTRjxgbb9i1d7Ic1BJlSxpT26wy
         3QBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=mDiAz6bIACqbhK+gBxbmTCadhhsWv0qUAyqu0BZZHTw=;
        b=DlXKwcxjX1owaPfs56OarC/vYvJ/3ULAp3jA97SaqmnRash/mjItFA2yfnrCyqD0O9
         bqyHmLqx2T+XLf0BITEY/C8RIucwNj7xUV4v59cF2aVdHhq9Swd3Whz75EcFA1CgIPn/
         c3gMYEQXhqN49I0b0twh/hSNgda0LZBxjwct7YJCzr1h/Bw6hZswq9CkXMhdAVHZCyBt
         0ncVqRtBoEkyGhG2qSoLAO9XD62UcAjqCma8nq9n/9buqdm3XRbBlHwt4wXbdteCb1Ue
         IHIcOxBkOcdDwut02d2n7m9Zun0h9vab6M7cFCJHEw8HkiUpAl8oOzDmUKCtt8Jz/jeU
         rGYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeBVBxp (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 20:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeBVBxo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 20:53:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D8920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 21 Feb 2018 20:53:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 01/17] tracing: probeevent: Fix to support minus
 offset from symbol
Message-ID: <20180221205341.3fd69b35@gandalf.local.home>
In-Reply-To: <20180222084153.e057d86729063fe39b8232f0@kernel.org>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
        <151922487738.6217.16114601174401123273.stgit@devbox>
        <20180222084153.e057d86729063fe39b8232f0@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593064214332205609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 08:41:53 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Could you pick this separately since this is a bugfix?
>

Yes definitely. I'll have to run my tests on it too, and I'll send it
as urgent (current -rc release). 

Although you didn't mark it for stable. Which commit does it fix?

Thanks!

-- Steve
