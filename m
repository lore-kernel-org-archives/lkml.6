Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677E92147E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 03:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Ja3BD4EB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677E92147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeHTGhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 02:37:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39737 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTGhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 02:37:31 -0400
Received: by mail-pl0-f67.google.com with SMTP id w14-v6so6365674plp.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=f93Pk77n//138uVICqkEHdCERG5DVYotTn9mhWSXD4E=;
        b=Ja3BD4EBY0Yhuoli+EHTwnhGpungL10Tip4rxo6jC3wYScynxJQu5cjcIC2zGLHlz2
         FRvCZyjOsJSIaWcAGz83YKVhNaE+eMV83FbmMhJXlbpmLdz0/s9+/JqFquJ+8I0M51VS
         2XdEajCw0iM+QhQ0GFSR8Rjd9oI6js03trYpH8tK1QjyELXLniG03AEdsuIE1eXO60vL
         kgF83wk2TksjxT0Bc56dgxe1AEfLxMaCyLbk/NxyX5z+HCz9Ajh3FqgPD47Vo9jy7w+l
         7JdQAKVrnjDhSF3tU4oVK3ScnSpfYiZFOh58tAOTEcPHltXPhXGexZ3bHZr3wDd01voV
         6p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=f93Pk77n//138uVICqkEHdCERG5DVYotTn9mhWSXD4E=;
        b=WtixYtWkFeaT/Y/gXTYROGFZ14TB7p+pqTToo/ThBvk5i4f0TjI/8pN0OONa82BHeZ
         GJdGbCDnBSfkzrtLGEkLNB85QNqtQ5JXeTB5Gw0xzO2HS3d7nxIXZMe9JT6SqbYeLZxv
         LAKgIhnsgXMkPpHM0B7f4mui0IRzSloOYV1TPOtiTqw0hl9FdB1DI6CkEiKUYvjrlXuz
         7bCSt6Q63LoLX1v6k1mecq3xIYkuUsL5wPpCMyIG1OAYM/PIrfuH4v0HgHZFkLHUcEpk
         Vj3AYX3LWXxMJQvvHQ6Y6mh47BTyj8XGiHChUdjexNUGT2ObKu7q2SHihFeQuvuohoct
         Q/JQ==
X-Gm-Message-State: AOUpUlFWSbKwhHwDWWyf1n/rv7QQbqUxJMmZ74U707JUDC9J4mZGf2lT
        p4SkhbpjuuRChDh3mA0fH+GKRVN+89E=
X-Google-Smtp-Source: AA+uWPwJYLigD8EvX3anbGpMZTJ0qN/9rSln27B5AEc4YgYh82qAQj4UmUadGYwxFTlbveVRV8pKWA==
X-Received: by 2002:a17:902:d706:: with SMTP id w6-v6mr43570779ply.158.1534735420463;
        Sun, 19 Aug 2018 20:23:40 -0700 (PDT)
Received: from ?IPv6:2600:1010:b005:f978:c1eb:4793:2546:f614? ([2600:1010:b005:f978:c1eb:4793:2546:f614])
        by smtp.gmail.com with ESMTPSA id g2-v6sm11251029pfb.79.2018.08.19.20.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 20:23:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/process: Export start_thread()
Date:   Sun, 19 Aug 2018 19:29:18 -0700
Message-Id: <53141AE9-7192-432B-8A27-25986CF442D4@amacapital.net>
References: <20180819230854.7275-1-rian@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bpetkov@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dmitry Safonov <dima@arista.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
In-Reply-To: <20180819230854.7275-1-rian@alum.mit.edu>
To:     Rian Hunter <rian@alum.mit.edu>
X-Mailer: iPhone Mail (15G77)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 19, 2018, at 4:08 PM, Rian Hunter <rian@alum.mit.edu> wrote:
>=20
> Commit e634d8fc792c ("x86-64: merge the standard and compat
> start_thread() functions") removed exporting for the start_thread()
> function in what seems like a typo. Add it back to
> arch/x86/kernel/process_64.c for parity with process_32.c and other
> arch.

What for?  Perhaps 32-bit could remove it instead?

>=20
> Signed-off-by: Rian Hunter <rian@alum.mit.edu>
> ---
> arch/x86/kernel/process_64.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 476e3ddf8890..a451bc374b9b 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -384,6 +384,7 @@ start_thread(struct pt_regs *regs, unsigned long new_i=
p, unsigned long new_sp)
>    start_thread_common(regs, new_ip, new_sp,
>                __USER_CS, __USER_DS, 0);
> }
> +EXPORT_SYMBOL_GPL(start_thread);
>=20
> #ifdef CONFIG_COMPAT
> void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp)
> --=20
> 2.16.3
>=20
