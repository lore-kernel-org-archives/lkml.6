Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D385EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWN/Ll5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfBYFVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:21:44 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37379 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfBYFVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:21:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id z196so5175567lff.4;
        Sun, 24 Feb 2019 21:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZIN9RloOx6e5QAEgcOLDVZsWmKB21qkK6oSo5r4EGI=;
        b=pWN/Ll5i7UtGwHXFTG8Y4DVvyuN9omCXa787jLSAEnpfbE9kOLAG/SV9mGAoca7BKh
         HsFpc36dFfaii/GrrUSJG1u3R8M5phm0R66Gn5YLYPlxGiOfeGtX8xmSeXdbRJkBpdaH
         pNQ2aFfuY4eLJbvvyJXzhLb0Hqc/v1rHpoLLi4QNapHVQGJbqlBNCvrvewWaEcaS/IXK
         zarw46OQzldicLok789WIxJDBYSxDnI3O9HhuwBr5qOvuZA3i4f7SQ9ebi9F04CcM9Xo
         x3xamlinSaBn/G7ab6YzoGwwZcCVslxcbq5m+D0tetBPUq0ZCN8rBG29ogQdiZ27o3Pf
         c6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZIN9RloOx6e5QAEgcOLDVZsWmKB21qkK6oSo5r4EGI=;
        b=VaEkuZdmOIBPdvI/taxdb+1aCFi2Et2Z8oYRD1KvXjC2PF7hQcfZsZsYxMrKXmVHM7
         a/0Bua7baSltZDoQcOTRJqBMr7FRJpXXd5uoPMhYaQfGaZVILW7QXGO2m+OvAWttO5TQ
         soj1g/pmr9p6ZT5Z8ggWjPWmdgjZf1Eai8KK01c8Hv9DaGBQ5LQu9/KHRxeQn4+g1q08
         iS4/h580IbX1Gggz4GiKJ/gm5LAPxEgj1+7/X23mH1ew01JqgEY9HiEtnXORU7s9CxpD
         6NoM+YGAxfLL43q2H9rbVE9Q9eTH/3Dw9El49/v0rECXtjhn7gUy8jdyNyOW0Rh/58RQ
         vjCw==
X-Gm-Message-State: AHQUAuaw+Em7sACCiwojmNwWF7R0BKJR/prqlgUfgwbgYjS4e1zbmP4Y
        PFCy8aRQVahBdz0jDhcIHMo=
X-Google-Smtp-Source: AHgI3IZr/4s48smsDa6hQnyGfl0DGQexq5NoVCL2+/7laQoNbc9HKHfg4uy8dsO3UWnkL10Eoze6zw==
X-Received: by 2002:a19:c6cd:: with SMTP id w196mr8482779lff.127.1551072101345;
        Sun, 24 Feb 2019 21:21:41 -0800 (PST)
Received: from dimatab (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id a23sm492487ljd.20.2019.02.24.21.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 21:21:41 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:21:55 +0300
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Robert Yang <decatf@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Support Trusted Foundations firmware on Tegra30
Message-ID: <20190225082155.1163ed85@dimatab>
In-Reply-To: <20190225040232.GA2242@qmqm.qmqm.pl>
References: <20190222193426.10747-1-digetx@gmail.com>
        <20190225040232.GA2242@qmqm.qmqm.pl>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Mon, 25 Feb 2019 05:02:33 +0100
Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:

> On Fri, Feb 22, 2019 at 10:34:19PM +0300, Dmitry Osipenko wrote:
> > Hello,
> >=20
> > This patchset adds support for the Trusted Foundations firmware on
> > NVIDIA Tegra30. Pretty much all of Tegra30 consumer devices have
> > that firmware and upstream kernel can't boot on those devices
> > without the firmware support. =20
>=20
> Hi Dmitry
>=20
> I've applied and tested this patchset on my TF300T. Boots and
> suspends/wakes using 'rtcwake -m mem -s 1 -d /dev/rtc1' as the test.
> dmesg attached.
>=20
> The exact tree used:
> 	git://rere.qmqm.pl/linux tf300t
>=20
> Feel free to add my Tested-by and Signed-off-by on the patches where
> apropriate, and thanks for your work!

Awesome, thank you very much!

Robert, could you please confirm that v6 works for you too?

I'll probably make a v7 with an extra minor clean up and then will add
all the appropriate tags to the patches.
