Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F674C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E27C21761
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q283zjzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E27C21761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbeHMQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeHMQ6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:58:15 -0400
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com [209.85.216.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AF8217D2;
        Mon, 13 Aug 2018 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534169747;
        bh=4vGS43tSH6gOfrhqQka+O5y9pwdD3deJm1elQwdWwos=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q283zjzEX95zKoQrBNSD42KgUB+ThxYxsrDYNCKD1pY9UNe0VcjysMI/ne/OqZGmF
         aFqJgvwkKvlWiT+MjuHg2ptOTsqacNxlSs1K+8Kk6UBC1WxZpd35bGKIAuMA7zAS4W
         SpJRr2glLhgF/nXY4lBL/1RcgDNc6CoaRwIUl/IY=
Received: by mail-qt0-f181.google.com with SMTP id n6-v6so17489879qtl.4;
        Mon, 13 Aug 2018 07:15:46 -0700 (PDT)
X-Gm-Message-State: AOUpUlEtal9oaDz9JUhlTq7+BG64yXxRfSej2yEsuNQLYLi3/voOUZbc
        bujZrlG22Z9KYWACjwbOmL6kTqGnSDMlb3DlLg==
X-Google-Smtp-Source: AA+uWPzBWRZijaa8lZWpswZfHe+xRdwzqwjjFVFN+vmqJ28JnWX/Wc01rK5u/fmObD415D73wXV6bwDxs7WGk1UstsA=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr16630748qtp.22.1534169745941;
 Mon, 13 Aug 2018 07:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
 <1532120272-17157-3-git-send-email-soares@synopsys.com> <20180725195733.GA14450@rob-hp-laptop>
 <c00cb815-ae82-312a-213b-145537a294bd@synopsys.com>
In-Reply-To: <c00cb815-ae82-312a-213b-145537a294bd@synopsys.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Aug 2018 08:15:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMxyBtZBtzZOVN7Dx3guD7vgrGwH6E05P3d+ZFW7FOcg@mail.gmail.com>
Message-ID: <CAL_JsqLMxyBtZBtzZOVN7Dx3guD7vgrGwH6E05P3d+ZFW7FOcg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: i3c: Document Synopsys DesignWare I3C
 master bindings
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com,
        Peter Rosin <peda@axentia.se>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 10:59 AM vitor <Vitor.Soares@synopsys.com> wrote:
>
> Hi Rob,
>
>
> On 25-07-2018 20:57, Rob Herring wrote:
> > On Fri, Jul 20, 2018 at 09:57:51PM +0100, Vitor soares wrote:
> >> This patch document Synopsys DesignWare I3C master DT bindings.
> >>
> >> Signed-off-by: Vitor soares <soares@synopsys.com>
> >> ---
> >>   .../devicetree/bindings/i3c/snps,dw-i3c-master.txt | 43 ++++++++++++++++++++++
> >>   1 file changed, 43 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >> new file mode 100644
> >> index 0000000..7f5c8b0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
> >> @@ -0,0 +1,43 @@
> >> +Bindings for Synopsys DesignWare I3C master block
> >> +=================================================
> >> +
> >> +Required properties:
> >> +--------------------
> >> +- compatible: shall be "snps,dw-i3c-master"
> > Only one version and no version number?
> >
> > ... and an SoC specific compatible string.
>
> I'm not understanding. Can you explain?

Add the above line to the description. Experience shows that only an
IP vendor compatible string is not sufficient. SoC vendors integrate
different versions, configure the IP differently and/or integrate it
differently.

Rob
