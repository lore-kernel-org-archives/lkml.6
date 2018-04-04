Return-Path: <megha.dey@intel.com>
X-Google-Smtp-Source: AIpwx4/9tMVIdeTDr5Spt1BQTGMEurl7x4CygHef6o6nlP9HaPjqfcjLadX3H2SsHqXj804VFdyo
ARC-Seal: i=1; a=rsa-sha256; t=1522876596; cv=none;
        d=google.com; s=arc-20160816;
        b=dVrdjQOCVWGhRwarAeoNRrXxn73PC3brzXwcISboZw/0XX2Txnr4Fr41Uuxiw72qXe
         o/TpzDVCAorUxchCt9rCxWR/7biSsT1ZCPrbiavbxJ0F1AqX0tNCbyTY6wOch93Vik2I
         zTaKO16/CepuZo2wGWbkZeqWIezP9kxYr1oGwNkZWns4acRCuhwGRwYxx87qWTGW+SWg
         fqfZAJY5rSPg9CDPmBud+o94pQi4v1iOQFO/eMMDWkVz8Rn8zR5XuKxbHDcy89HIF9xz
         aRN1df8iakxcpOjyxRaEcoPA6bTDrLMwrmSWKYlZtTLt0Lug+dC7aBT46GjI0jC/P+/K
         D2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=KDprv6LwnHe+s9vmLVhWUKUuNAV8roy0DXXnG7dz7a0=;
        b=Or+ayFGELO2i5ZDOsdrKcf+ZDQanr9vEIymnBKSHVSKt7SRAUPYgeikEpWrn9mdzcj
         zxaNJGyYoV+Bx9dieyXfuVbE4yw3C4VjPsFNhDDpHRwBjuij/c/oio0vh9JZBya2YgbD
         bYvC0fKywdur6LgWabVdzFbo1iuQrTAXLkfKRtsTD45fvhxAgbcC8rNzv30mpMAtGbhr
         dFu8xieI0M+6dhG8lI9M21sxaUA/tsI01LJnVbZHtBOtoOmTUrD/+zdVc1v1ernZCnR8
         wmwP/zQe9C+t2FiKKjdZh6B/CB2nw2VJjqvXZyaa6zuRX4l+ohTzRb+MIu5LeQQWL62o
         HzoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of megha.dey@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=megha.dey@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of megha.dey@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=megha.dey@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,408,1517904000";
   d="scan'208";a="43499258"
Message-ID: <1522877605.3367.2.camel@megha-Z97X-UD7-TH>
Subject: Re: [PATCH V2 2/3] perf/x86/intel/bm.c: Add Intel Branch Monitoring
 support
From: Megha Dey <megha.dey@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
  tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 andriy.shevchenko@linux.intel.com, kstewart@linuxfoundation.org,
 yu-cheng.yu@intel.com, len.brown@intel.com, gregkh@linuxfoundation.org,
 acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, vikas.shivappa@linux.intel.com, pombredanne@nexb.com,
 me@kylehuey.com, bp@suse.de, grzegorz.andrejczuk@intel.com,
 tony.luck@intel.com,  corbet@lwn.net, ravi.v.shankar@intel.com, Mark
 Rutland <mark.rutland@arm.com>
Date: Wed, 04 Apr 2018 14:33:25 -0700
In-Reply-To: <1513805032.31684.2.camel@megha-Z97X-UD7-TH>
References: <1510970046-25387-1-git-send-email-megha.dey@linux.intel.com>
	 <1510970046-25387-3-git-send-email-megha.dey@linux.intel.com>
	 <20171120115714.hden247iet4bf2t5@hirez.programming.kicks-ass.net>
	 <1513113057.11361.7.camel@megha-Z97X-UD7-TH>
	 <20171212223253.wtvei7i6fz2h3dpn@hirez.programming.kicks-ass.net>
	 <1513120080.11361.12.camel@megha-Z97X-UD7-TH>
	 <20171213072146.7zbledeffvwskxx6@hirez.programming.kicks-ass.net>
	 <1513805032.31684.2.camel@megha-Z97X-UD7-TH>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584365964902153283?=
X-GMAIL-MSGID: =?utf-8?q?1596851849326828088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2017-12-20 at 13:23 -0800, Megha Dey wrote:
> On Wed, 2017-12-13 at 08:21 +0100, Peter Zijlstra wrote:
> > On Tue, Dec 12, 2017 at 03:08:00PM -0800, Megha Dey wrote:
> > > > 
> > > > There's work on the way to allow multiple HW PMUs. You'll either have to
> > > > wait for that or help in making that happen. What you do not do is
> > > > silently hack around it.
> > > 
> > > Could I get a pointer to the code implementing this?
> > > 
> > 
> > There isn't much code now; but it could be build on top of the stuff
> > here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> > 
> > It was mostly Mark I think who wanted this for big litte stuffs.
> 
> Could you give us an estimate on the amount of time it could take to
> implement this?
> 
> I am not sure what the current status is or if Mark has been working on
> it. 
> 

Hi Peter,

Is there anyone currently working on this?
