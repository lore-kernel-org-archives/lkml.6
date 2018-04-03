Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+E5sLCkbPaDTRhOLKoEHXt9aWhHmmctOVQo+1qOfvVy4oiqHIMUciBp2hoqF8hUTi26QYB
ARC-Seal: i=1; a=rsa-sha256; t=1522766519; cv=none;
        d=google.com; s=arc-20160816;
        b=aDLcnrRKYMlfqMH00Ux5QWL9J8IOWzn9KssMuXbzkCXQBCpWTscMgilZBmA8WXm0rA
         UwgO5pWzhjFBdQ7diBRv7Jb+3StUB1yqy1WYHEzfz8+ymkhOenls5Gk1tGnB9bGjWVQf
         ffmdW8/Uhr+Gfo9dChxXKodlJId8qiCV5LnykBwGyN1prGFkejSwCAyMK/RfMc8rrGln
         HT7qmY6SLHbv3G4M08MxmxYEcHYTAwV745FFT0IweWATHwllsUP3QG8zaySfVpzab9Pc
         oegwtgmfwVDYatfrugax4VC8R8A3jzZVKQ+/hkUQzy57nG4dc/WdU+MTlsMbUY5us9/F
         PAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=Pu2Z4sw0KzdjlB75ppG/9D7kiQJda0y3Tl9wMa8e6vc=;
        b=OxHdO+KQRF8HgGpvIqKds6k+KbZP/bxog5n1AU5wFr0yM4LaS7N+csX0x0RGlotieD
         cyimyHL7ZPiH4R9AjVP1Q7WQQs9HaGsY+hDj0Ao7seE6R+9nyDoc+6biNUtV9ij97khR
         MlwB7eeK92iWCrKpl9h9HW97gUjdolR5MB8T3ha/lBG6BPzP24nGqt0Zi/JrFyfeaVkY
         p7/462NTsPZWw5RHTH6+QGyo4yXE+nuC+fE/fn98ZJ37+LwW8dBc3XRErCjb/kX+i65m
         OZt+mBZlbKDW5C1FEc23tAAY3XZ6X6yCvm4yew2/+/0SGSwIc0OB/+H9eb8LkkDKIPiR
         9RYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDCOl6 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 3 Apr 2018 10:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751247AbeDCOl6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Apr 2018 10:41:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A920CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 3 Apr 2018 23:41:53 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 10/21] tracing: probeevent: Return consumed bytes of
 dynamic area
Message-Id: <20180403234153.7bd44567305ca11cead0e35b@kernel.org>
In-Reply-To: <20180402160207.23c96309@gandalf.local.home>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129069244.31874.7879658400858676349.stgit@devbox>
        <20180402160207.23c96309@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188955089509902?=
X-GMAIL-MSGID: =?utf-8?q?1596736425875868748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2 Apr 2018 16:02:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 17 Mar 2018 21:44:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > -static nokprobe_inline void
> > -fetch_store_string(unsigned long addr, void *dest)
> > +static nokprobe_inline int
> > +fetch_store_string(unsigned long addr, void *dest, void *base)
> >  {
> > -	int maxlen = get_rloc_len(*(u32 *)dest);
> > -	u8 *dst = get_rloc_data(dest);
> > +	int maxlen = get_loc_len(*(u32 *)dest);
> > +	u8 *dst = get_loc_data(dest, base);
> >  	long ret;
> >  
> >  	if (!maxlen)
> > -		return;
> > +		return -ENOMEM;
> >  
> >  	/*
> >  	 * Try to get string again, since the string can be changed while
> > @@ -854,19 +851,19 @@ fetch_store_string(unsigned long addr, void *dest)
> >  
> >  	if (ret < 0) {	/* Failed to fetch string */
> >  		dst[0] = '\0';
> > -		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
> > -	} else {
> > -		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
> > +		ret = 0;
> 
> Why do you return 0 here and not the error value? You return -ENOMEM
> above if maxlen is zero.

Good catch! it should clear dst[0] and return 0 even if no buffer remains...
OK, I'll fix it.

Thank you!

> 
> -- Steve
> 
> >  	}
> > +	*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> > +	return ret;
> >  }


-- 
Masami Hiramatsu <mhiramat@kernel.org>
