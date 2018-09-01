Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27956C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84462083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kF2iuUJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84462083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIBC5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 22:57:34 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46876 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeIBC5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 22:57:34 -0400
Received: by mail-wr1-f42.google.com with SMTP id a108-v6so14287865wrc.13;
        Sat, 01 Sep 2018 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uX03Uy2XjvH0qFbVcN/FEJwQnJii6aBfZhRE1G1cx/c=;
        b=kF2iuUJipsQ796VYVRKPd5k24OB440cLLnyS858hjzkz/rTLg6PtpjUe02GRK/RNae
         P9OAzrM+UG4dnscVMnSxy2Tp1Jw2Fv1GEGyOF/iP4WJGUmGnVFAejGJyFXs62lmyip+2
         WexDx7Q0UExw60BT55CXm95FzS5IfTw+VkXqizZlHaLoXjhQ7NcBoSp7riQxWvWfVzV2
         l0ukr89v3NPmb7gO12mLQtr9cUhRhTrclGFpvqLPNJb1bopTJlGts0gIz/oc82Z8bzp6
         OHeik8lMsI/F+aSSswfhIX3CWuoddGeVgEfWwHFPW3l18BvYPgF4Sz7EVJhSIlEAp5FC
         nb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uX03Uy2XjvH0qFbVcN/FEJwQnJii6aBfZhRE1G1cx/c=;
        b=UzZvGhhN5YQmuqLcnbiNmSsx9CiA5YagqyE5LP5LXDfVfJC0OG0oDUo/Dv7DmxvQvb
         P+IUBtQLvRNkBcBgvG3Hy7qIwn86EUfM03Bb8thalGy0BuL+pubhVHik5Vcix//loDnl
         Xh+MJtd3PxUc+Kup5DTmHtv3tpQVwyyeqflX7mDVk/iXEEsBVol+vdsLG5ihxSP9CpMV
         83XolDL/oo3ZMBC7L3YT1vZbikQXnVsVnxzvNJOz1OSoe5i03rF+e6BmIpdopne28YCy
         yfpM+u3aKzopejZZHZgXXTmF8ZlcvyXjx6jMnURqjublCTp8e7LNmdEAfmO2mlDy71Zo
         7SuA==
X-Gm-Message-State: APzg51DHCX+tu1xrXgmAPJme7c54DUltTRGX0/ukx8VuYldwU13U5dvM
        hnp+uaP6YovEyzWw1oWxa/I=
X-Google-Smtp-Source: ANB0VdZ/ueHX7Xvgu6qU/JqLa9iEh683ADVNemOWLZ604AczU3DBVCOYUd8o2B5KwqdMMEar9neNNw==
X-Received: by 2002:adf:e44e:: with SMTP id t14-v6mr14566005wrm.96.1535841844098;
        Sat, 01 Sep 2018 15:44:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73C2100CC1F3491F6EE03D2.dip0.t-ipconnect.de. [2003:dc:d73c:2100:cc1f:3491:f6ee:3d2])
        by smtp.googlemail.com with ESMTPSA id 132-v6sm6993250wmd.13.2018.09.01.15.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 15:44:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     bmh@certi.org.br
Cc:     John.Youn@synopsys.com, alexandre.torgue@st.com,
        gregkh@linuxfoundation.org, hminas@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: dwc2: Fix call location of dwc2_check_core_endianness
Date:   Sun,  2 Sep 2018 00:43:48 +0200
Message-Id: <20180901224348.25011-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827213638.18890-1-bmh@certi.org.br>
References: <20180827213638.18890-1-bmh@certi.org.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some SoC/IP as STM32F469, the snpsid can only be read after clock is
> enabled, otherwise it will read as 0, and the dwc2_check_core_endianness
> will assume the core and AHB have opposite endianness, leading to the
> following error:
> 
> [    1.976339] dwc2 50000000.usb: 50000000.usb supply vusb_d not found, using dummy regulator
> [    1.986124] dwc2 50000000.usb: Linked as a consumer to regulator.0
> [    1.992711] dwc2 50000000.usb: 50000000.usb supply vusb_a not found, using dummy regulator
> [    2.003672] dwc2 50000000.usb: dwc2_core_reset: HANG! AHB Idle timeout GRSTCTL GRSTCTL_AHBIDLE
> [    2.015176] dwc2: probe of 50000000.usb failed with error -16
> 
> The proposed patch changes the location where dwc2_check_core_endianness
> is called, allowing the clock peripheral to be enabled first.
> 
> Signed-off-by: Bruno Meirelles Herrera <bmh@certi.org.br>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This fixes the same error on my Odroid-C1 (Meson8b SoC).
Thank you for spotting and fixing this!


Regards
Martin
