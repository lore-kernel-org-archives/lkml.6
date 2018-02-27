Return-Path: <bigeasy@linutronix.de>
X-Google-Smtp-Source: AG47ELvBQcAgTYI9crfXm03061knl55308zEO3bMaF3DCBs9lsTpia4BaQGwojcd23pL+KMB4Psw
ARC-Seal: i=1; a=rsa-sha256; t=1519760166; cv=none;
        d=google.com; s=arc-20160816;
        b=Pr1BPQZSTROfRK1oz1wr/+WXyN1I5iUJvG0mXPhMu3OouK6+gk0BwdmbYA58RuG79N
         Pp+X1hNEsBlD1dbFhQ7NNBR14E5mklYPkEShkcfrvPF5e0SuI2cQF5f6dA1C/R1SVnZg
         15aX6UL0RSpn1DtTTBai0Z0bguHsP8/Y8ppjRbn7vrulsSTcFhNW9YEr7k+IZEsUbS4A
         54SMkJaF9eVnX6DVbY76dlg8nMOzEdW8DTEA26y++aWvhMoaW/fEFoHKrU8pINw6aWy8
         N2Gb189VmJtHc1DPq5aktPlxPH9QggXNDFTkpHjgXQpyBPHjm2t6WrMGTMwSkzBjkJMZ
         24qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=eUwUzlhnEB9W94trysX1gz8E5NI7orMSmBnmUiwAXYo=;
        b=i5gOYeKYZFrEVHYUTEJgQfBzlM8fiBHZeLOC7uUShiYcMXiKziTfPe+VjGxUOQ5coG
         45/Y1+a7w04aGW6csH+4WMZEowH8Jen3qx2BnXcrHQNP1tXiZKxwEYFLFoJg6Fzf9o79
         cxMCm6V4RGjx2t0Rw3A/sNq+2wuENW9m+ic7k5qMdCMkMfG99l0CkFVcKdQ/CiQ6nUZ9
         vWBEWYm9KFovBvqyYuKNGaJCipCQ0G5GCPtQKUQUxFNUnQK0eTewhdvvkuCzoxFtLXWD
         Kmd9011N0c/Vd4pkS2WrICgWr5mhJuy4DN32Wwjr8EdpY9KQsb9ZU0AQ3rEXoX2iWfQ8
         5NKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of bigeasy@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=bigeasy@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of bigeasy@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=bigeasy@linutronix.de
Date: Tue, 27 Feb 2018 20:36:05 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gary R Hook <gary.hook@amd.com>, "Hook, Gary" <ghook@amd.com>,
	linux-crypto@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
Subject: Re: Can a driver->probe be called for two devices at the same time
 (WAS: Re: [PATCH] crypto/ccp: don't disable interrupts while setting up
 debugfs)
Message-ID: <20180227193605.nhkagbqjkadqqruo@linutronix.de>
References: <20180223223307.18882-1-bigeasy@linutronix.de>
 <3f0e1a62-a7ea-6d0c-d305-67080803aefd@amd.com>
 <20180226083508.th2m3xssp36lx3zh@linutronix.de>
 <372b353d-017d-a72c-b750-9417f6265874@amd.com>
 <20180227173314.uko5xpf4od2fn74g@linutronix.de>
 <20180227184034.GI20601@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180227184034.GI20601@kroah.com>
User-Agent: NeoMutt/20171215
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593576313003977918?=
X-GMAIL-MSGID: =?utf-8?q?1593584036248584573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-27 19:40:34 [+0100], Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2018 at 06:33:14PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-02-27 11:08:56 [-0600], Gary R Hook wrote:
> > > That issue remains unclear to me: Are probes of PCI devices guaranteed to be
> > > serialized? Observations on my CCPs says that they occur in order, but I
> > > don't know for certain that serialization is guaranteed.
> > > 
> > > Is there a definitive statement on this somewhere that I just don't know
> > > about?
> 
> The bus enforces this.
> 
> > So the question if a driver can probe two devices simultaneously.
> 
> Depends on the bus type.

PCI

> thanks,
> 
> greg k-h

Sebastian
