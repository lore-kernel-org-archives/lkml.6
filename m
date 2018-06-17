Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593E3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A35208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 23:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A35208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754330AbeFQXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 19:03:34 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52270 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753570AbeFQXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 19:03:31 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5HN3U5b001459
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:03:30 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5HN3PMh026173
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 19:03:30 -0400
Received: by mail-qk0-f200.google.com with SMTP id b195-v6so13040495qkc.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 16:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=NplYVCIU8uVu+k/hRnJ9wY88fHW5zBi7U7DpV8jrcmE=;
        b=nCGYzEm1mgybjKZKGkiWB50CnI8NZRjUnKzwqNf9PzXTreMSXgo4OjuFH+aY3hY2yO
         G1d/m4VhARUMU7JRD0KnUQNZP55pyAPHX3pbxGjKJrAwjAoAN8KrTda1ggP7sKJuHCle
         cM8U4NkwFcu3+RCPkDL07u4uMEphxdkXSh68j/gMc3oSrBy7V7/IblhAXHq9a/E+od7G
         80EffIgkatEH2vA3vGi7/ZOjpVe5braP3lqk300oiT4rTFWgErFjUVNQ0mzpeXJ4oh4D
         RvxxWagNt9pokRNe7+cwgg/XIqIWL6ChaEeJI/8vUd8Hr3/XnxFAtpOFTF3M6XWmQCbE
         dl/Q==
X-Gm-Message-State: APt69E3i0vTt2Rp7j2uos/NbNB3T5t3ALtu0WyEY1ZbRK5xwYrMVdD+Q
        d+PqdgjVtvgL1PBMjYNOeu4GLOoSMJkNun5BBzDUm8Bdbztjy8hvWPcvffssnNuQf7Sg+6sum3Q
        bVww3Yq2BKbZ9sA4tJHpz93CZYUlF9iBM0TY=
X-Received: by 2002:a37:3095:: with SMTP id w143-v6mr8536087qkw.362.1529276605362;
        Sun, 17 Jun 2018 16:03:25 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKC16QPCBUbaBH3cEtAQ84YczAb17b016eg4GZ0UL2zTFxmvkEOpspMfoe9iQqVcr1HvED2Mw==
X-Received: by 2002:a37:3095:: with SMTP id w143-v6mr8536079qkw.362.1529276605206;
        Sun, 17 Jun 2018 16:03:25 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:2116:22ff:b17b:7cd6])
        by smtp.gmail.com with ESMTPSA id g18-v6sm11330530qtg.59.2018.06.17.16.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 16:03:23 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Mihai =?UTF-8?Q?Don=C8=9Bu?= <mihai.dontu@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: wmi: usercopy: Kernel memory overwrite attempt detected to spans multiple pages (offset 0, size 4104)
In-Reply-To: <1529263827.6069.4.camel@gmail.com>
References: <1529182886.3450.3.camel@gmail.com> <1529186697.2784.2.camel@gmail.com> <CAGXu5jLwA37YJWi50i7bQZ6N7MtctvbXjsVg337zgD11AQ=9SA@mail.gmail.com>
 <1529263827.6069.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529276613_2593P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 17 Jun 2018 19:03:33 -0400
Message-ID: <134035.1529276613@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529276613_2593P
Content-Type: text/plain; charset=us-ascii

On Sun, 17 Jun 2018 22:30:27 +0300, Mihai Donțu said:

> Your patch works OK for me, thank you. The libsmbios tool, however, not
> so much. It appears to be behind latest developments.
>
> # echo "+keyboard" >/sys/class/leds/dell\:\:kbd_backlight/start_triggers
>
> is all that is needed today.

If you're ever in this remote corner of southwest Virginia, I owe you a beverage.
I was going bonkers trying to figure out why my Dell Latitude's keyboard no
longer had a backlight... (and wondering if I was going to need to replace it
*again* - this laptop is 5 years old and on its third keyboard already)

--==_Exmh_1529276613_2593P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyboxY0DS38y7CIcAQJLhAf/RLIjU2o0G7Sm3G6zK1mMNewF9a4LOls+
eZUpQC6fZB5g+x+xP4+fontc7czdeNQZBkW61Pl9jbRVrOALkvYpoiGHn8EnjxrA
jW7H6wisfZ4xDbo97CS2GpP/pwadgTffPzdABpylo51sh3UWvdYNOMtMlZQL+MSP
fNf8ea1sv6dvVZjQNv2spgLLAL5fcG30V0KPDXtv5tWPGDTSoI2F2KgPA1wArgUr
pevvcZI2AyRW5sLQTNUMtDLdvSZTuVy4pFT2eHEoRyMHmnCvqELoN8d9v/aqrDpt
Ueca6oDYO30BzKAqKYI3K9bicCWpS6JlKn4juPvJeKL9LFJM31fVVQ==
=cdug
-----END PGP SIGNATURE-----

--==_Exmh_1529276613_2593P--
