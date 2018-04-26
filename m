Return-Path: <kernel-hardening-return-13143-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+fDrb1i8VBNFNGBUYfFPVWEHptZUNEIk0HwdRIAat/H9Fu9WkY9Qu0DR+P2sYB8nxQxBQg
ARC-Seal: i=1; a=rsa-sha256; t=1524731612; cv=none;
        d=google.com; s=arc-20160816;
        b=NoJ8u4rZMGYe9pRovDajf2qoD+7gvDL0CIvtSNGeAovHC/LzxqWOa/xmCBVdgz6Bed
         pdj+LPOjLHOTf82HOwlZ4tbBoiHqMTY9tCuelUSJ5G1dDI8CAGT26DEpyAxSG7/pVxxj
         0NVWcb1P+mhP4VthBbesp3Cio86iCjr7b/ffloH6gFt7vL9OVZ3GgZqYjZ64L/IIPMoT
         1UaZ65mTLwUPOxx4E9cfqgPEbpysRUWLtsOinGGLXHj2OdwBIXbHRdlvzZj6uGzzvhql
         IkGzTKa5f0nHiRTwrqbAQgMfEF/XfuEDhRAZlBkeGDotLYLnOLE6+U0mt6Y7JFMsnJGO
         8cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=QxMNyEjTtnQf6YfG77i/S89xY7Cp1PIJz27pvZyHDSk=;
        b=UZI2L/DVUG5j4M6C6cERkiAyN+1JX/niPWbGOAQs7pb3fSI0cG0sI4sQTf7vwgv5hP
         CWEb+OT+sxfJKGAZNSPy5Sb+oL/SrGGV5EJk4ZqlaAvfdcoKwXxBvlMrW3WHdMGcc+lF
         LIWVsk5/G7dqWLfFPM8rrhf8qh0sz4wRnbXGF+qFYM99CkV2pZEy/W+MvMDbvHH9lRyL
         HOszA98AgEVHkFD31+sGi4PpCR984GIcE+sMFE6IU7CMNhZT5snlIkVe38wnqvQ4pBkh
         qE72FZPvjGhCVjq164RreZ07Z4hFy/4ygUKH/K0xOvyuh6tx25KPAz5uGKvmp1QM32SV
         tODw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13143-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13143-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13143-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13143-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 26 Apr 2018 10:33:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Stefano Brivio <sbrivio@redhat.com>
CC: Kees Cook <keescook@chromium.org>, Andreas Christoforou
	<andreaschristofo@gmail.com>, <kernel-hardening@lists.openwall.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki
 YOSHIFUJI <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 ipsec-next] xfrm: remove VLA usage in __xfrm6_sort()
Message-ID: <20180426083306.uwhew63btnoalbxw@gauss3.secunet.de>
References: <20180425144639.GA38350@beast>
 <20180425165852.6c7460c2@epycfail>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180425165852.6c7460c2@epycfail>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: FB01D57E-AF57-447D-B396-7247563355AC
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598729875203857448?=
X-GMAIL-MSGID: =?utf-8?q?1598796975465566258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 04:58:52PM +0200, Stefano Brivio wrote:
> On Wed, 25 Apr 2018 07:46:39 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > In the quest to remove all stack VLA usage removed from the kernel[1],
> > just use XFRM_MAX_DEPTH as already done for the "class" array. In one
> > case, it'll do this loop up to 5, the other caller up to 6.
> > 
> > [1] https://lkml.org/lkml/2018/3/7/621
> > 
> > Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v4:
> > - actually remove memset(). :)
> > v3:
> > - adjust Subject and commit log (Steffen)
> > - use "= { }" instead of memset() (Stefano)
> > v2:
> > - use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
> > ---
> 
> Acked-by: Stefano Brivio <sbrivio@redhat.com>

Applied to ipsec-next, thanks everyone!
