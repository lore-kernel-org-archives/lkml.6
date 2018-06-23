Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40A0C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8111824C5A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 15:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNhky2Pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8111824C5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeFWPtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 11:49:11 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46203 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeFWPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 11:49:10 -0400
Received: by mail-ot0-f193.google.com with SMTP id v24-v6so10698260otk.13;
        Sat, 23 Jun 2018 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KmDxz6cgCU9jamxqTlGWwOGTG7suYsbO6R3ocu7RdoA=;
        b=FNhky2Pgq04HYVLmKpQFFwVdCUMv7PUtkj4BWjWV77TalytZEhwsOsnFMEfSQnzI41
         OwwsrDdzVTJ4kztbaX1dQh07p6m1thjtQNMHtcd2I7fj4+NDMcCpYjis1rmIVb8gDB2D
         hiSmyvU10gHGBi9VYHkOW5Q1u0yW3hSlEFFiqlBZFj6QArNyC9XOtfidctkus6JvPC3m
         h4hyPtMGTMxTSd97Iru9lpENeJtoL4tlIAvBGqnnyDl02rbatEnr+XPRWIQwg7LMh20t
         moa1KgiG8LHdarYqivIsPxp3QVssERF6XpvakWpmt/ZRI1Yg6m2KaqsCyOwJSedPdSxS
         cGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KmDxz6cgCU9jamxqTlGWwOGTG7suYsbO6R3ocu7RdoA=;
        b=ePpOenoO53sD2gns3tj4hza7YTD+Vy+Qgg3jpyAqYVJckKmnpyRgDt3AGD5cWmKjxy
         OzGa3chWSj6+WqCPaLpRHk3MO3NGNsl3TtNz+4oG7fG5AoGdeFBb2FOI27QAgJF+0kCh
         yaYCYT/6eq4webpryV+wMeVNYnrxZHvbpfxzH+03NjlpGIKuXpvTwdwWzA6FJIgRaJ7V
         u6AZT0a6iv/f/OHWVTwnUJZsDbBPVa6qS5amRcTjIGz1ZQ7omu9C3bk2vlW5vt4QZ8hR
         flKMVtBbOxx3qlzPyTsXXt5rz2d8JrWbF7Uebuvou5/7/yyS+mFDM6rmLElk5IL/s7zF
         6ArQ==
X-Gm-Message-State: APt69E3FNoTiu4yYlUmPMDor4ihgVIn7fMmijRd2fUPyieGiNrDwwQ8p
        YICZp04AFaPnDKce203763bea74pqZo+5b2dopQ=
X-Google-Smtp-Source: AAOMgpeF07XHETOkPilfvvyBwutVt/voyjzC6rV+Sky8O82WpoR4qkWBcVJ1Jb86Ye2ZyN/ToZ46F35pX2ns5J+gVZc=
X-Received: by 2002:a9d:56e8:: with SMTP id b37-v6mr3342169otj.175.1529768949237;
 Sat, 23 Jun 2018 08:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 08:49:08
 -0700 (PDT)
In-Reply-To: <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
References: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com> <1529649154-5724-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 23 Jun 2018 12:49:08 -0300
Message-ID: <CAOMZO5Dnzk-pmFHNMXL8Zma_B2867F-tDgCO3A0uRqdbOPwUQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: imx6sll: add gpio clocks
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Ping Bai <ping.bai@nxp.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 3:32 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL has GPIO clock gates in CCM CCGR, add
> clock property for GPIO driver to make sure all
> GPIO banks work as expected.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
