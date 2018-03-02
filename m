Return-Path: <kernel-hardening-return-12077-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtpcPG1AHqqYpfMEBKx/MLuQM14Jn6x/BQ8wX6lzQLWUsT/GlFeror4vxOAoTX9xcFqjw/3
ARC-Seal: i=1; a=rsa-sha256; t=1520023723; cv=none;
        d=google.com; s=arc-20160816;
        b=Mhz5DW+N7PMOmdgqwSvVK50rmphRG6LU+2PblI6n8n8Kq3iFR5EKfj0xEOcpzChWvR
         BJ04AQLQn06M0Q3f/hCvA7M+7HbHbFvGRdPNQvnXej778jHjV1mnZKYXiOmuHB0Vq2p1
         gT1607GAfjTeoBd6Ga6t6VAASGDkthtDYEi8PcWtXkrPuS5YFWNQPfy1QRjmI+1FhOAx
         E1PiWB/fuve6i1y6IylfZ6sFAqx3OhyPL8Eczuo/kMRJL/Y6rgiC1PxL3wY3RgECZzM5
         8IAj1Y6+AetS58x4P9QJ2e1Ka7ZfSym2f/1gNx7TGrkx2V6jppdPPFG2R+ElsSGhHEI1
         Qzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=rkePfZZVIDrCZLnbxKPRY5ghHgdY7yBMosIY8485V0I=;
        b=t2qgRua0uwRkOqNp6NXrgqh10X0Hpe90vIxLAp9CCVBcrFLEEU2HHz99Ab+ySahKGR
         BMR0S+BZZn1VsId1BN8xvXPOgn9LOAk3dci+isXArjS809Or3C/Vl/+iQqps1KcWKBRa
         yKEO8DdO1pvflZYHjdhM2tRKi6vfMSf4z9jcI9sIg68Z9UkXSWJtRdSPyLHUqRXJ6Qad
         68W6mYIPhq6yKOx3QOjbfQHhcZiu/X2sYUobgHBT1+W4spK3NseG06Mdt63+j8dOtNUx
         DTS3E7URvyT+OGTmR+87BQjsahk7jijVSddxr6it9H2S9m7pqlIbsuX6T7nqi0lV+84R
         QgiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=DEh84WSp;
       spf=pass (google.com: domain of kernel-hardening-return-12077-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12077-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=DEh84WSp;
       spf=pass (google.com: domain of kernel-hardening-return-12077-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12077-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 2 Mar 2018 12:48:08 -0800
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
Message-ID: <20180302204808.GA671@bombadil.infradead.org>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <C9D0E3BA-3AB9-4F0E-BDA5-32378E440986@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C9D0E3BA-3AB9-4F0E-BDA5-32378E440986@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593860396065748361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:30:28PM +0300, Ilya Smith wrote:
> This is a really good question. Lets think we choose address with random-length 
> guard hole. This length is limited by some configuration as you described. For 
> instance let it be 1MB. Now according to current implementation, we still may 
> fill this gap with small allocations with size less than 1MB. Attacker will 
> going to build attack base on this predictable behaviour - he jus need to spray 
> with 1 MB chunks (or less, with some expectation). This attack harder but not 
> impossible.

Ah, I didn't mean that.  I was thinking that we can change the
implementation to reserve 1-N pages after the end of the mapping.
So you can't map anything else in there, and any load/store into that
region will segfault.
