Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD8FECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4F720658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4F720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeJSEoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:44:17 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35889 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:44:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so29722513otg.3;
        Thu, 18 Oct 2018 13:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kF8WkYCTMl50v4ZLFXYn2h/JfOCPQn+MzE3mBFdK6os=;
        b=qq9c+h/5R42KKr/UySDYpfHESGiWbtSXkXPLzFqCVYQRvdnGhQ/S84WkUob/DembKZ
         r/OgJ7gk+IwQPZUd4vwTxg/eK4NuFXWEPCiI0Br3JWhzC1lNjrmKcMSbvjmYTz0TmGo6
         Vx7uvloeSBYEI866iXYZEOKHkbMEcPpn2l865onN0akM00kVXSGq6xgd4aQXs6nGNLS9
         3FU6aQucH4F/3RpK/vN6iZFdfm9HrGah+HhlHHcQvQd+WYU7RiSsu4GDOAfhvWF/CIbR
         sNRHR6BKL3m/2+mAbbZaad5sTuhaYnpxV/TW9OjkqxBYmHAS6DmpyKhWB+HTm/qqNXBI
         fA1g==
X-Gm-Message-State: ABuFfoimwpa1mJAAY8piq2rXnyssj+cEWd5vcS0T1bI4V5Plgtfs6wLJ
        VorRv3JtHYIlLkARqgqbiw==
X-Google-Smtp-Source: ACcGV63gh8vCsDpPQ4keNGYusa+ixEwtKXtrvfw8NecRqKcDteX0MrZsptZgwXcZvzq9S2O4PDqb8Q==
X-Received: by 2002:a9d:11f5:: with SMTP id y50mr21229878oty.306.1539895290736;
        Thu, 18 Oct 2018 13:41:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l56sm7018844otb.65.2018.10.18.13.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:41:30 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:41:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Lei YU <mine260309@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20181018204129.GA25436@bogus>
References: <20181018144251.30028-1-poeschel@lemonage.de>
 <20181018144251.30028-2-poeschel@lemonage.de>
 <F2B73CDB-434A-41F5-8A9E-3E4E76DB89C9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F2B73CDB-434A-41F5-8A9E-3E4E76DB89C9@holtmann.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:03:13PM +0200, Marcel Holtmann wrote:
> Hi Lars,
> 
> > Add pn532 to the trivial-devices.txt binding doc.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> > Documentation/devicetree/bindings/trivial-devices.txt | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> > index 763a2808a95c..c580be08a380 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.txt
> > +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> > @@ -172,6 +172,7 @@ nxp,pcf2129		Real-time clock
> > nxp,pcf8523		Real-time Clock
> > nxp,pcf8563		Real-time clock/calendar
> > nxp,pcf85063		Tiny Real-Time Clock
> > +nxp,pn532-uart		NXP PN532 NFC-/RFID-Chip, using UART interface
> 
> is this really such a trivial device? It doesn’t require any GPIO to enable / reset the NFC chip?

Considering it supports multiple interfaces, it is not.

The '-uart' can be dropped and the same compatible used for any 
of the bus connections because the device is bound based on the bus 
type.

Rob
