Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D15C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571EA20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571EA20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLCMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:30:35 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43206 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeLCMae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:30:34 -0500
Received: by mail-vs1-f68.google.com with SMTP id x1so7333086vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+Vak4EbmeWhRC4cNTVQw/uOFbUK3tHOgw5DMsecb2I=;
        b=cFATbJ1tqq39kYqqlzJ2swnzPzuyu6Xe/+fAvmvkYj94wWD7W1YbhKf16lZff5Eabo
         u/rrvVugctagEc8LQLIj2hFmbXDIVWF+9L8LksqOjsfslhItq3QaEU5zDcFX5A//cyrj
         6LRrrWIXToN/AWWmnu2J5mI9e88PwOWh1i3BLHv/fn8dP3IDcNYKLGuHUtSpW2EHQqfA
         rcTVgGvdc2TB1OlKW+SRycLp6BtxlMGfpWjVeZW0cC7tgMI8dHFFP6pMwTMKpXzgPKtD
         PFQpRXwIe3Im9Q13TXnaS4pl4t2aFqJW5geAnOA1PFoYWy7xRE0lfANgjAqg9Tgz8Ogg
         cQGQ==
X-Gm-Message-State: AA+aEWbTdb27l/h7lRVs/j9ZRdaIKOeOVZ1etMYv5GqiVEshl0553ofz
        swArnf11EDaswMhvmJhOkEPPSJtI+abBsvOUgrU=
X-Google-Smtp-Source: AFSGD/VxffZ19riDBNI9eAtJno727kNmjyuWelZYQsHcFga71zRuhPbOdnsrNtCdy9LLo+vvWEwxHYkeMXuXNCMOsVQ=
X-Received: by 2002:a67:c202:: with SMTP id i2mr6218542vsj.11.1543840182488;
 Mon, 03 Dec 2018 04:29:42 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f@eucas1p2.samsung.com>
 <20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f~eGh5UqXXL3084730847eucas1p2h@eucas1p2.samsung.com>
In-Reply-To: <20181016133400eucas1p2f5bab263e70ed0308ce47544fb64a57f~eGh5UqXXL3084730847eucas1p2h@eucas1p2.samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Dec 2018 13:29:29 +0100
Message-ID: <CAMuHMdXBDom8+p9GgWavpc_mdEtMoVkSvL3fuDCkFrb=5Fooug@mail.gmail.com>
Subject: Re: [PATCH] m68k: remove redundant 'default n' from Kconfig
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:34 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> 'default n' is the default value for any bool or tristate Kconfig
> setting so there is no need to write it explicitly.
>
> Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> is not set' for visible symbols") the Kconfig behavior is the same
> regardless of 'default n' being present or not:
>
>     ...
>     One side effect of (and the main motivation for) this change is making
>     the following two definitions behave exactly the same:
>
>         config FOO
>                 bool
>
>         config FOO
>                 bool
>                 default n
>
>     With this change, neither of these will generate a
>     '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
>     That might make it clearer to people that a bare 'default n' is
>     redundant.
>     ...
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
I.e., applied and queued for v4.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
