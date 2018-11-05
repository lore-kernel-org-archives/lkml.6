Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A85AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1B2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbeKFCOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:14:38 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43600 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729681AbeKFCOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:14:38 -0500
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wA5Gs4WL001192
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:54:04 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wA5Grx4m017929
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 11:54:04 -0500
Received: by mail-qk1-f200.google.com with SMTP id c84so22774301qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 08:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=1wziqTN7Fdza7mxD6Ka5sSVZsQe1xBnHGG3bPBOWNKw=;
        b=qpdrQdMun9ztdiEQu7mswDI8flXDIABGypFO3/ThFNbXjVe73MFkl935FLoVHzNzkq
         lVb1t7uiy8pUFiDvGm/vL9U+JLzC8BToYK1bNFuXc9q4xkStp6kxeWf2jnjDC8XwkQTt
         5rh6yOkerBK8uL/f5xNDoH/y80j6pxX7jZJdC1BQVoXNO2EDGqBXOZkGfq0r3nvw9cIJ
         4Ept/lImOFdhT+t9VbVYOmzcaTCs/Z31V6BXY89C0IbEesn9HcTx8S7ng+aylCg8pgjX
         2/5HoFs2zS8J7npFcNO8wTS2rUu0Y5HKszlPw0BvTcPU7yk4T43Wckq5ASG8mRUieWmr
         FrXA==
X-Gm-Message-State: AGRZ1gIFStDHoXx2SlXLxukenf8grU8feAi62AdLGLVduouVBVj+fO5Q
        /EEleNlbKbHOAdCVmlPLazxq3qaq2HY5dweOQUC8DN0fExir2nqA2Eqdmu0GKH6a9RcJDlmhKJ2
        RY/i8Xs4/tHRpP3kyk3eLUma0lbXPOmyAAfs=
X-Received: by 2002:a37:8f02:: with SMTP id r2mr21677927qkd.246.1541436839576;
        Mon, 05 Nov 2018 08:53:59 -0800 (PST)
X-Google-Smtp-Source: AJdET5eKTL1E1IsaVSqLtz70svXn+78e3/jPnMlvKVSvBXq6pCTkZlYy6V761tMZkkjCMzFfK+lZYA==
X-Received: by 2002:a37:8f02:: with SMTP id r2mr21677879qkd.246.1541436838992;
        Mon, 05 Nov 2018 08:53:58 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id v3-v6sm29387972qth.74.2018.11.05.08.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 08:53:57 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Adam Borowski <kilobyte@angband.pl>,
        Pintu Agarwal <pintu.ping@gmail.com>, linux-mm@kvack.org,
        open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: Creating compressed backing_store as swapfile
In-Reply-To: <6a1f57b6-503c-48a2-689b-3c321cd6d29f@gmail.com>
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com> <20181105155815.i654i5ctmfpqhggj@angband.pl> <79d0c96a-a0a2-63ec-db91-42fd349d50c1@gmail.com> <42594.1541434463@turing-police.cc.vt.edu>
 <6a1f57b6-503c-48a2-689b-3c321cd6d29f@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1541436836_4003P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 11:53:56 -0500
Message-ID: <83467.1541436836@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1541436836_4003P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Nov 2018 11:28:49 -0500, "Austin S. Hemmelgarn" said:

> Also, it's probably worth noting that BTRFS doesn't need to decompress
> the entire file to read or write blocks in the middle, it splits the
> file into 128k blocks and compresses each of those independent of the
> others, so it can just decompress the 128k block that holds the actual
> block that's needed.

Presumably it does something sane with block allocation for the now-compressed
128K that's presumably much smaller.  Also, that limits the damage from writing to
the middle of a compression unit....

That *does* however increase the memory requirement - you can OOM or
deadlock if your read/write from the swap needs an additional 128K for the
compression buffer at an inconvenient time...


--==_Exmh_1541436836_4003P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW+B1pI0DS38y7CIcAQIaSwgAlaWBTJLuKtJT7ru/WLIqVahEPpFO8vgl
0Wd9hwwQSj1a4HtpAkeRTo3/24JBDnIg315A8Q+YW0/zF9MP2cecGTCDT4tmJUR1
NhN2hoAnKvLleU5ZebPygptkEkiQdbs7G92ok/Zi32lPUwWVt1ZdQG3HVYHWtNxJ
ret95nyOWAgBJFJmb+I9kiO8O3RewbnfPjLRiUA1d1iaaK6Zilur44fG6K5KN5Yv
jxN/ee4UM+w/u3cTEpVyAdFqAVq8phDKn1Pa53LSa6TtHXoUOI3ir/k2owUxfzE6
pO+Len2d4Y2U1VcrfyB5yaLyd5gFGoe82qwsgregzqCbaygKQ4UgPg==
=OHwC
-----END PGP SIGNATURE-----

--==_Exmh_1541436836_4003P--
