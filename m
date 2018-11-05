Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CFAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676CF2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676CF2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbeKFBe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:34:56 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:55784 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387398AbeKFBe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:34:56 -0500
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wA5GEWsY014278
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:14:32 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wA5GERMb013041
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:14:32 -0500
Received: by mail-qk1-f199.google.com with SMTP id k203so22572301qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=pWhII/pusO9Otih4Xi7LGUubPvgCxxPoq25cqjlfiWQ=;
        b=FmDpFIxBN+Wd3UhsNcurKbb5TFo9sp7hTbbsUjV7ipI+nqpiONz/5oSCpKWxfGYpms
         qXExkLeWA9TQLjbmPqAhmFNrj1ONG9wTfH6KU98iG3w5D4cGQdFxpMfrTB+xko4Ig/43
         H9wUPoyyBfSvBhTy2CWmD7agBnjcSp0GKeua6+p8EUMUiyjv1eKY0uRLYz/lSsf3GoNs
         9RNiihryon5HjqFQxMDSMFy+OTF77DGAYZXxNL+0j1qpTRmEHwSoqhk8E8vO+FNH61Ab
         nxk8tAgsCAjJFNjUH0bpzRpJmm4TrITMi6J1kQRp6i8KsI2dEPu7Ev6W1YhJFvMcBqxb
         3cTg==
X-Gm-Message-State: AGRZ1gLmXFgv4IvGYSzRkU7KvRg7xRpMT3HmHr5AQ4oRVXPZTI9/+jAc
        vBfuk+8x6znOpPX01Lxz0EPMiOpFGgtbtntyiIoQg8AcA08CWx0O+S0sbtknAzIDnuTPq2ZRpV7
        cQV/H/jVx7488C5Dutm98HoOf7DCyiInpN4s=
X-Received: by 2002:a0c:fed0:: with SMTP id z16mr22038185qvs.229.1541434466694;
        Mon, 05 Nov 2018 08:14:26 -0800 (PST)
X-Google-Smtp-Source: AJdET5dzwOFOz7Ku+0UyiSq8G3GnMkN7DjujAgpScxmgxWHU6FnP4Jf9kP7ZsUNeMgCOjwmsbXiQAw==
X-Received: by 2002:a0c:fed0:: with SMTP id z16mr22038157qvs.229.1541434466376;
        Mon, 05 Nov 2018 08:14:26 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id 42-v6sm38879846qtt.31.2018.11.05.08.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 08:14:24 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Pintu Agarwal <pintu.ping@gmail.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: Creating compressed backing_store as swapfile
In-Reply-To: <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com> <20181105155815.i654i5ctmfpqhggj@angband.pl>
 <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1541434463_4003P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 11:14:23 -0500
Message-ID: <42594.1541434463@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1541434463_4003P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Nov 2018 11:07:12 -0500, "Austin S. Hemmelgarn" said:

> Performance isn't _too_ bad for the BTRFS case though (I've actually
> tested this before), just make sure you disable direct I/O mode on the
> loop device, otherwise you run the risk of data corruption.

Did you test that for random-access. or just sequential read/write?
(Also, see the note in my other mail regarding doing a random-access
write to the middle of the file...)


--==_Exmh_1541434463_4003P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW+BsX40DS38y7CIcAQKKYwf+JIV/RuxK/7zIKKuu0D7pKRGkvTgaqGWD
zEMpdlcFYT3HXlXwL84EElJ4hiE3b1CZKfaDHqyYjLG+Q7WbY93n8Hmu9IFPH3F5
riIz1q62Ik8jfpjKFEoRGibbPutIgCL5y7WAXtdDnGy+1LB3ifHl3qu/Z3AlJzp1
zE8S5Du91C4qF+N0sPN9TyyKPu7+xGgGL3yYYpyRS58wMO6fxOLGwd82tNiv90mc
4wka1FtNq88S+l9WhREscHIctAt57pHStkDcChiFGmpf8Fb6WzATMUWO3JCo4mKr
Fd+zC9LB3/8hsaBxTYP88+MBp8qtj+2deUCW0U97pLs/Mz/rLaWK5w==
=yLe4
-----END PGP SIGNATURE-----

--==_Exmh_1541434463_4003P--
