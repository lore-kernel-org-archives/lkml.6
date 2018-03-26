Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvsqmsSrOo7aba0LE+JHiYX2ZoJRm9VyU3BZjY+Dr+JyJk0H2+r+Vz5Ag5pUyr60T0myYws
ARC-Seal: i=1; a=rsa-sha256; t=1522085317; cv=none;
        d=google.com; s=arc-20160816;
        b=QjQ8yAJL2rtO4OdWYwvZtnsR3EPGEk7bOMBghj7g4I/yHc19LeFjR6yajDgv+df0A/
         KkEQRWNa5cehVI7Heea/A+8eoXPs8vESoOcat/iY1ZVZAm6WjRQkz7PIt9ZJsA/EsJL1
         6dZtFbWkVzfpD5Vt2M1Lv6lD0u+KhZE9NyHWzZBUKTU/+2qM9lt5mJYA//+9+HAUu8Ih
         J5PXIQ1J3pEqOhQ45+UYjb3bBxttWoVudFjGf/q5fjxoqQGv6EzeKu9BIcdcPK2mT2Ps
         As/DmXK0mkshd3MZqBxw1Fk+1k712F8FvkPk4bb0c1JWjdgTO68zivC5j9QFs077jyl/
         IVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=21K6zx3rFEcabZmVTy5muXd9ZNA0sgCtrS/PSO+2+Nw=;
        b=an53P3tUtTC1X4quRk5lTJ1FAgJ8swoWn8x4ivoFX0Y7AtwbzKzhpbyiks5CjhBlKk
         XvENEYRkIj3r0S/VkLWyP0nT6DcyTfh1P8QaWnoxQSxRXfUiPacJEBJyF8DHibqn1NJK
         7sqtV22XKQN2IZHbLAIaCCjdSSmeosIzgLRTp7gdJizmJhqqSvM5ysf4gGLa1NteRA36
         EVCc2DwFiT3qxwtdwHvGWXrXRtEkAt9187cH+moQ0FBWq9RME3uvFlxtwoACfQaKwmCC
         q/QbiKNRSM2HploL6UQlczAFRzp0s7PQMRZb69WZQC2ImVY35eAWbLS0G6nTvYtnSUuo
         5JZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbeCZR2g (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 13:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbeCZR2f (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 13:28:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147D22177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 13:28:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/21] tracing: probeevent: Cleanup print argument
 functions
Message-ID: <20180326132832.70e1797e@gandalf.local.home>
In-Reply-To: <20180326131733.ac156981d82c4a38dae307f4@kernel.org>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129047203.31874.3188700720826213215.stgit@devbox>
        <20180323123647.4398ae48@gandalf.local.home>
        <20180326131733.ac156981d82c4a38dae307f4@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188722013958666?=
X-GMAIL-MSGID: =?utf-8?q?1596022132987948821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018 13:17:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Current print argument functions prints the argument
> > > name too. It is not good for printing out multiple
> > > values for one argument. This change it to just print
> > > out the value.  
> > 


> 
> Cleanup argument-printing functions to decouple it into name-printing and
> value-printing, so that it can support more flexible argument expression,
> like array type.

Ah, so this is a change to make it possible in the next patches to do
something more? I'll update the change log to your above.

That makes more sense. Thanks.

-- Steve

