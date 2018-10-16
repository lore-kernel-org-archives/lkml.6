Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AC7208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AC7208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJQADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:03:30 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44758 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726778AbeJQADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:03:30 -0400
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9GGCLZH015634
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:12:21 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9GGCG9E005897
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 12:12:21 -0400
Received: by mail-qt1-f200.google.com with SMTP id b55-v6so25179046qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=Xbm/CHtAgaIM2pq2nOBjmScZHDMJ/5bV6u5qHmuWCTw=;
        b=RIKPqBoeCFmXCGxPmR8L65yw01uUnUAbJ/TWmvFIHOBfqmnrDoXv1rd9Km58y2ZPsj
         0Rj5ne9NvrXGGF1E23sIZfoRX9c9fGCeLmyObsbYqGDIkoqCbI2tFTE3jNbBvz1fj1Ki
         bAisHx6lvlYxH8/zNSJ8suk6ID1AwrdpPklhWSphr0Tr0R6LYTbTMnMYXGDhWt0HBgg3
         btfupAiDyq6tS7WHiB7utVdeC64DZEePcbSRpqR9kOcDC6PB54jggTWkHl9+zHRcYp/R
         7d5jPUFbdQG6nF4+OnXCTa+HAeryZG17n+lYUhOo99fbGpi2pJkr55XqcmOPsLgy7G7d
         Bxpw==
X-Gm-Message-State: ABuFfohigqH864hvyEdwMngipeYOiK32kYM981GQ1FzYhOa5Ow66FbFr
        u7snPSadHFEOex/aq+D68RoOg+yKRniYB1eMxkkCI1ZOBIKgH5qDODWMe9TkLa219BYtPnMao2a
        4FnRRFW1qjTJMqp+RE5LmkEnYI1VTncoS1ag=
X-Received: by 2002:a37:4a96:: with SMTP id x144-v6mr21570860qka.112.1539706336133;
        Tue, 16 Oct 2018 09:12:16 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61/FWbDC1Ercu2N1qxkIWewq7bum9DYuNRn8n081JDSKodxc7oaO6PmYS5xjO06vv7r7UojvQ==
X-Received: by 2002:a37:4a96:: with SMTP id x144-v6mr21570830qka.112.1539706335751;
        Tue, 16 Oct 2018 09:12:15 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id y190-v6sm8314539qkc.84.2018.10.16.09.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 09:12:14 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <66480.1539693734@turing-police.cc.vt.edu>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016015201.GB18547@thunk.org>
 <66480.1539693734@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539706333_2381P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 12:12:13 -0400
Message-ID: <12638.1539706333@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539706333_2381P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Oct 2018 08:42:14 -0400, valdis.kletnieks@vt.edu said:

> [~] zgrep CGROUP /proc/config.gz
> CONFIG_CGROUPS=y
> CONFIG_BLK_CGROUP=y
> # CONFIG_DEBUG_BLK_CGROUP is not set
> (...)

> Looks like I should enable DEBUG_BLK_CGROUP and see what that says.

Built next-20181016 with that enabled - and the exact same kablam.

Started looking at the code, and I noticed that if the .config has

CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
CONFIG_BLK_CGROUP=y

then the 'struct cfqg_stats' at line 185 of block/cfq-iosched.c ends up being
zero length (which hints that combo of config variables is a pathological
case). I haven't delved through all the #ifdef'ery, but I wonder if there
may be other corner-case issues with that combo....


--==_Exmh_1539706333_2381P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8YN3Y0DS38y7CIcAQKm1Af9E7hXxt6027MX7A17TQoxeQAQZXV4hw+I
/kyOqhvtGZuEr+BQdtXAUpDlQwPs74uQOByPy08dvleO7DwZvS6jbdtZEPyW/kxD
Y1y1SahHpyRXAx2ngE6WSv2kzNGV9KgU5RKMcBNSpX53wM5eRNk+meRPXqgqVaLL
dTe3QL1mcmWrsOX3d35uYbi15q0+2nkXDD7M1oZVaCDenVzxZ8W07KzjzD+swClc
SQV2gQdXnEFBQeEEPuYQQI1Uzy8CItVI+bJ6yO1vc336vtu66sN2w0XIAB2AYi/N
zPbZMcXA+rp37FHc+uYRJBqOSqGfFGBqZNQj97Gc0yO6k3SaI1uhCA==
=X1MR
-----END PGP SIGNATURE-----

--==_Exmh_1539706333_2381P--
