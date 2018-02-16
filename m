Return-Path: <ak@linux.intel.com>
X-Google-Smtp-Source: AH8x225IwUfemmiJreI3ATdB8KApgnKj0b/VuckxqLGG+Wt+atTbhC4ybMQ+4oJr8Y2wtjRzjQY2
ARC-Seal: i=1; a=rsa-sha256; t=1518754945; cv=none;
        d=google.com; s=arc-20160816;
        b=Hv27ku2VsnSljghE7L2lfA6U24XmZ62EGkWKGybRGQ0xAwIn3I77eMFwXlbXhgtspO
         /z+Yq8PIEJyLiKwlZnKq70NuyQez2gipN95INFewS0B4pMksgHSfw1Xqq4nRYSS4k2eV
         o8xf5Hm0JCpte53EnYp4CGeyJNiQONqPOyPJ6MN7tq296anTN3v1HaemK338ojSSKYZd
         yisoggq/OX92KHwOygvkvvIUagiVBuXtzYAIS9cQnrSG4YFqJYDhRgX/9vUjL/Zgr6s5
         DTIMkbjBTsjtd9RPCg6L5KTwzdedzH7+U2SNDG/2srFvXRkc4L0lqEjs9ig1/TsBvLh8
         MuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=R55c5WrXh3A+ehGDUdHqNzhrCYmQ6h5LGHKhuuULZQc=;
        b=PHTP8gaTWDzTviS/R+0/+L+8OkrRyEvxA8+o+PpJoOLS7m3Qt3nzzKM4ylW6Rla6p3
         RSQnYT0bcpRBBMBMAtQLJ6rYqh7+xMoquNl06nNIDEhY1R3lnNtrxtJy/CxMiYq130dw
         wGKfjBCQiv+ePRR/6azeUGnG3e0ok4bfyGmdD/XbqsaiwSiLJ558OjVTawFQa2fdRj8d
         xZRxXU/XwvfSsQmf0iMPGt9V/7DEbLqB+7p4V3rG7EEro9U6SRRBvwCjaNFR0WuK5dTq
         0gJo1j4nul6qfzovWx9pcpAZw+wZT+yF/Xn2aTcltj+eJ2kTbVFHQuky+XE/SX2j3YtH
         Yu6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=ak@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of ak@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=ak@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="35208577"
Date: Thu, 15 Feb 2018 20:22:09 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, kvm list <kvm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Ashok Raj <ashok.raj@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
Message-ID: <20180216042209.GB3231@tassilo.jf.intel.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <CALMp9eQEjaaK=RDZ3OFL5+fq78nWRrpVO-KJ8ruosV9vWjfW6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQEjaaK=RDZ3OFL5+fq78nWRrpVO-KJ8ruosV9vWjfW6g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1592529985611442686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > +               wrmsrl(MSR_IA32_PRED_CMD, PRED_CMD_IBPB);
> 
> Should this be wrmsrl_safe? I don't see where we've verified host
> support of this MSR.

In mainline all wrmsr are wrmsrl_safe now.

-Andi
