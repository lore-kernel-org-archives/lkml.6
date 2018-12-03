Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4011D20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="WkqbY192"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4011D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLCWGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:06:22 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:38666 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbeLCWGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:06:21 -0500
Received: by mail-ot1-f52.google.com with SMTP id e12so13227083otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=kPz2fS32xKXYAczV0ZrE8OqocFQwTPzcdpuQFXv/7DE=;
        b=WkqbY1928xqc9iBMKSMXQoQClKb3Xl9KoNZ6qTygB4NaRobJwkrJQNfBEe/uTeAtiV
         3pRH4j2/VoxXLZhcIid+7flm92kkqQQepM6yNAotHbrz01jWG3wUgTnGvJOZBYOMup7B
         SjDkoFt+xdFBLxeknoxDipEXDNXjUomoQwVtr4Pju4poKrffri0Gv1mHIrf7cAkqPLZC
         p6PWqghXH0wOhK57Ab5uDmnCc6Q+ovSpsj+UtHIuuHGUDrQ90F2dxuNtZJ+NrMTeYDWd
         mR0EXfV2i2Af+uKK4gkQZ9UckM3Mm3rv/g3ks0uQ8vjSuCcDGDGkThIIGrf1zbV/nhqz
         q4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=kPz2fS32xKXYAczV0ZrE8OqocFQwTPzcdpuQFXv/7DE=;
        b=Kc3re7w4XHizyvvaWGj356POM9ZUNbugT0th0shlDHv6TZFubEIxz2sPXNp3ms+X4T
         gKYTS4HKsyzQvQnqdT/JxxZ+zlagszY0y3k8ihmPVE0b3Rfes8NnZkUcOhgSssrd+cyJ
         hEkFaOpPRrEkfBTOl/jvzvFiRHL0bDfZg/grdjSdL/2KzGNeN518cSYUL8QNVsS3YbSL
         u6K/RR08WUuKIc9vFy4L6lQuDAIUzfxWmRFfTnI6ppxbT00xnY8R+GqyC/DhawAqCquf
         S3oyQTPEKEsoji8tXx/9EjD2jO23QWj++97yT3+bIvOh0UC8Fiy/awTGTCN0+cnSf/Hb
         +btA==
X-Gm-Message-State: AA+aEWaaOf0pBMce4FFAYhBoLmr0WA4oMZHYERJgvESxGtW+snPSISqs
        Im39y0yU4VrhHrM4raoq3VR+7ibV53564Q==
X-Google-Smtp-Source: AFSGD/V9rtosvJ/GAws/pjo5c2a5wKAxmY/Hurp69L/WO4dx8LgyXsqAH+7x46nRXOi6JKj7iatUJA==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr11973611otl.259.1543874780495;
        Mon, 03 Dec 2018 14:06:20 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id j1sm8102624otl.43.2018.12.03.14.06.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:06:20 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f54.google.com with SMTP id 32so13178846ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 14:06:19 -0800 (PST)
X-Received: by 2002:a9d:1b2c:: with SMTP id l41mr10684052otl.1.1543874778760;
 Mon, 03 Dec 2018 14:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20181201193858.20738-1-otavio@ossystems.com.br>
In-Reply-To: <20181201193858.20738-1-otavio@ossystems.com.br>
Date:   Mon, 3 Dec 2018 20:05:53 -0200
X-Gmail-Original-Message-ID: <CAP9ODKo62r8ZrHTj9mHvjbhMXHhaLxA8Hak3su4-yV0dAxNY-g@mail.gmail.com>
Message-ID: <CAP9ODKo62r8ZrHTj9mHvjbhMXHhaLxA8Hak3su4-yV0dAxNY-g@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Enable ATH10K SDIO support
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 1, 2018 at 5:39 PM Otavio Salvador <otavio@ossystems.com.br> wrote:
> The use of ATH10K WiFi is becoming common in i.MX based boards,
> especially on new designs, so enable the driver support as module so
> it can be used out of box.
>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>

Please ignore this patch for now, the driver did not work on the
custom board ... once we get it working, I resend the patch.

Sorry for the noise.

Best regards

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
