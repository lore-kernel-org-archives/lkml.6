Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/aCF6NOHocDyk8LZNKbsx3jpPOXluA1B7iimrrcwqnVE9uEA02DSq73MmdsOe/oApuJRz+
ARC-Seal: i=1; a=rsa-sha256; t=1522036426; cv=none;
        d=google.com; s=arc-20160816;
        b=R2P8wf75YZep+OHK8GOrHut/gi8LhJwO3cJXEwlODzYbzSHUFqBFXY4wFVaVw+ycaO
         cnH5CMIuiCfLceBGy3T7fMObxVsngjagkey9fn6ROJrhk7QAGOCHGrmZ2lFd1dfYtYh3
         0o2AqRf+nZ8O/EVVLdXqwWcrqNzEk/HnjtUoYB+jgx8cqMfiRHeliS3yU0rb41rKpFZB
         boBr4v9LOsr4qvPY5odefUTjTaT+hbrZI3JJ0ONAdrvylJzjDxMMMMz23rzdMa7sPe1A
         l0rC6FIXWgOxmJ0HWYCAVaBePgKoe6lZ9I/uoKzSyhM/KN1lWSByuKTFraM/fFlByCkO
         hDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=DDxSaghIJ16MpG4A/e2HkTaMwZciL2Yy/xSgUbePUEQ=;
        b=l9qP9MLQSE7FmutmdRHrdUH6+EC2WCdKBEFvELblxaV1UngM8870xHyW4g4EvVvOdy
         UCGdinAo7hMOQpqa7zggvcjDnycEtpcomnaaSPO1gh44+Dng1saRvPdTAokrvHAue5bh
         7lAHvdm+RMpVQiRpAbTTv5c3wjSpVkIHXXmWb0EUtvKEIM7AqSZyDFiz61Yq4UmXDLWx
         WHkLuKMHJ64d5vZSLxDnjuzuB1fo07a9U4AyogmSilUfiMdeW5OSUzPe7fwk7/doTrd1
         eVl5l9R24O9A6rD7Tdc4mpY3B9t2aWk4nqGNMUyRe5V/IBoguWU5CbIHaEH3UkGABBdc
         dd1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeCZDxq (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 25 Mar 2018 23:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZDxp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Mar 2018 23:53:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221021749
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 26 Mar 2018 12:53:38 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v6 21/21] perf-probe: Add array argument support
Message-Id: <20180326125338.16f9eeead34feeb86114ee39@kernel.org>
In-Reply-To: <8b3ad72c-f28c-8fc0-32b8-4401dbe16358@linux.vnet.ibm.com>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129118998.31874.16273532808298489908.stgit@devbox>
        <8c02c538-4934-59c2-7795-9058ce57e625@linux.vnet.ibm.com>
        <20180322182347.ca1aab9b77ab4c351100646b@kernel.org>
        <8b3ad72c-f28c-8fc0-32b8-4401dbe16358@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189477266437642?=
X-GMAIL-MSGID: =?utf-8?q?1595970868362191783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Mar 2018 16:19:46 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Hi Masami :)
> 
> On 03/22/2018 03:53 PM, Masami Hiramatsu wrote:
> > On Mon, 19 Mar 2018 13:29:59 +0530
> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
> >
> >>
> >> Is it okay to allow user to specify array size with type field?
> > Fro this patch, yes.
> 
> So IIUC, perf _tool_ will allow user to record array either with "name[range]"
> or by "name:type[length]". Please correct me if that's wrong.

Yes, it is correct.

> And If perf tool will allow array length along with TYPE field, I guess we should
> document that in man perf-probe?

Ah, right. OK, I'll add it.

Thanks!

> 
> Otherwise,
> 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> 
> Thanks,
> Ravi
> 
> >  The availability of type is checked only when
> > it is automatically generated.
> > IMO, it should be done in another patch, something like
> > "Validate user specified type casting" patch. Would you need it?
> >
> > Thank you,
> >
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
