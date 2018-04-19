Return-Path: <kirill@shutemov.name>
ARC-Seal: i=1; a=rsa-sha256; t=1524382893; cv=none;
        d=google.com; s=arc-20160816;
        b=bgBrQq2yetNp05/VAwwEFnC8WSRTLrun2MtUYg94+h1f3hCvGMX7u6WnTRQZArXIsT
         XuMb9jaDHJ/yPzroXH57MxR1cye95jTWr5ghBuw43AHNKfEakyYlgB4PARKoskcyTaV5
         SCl8iEF3Bdw4FhgMVnH/kPZTAYWyIfzb3L1XdKjwJlIwZRhzz2P8jtS8cDj1U9OreEZN
         lXWgLtRbG8K8wiamlP66U7bLi8qqOqP7tfKsgm+Q6SCIJoyeGF/SEclhNHKu9CMQInsI
         RaWC/TVcEs0NfYMxEgg9p6gmBHyMjDm3kGy+2zdi52fiyt4MX6ORmi5NU+5HowvVXUaw
         0uXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=vaviOjBnACZVehy+k5C6VgaLradD842lXv7spOp0g58=;
        b=BVaRpeM2SCPuw0/xyxTViRQMXONhwa4hKQb+ycO6fD9UtXcILKOKwiH1dkG489XLRc
         nLHWsRlVI+pCiQ+Mrd6mrLlyBhLEJ5/VAms8dHV2NiIlbL9Ssb00MVGWl7SAIbZS7e86
         UEq/Si0mvwJ4VshbqSVZTsZx8HqsTdQlAqOu08CwFSqcKyrN9C/y2mcPRv4+XTfRxZ8V
         XDbNyTNZgQWxxH1Zws0vmblWfGwNZBGLkU5Ygrmxzv3k7yYfrfiWf5gREEUcJYvZriDI
         0KEaa4S3h4fI2wIlv4XY9LYUNJUBfnMvv/LEsx5iTLzyH55m/v2syM2wtww0cukiZZ/d
         RKlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=Sa0hpjSt;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
Authentication-Results: mx.google.com;
       dkim=pass header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=Sa0hpjSt;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of kirill@shutemov.name) smtp.mailfrom=kirill@shutemov.name
X-Google-Smtp-Source: AIpwx484Bcf71W8NdM2Bf7lGg3caJ+L0sJF75/S3PbYDPY6smhsN+Va61OK4+QyttDtZ2C5Nu2JlVw==
Date: Thu, 19 Apr 2018 12:33:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: Re: [PATCH 0/6] arm64: untag user pointers passed to the kernel
Message-ID: <20180419093306.rn5bz264nxsn7d7c@node.shutemov.name>
References: <cover.1524077494.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111192269135822?=
X-GMAIL-MSGID: =?utf-8?q?1598431317221416547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 08:53:09PM +0200, Andrey Konovalov wrote:
> Hi!
> 
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
> 
> We're not trying to cover all possible ways the kernel accepts user
> pointers in one patchset, so this one should be considered as a start.

How many changes do you anticipate?

This patchset looks small and reasonable, but I see a potential to become a
boilerplate. Would we need to change every driver which implements ioctl()
to strip these bits?

-- 
 Kirill A. Shutemov
