Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1114C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EEA208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EEA208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936376AbeFOUfS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:35:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43502 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753732AbeFOUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:35:17 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5FKZGs8019048
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:35:16 -0400
Received: from mail-qk0-f198.google.com (mail-qk0-f198.google.com [209.85.220.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5FKZBFC013543
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:35:16 -0400
Received: by mail-qk0-f198.google.com with SMTP id s133-v6so8760622qke.21
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=PJ991lyrEEl0JVfhnTx7RZpaVM1jI1YD7tN+SFRLuyQ=;
        b=QofW7wTyjbUwqubyemUVHKQkUJZOqCVGGhy8d254DTF8j6HoiR2DNfw+bQCFUXOjRc
         Mgl6wLbX4zBzPsevxKvIyZZxs6DgKXazxsyNaZdl0Zcxog2eDIlZ9GC5619GrkFd0zc8
         I7trmop8N+Uc2jdhkrcEp+1cwJyAZsPEzkqh70gPmdn4zrSihNbVu7xc6xoEkTGJmLEI
         W+IdRxFH3Wiq5aZnLQ/O7/cZd8kFRvZ9wT3jp+kmkqDN7eEGAgvVRuqK7qX9H7rx1LWQ
         RgzAbzFAnYSEx8EQF+9C2gDlzZFvWHcllwqlxi17T6jiGngQtvxIpjCBBudhGdI11MIx
         K+WQ==
X-Gm-Message-State: APt69E3ejJ1ZFZ0FKCD9KL20XolRHzOuwiyyNXrkhRPdfKJzHQDOS7Um
        n7l32EOH6EpFoR+W/a8D1W7eEi3qQMGDxHzspJKsUKXJ81dsZ2JXZJPLEsABfY9jaFZcy49G4ZO
        nMKodSLjtzU743tm5PMzLMby4XyW6b5fNNbM=
X-Received: by 2002:aed:3e51:: with SMTP id m17-v6mr2961351qtf.283.1529094911109;
        Fri, 15 Jun 2018 13:35:11 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKIq7Gx/rVsW/EMk9q3k4H2fA1ElBRO+6o35lbeZwsWgne32ny/PJsf+GwpqC/OvrqbDgva48w==
X-Received: by 2002:aed:3e51:: with SMTP id m17-v6mr2961335qtf.283.1529094910855;
        Fri, 15 Jun 2018 13:35:10 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:c5a7:bb98:8d38:c9af])
        by smtp.gmail.com with ESMTPSA id l25-v6sm5517296qkk.49.2018.06.15.13.35.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:35:09 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Nadav Amit <namit@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/7] vmw_balloon: update copyright message
In-Reply-To: <F8F02A0A-133F-458A-9492-30C3ABD8C592@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com> <20180613135412.81660-7-namit@vmware.com> <20180614052413.GB29739@kroah.com>
 <F8F02A0A-133F-458A-9492-30C3ABD8C592@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529094918_2750P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jun 2018 16:35:18 -0400
Message-ID: <81730.1529094918@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529094918_2750P
Content-Type: text/plain; charset=us-ascii

On Thu, 14 Jun 2018 05:33:46 -0000, Nadav Amit said:

> >> In addition, updating the year and adding a license tag.

> >> +// SPDX-License-Identifier: GPL-2.0

> > You still have a lot of boiler-plate text in here that can be removed.
> > Please do so.

> But what else do you want me to remove? This is a standard GPL license. If I
> am required to remove the GPL license, I will have to run checks to ensure
> it is appropriate.

You mean the checks that you should have done when you stuck the SPDX
tag on the file?

(Hint: Think of the SPDX tag as a '#include gplv2.license.blurb" :)

--==_Exmh_1529094918_2750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyQjBo0DS38y7CIcAQIT+AgAjWtfnkYiNH+srK1KXZcQBUQ2HcuNOCXY
7tghg1rcUKPU/0Pq0bVq+Ib96jGTRXo1Eb69xPn0KTKIfapFVX9Fkwnv6xYuQMxh
hCWY5wxVtX45OTJkO0HGTy4bAX41HNbGL0kqs9By7jKE352VsDnrCsOqKEa7+hep
rScr6B1he2DnBFC52nyD/BfNUjc8/SxoPX+r2+Goj6QFzYudvi3dukjc9vtIN3Bq
/En5YTu8g6qruBsCd2ztFX9mM40yvLl4QE6Ukx8zcvpq/6rgw5qxJSzK9tklobdj
GjGTVa8EOTPICZ9IZ9ugwu6LZ1zMUfcgEBLWaEYMIpIfzEqSIn2p7g==
=Rzxx
-----END PGP SIGNATURE-----

--==_Exmh_1529094918_2750P--
