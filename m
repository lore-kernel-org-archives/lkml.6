Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aDfTFAGfGVtoVQAAmS7hNA
	; Thu, 07 Jun 2018 21:09:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 382DD605A2; Thu,  7 Jun 2018 21:09:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKIRZsb/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A695D601D2;
	Thu,  7 Jun 2018 21:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A695D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeFGVJS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:09:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33942 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeFGVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:09:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so5518129pfl.1;
        Thu, 07 Jun 2018 14:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gfrV7QMiBEcp+oCgt/tkqzayckx4v0NC6uDo26uyLDM=;
        b=LKIRZsb/ciNZRb2d+XOhFwJhktI3KabxvXAz9jn+oB7sSAPuCElKtKMQYL+33VZMir
         OPq5esX1DWlDOIon4376fCfx6c8hytbhKRD1/2WipAAkD6Lq/MUTpRDpSbA+hM9zc1dw
         z9IYeU/CrmOw8g/A1Vuqh8upkBhoo1Bzn9n8p3PggfNxCxbCKS88yRDznINtQcELLHvX
         5y4gpIXhjMU4NPF0Q6+6QvOteL4LfUAoGWgnlgV29amInFkPLIj/TxwMhsug4OGaCq60
         j2u3Nhvyjrf7DII2991NOtgcbTiJ07H/SZN5RUaGfjvjohMseqjP2K5CYzDwawOmoWQx
         kn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gfrV7QMiBEcp+oCgt/tkqzayckx4v0NC6uDo26uyLDM=;
        b=tKeaISsVHh31dLIovQtKy9vdl8t0dtB38O5Rv25OCjq04gOOHdaKseDOM9BgPewBT8
         Nt/CZC5EGhVn+VEsGBR7X9Ot+oYYaoiBXYUzalqGdKZjSDsxaSnWxLcEszPdOE6cRqhc
         rVouzlE6j6ACPHoiRx5qucBNHMNeXKicSLa9/5YuTl8o/UVzaQ+m+fOtkQ3waWBC7oxv
         liBfaTHygoawvjIVf+dhZdI+7EK+doB8IauGZjgPhpOTN8f7Z/LiRAHvOsTH9dCw7OFC
         ZNOuQ2tG5DbJUf8nRREfQrqkESIShtSfPhqcxHUE7vA5F0E/YLyzVEoBOyy70BdvAtgE
         qRdg==
X-Gm-Message-State: APt69E3KBBt/Lpa/pHqwv6zSvEEDBkKMSvkR+Oo4uTGEG9DszM46Dll7
        etcYaOz8/yvG1wO/hViVqBI=
X-Google-Smtp-Source: ADUXVKKs9OC/zWLZYg3bwhEGMSqiBkxPmRwaZRjiteuvP13+x6QROo+lY7FzfpE/bK337oiyV/ESVw==
X-Received: by 2002:a65:61a7:: with SMTP id i7-v6mr2900781pgv.219.1528405749295;
        Thu, 07 Jun 2018 14:09:09 -0700 (PDT)
Received: from [10.2.101.129] ([208.91.2.2])
        by smtp.gmail.com with ESMTPSA id h17-v6sm84929786pfn.80.2018.06.07.14.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 14:09:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 09/10] mm: Prevent madvise from changing shadow stack
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180607143807.3611-10-yu-cheng.yu@intel.com>
Date: Thu, 7 Jun 2018 14:09:05 -0700
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1A84B62-E971-4ECD-A873-2072F2692382@gmail.com>
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <20180607143807.3611-10-yu-cheng.yu@intel.com>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
> mm/madvise.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 4d3c922ea1a1..2a6988badd6b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -839,6 +839,14 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, =
size_t, len_in, int, behavior)
> 	if (vma && start > vma->vm_start)
> 		prev =3D vma;
>=20
> +	/*
> +	 * Don't do anything on shadow stack.
> +	 */
> +	if (vma->vm_flags & VM_SHSTK) {
> +		error =3D -EINVAL;
> +		goto out_no_plug;
> +	}
> +
> 	blk_start_plug(&plug);
> 	for (;;) {
> 		/* Still start < end. */

What happens if the madvise() revolves multiple VMAs, the first one is =
not
VM_SHSTK, but the another one is? Shouldn=E2=80=99t the test be done =
inside the
loop, potentially in madvise_vma() ?
