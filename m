Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C61AC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61E120664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61E120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKAL4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:56:48 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:35611 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:56:48 -0400
Received: by mail-ed1-f44.google.com with SMTP id d6-v6so7299536edi.2;
        Wed, 31 Oct 2018 19:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n48mROcUTTlRJRVoRzsI7cvtEKKiuq8dgKpd67N+vsQ=;
        b=ASha/sXmRAxL3HMyFT4YHwfrgWdtFjsduoUMAXXTLAw1jHq8f4BfGz/GzWpu9aDE+V
         SJ7W0SZHhkr01x4l34DhRwa27pUQbSEWM0kc/lYfOw1b73YJYbcsyFewUyJPor5eA3qX
         y/vWQst1u3XZLmcQMLpEMac9vKOQ9fuTw8vyT/OrkSWm+eBQ9KA9THDTs0RwgZ5zTz0t
         2nRpXBxwm5L0EdboMFt0z08zofodkpG1sBsoGIAm64frhbA4Hw5/KCvFHTJbBqB2rcNM
         nUjr+YHHGMb9A6D1yPwVVaveRE6FbJMsfnvkGVCztESHilnmkRgjhUXBGNSkUMbpkvPV
         dcYw==
X-Gm-Message-State: AGRZ1gIh9qYrgcL3loQ0V2PV7hxD3Fj+3GUxVFeK9cjSvpBhbFLsyF1T
        P9uDpxZQ/kpwdcH4Lw/t9p0Tv3IRGu8=
X-Google-Smtp-Source: AJdET5f+7UwJ/ZGCfCBaj93ahKvcCkSM0hyL4Ux1bDlMY8HjdcNnxAJe4LesSsB3rxSCEyPdO3hv1g==
X-Received: by 2002:a50:a602:: with SMTP id d2-v6mr3935862edc.8.1541040947112;
        Wed, 31 Oct 2018 19:55:47 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id c2sm8037961edv.14.2018.10.31.19.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 19:55:46 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id a8-v6so144086wmf.1;
        Wed, 31 Oct 2018 19:55:46 -0700 (PDT)
X-Received: by 2002:a1c:c016:: with SMTP id q22-v6mr4239482wmf.151.1541040945897;
 Wed, 31 Oct 2018 19:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com> <20181031183634.29640-5-jagan@amarulasolutions.com>
In-Reply-To: <20181031183634.29640-5-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 10:55:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
Message-ID: <CAGb2v64fnpCh_rCy-9m8xgXmAZQGab1==f7cr332QfgueyuRNw@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> From: Jagan Teki <jagan@openedev.com>
>
> RTC controller is similar to A31, so use the same compatible
> for H6 and update interrupt numbers as per manual.

No. Unfortunately they are not that compatible. The A31 does not have
the RTC clock output. So everyone got it wrong. :( Plus the clock rate
of the internal RC oscillator varies between SoCs. I'm working on a
series of patches to correct this. Stay tuned.

ChenYu
