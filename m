Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E322C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C6A208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqftCttq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C6A208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH0Tuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:50:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36925 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeH0Tuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:50:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id v9-v6so12817119ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3qfE0uaPNziobailZaH1ImgJcNFzGSf1nE7s4bncEg=;
        b=oqftCttqW9G+Jn1j6L3mnwiqSM5hQ5ywNBgx9UUr+PKUjOBIqg7vQhPAg7Y+ohQHIJ
         pofSo5YwFHZDHu4FiLRJZ9nR0yS0sZMp3Z5U/Tz0fsqJUFmX0xnQwJJ1JL8dr72Qva7e
         7d3JErJeIxt5d7/4cjFsG+uUv+BWm2Cy27E6iLasrirkPSCsbFHajOOdeu+5gYZRUqln
         nnhOGFgsDZm0LuHHFhJyk5yJ3If+XOg2QOGWmM4LpfzlkT4NZd8Ga7AfBFU48o7EjWRX
         uWDhXUsVEk0adBnTWKk/k4TlGtfwSqX9E/0Aswtzs8Nnx9QvzDGcgB6i4FfYHLAVxXKj
         x6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3qfE0uaPNziobailZaH1ImgJcNFzGSf1nE7s4bncEg=;
        b=OzYunrVxo8hL5fIcmcgWM2womdqKNyHORkTh2BaGtyYKC+RMGdoFuQgG8ExyCl6vyJ
         pY/2l1U0wMXZ5VHLeOkVXFjxhUDH28tw4A/hiVnNdprFhJx1GXkfeNSXI9N5TsvQEFyZ
         kKJdFQ3xUyAzY/j3GS6MRR08sLw4/LDpR8hcqcHLBJJLVvgU/V+VIVHLn+AzK6NG/OVz
         zBs80U0grUCqc9svmRH5y6XKmWCzSS+e5Ok0BuLSDlPBMFxH+PuxrJCfhRj6HD3T7FnY
         k7KnuMfSXQqToW3C5TeMbUBgZWRxwrKVZl4Ov0+kT2QK8eLtMlR0hdCFYAQ6c2lpeQKn
         101g==
X-Gm-Message-State: APzg51CU5a1ayM2wctlgvwwnYtv3hHbJONg8Z1avAkoyPNhEKpxSD51y
        /gSSkFBUbhkEbVO9R5FgzYQ8HFnVB/97/waiSUc=
X-Google-Smtp-Source: ANB0VdaHtQswGafRLCwlXJ5CS4AuiygAZW3YEOkzifxVzFluelEGO/1Z+X5sWvsZjmHnU9RCAHcxFmpXfIKvgV7Aor4=
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr9525600ljc.145.1535385816871;
 Mon, 27 Aug 2018 09:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180821153755.30462-1-jgross@suse.com>
In-Reply-To: <20180821153755.30462-1-jgross@suse.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Mon, 27 Aug 2018 12:03:25 -0400
Message-ID: <CAKf6xps=OoS_S22KAiRwBdUeJE8b=EruiLJpc95b28+Ku3246w@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v2 0/2] x86/xen: avoid 32-bit writes to PTEs
 in PV PAE guests
To:     Juergen Gross <jgross@suse.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:40 AM Juergen Gross <jgross@suse.com> wrote:
>
> While the hypervisor emulates plain writes to PTEs happily, this is
> much slower than issuing a hypercall for PTE modifcations. And writing
> a PTE via two 32-bit write instructions (especially when clearing the
> PTE) will result in an intermediate L1TF vulnerable PTE.
>
> Writes to PAE PTEs should always be done with 64-bit writes or via
> hypercalls.
>
> Juergen Gross (2):
>   x86/xen: don't write ptes directly in 32-bit PV guests
>   x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear
>

I tested both patches on 4.14, changing patch 2 to atomic64_xchg since
arch_atomic64_xchg doesn't exist.

I haven't seen https://bugzilla.kernel.org/show_bug.cgi?id=198497
trigger since incorporating these patch. Without the patches, I would
have seen it trigger by now.  Also, I've confirmed Xen does not enable
page table shadowing.  For what it's worth, the PTEs that would
trigger Xen shadowing (0x8000'0002'0000'0000) are the same as those
that triggered bug 198497.  There was at least 1 non-Xen user affected
by 198497, but this at least seems to fix it for me.

Tested-by: Jason Andryuk <jandryuk@gmail.com>

Thank you.
Jason
