Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5DBC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D1320827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnExe5do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D1320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeKISi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:38:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41124 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbeKISi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:38:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so758822lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03XSgks2iiQkNbx2TWJrKMU+6zb5k/LCbR94oOE7ukk=;
        b=CnExe5doS6RIm6AGsKJ8xNi3Nu+VRUcSjtqs7D5ngBzN94rfp/d4O8wqSC+bGwBXQw
         tmWhcEVMOoZrszh8/vapUNfJ539gKMQwnfD1Oa7Tcz71ILpGnthA0r6X06mqXgDBgrah
         v/TAdgGrMA96Bsl8ILB+4RgVNJQhsmiX/EWgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03XSgks2iiQkNbx2TWJrKMU+6zb5k/LCbR94oOE7ukk=;
        b=FS97pyrCLsoFogWsRXL9tJO4J/aqhUDjBH1Cx6ZPqfgVzRnqsJBHA8RDTKudOnSPZs
         s6v5XxPKXYn+ykq7bWKxu7zzLzVyQsazdNH65HhV+7hwys7pYGqEaEKMzI9sbYXy5W+T
         k4+JF7PxCHt/hw0s2veTVjIQMcFJe0+OH1p4V/uDuGYptQxKMbsA0Fd6oaj6yuuxiG9V
         EmYcIdijl17gspXtt7a7KXDJ4xEkwN5Wx3IrpkoFBMcQN0cU/3ObNXYOsrRKgiyJ2+n+
         4wvNwAfIeYRUXBw6IkLhDEbnCqJ7QX3oMELxwiKYNkWVqvGwE9f7AKDNSDY5XLVtBYDe
         cHyg==
X-Gm-Message-State: AGRZ1gIngz2jcsQxkKIqomZspXGfYvvh/Aq6LYf+uqtIZzWT/PUt1Kwc
        Zg5SHb5634+yv6mSdSu7fQ+r9gnJnvKJu0mDg+FSFQ==
X-Google-Smtp-Source: AJdET5c25ToILMI4uT5kgls/KHLC5wpy7wpn2Rzr9SZx4bNZ2EYWfGUGqXuyxSDYt4E0uNA505gZ9gVmWsyGPbxUD5A=
X-Received: by 2002:a19:5154:: with SMTP id f81mr4958591lfb.96.1541753959870;
 Fri, 09 Nov 2018 00:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20181101001149.13453-1-masneyb@onstation.org> <20181101001149.13453-6-masneyb@onstation.org>
In-Reply-To: <20181101001149.13453-6-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 09:59:08 +0100
Message-ID: <CACRpkdaabE-ekKQp93CiFtN_Qp6OohEUE-qufsX=12u2p_SXtw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] pinctrl: qcom: spmi-gpio: fix gpio-hog related
 boot issues
To:     masneyb@onstation.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jonathan@marek.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:12 AM Brian Masney <masneyb@onstation.org> wrote:

> When attempting to setup up a gpio hog, device probing would repeatedly
> fail with -EPROBE_DEFERED errors. It was caused by a circular dependency
> between the gpio and pinctrl frameworks. If the gpio-ranges property is
> present in device tree, then the gpio framework will handle the gpio pin
> registration and eliminate the circular dependency.
>
> See Christian Lamparter's commit a86caa9ba5d7 ("pinctrl: msm: fix
> gpio-hog related boot issues") for a detailed commit message that
> explains the issue in much more detail. The code comment in this commit
> came from Christian's commit.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

No word from Bjorn but I trust my own intuition and applied it.

Bj=C3=B6rn: shout if it's wrong.

Question: should this also be done for pinctrl-ssbi-gpio.c?

Yours,
Linus Walleij
