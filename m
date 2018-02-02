Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AH8x226UBnWNfp1G9rk8JVwQyKC9mkX8YiNioZOghLRFcpIfm/6ZinLZeIONswt/ZrSn6rSskkqL
ARC-Seal: i=1; a=rsa-sha256; t=1517604813; cv=none;
        d=google.com; s=arc-20160816;
        b=S71dwd+/s7R7dqaP33xi5wXmHl0gS1dIH8DejSAuMACZUWwOv5YBBpEoZdtZ1wbuP4
         lWPzURYmSV6LFpVEN9FMCOTkOuUmxMsNgPZwBxEm/3GT0g0pLFwkNrXqwG/hBaktwwbC
         9/A8nDVau6KcmjmEajAKhI6/7/sYauyibR6uWDjTsfA60U1XchLVa75DIJr4wa6SWA6w
         mZcjxRk5BN+paIdtKhJa8DNodqE79J3Wx1PerooEzeVY8gSu0zyLSkpLWspxjzqnjjZL
         s3WmgTQzihEs3rEySuCh11XrtkmkAGeYAl9GqGfEJ37CrM5epcj7GlSXug+cHc44LfhW
         ofSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=waAsJN1P4brNpZ44IBloX9p5NhK+kS8d9aLA0E+SGy0=;
        b=nj6+TWr1kciAb4hnCaHDIn4uGY/iehfD9Ew8iMKCA+VXYPkLtmELaPSaM8w+4iGXhB
         hrkFVuDKHM7jJDRFV3pbU/RhA2yeAmM8/MGfCsdmwIqfXV3fXq1VxuHL5f/BGPbQc8yl
         OeUUxMPJ53lR1zY25JJEcqMJUyAJLSLIP0msX6wPv+XTqoiDqO2C6+znVT2d7bRJnlwa
         n1VrR7eFfTRuMXCOwmGntYkDchSlQAE5KY/sRvwSyhwF+aN1FU3pIou3lDqS8DXPEl1+
         ye1SQrGz45k/2c8gWR+IoSyOy4ZMUIXXtCcp1GnbNNdYfj5FkPBSgFY0RW1NUqIBgdYE
         4HGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Fri, 2 Feb 2018 20:52:58 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        KarimAllah Ahmed
 <karahmed@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Asit Mallick
 <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van
 De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli
 <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima
 <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH
 <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
Message-ID: <20180202205258.2819b14f@alans-desktop>
In-Reply-To: <20180202202857.GI28192@char.us.oracle.com>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
	<1517522386-18410-3-git-send-email-karahmed@amazon.de>
	<20180202174932.GR28192@char.us.oracle.com>
	<1517594544.31953.62.camel@infradead.org>
	<20180202195601.GD28192@char.us.oracle.com>
	<1517602575.31953.74.camel@infradead.org>
	<20180202202857.GI28192@char.us.oracle.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591323985482986660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > No. The AMD feature bits give us more fine-grained support for exposing
> > IBPB or IBRS alone, so we expose those bits on Intel too.  
> 
> But but.. that runs smack against the idea of exposing a platform that
> is as close to emulating the real hardware as possible.

Agreed, and it's asking for problems in the future if for example Intel
or another non AMD vendor did ever use that leaf for something different.

Now whether there ought to be an MSR range every vendor agrees is never
implemented so software can use it is an interesting discussion.

Alan
