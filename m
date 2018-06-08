Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aj2NBU3hGlu0BwAAmS7hNA
	; Fri, 08 Jun 2018 20:07:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 936F3607DC; Fri,  8 Jun 2018 20:07:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA6316074D;
	Fri,  8 Jun 2018 20:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA6316074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeFHUHZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:07:25 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:56854 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752948AbeFHUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:07:24 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w58K7Nkp012778
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 16:07:23 -0400
Received: from mail-qk0-f197.google.com (mail-qk0-f197.google.com [209.85.220.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w58K7IJi006200
        for <linux-kernel@vger.kernel.org>; Fri, 8 Jun 2018 16:07:23 -0400
Received: by mail-qk0-f197.google.com with SMTP id i64-v6so14079879qkh.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=MkGZzCzotcmwdMpkjNJkXL68QSlxRUUPTlUgK3CK8hM=;
        b=blGuUHTT3w8Af99IjiRhuxPx9DRFapxUNVtDGzoyF7lzvYA/2Y1j0dAAqqKFhqlZte
         UAPt85YePpJNWKY1YtMGhpEiqQWXWf42fUDo7R2Eu2whBqAhs/nodYHQLcQHYdhO/Qce
         STyVS2BS3Sve740qBH/NiDYnBp+Yyh7srY1w+X/uL4/smR8eBbRpzdRv5KaiFGsvMjJl
         V+m7kkETAn+9nsT8fBnK3lLWS0Dz7O4PFjTaRLTFUEjMoV3cGBFFwMTNvBfBm2+t/kkZ
         uyyJkHowj77GMt66uZEg9oxI/AlJMx1WmKl6YMT72ayVomMqYPxPP5M5z8u3ks2m3Eyl
         IJow==
X-Gm-Message-State: APt69E0S3k/2Zz1LESSdQ1JAmRDR4UWJ8xdjtwO611ZaH4Thq4FdqU8l
        6VUPbSj9eFJelYGu2MZ5S6Kwkd/ebl7nv/FPmG7OcbUwIo+ERBuz7FNxUSq8LfXsHsdT3flyEXQ
        3+Y6z41KBVldKfLYRCRzjbUeJA0HMxqkxR2M=
X-Received: by 2002:aed:38aa:: with SMTP id k39-v6mr7546213qte.125.1528488438071;
        Fri, 08 Jun 2018 13:07:18 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKKrw3+cwzcoP9wDTdQjpWjuLl15GDl8KJUdIdu90bHvMyLI26MitOd15E3t+MAhP5fnjREMJA==
X-Received: by 2002:aed:38aa:: with SMTP id k39-v6mr7546204qte.125.1528488437859;
        Fri, 08 Jun 2018 13:07:17 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:75f9:a491:d2fc:8ee2])
        by smtp.gmail.com with ESMTPSA id 10-v6sm19263319qki.54.2018.06.08.13.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 13:07:16 -0700 (PDT)
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk
Subject: Re: next-20180605 - kernel tried to execute NX-protected page - exploit attempt?
In-Reply-To: <136327.1528411295@turing-police.cc.vt.edu>
References: <21051.1528404057@turing-police.cc.vt.edu> <20180607211401.GD4481@redhat.com>
 <136327.1528411295@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1528488438_2490P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 08 Jun 2018 16:07:19 -0400
Message-ID: <248061.1528488439@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1528488438_2490P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Jun 2018 18:41:35 -0400, valdis.kletnieks@vt.edu said:
> On Thu, 07 Jun 2018 17:14:01 -0400, Mike Snitzer said:
> > Can you please share what you test is?  We've gotten lots of reports
> > with failure following wake_up but I don't have a canned test to trigger
>
> Just a laptop with 16G of RAM, no clear reproducer -  Chrome with a lot of
> tabs, a mail reader, a bunch of SSH windows, and the next thing I know, it's
> locked up good and solid with wreckage in /sys/fs/pstore :)
>
> I got bit a third time a little while ago.  Will test the patches and see if
> they help - looks like I'm averaging two hours or so of active use before it
> hits, so it shouldn't take long before I know if the issue is swatted...

Looks like those two patches from Jens fixed the issue - this build has been up for
20 hours, and has survived a kernel build, an OpenWRT/Lede build, and a backup,
along with a bunch of other stuff.

--==_Exmh_1528488438_2490P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWxrh9o0DS38y7CIcAQIoOAgArMCJ+83NSdQ/HHzyiJTpC2oKap6ySTfe
kNntFO9zUdFqxDibhOreLDe7y2RX82GOaJdF1NWA/zC5C/v6jOsLfZeCCeHHtsW5
cIBDoAOW+OWeNfDkV98KanHytd+EfJ5OxkbGGBkE9jI2Gkj8KMt2N6uK+cxOGcHE
7xtsq18oKw4YARUJceQPARt29a6i5W6SgQMHfAOSzy2RtdHs8bd6E51VYKNCL5w+
WP/FHLvz03wDiKY0/g783AQF1dPxqAYXqsvEDZOLGQOTjOujDiJQhSrTOnxRFq0P
vDOt6n23fQM9HGXOMLCPDYj+9B0jbE6uUFEVoFqVYtmCYVHD3S3EHA==
=hZJw
-----END PGP SIGNATURE-----

--==_Exmh_1528488438_2490P--
