Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AH8x224Y76bCp950TrI2Yf0PuQ06E+aVSVZUBpinUh3TPYc+Z2MK0/dYWCpwKgAhfutG6UbLx+54
ARC-Seal: i=1; a=rsa-sha256; t=1517498939; cv=none;
        d=google.com; s=arc-20160816;
        b=Jy9+y013UxBe6Us0m4/UdcKRw59/4bJTzalSSWNxFUvH8W+A+0JMasFOcSxpnx6fMh
         z+egDJmkgdvCCJn4gnGVVKqlGSD1DLeNHFGssRepdq/5iWw9x0ctJcn2kLci4FcOyhoP
         TvQjRexSfffBuOQy1mRWxBE6OxK1Cubz0gJvPNif9C75g+ZSop7GlhjXvncPjHE8aq+k
         /Lh0pNisjaCoj+6kWpI79io4obK8qLQqgUpwmYyJrCY1qbjHmqjUp0AT10wVXY9/spMZ
         ALgBREtvYXnS71neFzoyWY9JG2oN5JwGxJjxtbHQP+dE5jM16IezxKcSB53PG9s0SAng
         v+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6a/MqQac8pi8+iERB/UQXMg6KrhJhU2yhWSaPqk6pj4=;
        b=zDLtVDM/c+UU6IzDabpvgO7Xzmm9fHud1Amuf/dEl2Gbqbdu24N2iPt8H2ZgX1kwQl
         v5uaInCNVypCnUFmTpQMv1yz47wSTD7LvB/7vMSGTDntYYT3bNARkKnhOKmvoWyuhmHt
         LAxKeQROiUP3ivZ19dYAzyOvogHS31pQyaKdlSDYPk0zyI14fPePInyQZ2JXKJJI9Kwa
         udErbe1iBupt7+twciqdoHuXCqvfgAbHXihvKpSB9dVXxloGW35MiHcfTBbnyq0LnKtU
         XuI6O/IViUPGM8NyCbccMxpnOswVwDCQP7aBsx8O2RGsHRM4w4fnDM5hRSVrBsUKp8mO
         pCTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 1 Feb 2018 09:28:56 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Asit Mallick <asit.k.mallick@intel.com>
Subject: Re: [PATCH 0/7] objtool: retpoline validation
Message-ID: <20180201152856.okzhqvdlledykzps@treble>
References: <20180201143421.088202488@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201143421.088202488@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591210454988302775?=
X-GMAIL-MSGID: =?utf-8?q?1591212968172939793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 03:34:21PM +0100, Peter Zijlstra wrote:
> There are the retpoline validation patches; they work with the __noretpoline
> thing from David.

Have you run this through 0-day bot yet?  A manual awk/sed found another
one, which objtool confirms:

  drivers/watchdog/.tmp_hpwdt.o: warning: objtool: .text+0x24: indirect call found in RETPOLINE build

And my search wasn't exhaustive so it would be good to sic 0-day bot on
it.

-- 
Josh
