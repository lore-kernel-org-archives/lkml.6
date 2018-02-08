Return-Path: <kernel-hardening-return-11658-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227CJyh1vJ8J8SvO04BnDtOtv/XiAolkQ0kWv5cg44vQSiQtCDWg3w2QYLnPCVtHseetxfwI
ARC-Seal: i=1; a=rsa-sha256; t=1518113570; cv=none;
        d=google.com; s=arc-20160816;
        b=V3BGRr+rxODLSYpRZcZH0wJO+C7lHM2DlGBu63/FrcW3rh0dS47oCS2osR5EBijJKx
         E+jDVjlP02Un+0vQnEbOep/wYN+v9Gy1XDvplzOF2xCksuyWKCVeZ3i+U2zoMiPKqeMB
         lM2LlGSpr2V0Ne71yd9zBXpCXRZ7jYnWvuBimiW1HoiIBX6mwN9JxcUqX5HgwBIxm5HR
         F5kzH/vJrARNHkSdvsOcSn21QWQ41DCm3YD2p9TzI2MLEbJi5rnhx8N7QKQ7n0iZKXpG
         R6XEFmV/My8mGP9O1pYl7+a5xcyIziSwjqq5hyM6US/2i5eJ7CHvQsPuD5iVOnwH61eH
         wGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:sender:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=33MGOvvHYPxa+2kSILlN/JSr5kXs6bl0VeCORZuLIrc=;
        b=dVUgYVp31ZRGafijnCeafJ7CJAFw8y5RmmKHPbZGd7CoX7mRYkpjZAa0crV0o6OkiV
         Jw29UxXOA6FWye2L94263eQcuIbXUuHllD52M8/UeOwv48rS6LVKkAOEIigEt3ckbWP/
         4bHVTwm4wnwvf4xjGjAJ3YgRb10uQx85rp6dalu5CE4p2mQjdcFErMqgffvtfSa2aE4w
         3VfDwF77BT4ArDzSa5rw5hTfo78a3vhyozhj8b6qzPyxmOG6ST0thSn3iSrFG+nCmT2u
         sLqoeaGJ/YsrSWOMAREvhkzDZt6mH3kft5b4R59IUNKA4DWMsqq5OxZUeHRsabZrI84U
         sziQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11658-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11658-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11658-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11658-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Jann Horn <jannh@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
In-Reply-To: <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1518112722_2958P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Feb 2018 12:58:42 -0500
Message-ID: <24367.1518112722@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591857455031189496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--==_Exmh_1518112722_2958P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Feb 2018 03:56:26 +0100, Jann Horn said:

> I wouldn't be too surprised if there are more 32-bit overflows that
> start being realistic once you put something on the order of terabytes
> of memory into one machine, given that refcount_t is 32 bits wide -
> for example, the i_count. See
> https://bugs.chromium.org/p/project-zero/issues/detail?id=809 for an
> example where, given a sufficiently high RLIMIT_MEMLOCK, it was
> possible to overflow a 32-bit refcounter on a system with just ~32GiB
> of free memory (minimum required to store 2^32 64-bit pointers).
>
> On systems with RAM on the order of terabytes, it's probably a good
> idea to turn on refcount hardening to make issues like that
> non-exploitable for now.

I have at least 10 systems across the hall that have 3T of RAM on them
across our various HPC clusters.  So this is indeed no longer a hypothetical
issue.

--==_Exmh_1518112722_2958P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWnyP0o0DS38y7CIcAQJvMwgAqINtG3XsiyureZeY7FTqdkwoqxA0BUmM
tUkyfbqu/6bfJmdPUOhV4a62wWIULi9xc/yTUcH3Ve/Y71KQVBWfz+QBeeMIihdr
Qh8b6SWWL5gViGCj0uw0d8pbwgzmX/PplJSgupP8j4tf3CyQ7FcrIBpB3p8PfocO
FINFQ/W8JiCVsTGlgmlcwAlTxTzmNP2EF7JoKp4Ugy/cBpxpN8B35/kawTBWirL4
f2OagdWoDdeyu+XyVEaBhybUuGhGVBnbYGELaaJ5A2uGfPhooVZEMzBDZbFgpesu
9jKlkll5COPF3fozpf6idD5uHYaWGUaYRw5rdH+7+eZ59JdRuYZoiw==
=eDZP
-----END PGP SIGNATURE-----

--==_Exmh_1518112722_2958P--
