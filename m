Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66516C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2142120878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BejqA3X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2142120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeLDKTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:19:10 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43718 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:19:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so13755815oie.10;
        Tue, 04 Dec 2018 02:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ks087rJNMucCjyXK8QciBOZcbUjlEFozJ15GONL0jy8=;
        b=BejqA3X+DeYoLNY43pL5hyyqxITYMA61jrl9RTCyBqAqFM5mSCNnXxCTTZsBzTsUQm
         1qZ0g9wH5tbyIaD858A069xM9QVQwmN7YxX7aE90ZGFuVcHX21e/ABx2DQJD9cJpHWat
         UAcrKyNBA0C8a6/Ith6h6LLRk0iFHJfZwiOdxzdPwI9Cx55q/KdFNMa9i3VprbOfMv8h
         s5loroSBQAyhmt95GTmS7zuTYcbPqUE79L91fNTRNiY4OyxzAhUoosoTH09oZp6Tbo7J
         JqPce7GihOPgcAFnihiI6wkgPjUqu67Mau2FjQcmumAyUL9QuxWT38jD2EMfuvxgWvQE
         4TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ks087rJNMucCjyXK8QciBOZcbUjlEFozJ15GONL0jy8=;
        b=gorWss/4Pxkokw5q1ZCX9u7ozHhm5FUi9pOxCVxeM0n+s2CDei59Rq6s/c0cJYk1zE
         Gqqpzd6iW9kGW2BsijKiRx+MLhVv61w5WRkYOuIMbG0mLnww74VcAx3yo9Ita+Nep7Kd
         QClYugjMXYlbblgZ2fYfXzur9rqgWF/+idHx4WN0SC+qQGZx+dUGYstM+kMCcOQ60yzT
         QFhFzdE5qZ1OmaC2X66qZOHAK4avH1djzDlEduYEfnX3J0tYJDv2hZIIPDidJzDQKzyY
         Pc8eCLZx/hRyzLOwGXigZ0EAOgpDt+1igr6H+T1EHpluO3JxoY1aJZ0iWXtKemL0cw+Q
         qRVw==
X-Gm-Message-State: AA+aEWaEaWtBEH/ZTK1sLvcHC983UM1NRRJ/azsalBJHWeMTJFk//GxG
        KJUhuqGLGZWOLwrob/Vikc57WRaBFEIo0lSn4allaQ==
X-Google-Smtp-Source: AFSGD/Uvl2zMeo5VrV7270WwbzuwAP+7dszbq6MsrSYAdl/F44w0Jn/ihm+kbSIXRlefSmJE21jT/j6FgYzT9tBxN5I=
X-Received: by 2002:aca:6155:: with SMTP id v82mr3186139oib.259.1543918748824;
 Tue, 04 Dec 2018 02:19:08 -0800 (PST)
MIME-Version: 1.0
References: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543913303-6216-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 4 Dec 2018 08:19:11 -0200
Message-ID: <CAOMZO5D_GTWvLUjJaPSmhPqgjadJh_4pTZqHKz92=1ZAeYkstg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: add egalax touch screen
 support on i2c2 bus
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Tue, Dec 4, 2018 at 6:54 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add egalax touch screen support on i2c2 bus.

Please improve the commit log saying that this newly introduced
touchscreen controller is connected to LVDS0 and the existing one on
I2C3 is connected to LVDS1.

Thanks
