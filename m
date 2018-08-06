Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BECFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E492B21A3B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E492B21A3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732972AbeHFXyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:54:06 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37366 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731324AbeHFXyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:54:04 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w76Lh2F2009731
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 17:43:02 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w76LgvHe025162
        for <linux-kernel@vger.kernel.org>; Mon, 6 Aug 2018 17:43:02 -0400
Received: by mail-qt0-f198.google.com with SMTP id e4-v6so11783848qtj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=wDforYBfmARGVxejAnw40gD/yifo85cdpeEEjKt5iT0=;
        b=JJLfZpCzs7jMMEPAMVnZqsM3zHqKqH4uaCgvZm81Gh38jF2b4AP4OoNmbNThu9H2fE
         7lZormfaJJ0tdnlK7c+paNQwEAVtw7owqY9KBDaQOtQHGN0M527ob2wCIbyUxjqEiUrX
         /BrfucBei6tiprhBUbrxXPK3q1kR5U4PJzApxrA+2i8973WZycQCGPK3IU/VJMbN4qWV
         S71czMn9mY9gyDkHQdB4t7RZpMlyTxtWWFJgYCry1wJARC0BYiTYIdiBLAmWMocWji8x
         BHDWO5JwjyTz3WCATeyy30eeaVDLeWT7pQ2/7vZi9G1ISRvySAp0BqnMAEMTx+uQBdwm
         C4JA==
X-Gm-Message-State: AOUpUlFGOTXcKnAMEqPPOxpM7ROQKaUYlrXvNHkzyb8uwki83cn4j2K3
        NFb6/uKlc9cgFIVtCnY170UHg0+9WqcQ0a79nUgirOdpfccHJX6rEwkwBhnESP+4iFfjqiqqVoq
        HwqT9s3HjCJ43ZDqYFYKoB9Ueyo8W5ddnf5w=
X-Received: by 2002:a0c:e28a:: with SMTP id r10-v6mr14679490qvl.59.1533591777461;
        Mon, 06 Aug 2018 14:42:57 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpcu8djTkhSpAY11FfY0oneh5K+vm+kWcPyN1bMPMq4ROLXaO+HGajqF2DSQRHDrQaIHCIgYiQ==
X-Received: by 2002:a0c:e28a:: with SMTP id r10-v6mr14679463qvl.59.1533591777147;
        Mon, 06 Aug 2018 14:42:57 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id d71-v6sm8935492qke.57.2018.08.06.14.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 14:42:55 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     pkshih@realtek.com, kvalo@codeaurora.org,
        Larry.Finger@lwfinger.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net,
        colin.king@canonical.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] rtlwifi: btcoex: Fix if == else warnings in halbtc8723b2ant.c
In-Reply-To: <20180806045440.11920-1-yuehaibing@huawei.com>
References: <20180806045440.11920-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1533591774_2560P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 17:42:55 -0400
Message-ID: <63216.1533591775@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1533591774_2560P
Content-Type: text/plain; charset=us-ascii

On Mon, 06 Aug 2018 12:54:40 +0800, YueHaibing said:
> Fix following coccinelle warning:
>
> ./drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c:2952:2-4: WARNING: possible condition with no effect (if == else)

>  	/* sw mechanism */
>  	if (BTC_WIFI_BW_HT40 == wifi_bw) {
> -		if ((wifi_rssi_state == BTC_RSSI_STATE_HIGH) ||
> -		    (wifi_rssi_state == BTC_RSSI_STATE_STAY_HIGH)) {
> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
> -						  false, false);
> -		} else {
> -			btc8723b2ant_sw_mechanism(btcoexist, true, true,
> -						  false, false);
> -		}
> +		btc8723b2ant_sw_mechanism(btcoexist, true, true,
> +					  false, false);
>  	} else {

Rather than blindly fixing this, perhaps a bit of thought needs to be
applied to why this code looks like this in the first place.

See commit c6821613e653a  (which looks like the bletcherous "do too many
things at once" commit indeed), although the actual diff appears to be a
"no harm, no foul" against this commit, where the issue already existed.

commit aa45a673b291fd761275493bc15316d79555ed55
Author: Larry Finger <Larry.Finger@lwfinger.net>
Date:   Fri Feb 28 15:16:43 2014 -0600

    rtlwifi: btcoexist: Add new mini driver

Larry? Can you reach back to 2014 and remember why this code
looked like this in the first place?


--==_Exmh_1533591774_2560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW2jA3o0DS38y7CIcAQJ/jAf/XmviMxCyZhpbRc1fx3+jtXSa4o7GqWGZ
TK1ifksSAuGpytynZM6izSYTnwhHR68SSNflqpyhsDrT3ebNgYAtQHIDitMNtNQB
XWeNyL2OLoMsMX2F/ifU6UfO5jclfi/0bBdpHqM7IJaHfU42kjrvCqlRu5CqH/BD
a/K/c62EmGnR8LSy5em1P/39KePU22xEHylw3cq92uunKg5mhm3/TDOvzRyJGuqE
52D2RCrgJRrNqfZpDaxOC5QZTsLdC8XvQLwYiWzO6Hb3/LGZtuX4ZC8yOCIkeVfU
Jkgjf+D18Y9wBc5F/B8GwzvTebKfgepyZerK4YMgOuitE/ReR+byCA==
=0wn3
-----END PGP SIGNATURE-----

--==_Exmh_1533591774_2560P--
