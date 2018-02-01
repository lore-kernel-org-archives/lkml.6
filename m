Return-Path: <tim.c.chen@linux.intel.com>
X-Google-Smtp-Source: AH8x227iUaDs6+2NpH1CDn4Y5XAxVBU9919dRq5cPVePNBOCqqsKFTW8qNQ7AtPNxECyfMbYJ6i7
ARC-Seal: i=1; a=rsa-sha256; t=1517508985; cv=none;
        d=google.com; s=arc-20160816;
        b=LMXvBArbgqwwmfockcrP2L9onXzJcofgRXhzl7gFNIoNffzm5FgDRnAT6R6i4/ZMc8
         w1jRIZL7oEsjp/T6Bt1eknjrE8aGsQFoeadh67ER0/3Rbl15CqHyEFbT/KXMvvMDKvOx
         2BhaNrloYux6uoq7DNQP/FadT+p2mRihjbuR3GK1n/MwSilv7YG3EXIdWsTH8VKxEwOp
         xo8aqX9vg6LaVmpeD89T2sTZyhjD2heUQbD5teTtTxSBJxfuL23yGac7GyqGkZqWJ/zj
         CdXAkTgwG+1J4R3Vf2J0p5iVA3/6CdLWxQh8n9CI9d/Ck0DCs3ljgrxsmpXAMB3w5ydz
         8TRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=IF3yN7UyzkTrRqbDRgbYeksoaZUwiKMioJ6gju6VIsY=;
        b=htKI9PKxxUsON/XPtSSLiw/ehRl+qLXjQyY1FyIWkk/eqx1sRb802WosnO4qXlOSjZ
         FPnctMgRNHJqLm6OMACtWc/Ed0xuZLwlgcIyx+TB/GO8lV6MfM43aST+3horlez6uh9d
         T8avy6wEDn7kvGPLCHathWw3j48UZWfwjZnb3nkD5w/6LXVxR3PINwTvaGwAwZxJ060c
         wMedMUAiC7H33IYVgTZUVa3w4mPLiFuOp8DF2O32ei/DFzocsLsNDGABTg5gAIC/rsnh
         NEgWdqdPMvCngj5lLnQo4+Uq//AIhxvNmblUmI71Pk+UPMaBnCNcGaoCWPYcIF9jQugE
         q/lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tim.c.chen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=tim.c.chen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tim.c.chen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=tim.c.chen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="27322925"
Subject: Re: [PATCH 0/7] objtool: retpoline validation
To: David Woodhouse <dwmw2@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jun Nakajima <jun.nakajima@intel.com>,
 Asit Mallick <asit.k.mallick@intel.com>
References: <20180201143421.088202488@infradead.org>
 <20180201152856.okzhqvdlledykzps@treble>
 <1517499131.18619.317.camel@infradead.org>
 <20180201154028.GA2249@hirez.programming.kicks-ass.net>
 <1517503895.18619.319.camel@infradead.org>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <8726b17e-fcc2-be69-d75a-9e7e35a807d0@linux.intel.com>
Date: Thu, 1 Feb 2018 10:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1517503895.18619.319.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591223502165040214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 08:51 AM, David Woodhouse wrote:

> 
> No, we just need to set IBRS before doing it. The same applies to any
> EFI runtime calls, APM and all kinds of other random crap that calls
> into firmware. I'm not sure why those aren't showing up.
> 

Dave,

Are you planning to update your IBRS for firmware call patches
and repost those?

Tim
