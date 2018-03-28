Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/Kr6jCKi7p6xbcw5KfChxd1oDNBUclRKWPN9CwEZD2pBotZBegC81njSbzS/DQDRIAaR9A
ARC-Seal: i=1; a=rsa-sha256; t=1522210891; cv=none;
        d=google.com; s=arc-20160816;
        b=AaFCYWPZBUG08mEU0kOW72mDXajSHjL+MZT0OFqDS+F5mNrU/QxhsNqDpKnoKnc/9n
         ZT6haWqK6Otgxgm1N2dh8LK/B/R3hLTUcd9yGBgnuwUeE+dh+ZdeD80xZmQb75NqfPbo
         aY0JE0qmpuTmK2UtrhA051UpiOCuWSYaOHcZPTdNRFHSu39nbcB4oCaVzjRkm/rW0Jb1
         aZWpoVbbwrNcpmW2vEBxdzNzYxGumBSerKhrGnT2w+PH4rOJ+J+z6TY2Z5yN8Y7/focL
         lhy3Kioc5DTYtlezHj/tdh6u8Z0PSnsFmyztms1uuLHxG8kMOGopvpQx5ZnfjaaxL2U3
         rYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=G0ilZL9wAw95kVzTXgtfXFaTu7htu+a7rssYXaCPdO0=;
        b=it3//4lAXo2C9Zj6/5jtiau9B/hT0boWvIfJvqPKzp81j7etQ855maqsxMOJBX45P3
         WvlmXXrCkaTRBSqJ5UxyEJN50MWPMsfI2LYEETuCGpzGcrNMyNvkePreViKlcpPMS754
         ncLGE4iuH1tyBspZB0K3jTC9lxqhOpAOlfQSPwOHjABFFs95lLNHvw2HFfFw9CLeyZkb
         ckcAJWytBxX5XjNH/5eU2fDTOl3mETaTbfifl8nSrYoOduC95raMBRdoeUjvjqxqHFEz
         AA8ndG0ygu1E2PaZyCxrekyusHc3i6g3Hjd1sJ9O8hetDvsIBDqkuz8LNLqfOQ+ndwMH
         TpyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeC1EVS (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Mar 2018 00:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeC1EVR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Mar 2018 00:21:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9DD217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 28 Mar 2018 13:21:12 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 05/21] tracing: probeevent: Cleanup print argument
 functions
Message-Id: <20180328132112.c2d6662837e0e193796e83cd@kernel.org>
In-Reply-To: <20180326132832.70e1797e@gandalf.local.home>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129047203.31874.3188700720826213215.stgit@devbox>
        <20180323123647.4398ae48@gandalf.local.home>
        <20180326131733.ac156981d82c4a38dae307f4@kernel.org>
        <20180326132832.70e1797e@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188722013958666?=
X-GMAIL-MSGID: =?utf-8?q?1596153807380114671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018 13:28:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 26 Mar 2018 13:17:33 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Current print argument functions prints the argument
> > > > name too. It is not good for printing out multiple
> > > > values for one argument. This change it to just print
> > > > out the value.  
> > > 
> 
> 
> > 
> > Cleanup argument-printing functions to decouple it into name-printing and
> > value-printing, so that it can support more flexible argument expression,
> > like array type.
> 
> Ah, so this is a change to make it possible in the next patches to do
> something more? I'll update the change log to your above.

Yes, I'll update the patch description :)

Thanks!

> 
> That makes more sense. Thanks.
> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
