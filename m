Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25AFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1220827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tx7aaIzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKITXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:23:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36168 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKITXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:23:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so1046514lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZOuUjB4fjbeuRb1y06FXPyI7XCGREoEand9L0H+BlM=;
        b=Tx7aaIzCL4eP4N6r6tL8XY3qzqjUs+1Rt2raPBbpPrIUR488kXd4gf+vM4ikVjrGkp
         eWKrWp+fNOPV1mN2Ui1k2QkBWLH1/v94q7rQDES1Xnu3zqqRIVRWBALdhz1XSPHZQZUD
         gyYO+RiFRmApPZedAqizscHZRwD7RwoBFddhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZOuUjB4fjbeuRb1y06FXPyI7XCGREoEand9L0H+BlM=;
        b=ArNXrvnZ+m9LKbu1RzBkiBo0DL8KCHdPXt7b/QO362KWfjeFbvvnBTTnY92z9ou1zg
         8GRKJ8S2IyCCsnLYqKr3z1cxkIBeMa8qPsdicWzEmSUDN6jE8hF7W+Zxe+5EWMZ/l536
         cmL7/HeCkPYt4Mt0aAa7xeWL4B2Sg8NIfpq3wnHU4CIbZ8CvYvSxGyC0o0+yFLCPunll
         htzxfmwIJop4FJ2Aq6aU2G9dL7ctuI6CUzeJifZeRhfE6Lguh43CztXuxMQUoRRRYaRH
         5cPxrlcf/y0jEkbUE0RqWll025Q6yorWYxTHaJPVL8PxMPOWdZT9/BsTUociH4HuNIyG
         VJpw==
X-Gm-Message-State: AGRZ1gLE0ctovXYc0qiuivsH/0mI2AUsaTlc6/8fngDMm3CY1Srq9YET
        EWMylfFk3eTfpj4QRfdPTGu+IqgfrH/FkBIid0nsaQ==
X-Google-Smtp-Source: AJdET5e/uK3f3DtGY6HBA8l/ttyxzAY8U5W9wpfTr1pnBqypYXnvqWKwDpn2c255M7/uiUCmV+DmMuZ+JxVcyry6yUI=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr5085195ljp.12.1541756601225;
 Fri, 09 Nov 2018 01:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20180829082413.2512005-1-sravanhome@gmail.com>
 <20180829082413.2512005-2-sravanhome@gmail.com> <20180829152049.GA21136@Mani-XPS-13-9360>
 <7fc376ac-5998-57b6-8989-908d7a0abfd0@gmail.com> <72d4911a-588f-9bf3-4fad-a0b34692ecd4@denx.de>
In-Reply-To: <72d4911a-588f-9bf3-4fad-a0b34692ecd4@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Nov 2018 10:43:09 +0100
Message-ID: <CACRpkdZK2No9sBRCwUWv=ieCund78hKvaL=oxmQzg5M-Bnhz0Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] pinctrl: actions: define constructor generic to
 Actions Semi SoC's
To:     pn@denx.de
Cc:     saravanan sekar <sravanhome@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mp-cs@actions-semi.com, Jeff Chen <jeff.chen@actions-semi.com>,
        "Thomas C. Liau" <thomas.liau@actions-semi.com>,
        linux@cubietech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 5:43 PM Parthiban Nallathambi <pn@denx.de> wrote:

> ping on this patch series!

AFAICT there is some feedback with issues that need to be fixed,
also the patch should probably need to be rebased on top of
v4.20-rc1.

Yours,
Linus Walleij
