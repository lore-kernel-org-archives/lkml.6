Return-Path: <kernel-hardening-return-12044-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtNqaRYGxzSnkkvFdHpCHMOowN2nWiW7nk7/DjYtk1tPCUvvyz8YjdFs7Y4OISr2o+7KeMu
ARC-Seal: i=1; a=rsa-sha256; t=1519842861; cv=none;
        d=google.com; s=arc-20160816;
        b=xt9i/cN2ijDUex0NX8bYxml0HTUKtyCZijLibV7qzT0z7r50Jb67a1s72NHPy9+rOF
         fWNm19Sll1/cwqq72qQ9owq69p3tIOfk4jO2UD6zJvs3Ic5yOAIf3Rm2a/PXIXe9Ya2L
         mlyUz1FcnMWS9HkTdYWmyMI9GBZfoEOb4fl7f0BE4j7sNPOhoPCY9DeRuj7Haz/O0rHR
         hDqF+DVmyN+uRlaJB+8cStfkt1LiR1FKw6QuihQV2heGhqBbJJdYPvvD/XObA9L8R0Q+
         WGqw2fFXJb2MZnbH5j6u/aerWamR/EORfp9ZfppM6Me7bq1f7f2JlhEQ+Ler6IE4K+g8
         U1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=g8SX4SLi4RkiFOdy8Mlxeym76W4/EErheyMzRMrdrys=;
        b=nWg/JHJ9sBVqyqVAOT/p65OzoMptTy1+YwGW12XTi1mC3I2pUsLU0jQFeGFHKigvFs
         i+iZCr6l5SPiCHTzGjqfoAd1gEb7scgDR8QL0fR9oJhfvEmfNvd69tzKHeLudQwehprF
         gwm1CrI6soM2Hhm5env3wCI07AAGrhhYoV5QBEox5pcnWMbleZGq6hMHcgF9PwiVNBGg
         5OL1qNYuWCXSNWnmnB0OeYJokWKRHdWGFl6q13m2w8sH5BytySiQhe8+L3DiSAiwVpdD
         eovjkG2xrOKXcdZKpoicPdqm7hWOnDyZelFdRi2wyv1htXRBRn47lN+eVj2c2kODXuCx
         abOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Q0aCEXj/;
       spf=pass (google.com: domain of kernel-hardening-return-12044-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12044-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Q0aCEXj/;
       spf=pass (google.com: domain of kernel-hardening-return-12044-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12044-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 28 Feb 2018 10:33:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Helge Deller <deller@gmx.de>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
Message-ID: <20180228183349.GA16336@bombadil.infradead.org>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593670748384435219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 08:13:00PM +0300, Ilya Smith wrote:
> > It would be worth spelling out the "not recommended" bit some more
> > too: this fragments the mmap space, which has some serious issues on
> > smaller address spaces if you get into a situation where you cannot
> > allocate a hole large enough between the other allocations.
> > 
> 
> I’m agree, that's the point.

Would it be worth randomising the address returned just ever so slightly?
ie instead of allocating exactly the next address, put in a guard hole
of (configurable, by default maybe) 1-15 pages?  Is that enough extra
entropy to foil an interesting number of attacks, or do we need the full
randomise-the-address-space approach in order to be useful?
