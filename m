Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AH8x225m8yPzJgRbs+lL3ZSNIzXJ1rqGEr6fS2Y4CqcpiocWB0dzh8nx6p4t5OqJk2ovV2rir4Nn
ARC-Seal: i=1; a=rsa-sha256; t=1517504426; cv=none;
        d=google.com; s=arc-20160816;
        b=vpapqbzCszL0wSNW++sedTGTrRC922I+dbPn6fr5kSB1KdaqHnmsuMoxw/IlPNT4iw
         XN0TlloLtXj6oTTSwHGub3uH9SpnofyY0DbqcI1Yqdb7TV+0NWKbEUB7UcmUaA1AtClw
         Xn29r7rjw+Bcxp9GG+9V3yWPrInSBFnMd9IgAwA5saIMsXLxt0zeAaYd07lyBfbofenp
         kN9GKGN9REggD0Uv4CUE18xA7maj7iTwxfQFDZcF2B3ZMCDWVIOsIpxExeAlgCXN2hbd
         hRT7JFGX42x8zv+y4uZo6wj/VIYyjgZ25q85tSMfXX+YS4g4D6GsGZzsc+4Q5qLYjtyW
         YY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XRrJna2Px7cqIEGdoAgR1RZ5ll6h08b2LqLI77mk/CM=;
        b=p9rRFCgkUFK+n2YZu+l8lH5Tj32x7uqlpHyRxdlxCcgiDFnUeBoNYFtfhoOyxewjMf
         1ecoGBlIcnzSIUDm5e2Fy3LZ43D9OOM5lYqf+cKcKqfzXVjuejgBqVMxAxQgre5VnSK6
         +3wxDKfcZp9AADs0CJjFH9M29nAWoUqwSBJ8vACIGZ4Zq1iqKTO0ov/NNq5RFBSL2IWf
         lOa0PBgR2yeOpKqshIxz/4efN73BSvIEQwIFAcxzHHl67r1Rx4YZwY7yPhzwBcq+tuw5
         X4AHgZS7sLCwJN9WOPB2VbEGh+qXqLaCZFE/tm/Nvn2ZKP5x8e0L3dDhDbqo6trxMsLL
         f9EA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="28071003"
Date: Thu, 1 Feb 2018 09:00:25 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v5 2/5] KVM: x86: Add IBPB support
Message-ID: <20180201170024.GA30307@araj-mobl1.jf.intel.com>
References: <1517427467-28567-1-git-send-email-karahmed@amazon.de>
 <1517427467-28567-3-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517427467-28567-3-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591138068251830751?=
X-GMAIL-MSGID: =?utf-8?q?1591218721897675023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Karim

Thanks for cracking at it through all the iterations.

On Wed, Jan 31, 2018 at 08:37:44PM +0100, KarimAllah Ahmed wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> The Indirect Branch Predictor Barrier (IBPB) is an indirect branch
> control mechanism. It keeps earlier branches from influencing
> later ones.

It might be better to split this patch into two parts.

- Just the place where we do IBPB barrier for VMX/SVM
- The msr get/set handling to comprehend guest, nested support etc.

The first part should be trivial so it can possibly make it into
tip/x86/pti branch sooner, while we rework the feedback to 
address this completely. 


Cheers,
Ashok
