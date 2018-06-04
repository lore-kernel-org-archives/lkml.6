Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1918895-1528142415-2-10866980121394600450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528142414; b=lP50nPm6kH6oV3EJbCpKoKX8w2S/24xgCSaMuisglng9Fi7u64
    Zq6KNZpWTcAdldcONy8oi4drzfgfBMxL7W04Z/UuwtvXu2Nsugy/FRQrhrWe8cJK
    Wg8BlAvyFTFfrgF29gHq2gR+k3LkJwc85l4g1OIdcgAzJRiUBLgIM3w+0urPe7OL
    LrXbY7A3o5JRWUCcP4BYjIBVZ5eMQ0KrYs8p3KXv7e2wVANzTSJjxpJRmv7KZgno
    0YXEMA1F17Vk1Ra5GOSQnhmazbQ6QUNFgoeCIRDuKTGDA9IB4XzAnNadZlU0tdDp
    bBkKK0h1I0dPlt5xrRZx5yyU/gLbK9PHdfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528142414; bh=vRYshd3oZ9wZmGDKTYxzPGLyXvY6yn
    ir0xV45rRG/p0=; b=SYB7o5JhTYDaRdY6XNgALG9vN5XnrKNHyLBjscmLw/yl9V
    ImCbE3fFsHG7JKkcdpriP8t2l6EQwe+fRT14BvPI4IGH09HjmwL1irW/qC/MM/sH
    N1qtHmWV9Yu6UI8CZpN+9jFq+P35q5DtWARPl9xP56vXMN8xp2koVcUoMc6dUxn4
    IfUizA4nKqiiY7ymr+Mmxzl+0pgwnQUSFvLOXfa6eeo8C0IkdtYzFGrqceAE8QrI
    WQ5wLsniROXD9a8CySODqCClLRcw6RYE0LRTIpAnxlCUvsmFkE+pcUlinuW64WpO
    1s6xTW4kog6/iL5RBuh+FY96QtadkTlN41eCMr7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBIMMdJckKMNMISxzZTxnGMHKm5jcDq+69KZ3q9ypoffIn4GZ13FGMWD3AuvipzJA28JScugHefxGwo41v98NC2PKPSgSiK0R1pna9HY15O0x4vvdfN4
    d9mPPhMKlUG1w3UZm+iZ1MunabWJ+AFOeoIaYTsIZqsxmLiI6ghbmbmGP2zZvfbzVRkqf5D8C9IHhbCJ5pCKaUsv+DhlPrec/iRgq2bDpdPQ4tzHQ//WI8+B
    hiHZjbYViQuFZJLWRzaWvA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VnNF1IyMAAAA:8 a=PtDNVHqPAAAA:8 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8
    a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8 a=nrbgVzGBzIhZuJOiZT0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=WLjMIN4s_96MqnBbPenP:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFDUAN (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 16:00:13 -0400
Received: from h2.hallyn.com ([78.46.35.8]:56624 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeFDUAM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 16:00:12 -0400
Date: Mon, 4 Jun 2018 15:00:11 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 2/8] kexec: add call to LSM hook in original
 kexec_load syscall
Message-ID: <20180604200011.GC14454@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-3-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527616920-5415-3-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> In order for LSMs and IMA-appraisal to differentiate between kexec_load
> and kexec_file_load syscalls, both the original and new syscalls must
> call an LSM hook.  This patch adds a call to security_kernel_load_data()
> in the original kexec_load syscall.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  kernel/kexec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..68559808fdfa 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,10 +196,17 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Permit LSMs and IMA to fail the kexec */
> +	result = security_kernel_load_data(LOADING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
> -- 
> 2.7.5
