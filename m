Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b/H0GylkGlumIQAAmS7hNA
	; Fri, 08 Jun 2018 11:11:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 88086608B8; Fri,  8 Jun 2018 11:11:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXQqx4va"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F270A605A5;
	Fri,  8 Jun 2018 11:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F270A605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFHLLC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:11:02 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46014 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeFHLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:11:00 -0400
Received: by mail-wr0-f173.google.com with SMTP id o12-v6so12956255wrm.12;
        Fri, 08 Jun 2018 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Y5jdx0IWvaegn9iqEdmgZfEbQV5BOnpbYbUzTBsWm7w=;
        b=eXQqx4vamKJ3R01KIG+0Q5/L55veMjviwD/m//vGjD04uFeHwt75dg/L5+rA4dCOaF
         vrTr5E1JO6T30BpQghAk+vDiKi/51L4eh+/0kumAiorWSHemlh6CfPxQLlKgcdc2Q2Ld
         hed9ZuaLoHjUXSePLLsvt/gUl5n9assHt2g5MNu0bHE1EH8ziG6kaaFa4UvHo7Q0oweh
         r+4hQ4dfMX5dpghx354WpJLusDECcwYiu413DQ4Da534ltn4LhRstMktkiMjAfcUrF0V
         aDeKiPCtKmiG3I1dXYwbuqJtc9k0B+eQVbo+Y1kj2n2uMZH4oSJR4iI1iRgnldH0sx3X
         uaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Y5jdx0IWvaegn9iqEdmgZfEbQV5BOnpbYbUzTBsWm7w=;
        b=k7dNm5wML5nxsvSIcHUwgGs6uNJx7UK+C0mEYWHIEg+kR0LlIHeOxZWkQBfaYHvZaW
         Mm5FWB4vTnbg3qnCn/pmrTAtO7s22B78A+Fyk36gfvg74+fmqXq371/XcPvKa9gJCQPn
         KReZSgTwtTrBbpFj6B6kt+gyBvaRClErtinIxypTopcxnxc7NGpkx0d7jTWrCNZYfT83
         d387pVbKa1S2KxelxSkQgT6CIGOTRwCDVHRnRA6vKjd/bNSohH47Cojc7qLAzFene7hJ
         I07RsATSw6JsXbJPQ7CvkDOVfepaEONXcR6a0IvJ5VdpW0hjx8E+w/DU5j/AfHzLoIW2
         0uPQ==
X-Gm-Message-State: APt69E3ECEvADkokUEph0vzW5PY/CtXuDC/zM6jYoy0ypmv8iipQ7g3D
        uT0UGqtiZ7aEvKWbjSFcjP4=
X-Google-Smtp-Source: ADUXVKJAraZ3LQtU2JPY+l3PHKtY7esOdqMe3L8s2jj0VRML8ibG4rFs1+hA1lXviy98APTAqYIrog==
X-Received: by 2002:adf:9950:: with SMTP id x74-v6mr4484109wrb.135.1528456258882;
        Fri, 08 Jun 2018 04:10:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c131-v6sm1300934wma.41.2018.06.08.04.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 04:10:58 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:10:57 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180608111057.4wxpg7m7nm7suf6n@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! With up-to-date thinkpad_acpi.ko driver on ThinkPad T480s I'm seeing
a strange behavior of LEDs which are integrated into mic mute (Fn+F4)
and mute (Fn+F1) keys.

When thinkpad_acpi.ko is not loaded, then mute key is working fine. When
pressed, it correctly generates KEY_MUTE on AT Translated Set 2 keyboard
input device and also turn on/of mute led. But when micmute key is
pressed then, nothing happen. No key event is reported and also led is
not turned on/off.

On the other hand, when thinkpad_acpi.ko is loaded, then both buttons
mute and micmute correctly generates input events; mute via AT keyboard
and micmute via ThinkPad Extra Buttons. But led is not changed. When
thinkpad_acpi.ko is loaded it turn off both leds (mute and micmute) and
leds after pressing any of those buttons, leds are not turned on again.

When thinkpad_acpi.ko is unloaded, then pressing mute button again start
switching led on/off.

So it seems that some init sequence of thinkpad_acpi.ko breaks mute led.
And fini sequence of thinkpad_acpi.ko makes mute led working again.

-- 
Pali Rohár
pali.rohar@gmail.com
