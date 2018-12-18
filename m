Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F05A21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/uKzHzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeLRO5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:57:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeLRO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:57:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so7922018plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oPB8RR+121EFL6hJxdpqH9a7Rzs6OxHUxpWYpeBbqVE=;
        b=J/uKzHzTJbz/I4UR5vW8rnKaBvgH4q/HxaFhUmG+v8FLAc3Dxu5pbWXgQBzhIiF7oI
         oEN0oAuXcS7S82Mn4WoMadBt00GVonjsJUkw4eAE/d9pRDwdDEXF820xe6+g3RTe61O3
         4petINecqiL8LczvuWdAalCg/e4HXQ4AnQm04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oPB8RR+121EFL6hJxdpqH9a7Rzs6OxHUxpWYpeBbqVE=;
        b=DFL/0qFlIgXyv8154VjnRlFRym5pKlKjqmPuXEyaJx/zV2qSR1wN2VXX0o7bprXNYO
         6oiIsAcS905F5XAyt/oPe+xXvmzmwRo3NJfiBS6lsdnGU5ywjv5Iamq6KpjmqmEPLiKB
         8WqngKx+BHMBdtwz5HuwZxeLsVYyuvbsPycb2O+ArATP2hAdUZS1EK12qw5QxOU+mpT7
         OPgIVW2myT4MliDpUSuwK9mV2TiQr4TnJFPooTpe2fejNb9vnlBJLCGvGewT4CkMW0Tz
         YYhU+6v3EzcCvPWmggnyDF6NpqtlHkJ6p0zJVd/R2tnjf4KEh+r8ZrQP1XF5tQhxZM25
         1UTw==
X-Gm-Message-State: AA+aEWYJZasAqZTJBYT5O7N+csqR2ztZDKUzJaYjt0BqMH5vJ2XUwkG3
        liJMQeqe800x6eurB1Y4A+lC
X-Google-Smtp-Source: AFSGD/XbkKHNv6vUO7lTSsVI93TGxtAlY7xLnt9nlCoIPUXW4wRHb2lMzPuI9Mv/hZRbk+I1dvRrBA==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr16185671pls.322.1545145063665;
        Tue, 18 Dec 2018 06:57:43 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id l69sm32517835pfb.75.2018.12.18.06.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 06:57:43 -0800 (PST)
Date:   Tue, 18 Dec 2018 20:27:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     olof@lixom.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-unisoc@lists.infradead.org,
        afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net
Subject: Re: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181218145732.GA22420@Mani-XPS-13-9360>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
 <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
 <20181218145443.GA5150@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218145443.GA5150@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 08:54:43AM -0600, Rob Herring wrote:
> On Tue, Dec 18, 2018 at 01:35:24PM +0530, Manivannan Sadhasivam wrote:
> > From: Andreas Färber <afaerber@suse.de>
> > 
> > Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> > 
> > Signed-off-by: Andreas Färber <afaerber@suse.de>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> 
> Please add acks/reviewed-bys when posting new versions.
>

Hi Rob,

Sorry for that. I missed your Reviewed-by tag here. Will add it in the
next iteration which I'm going to send to ARM SoC list.

Regards,
Mani

> Rob
