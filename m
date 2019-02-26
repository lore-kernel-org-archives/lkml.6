Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E432173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSEifZp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfBZLfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:35:08 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40063 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfBZLfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:35:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id x187so10022924oia.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 03:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2O4nftI7EUiVu0gZW4PMSggC36F4VasZbmifgPoWuI=;
        b=oSEifZp/drYM6UAtZzkODb6Fme2qWBjRjalIncoKTROIWLd3c28661ftn7p4Vxgrrp
         68Yki51Q9gE4tjUZKbagxC8zZpT1/JbXtSgTMx7o8eYKf6+JwEDjaHaivWIzCSG8eBXg
         U1PdqkLPF8Obqe+mstPdmGYBryH+qmIEKVHYoWU3QIrhU/oNp/UuOzScjr/mDuz3aMsl
         xd2dp/kwyWUxgUpAkbTsJ0Hjn4qlylkn/l7y7/M4FE59otaYx+iVMgdu8VFQkRlHRxsy
         ULhwmGTrH+MVRFuEWlkMeqQxk4euke/tkQKvEKL/nrZ5jnd4n0UiCus5yDSp6OiZtE3t
         o5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2O4nftI7EUiVu0gZW4PMSggC36F4VasZbmifgPoWuI=;
        b=QwY/Bwmg5YslCbSNkbrFjpl9/puVcSLsPZlerAPk3Jq/JR8mprWTSpKFOw93n+a5NO
         /IJKqY/0O1Loj4sDDVLmxXVyOFYaPwt6trT0BXSTke4ShYyvSSRukCLXGwKTMDgkmvbp
         Vgy9COpzG93ccY75/17j5TNd5Xx1EQizjZ5k6PLMd8JRGxQRYVrGX+lCwIOhOL+daf92
         N7YTQEytic4ZX2pRx7xZHg1r/KgbI9N+foD5BVDO2q7QpGh5g9lxpQxJx8hdERpeIKL3
         YHTSyPS9BmRUzsGQlQaor9u5VW+9JGtZOlTcTLc2Nlu1+yyxq/WIpBHTnM1OLJX9bd+8
         mLuQ==
X-Gm-Message-State: AHQUAuYA2IjfCG5yiUCurWeGAF+1r5iTNletoH2NYB/p5IAD+/ZzKHrH
        BmT8d5evuAYM4X+fjoQy3qsUA9j0va4k9FtoEEk=
X-Google-Smtp-Source: AHgI3IbKPwklhiU8ydtcG9noJ5jAfSbJJt0doWjV1xUv77J0TeuqvMwZuPTLw0jnup8jiC83Y/HFzw03nBMA/0qmFAI=
X-Received: by 2002:aca:bac3:: with SMTP id k186mr2059688oif.67.1551180906897;
 Tue, 26 Feb 2019 03:35:06 -0800 (PST)
MIME-Version: 1.0
References: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551178385-14572-1-git-send-email-abel.vesa@nxp.com>
From:   Chris Spencer <spencercw@gmail.com>
Date:   Tue, 26 Feb 2019 11:34:55 +0000
Message-ID: <CAGUNXRQk3XwGr+LJO8T+m5sqJPSa6r69qqS7r150Rq-C4fuEnA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx: Add generic i.MX8 SoC driver
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>, Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 10:53, Abel Vesa <abel.vesa@nxp.com> wrote:
> Add generic i.MX8 SoC driver along with the i.MX8MQ SoC specific code.
> For now, only i.MX8MQ revision B1 is supported. For any other, i.MX8MQ
> revision it will print 'unknown'.
>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Tested on i.MX8MQ-EVK. No idea what i.MX8MQ revision I've got on my
board, but it shows 'unknown' for me.

Tested-by: Chris Spencer <christopher.spencer@sea.co.uk>

Thanks,
Chris
