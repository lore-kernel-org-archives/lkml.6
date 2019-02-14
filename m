Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E41222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfZ/DV3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437166AbfBNHJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:09:48 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44103 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbfBNHJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:09:48 -0500
Received: by mail-yb1-f195.google.com with SMTP id b15so1982222ybn.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xx+29PGBPyVcyZc/GWIilf/KpMu+6bjEU292kyGU688=;
        b=lfZ/DV3BXCyV2fgQTbmJHMkJbvTR0chiAqynHav4fl9z1OubpwzrVde6Q/6DEG4+Ua
         +wOIlBtpvlXHGW1ksa6dhVcUI9A7Szdq4QS8xZBsjIXzmqYWbUZ7bNGubaNEdek0eRZ5
         /nPMAIAXFjE6BCJ+IgLxPmJGK5kOMY7a6JRobrlAiFb8Bl5gyRnUqBJFuip0beLWVeif
         Ft27IC7pwuLRaW+HBC29plz9nI5/HjfZK+2iAcbbbmWP3aXt97vVJC/lY5dCve0OxGgL
         +QGqRuyqw5Co/l68xJx+hG0rZyyvdibu2FOJitnjhEvVwUWYGCqbhzjU1OgzmD6Ccz6e
         X2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xx+29PGBPyVcyZc/GWIilf/KpMu+6bjEU292kyGU688=;
        b=aEpHNc1MHJrvk3gH8GHCbcWdfFI4dim5INte7H3JEpBLW5tCR3J6TdU62OvvbDDJnu
         xc9VNlTljU5V6D6iXtCg/rq7clkLMOz6W0jJiZJ7sh0X1jBzOPm2yuofhUm34TeP40es
         r0hU38uiOIpgOSVq/ggwXrcx+4VvNIV8Ci7lL1uhriQMzebHO1VRtTX61t9vdngaVaPi
         TKGRbB4ZHLiRxqMAacJCuAJEo3Dzzm7VHEmdzg8QJyjbau2zQH5k9zSkV358o/orvc0p
         8yKb6U7ClO5O/Xm5BfBY707jJGAUxAtQtwYYr59q0He9GWxC5qZwFgZbp3Z/YZGMEcQy
         ojVw==
X-Gm-Message-State: AHQUAuYuf4ysjm9H5NaSoZgrp8QNt2slarrB2vtE6dkpdJFnsPpK0KWH
        SS20tCIVSJtfGh4MqyCLW/U=
X-Google-Smtp-Source: AHgI3IZDLM/GSz4FG830PceTg7bxFYBkITL7grRd7ygQNVDBBSSYUR8NvTqBV4hqC2NQMJSOVhgfZw==
X-Received: by 2002:a5b:4c1:: with SMTP id u1mr1815799ybp.82.1550128187324;
        Wed, 13 Feb 2019 23:09:47 -0800 (PST)
Received: from localhost.localdomain ([46.216.144.58])
        by smtp.gmail.com with ESMTPSA id 205sm599090ywf.35.2019.02.13.23.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:09:46 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.92-RC4)
        (envelope-from <jekhor@gmail.com>)
        id 1guB9T-000775-P6; Thu, 14 Feb 2019 10:09:43 +0300
Date:   Thu, 14 Feb 2019 10:09:43 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] extcon-intel-cht-wc: Make charger detection
 co-existed with OTG host mode
Message-ID: <20190214070943.GB16597@jeknote.loshitsa1.net>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <20190210203649.21691-2-jekhor@gmail.com>
 <767c3d5e-f521-4d59-3922-a322b4124126@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <767c3d5e-f521-4d59-3922-a322b4124126@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:15:00AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> > Whiskey Cove Cherry Trail PMIC requires disabling OTG host mode before
> > of charger detection procedure. Do this by manipulationg of CHGRCTRL1
> > register.
> > 
> > Source: APCI DSDT code of Lenovo Yoga Book YB1-X91L and open-sourced
> > Intel's drivers.
> 
> Hmm, of the ACPI code is updating the otg-mode, then there should be
> no reason for us to do this, can you provide an acpidump of your
> device please?

sure: https://github.com/jekhor/yogabook-linux/blob/master/yoga/acpi/yoga.acpidump.log

Yes, there is ACPI routine for switching this but it is not called at
IRQ handling because it is handled by extcon driver. See my notes here:
https://github.com/jekhor/yogabook-linux/blob/master/yoga/acpi/investigate.txt#L364


-- 
Yauhen Kharuzhy
