Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AG47ELtpTxwaep5xNafBd0nB0HLDRi9AIroJkv8uxWRSTicRd8gAVI96bxY2bwKtGdRqaKq3dKGx
ARC-Seal: i=1; a=rsa-sha256; t=1519754000; cv=none;
        d=google.com; s=arc-20160816;
        b=BRJtu0EbCY4MIzETWfuvxylHPTj+OHeFUwJ+xWJOQb3AQkY50gM/YG4S9ZHS53URLO
         kVQwW/CjQT7KEKq5Fa+xqpc8OdA19tRfHCxCGaA1D9++zqWjJFHiELvDVHi3zln/Ncl9
         rcX0dizO6TLIboNDcKLZEcxA5tkB81+lPzABcdZJ8+/0vAJ3NnxuHn5J2PxyQHH3s8Xz
         XyThPYfU70NULY4ImFzC1r3RJkFuiDsSfhEcy6LM5S09Z8DO0QT/6QXiXt6UHl5mlLq7
         KtDiNWaMslCK8GT2xrCxfVpzttB91mi2uAiLIWR5K6s9uVpJKqhvtz8sEkptaHt5CK5S
         icHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ENhOv/Ac1pk9aOx0DzMI+Zv7F8Sfua+V6Ap9CMQ3SLQ=;
        b=BzODnSsfq7DJr7CXUliB6H0aFJDYZ9HV8nbNfqBXlwLXa2xOXz3aHJpNxoEYOpHzWq
         bA4Cg24lXBp0BuYnUhrpWajs8xjSVNFhm2PDjwSRShwC1dEb6cu8F4bBQc192ZQwBMyv
         p0+2rJidTcFKWCbIDaPLDzC2RzTZCAm1dpsykp+V2W/C8zL60WNlrzCncjfr9tYA65hA
         P5F9TAo/yUKYJZw0rUdt9lIpTyT1pSHkFQId97dvVuofic3neGJnv8cftq1RFvdYV49p
         k2BOVr//kmW+gS9EjQ25NmwXRQbS05CHhWOVi5vIVneLeSGiHAwpmR4VYxUh5qcETAku
         7sOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 27 Feb 2018 11:53:19 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT pull] x86/pti updates for 4.16
Message-ID: <20180227175319.7dszqmit57p4g47a@treble>
References: <alpine.DEB.2.21.1802261358090.1896@nanos.tec.linutronix.de>
 <CA+55aFyJstnk9Ne-=0Stbo6dPo0nDnkGNJMPEMhP9TdDZ5xeqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyJstnk9Ne-=0Stbo6dPo0nDnkGNJMPEMhP9TdDZ5xeqw@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593470100080212890?=
X-GMAIL-MSGID: =?utf-8?q?1593577570928701861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 12:07:32PM -0800, Linus Torvalds wrote:
> On Mon, Feb 26, 2018 at 5:25 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - Teach objtool about retpolines and add annotations for indirect jumps
> >    and calls.
> 
> So now we have that
> 
>   drivers/watchdog/.tmp_hpwdt.o: warning: objtool: .text+0x24:
> indirect call found in RETPOLINE build
> 
> upstream.
> 
> Is the hpwdt de-crapification patch that was quoted in the discussion
> about this monster lined up somewhere?

I believe that patch is still under review:

  https://lkml.kernel.org/r/20180226032227.14615-3-jerry.hoemann@hpe.com

-- 
Josh
