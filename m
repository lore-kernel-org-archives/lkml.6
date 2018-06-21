Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D9DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDAD20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkpNec16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FDAD20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbeFULkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:40:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36344 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933100AbeFULkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:40:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so5440831wma.1;
        Thu, 21 Jun 2018 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QT7fFobUzlGqhw2etpDSNqHvC5hRpIx3b2+es1pUjJw=;
        b=ZkpNec16IzxF54aZbOqD5OL6UVYqwWXRS3idEOyipzuZ52vtxpW9aYtSmKvRVBWidq
         hGbyuOsjbCAkYf9TnMu/c9g2baNFm0PAOSYg+EP2I+Hlg2bkwj/zMvJWgYAqc6mvnBH8
         C0wPUKztkI2Lk2ikBFP0FV6Yrvulx5IeYv2EbwVWVOYNFvrDd5+acJ4biQhG6KbbxkeB
         ihOvsRIoPEfcPEHtAZXfucErgdB/7zhK0DLfPPGc4Krqy3/ye6taODXMXA4CCi+s3KMv
         LgJGngKh68bPFvAq3DfmpCrXXl11BwK7QtGEkOQ+P7FGUHG9Qk4lDVpjXGhqE+OnVw1p
         yxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QT7fFobUzlGqhw2etpDSNqHvC5hRpIx3b2+es1pUjJw=;
        b=hAtTfDeQxnAOz4WEtrTkyXwB/tS1n6kKLYWoj5KG0ztvMGmj+9ufvkQCzgtMta4AuK
         XadCXerbzxGLwmED68gB3klNPtMmcCH9Arnm02K3oNP7wRraIXUhupt+6VfqOx86yD8r
         gDdwalW6qbEyGap6IY6P6fXDTSSu/4GtOLumQw8jPzEw80ibEntKMl3CY9mb23dEqfRB
         M1VbhGXvuldxYaBx4snPItLt+cAW42kFOf5KOuqt5d6zLQ1YgcM0us1qJZpMPDwB69Sp
         LsCU+DIS8/AdW5J4spNjgJr+Xk1O4ZBo1gBp5IV5t6Pae+aG6pMbayhs0ykayRTiKrUJ
         AR1w==
X-Gm-Message-State: APt69E0gOdbTnm7eNN6n6h7CiBjxeyJcc5yKdTgwZ9XsYuk71hEou/PV
        YMwmgoDVYHD66gwRICCC8fU=
X-Google-Smtp-Source: ADUXVKIsISJYZrbYHMZC+SgsyD9rf3g20U0TXHh8osi3Mf+2fLbT3YlfFccj4bxN/I53uNefjB9wCw==
X-Received: by 2002:a1c:3fd1:: with SMTP id m200-v6mr5223766wma.88.1529581246476;
        Thu, 21 Jun 2018 04:40:46 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q1-v6sm1574327wrm.96.2018.06.21.04.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 04:40:45 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:40:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Damjan Georgievski <gdamjan@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>, ibm-acpi-devel@lists.sourceforge.net,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [ibm-acpi-devel] ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180621114045.tffl5duczhunuzcl@pali>
References: <s5hmuvvtdmi.wl-tiwai@suse.de>
 <20180616154309.ualrx2py6ndr5xgz@pali>
 <s5hh8m2u3cp.wl-tiwai@suse.de>
 <20180618102806.vwm4rhvxhn6hi43z@pali>
 <s5ha7rsz8i8.wl-tiwai@suse.de>
 <20180618112121.cl76a3oozsbbbqnb@pali>
 <20180618112618.hcwiacfzzu4swwd2@pali>
 <s5h1sd4xg3t.wl-tiwai@suse.de>
 <20180621113031.gv53yv3g46uaetwm@pali>
 <CAEk1YH6-b3HtBN335XNxeYRWCCsBm52kC95_EZH3B4G-_TP5Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEk1YH6-b3HtBN335XNxeYRWCCsBm52kC95_EZH3B4G-_TP5Pw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 June 2018 13:35:21 Damjan Georgievski wrote:
> > I applied them to Debian's kernel (with slightly modification) and they
> > are working fine. Via "alsamixer -c 0" I can change "Mic Mute-LED Mode"
> > to "Follow Capture" and then led is ON only when microphone is ON.
> > Recording from microphone is working in both configurations.
> 
> hm this is the opposite of how it works on my T450s and X1, where the
> led is ON when microphone is muted.

Purpose of this patch it to allow user to configure that LED. As I wrote
above, when I *changed* "Mic Mute-LED Mode" to "Follow Capture" in
alsamixer, then led is ON when mic is ON. Default configuration (prior
changing anything) in alsamixer is "Follow Mute" when led is ON when mic
is OFF. That patch allows you to change how LED behave.

> (I do wish the led would be ON when the microphone is not muted ie. listening)

-- 
Pali Rohár
pali.rohar@gmail.com
