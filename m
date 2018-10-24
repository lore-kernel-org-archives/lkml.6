Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61688C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02731207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lSTuWwRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02731207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJXQY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:24:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45918 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbeJXQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:24:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id c24-v6so3189916lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 00:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=V2JxQ9bo1qI+nhXdlK58QIW5s19i3I6plF2Wm8La7tg=;
        b=lSTuWwRw+w4s0c6dnCFrgC2Ld3jUFS30Z4N8hxaNUmj1aVbNWQGhyYVwm05Fznzvv0
         vDt/786ivZubvxT5fZoiumDQ4+rF5Qy1Ev/nIx+KZxXkwrU9gEi/mdjIAIT/K1WhsjjS
         AyWbrNUUSjkTmTnsrHkYdX+kKeEgczFRp2W56nbOS0Ik/4AXjO7EZ+bwRSravPjIJW7j
         kaTEyiX+w6uWoW2WNZ+tdTBCKwJYbYgEDIwf/yqqNC3D9aulvvGwXeTkP6wuACOFt6jw
         uCGCSYmAzZc+Z6TQsNDfc6J6SX6aJERYzTdGQpdlp4hFSyA7bbbT5Ve15FYI+4jQIk6Q
         ZPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=V2JxQ9bo1qI+nhXdlK58QIW5s19i3I6plF2Wm8La7tg=;
        b=LKgHYXfgJefzsRwl9G/sgYLWW283iSt2jpPziXvYR/fVjrvj0DfhQCEKY/RADY5SHa
         NM8rw3W1ZKVZAJCLn5S8kvg6RthuwP8PB9KOUYoakeHjcGWBkCqPV27utZhoacR8TnIJ
         C+qDLXhyMC/CVsLJ2+EQG9ci5YSnTbwjsXKfHHcc6yHPmXWu4fsirqKERa/5T9c1em/N
         NOn4pDawjauZ29HipPEIFhpncPKpXPJSFX2R6IWMWd8Mx/1C6OjFE6sgUP3bZ97Km57S
         DM/Nl6zH/GhromWMo/BdCy0HW/s51yNGex3uZHISlBC13t6Tl3v1hJ4d+7le5JqgTcW0
         BpoA==
X-Gm-Message-State: ABuFfoj/YrnX97qhTVFmQlH8fubYCnQI8PnCHVtXh++LnE/KRk2aMG15
        NCAFyREI2i53ZH25MxygP1Dh3g==
X-Google-Smtp-Source: ACcGV62uYJH8DMiyK5GKYiczfyqB98ujW+uN85c+acc8oigvD5Qj6uIm52nRHcmBCYDFjU2bnn5Y5A==
X-Received: by 2002:a19:5510:: with SMTP id n16mr8139579lfe.68.1540367875507;
        Wed, 24 Oct 2018 00:57:55 -0700 (PDT)
Received: from [192.168.0.200] ([31.173.82.66])
        by smtp.gmail.com with ESMTPSA id u20-v6sm586980lfk.55.2018.10.24.00.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 00:57:54 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] ata: ahci_sunxi: use xxxsetbitsi_le32 functions
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
Cc:     cocci@systeme.lip6.fr, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <83472722-c7e7-820f-b97f-37016ff32893@cogentembedded.com>
Date:   Wed, 24 Oct 2018 10:57:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1540366553-18541-5-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    Typo in the subject: s/xxxsetbitsi/xxxsetbits/.

On 24.10.2018 10:35, Corentin Labbe wrote:

> This patch converts ahci_sunxi to use xxxsetbits_le32 functions
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
[...]

MBR, Sergei

