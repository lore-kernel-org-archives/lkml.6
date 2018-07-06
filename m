Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9FBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B6920020
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B6920020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933182AbeGFOvf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:51:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59694 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932778AbeGFOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:51:34 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w66EpXvu016559
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 10:51:33 -0400
Received: from mail-qt0-f197.google.com (mail-qt0-f197.google.com [209.85.216.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w66EpS9C019957
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 10:51:33 -0400
Received: by mail-qt0-f197.google.com with SMTP id g7-v6so12679309qtp.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=2LHYsVESv4OCWN4po9Gah0Dgt7ih2AZaV7Kqb0Fq+2I=;
        b=p51IW2DXnlU9m06162TtDV1Av9EUAPILEclhOfEvoGhbOlGx9cJc2x6734VFX9HQrv
         sweDJ2efd3UUrKxwDiv8/R+/gmh7X3Vdval8kylDQkvUcq8TdE0TkyiBacl4MtmP3XS8
         FkrTitngQKyCTYXN0H7pDEjnTI09ChcNeAtPkJNE75JgkTubknobDDb0wUT8UTXminFk
         e2xRq/d7A+QHufkBvdH90mMVKl28OFgmcQj6p/4npiwwcnVz/757exiHVchXQZ3RBjKv
         dw9FaBZ7KSplFIUEGCXMq+4uK+iPY3mefS/X+RFOtJCC09lnElJfrHTvqctuXsffYdj8
         Fmkg==
X-Gm-Message-State: APt69E2MPvAVUbw439B5kOM3jgQ1J5Da5PH4e4oxoOAXAmRK9GaJlfch
        oXUqLuVCx76Cyzp5WzA9cFnu0omx29fxK9F4vw7b8mpsycnkPOepdoWNPYqJ+4UoRkqTdLnNGWA
        mIi6I5kQY6cxYJakxevpyX1q5H6IvGUiOlOw=
X-Received: by 2002:a37:1286:: with SMTP id 6-v6mr8989878qks.158.1530888688565;
        Fri, 06 Jul 2018 07:51:28 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpflLK/Kdp5itcUpJOEyqvWBQrNW0CwfWBsTsRrg0nHXVKO/njzQO81Gnk/Dsu3zHcmRO2Mqzg==
X-Received: by 2002:a37:1286:: with SMTP id 6-v6mr8989864qks.158.1530888688416;
        Fri, 06 Jul 2018 07:51:28 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4341:14ca:ddb1:eafc:6608])
        by smtp.gmail.com with ESMTPSA id 8-v6sm6258598qtv.2.2018.07.06.07.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:51:27 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: [PATCH] radix-tree: avoid NULL dereference
In-Reply-To: <20180706134144.48446-1-mark.rutland@arm.com>
References: <20180706134144.48446-1-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1530888686_5155P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Jul 2018 10:51:26 -0400
Message-ID: <82416.1530888686@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1530888686_5155P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Jul 2018 14:41:44 +0100, Mark Rutland said:

> I beleive this is what Valdis hit [1] back in March. I spotted this while
> booting an arm64 machine.

Yes, the stack trace is the same.  The odd part is that I was consistently
seeing it until next-20180626, but it evaporated in sometime between that and
next-20180703. I suspect it has to do with the fact that -0626 was compiled
with gcc 8.1.1-3.fc29, but -0703 with 8.1.1.-4.fc29. As such, I probably won't
be able to test the patch without downgrading gcc....


--==_Exmh_1530888686_5155P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWz+B7o0DS38y7CIcAQJ8zgf+PFxZKT4hmhq4DHKnq+rL05m0PolWNWys
YqU5IjTeP5ewjmGl2VlYt3bjXzY/mlYrfJMjazFjgWBzafdOruM1cuMB96hnAhvx
woJUDqxqNUcJ5ZAIdXrwImbtYeOkTZ3PsemgIZ/jBzvGXd+DpekPY2xoZsLb0h/H
fZX6AV48/TbaZdckwYF3NldlBsuJ1ZmIuDsJqi69hMLxqa65r0QC3aWAs2241Ruu
sz68P5P2G4gwpTyW6oO1DwUYo80ssTZwVx3bULFW0VM9NiqVM5tWGOXN1PC/am5j
MW0nmhykw4t5cIQxUEStsGV4kEIq72TRDpNeK20XykPd/McsQXmp/A==
=Ldrc
-----END PGP SIGNATURE-----

--==_Exmh_1530888686_5155P--
