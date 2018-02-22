Return-Path: <kernel-hardening-return-11881-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226QF/mVqDu2Mxi0sg2sQ/znVdt4jZmaOyIxNEvyFpsFpwrS+RD2QQmgPvCj35/uGRzlvZ+U
ARC-Seal: i=1; a=rsa-sha256; t=1519262917; cv=none;
        d=google.com; s=arc-20160816;
        b=BJ3TLu6J6ZDIsqr1c+GbWyw11nfpbpEFsEUBFuZjwi5lGAhqyXuskHPNZqvCtxTJZt
         jeCZoF+ZPKRos7sdwvKEFTbr8qXx9OGAkNAVuJM57C+oNILcJnyrpXDCmMUlDHCTbCQt
         YJtoY9/ZRJNfctkn06nJQlnS9rkeGcT8cAO9ZrUC1OtxQKwLl3swa3k/AdEnyTT2UkXY
         f/hpi0tI+a9MxTVuRwIcwpfARrXrrzCIBerbwXPrbOnDNdBxKfFZQZkrIMw09X5npuWA
         mGJJfKrNZRLyzF+3jWnKfsdLc523fX8rHH/QtVj/EDnIwCfI/Wp+vdeT2e27Flc78PVH
         J/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=s3xqYWgAb/kurBf4adTtLc9b5uGjXN4mgschgPcYquI=;
        b=Hi/1tJ+p6j363Qu7+6dnvA8xWp1zBVVGhJuVG1MA2AsS0LDHvQ/S3aaRADtgt6s0dN
         XO9GacKnAe/5kb4Z62Wk2WYCE9f/mxTOcoPXyEIraZOS55/iYCDahxZ6wUXugsNPjKLF
         1scN9qzLkygVkE0nOlsovFuUIdg7HlqbmTWjUmRnmJ9ZQtwzV8XDccMSJUM0rE3LyQVu
         b1AAJ6TtVwgc7E3/BFv4cGVae7l12/J2pjg7KIoL1/UpzVwqGpNwMRXX9KMX8Lj95YUs
         Uh+VXaLDBuZCcIuVojeSXAgEVO7vMtZWtO7W6ufx6+P+NyDwph5FpKXcWWBifcgHWbwv
         /7Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BNv0QH5s;
       dkim=pass header.i=@chromium.org header.s=google header.b=kXv0NsTu;
       spf=pass (google.com: domain of kernel-hardening-return-11881-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11881-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BNv0QH5s;
       dkim=pass header.i=@chromium.org header.s=google header.b=kXv0NsTu;
       spf=pass (google.com: domain of kernel-hardening-return-11881-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11881-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <alpine.DEB.2.20.1802151104140.2970@nuc-kabylake>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org>
 <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake> <20180214201400.GD20627@bombadil.infradead.org>
 <alpine.DEB.2.20.1802150953080.1902@nuc-kabylake> <20180215162303.GC12360@bombadil.infradead.org>
 <alpine.DEB.2.20.1802151104140.2970@nuc-kabylake>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 17:28:17 -0800
X-Google-Sender-Auth: qjzDr3v-uQExITJmStC0XbkWkUE
Message-ID: <CAGXu5jJaQUbwo0_a3KpzzV0Roc898bkO7xQ5VScbgTe-s59TQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
To: Christopher Lameter <cl@linux.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1593062633084389542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 9:06 AM, Christopher Lameter <cl@linux.com> wrote:
> On Thu, 15 Feb 2018, Matthew Wilcox wrote:
>
>> I dunno.  Yes, there's macro trickery going on here, but it certainly
>> resembles a function.  It doesn't fail any of the rules laid out in that
>> chapter of coding-style about unacceptable uses of macros.
>
> It sure looks like a function but does magic things with the struct
> parameter. So its not working like a function and the capitalization makes
> one aware of that.

I think readability trumps that -- nearly everything else in the
kernel that hides these kinds of details is lower case.

-Kees

-- 
Kees Cook
Pixel Security
