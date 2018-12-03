Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D62C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA5820848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA5820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLCPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:51:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47100 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeLCPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:51:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so11143727edt.13;
        Mon, 03 Dec 2018 07:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFzo/slJm2cznF0olPEsCEDt0PV7/qxQRkqsEszYN7k=;
        b=r5kqhsld+J0OkZ1fiu3NN/9zh1UKRwVEoiXVTmNdCnjT5a8qbmULP7DE7y7QDyaiyi
         ROm/gvh3OQyxlGPMcK0XiST02csZbNyEptQOBNMfPyQ7A6rRHmveJ6AGngABy7F6OCKW
         S/m27/8tMZmS16zW4NAO78S+E8tVrfpXfn1XLYs+wIyWBqRMays6iC+HCsaoOncwneqd
         3ZAU7TFULz8KaCMNe1HEEgynbA/tTnGuPFQ7QP7nL6nKRYpxqP241JbPVcURUg6IePT1
         VgejF9uFThUjVFLdBxOfBN9LnS850xjJqW3ok6O7InfLQx9AvUBpMLDihb3E5tJN4wXz
         Bqsg==
X-Gm-Message-State: AA+aEWZFA2YrVFeN3VW9FZNi42teZQd4Vayrwl0jBRkKZ36sZAuScW/F
        H4VQLqFlKAK/D5qDRTvpI8TaMK6iOre9MA==
X-Google-Smtp-Source: AFSGD/WniQ5xroyYYxvEAwK2J99k358sAtRyZBW3FBadxSwO/cwXAJ/62Ros+wHaWP96e3kkG7UVYA==
X-Received: by 2002:a50:b68a:: with SMTP id d10mr15329362ede.16.1543852310542;
        Mon, 03 Dec 2018 07:51:50 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id x30sm1734194edd.30.2018.12.03.07.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 07:51:50 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id s14so6411273wmh.1;
        Mon, 03 Dec 2018 07:51:50 -0800 (PST)
X-Received: by 2002:a1c:f605:: with SMTP id w5mr9273856wmc.116.1543852309542;
 Mon, 03 Dec 2018 07:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20181115093603.26729-1-wens@csie.org> <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
In-Reply-To: <CAGb2v66YJ8tkd8wMsBBHETO3UfQDNdmDtgy6SrUXSYergsSUTA@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 3 Dec 2018 23:51:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64CdrT44H0pf4RYXON4d145kMz0DnWQL-+4hT-MOx935Q@mail.gmail.com>
Message-ID: <CAGb2v64CdrT44H0pf4RYXON4d145kMz0DnWQL-+4hT-MOx935Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ARM: sunxi: Enable Broadcom-based Bluetooth controllers
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:25 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi,
>
> On Thu, Nov 15, 2018 at 5:36 PM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > Hi everyone,
> >
> > This is v2 of my Broadcom-based Bluetooth controllers on Allwinner SoC-
> > based SBCs series.
> >
> > Changes since v1:
> >
> >   - Collected tags
> >   - Re-organize dt binding clocks and clock-names properties
> >   - Simplify check for deferred probe when getting clocks
> >   - Add explanation of Cubietruck's clk_out_a pinmux setting placement
> >     to commit message.
> >   - Add missing "uart-has-rtscts" property to Cubietruck device tree
> >
> > Original cover letter follows.
> >
> >
> > On many Allwinner SBCs / developer boards, there is a WiFi+BT combo
> > module from AMPAK. Inside is either one or two Broadcom chips, depending
> > on the model. This series enables the Bluetooth controllers for AMPAK
> > AP6210, AP6212, and AP6330 found on several boards. More will come later
> > as other SoCs require changes to some other parts. I did not cover the
> > SCO PCM connections from the controller to the SoC's I2S interface. It
> > seems no one is actually doing this, so I was not sure how to proceed.
> > Any suggestions?
> >
> > I deliberately left out the netdev mailing list and Dave Miller, as the
> > only thing that is under net is the binding document. Maybe we should
> > move that out of Documentation/devicetree/bindings/net/ ?
> >
> > Also, I'm not subscribed to the linux-bluetooth ML, so please CC me for
> > any discussions.
> >
> > Patches 1 through 4 are device tree binding changes:
> >
> > 1 - Make the external clock name unambiguous, and add a second entry for
> >     the LPO clock.
> >
> > 2 - Add regulator supply properties for the VBAT and VDDIO power pins.
> >
> > 3 - Add a compatible string for BCM20702A1.
> >
> > 4 - Add a compatible string for BCM4330.
> >
> > Patches 5 through 13 are changes to the driver, either improvements,
> > or updates to handle the updated device tree binding.
> >
> > 5 - Make the driver handle deferred probing for the external clock.
> >
> > 6 - Simplify clock error checking for subsequent clk API calls.
> >
> > 7 - Handle clock-names for the main external clock.
> >
> > 8 - Support a new external clock, the LPO.
> >
> > 9 - Support regulator supplies.
> >
> > 10 - Wait a small amount of time after toggling the GPIO for the device
> >      to settle.
> >
> > 11 - Add support for BCM20702A1, including its default address.
> >
> > 12 - Add BCM4330 compatible string to the driver.
> >
> > 13 - Handle default address for BCM43430A0.
> >
> > 14 - Enable Broadcom-based serdev Bluetooth for multiple Allwinner ARMv7
> >      boards.
> >
> > 15 - Enable Broadcom-based serdev Bluetooth for the Bananapi M64.
> >
> > checkpatch reports an error for both patch 11 and patch 13:
> >
> >     ERROR: space required after that close brace '}'
> >
> > I followed the existing code's style. If this is undesirable, I can send
> > a follow-up patch fixing the entire code block.
> >
> > The first 13 patches should go through the Bluetooth tree, while we, the
> > sunxi maintainers, will take the last 2.
>
> It's been close to two weeks. Any comments or concerns from the Bluetooth
> maintainers? I'd like to see this in 4.22 if possible.

Ugh, I meant 4.21.

ChenYu
