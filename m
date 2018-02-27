Return-Path: <kernel-hardening-return-12017-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuaTx1wZgQDFXDEyIUb+YlX9G07OZHzv7H0i+QZbIYHzAfHb9zg60jWBjzsgarUlg4xzewh
ARC-Seal: i=1; a=rsa-sha256; t=1519768491; cv=none;
        d=google.com; s=arc-20160816;
        b=P2GC/081ZGPlG5EvJ6YSjfD+2L5/rslKdaEqytUlKnXzZp52s2lZdAZ1k1PAffbatM
         yIB7uIwJk9adryRmu3r1zgybH0RzUjYV00tKaCE3BI13f0eHW3YKZ6ylTEc2Yn+oMDTi
         XwZno43z+ByCiwI3OZcDsJh3f1yqt0eSkW5JN3tMRJsZaedtrfsyRwiVagf1opDvFmhU
         klPLV3Ss70aYGa6/RySpJXyZ64LBkQ2pjngYTAz6jbWfU+4kxCOb5QK69r1e5a5M6Yg2
         YRHhow4lknqYQEsTqVlCzNYpXmde/KIDHAELVv+FlTORqs1iJhZQfYG0h/AqAXJI7Jyn
         XHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=C6DUV3Xur5W/2Gy9pZsGtZ8LDjmfQy+Cn+R1468izEo=;
        b=mHETKAqE3royy03rpPPjde064soJ8Vxu/q8TR++CCZwseM3UM1+oQPHBtPHgIvLX3c
         FJ1hy46PntUTH/iZ1EIsznr0xOzlzG/PZHpD44Ou7KYuL01J5OXuIBzimQtkSQkqr4+m
         5/nKFaQ+KP4tgs7MmmtZCP3mSIoOpVfd1htDOCvy0FnuqFlt//Et100OFxsDvnXBAfKs
         mKxhXSpXkDldQAPMxbaBAxLcG5XDBeL8AFMAMtDPszyD5FVd5Wudw0kkvHxKUhaideDY
         DDciogXGCYPP4eVEg2Q9rULerB3vhUfpkFAnMrnIKwpHKsLOiFFGutnCLAASERqu07D2
         4AKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O95p1lcn;
       spf=pass (google.com: domain of kernel-hardening-return-12017-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12017-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O95p1lcn;
       spf=pass (google.com: domain of kernel-hardening-return-12017-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12017-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
To: Kees Cook <keescook@chromium.org>, Ilya Smith <blackzert@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
 Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Helge Deller <deller@gmx.de>, Andrea Arcangeli <aarcange@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
From: lazytyped <lazytyped@gmail.com>
Message-ID: <089e9c52-f623-085a-4d8b-d91cfc6a3608@gmail.com>
Date: Tue, 27 Feb 2018 22:31:38 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593592765423708121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2/27/18 9:52 PM, Kees Cook wrote:
> I'd like more details on the threat model here; if it's just a matter
> of .so loading order, I wonder if load order randomization would get a
> comparable level of uncertainty without the memory fragmentation,

This also seems to assume that leaking the address of one single library
isn't enough to mount a ROP attack to either gain enough privileges or
generate a primitive that can leak further information. Is this really
the case? Do you have some further data around this?


       -  twiz
