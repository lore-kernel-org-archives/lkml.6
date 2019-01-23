Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CA3218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzTC9vFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfAWSZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:25:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36873 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:25:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so2814943otq.4;
        Wed, 23 Jan 2019 10:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBaoiU7eR1QLYUu1fuep2rQ7Trl8sJuH/fe25wut9bA=;
        b=rzTC9vFa3foJ6/lEYJRbSFvun6uOBD28iWnfxI2s1iAdRYYIhMObQFMiBuIlBUV7Ir
         4zYZ2c6Q3YXPcOJdKcjxCmljw6J66jcOzc9TOlVXCg+Nu/9rhtE0jhHbos67vvGkt6EH
         WkTAHOfXQyAoqf/k9FFCi4qNWp2uONP674qhI0Ti3dI3ktcHfhWzlUP463gRXKSd4GhP
         +S0N5zjweMAeIDCFxrwrSMSJ7yA5W7EY25218D62j+9nJZQZbyOzujhxguL1KfcxLB4s
         l2xG/GmBbYaCpfIn7m+f6PcRyUmqr5p7AfSWJmgub8fjZO5lylP3Phqm24WqZN+/GV/H
         P+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBaoiU7eR1QLYUu1fuep2rQ7Trl8sJuH/fe25wut9bA=;
        b=ja7EAzmiFyyW7YgbLK3rkm4jDuSBYfirWS0IH0jspUIqVCfKRo/neIL0kxAD2iDpFN
         6s/lBPbxTA8B6pkf+BYGO0rWmVe+sKIylAl8oSeuupwFWG+LQlHVpyaEI3JBqOWMQose
         atSZFu6c6usxs2JMdec7ilv6egbs91Tse1gLUSwF34q5m+DJcbCZK8M5JW1xS3JBbE9h
         4PvYpA19FvzTNIyNEDDsvqRjqRQ402XQCPmMYKYfZIrO2UbVt/svzknAs6RCSqcSTpUR
         kpjIyddS4A7Dkn20wMvg3naYfrckGUAy1/DFpfMRUGM+PiiAMvDNF2rbx2ZBIyn+VZxx
         nXiQ==
X-Gm-Message-State: AJcUukeJBXrILdSF9ixzs/Cr0lgSPtwWWTGJKEFdZu8cEmPzCoIoXRg4
        rF0WSROFpJS7IpfRm988XGNiV71y82AWAVSg5pL7XA==
X-Google-Smtp-Source: ALg8bN5uoY796+LtwhysN861ig8AM7za5LQWOz11AtUofkIZ5oAfxtgbH9TL+LhBLuNVrtPex97qVElNIGFXRrnaA2w=
X-Received: by 2002:a9d:6297:: with SMTP id x23mr1981688otk.63.1548267916656;
 Wed, 23 Jan 2019 10:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com> <7hef93mi88.fsf@baylibre.com>
In-Reply-To: <7hef93mi88.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 23 Jan 2019 23:55:04 +0530
Message-ID: <CANAwSgQXFWNP4NdmheyE2O25FzBk7VOwbY1h7rx4GrH9J4XiZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
On Wed, 23 Jan 2019 at 22:20, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Add missing vbus-supply link to phy controller for usb_phy0
> > and usb_phy1 nodes, this changes fixed the power issue
> > on usb ports usb, changes help fix usb reset warning.
> >
> > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> >
> > Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Rebased on Kevin's amlogic/v5.0/fixes branch
>
> As requested, dropping this series from the fixes branch pending further
> debug and testing.
>
> Kevin

[snip]

Thanks your very much.

Best Regards
-Anand
