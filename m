Return-Path: <SRS0=4QCZ=GE=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELutCZoQBUHIecnwYEb+nL0iBc/zNbnSRmov5TftNuA8S+FSnOkywZj1IJzO8zSzB1w/qkA2
ARC-Seal: i=1; a=rsa-sha256; t=1521064693; cv=none;
        d=google.com; s=arc-20160816;
        b=HRRTUQSO8eJNW4NoHXxMuEdCLnt0mWBL/GFiVNu9gAHBinXy3gyrZWxTVjGZP46uTt
         gxyvtAqNlgIQqPVvN1e2xvPRUrhDwu6goZ8HlLk967/MEKmPkM7QyeJ/oNUuNHzVGj1W
         t/QCQ/jKWoLXRQzU50hKgc0HOsr6xisQyPLuIKZRQD4KV4COTxB8inMiRdVsEbswCG1m
         0a549CKqQraqkRqBsA6CnFHtEPRIkiMzMkmbAGFNI5mIC4yzUVyuYgvTaRncrVpDzT8R
         BCSqCf4wA4BMHCcrvgJTvYryGGiwf8fT5X/7byUy+RnAHiy4wRU//q+4eNdrvsTB6D8Z
         /klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=kv+RZO3+wDeOMLV2pJT0qDpTRRw58JJNqdAmvBd+U4s=;
        b=ZyiVUnLsRdHYdiOh0kmNJnmpV4+bWGI6FE0KctsLlwrmNF6bSFjLdcsh77TGhD1vrN
         +wIlCvTIgFb1XSu3qLjba8NN11MhNGX9rxug+9Os/crE4ipqboo01pB+3e5agdp8aasf
         Nqjgn0wStzg1FjA1Vn/GDw6J+zAa67ueYEtSIT4LM/mGiaOpINIwKnpuNYtwcVlAEQTa
         1Qn5HKcTN2iZ6julpxLoVHB8aV0tfUo6IE8/u9MUFAPYbMeXyI0BfzWYZ1rF8v+UV5kr
         YFjKqYsf7ifmodyvWhC+Wu8S1QHBwCEGLMYn1X7WHOfo2BPLRZcP3fYUCaj7Sb/i6Feu
         brvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4qcz=ge=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4QCZ=GE=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4qcz=ge=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4QCZ=GE=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BAF204EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 14 Mar 2018 17:58:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 srikar@linux.vnet.ibm.com, acme@kernel.org, ananth@linux.vnet.ibm.com,
 akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
 alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
 gregkh@linuxfoundation.org, huawei.libin@huawei.com, hughd@google.com,
 jack@suse.cz, jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
 kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
 kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
 tglx@linutronix.de, tmricht@linux.vnet.ibm.com, willy@infradead.org,
 yao.jin@linux.intel.com, fengguang.wu@intel.com
Subject: Re: [PATCH 5/8] trace_uprobe: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180314175811.1ca7d830@vmware.local.home>
In-Reply-To: <20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
References: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
	<20180313125603.19819-6-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1594951931801587996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 18:26:00 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

>  include/linux/uprobes.h     |   2 +
>  kernel/events/uprobes.c     |   6 ++
>  kernel/trace/trace_uprobe.c | 172 +++++++++++++++++++++++++++++++++++++++++++-

I'm currently traveling, but I'll try to look at it in a week or two.

-- Steve

>  3 files changed, 178 insertions(+), 2 deletions(-)
> 
>
