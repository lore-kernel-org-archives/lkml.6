Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B01C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29450206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbTapwhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29450206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeK3TUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:20:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33695 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeK3TUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:20:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so1094884wmh.0;
        Fri, 30 Nov 2018 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sGSsqDhGQXN4EM9c2OJsQvwTGPu/pb1f4jh8CADYmD8=;
        b=MbTapwhq/rlbzWNAAnCOe7k429TOhJj4fFnr5MECodwAkXhplR5guz881dOL4U+7On
         5XiNzVe90QNyOVakVy+RW1KmUdAn1VISS0KpUIv/VFwlw0rFdRsIxC3FH6+bkiormvSY
         J6YxrzIvT/RUuXT9ZS4FglQE80tOhvjQf6GR4zx2rX8zsF+7D7aqdEAWnMKKKXUvr1+L
         a5A06Hb1iNKNTWSU+EjZcoYVCUPROhjRxiyPZ6QX8vl5JsPoxKmYKBZwN5TvikPsepyf
         prtLDZU3E76G5WFxKp96vJFB/eFZQDljL1DLv7FnBK2c8VPG7K5D69qcgS3yXolu1940
         qBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sGSsqDhGQXN4EM9c2OJsQvwTGPu/pb1f4jh8CADYmD8=;
        b=nYFv6b/mtpGdGf5cbe2oXiYbeWUEbmcAm36B3nNUXRNm6s9GGno3Zs5UTDBzdCydYW
         mlQXgbqCW1bJULbDscEW31NKELtgipLTEFSXrZ6iUaxaZUIyYLeORH5q6FogZwuEaaDo
         cnvcDJoabuXa0gz3WZbEsu/VHMwEQ55v3hTNYgUTTmmdN4XArcVmadSNz7m2ufchdA/Q
         K6nTzI+tP26CS5tR+4DhO0vJMixPERh8H4YvWSHBHc1BLE5N/nd700LBi9JSIi0PL2li
         du8ZgK+Jz1L4jvhwJYFUcEzqP0ayj/TIBqUiKQsUBc3IYlTLRpvUbbTjpRxnNb1zIq7t
         HH6A==
X-Gm-Message-State: AA+aEWZIdLJh4YnqBTbZAI2qxci7dwrjNLZSDMrJf9PZnE5k+darItz8
        MQf/yEhGAmVa9F5E2+S9l/4=
X-Google-Smtp-Source: AFSGD/V5TSLQY1qOoQhBxVCJWRbxXzO8Zks5xpQ2v3JlmfBiIKz8LLZdq5ZD65Mevej23Jwp+kLu2w==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr4789373wmf.32.1543565522943;
        Fri, 30 Nov 2018 00:12:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h16sm6260028wrb.62.2018.11.30.00.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 00:12:02 -0800 (PST)
Date:   Fri, 30 Nov 2018 09:11:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH 08/11] firmware: efi: add NULL pointer checks in efivars
 api functions
Message-ID: <20181130081159.GD16084@gmail.com>
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-9-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129171230.18699-9-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Arend van Spriel <arend.vanspriel@broadcom.com>
> 
> Since commit:
> 
>    ce2e6db554fa ("brcmfmac: Add support for getting nvram contents from
>                  EFI variables")

This commit ID is not upstream AFAICS. Which tree is it from? Mentioning 
non-upstream sha1's is discouraged in changelogs, as there's no guarantee 
that the sha1 will make it upstream.

> we have a device driver accessing the efivars API. Several functions in
> the efivars API assume __efivars is set, i.e., that they will be accessed
> only after efivars_register() has been called. However, the following NULL
> pointer access was reported calling efivar_entry_size() from the brcmfmac
> device driver.
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00000008
>   pgd = 60bfa5f1
>   [00000008] *pgd=00000000
>   Internal error: Oops: 5 [#1] SMP ARM
>   ...
>   Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>   Workqueue: events request_firmware_work_func
>   PC is at efivar_entry_size+0x28/0x90
>   LR is at brcmf_fw_complete_request+0x3f8/0x8d4 [brcmfmac]
>   pc : [<c0c40718>]    lr : [<bf2a3ef4>]    psr: a00d0113
>   sp : ede7fe28  ip : ee983410  fp : c1787f30
>   r10: 00000000  r9 : 00000000  r8 : bf2b2258
>   r7 : ee983000  r6 : c1604c48  r5 : ede7fe88  r4 : edf337c0
>   r3 : 00000000  r2 : 00000000  r1 : ede7fe88  r0 : c17712c8
>   Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>   Control: 10c5387d  Table: ad16804a  DAC: 00000051
> 
> Disassembly showed that the local static variable __efivars is NULL,
> which is not entirely unexpected given that it is a non-EFI platform.
> So add a NULL pointer check to efivar_entry_size(), and to related
> functions while at it. In efivars_register() a couple of sanity checks
> are added as well.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Will that new commit be backported? If yes I suppose we could mark this 
fix -stable too? If not then it's fine for a v4.21 merge.

Thanks,

	Ingo
