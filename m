Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B3C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF26205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF26205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJIIVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:21:52 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43568 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbeJIIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:21:52 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9917TDF029146
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 21:07:29 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9917OaB017257
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 21:07:29 -0400
Received: by mail-qk1-f197.google.com with SMTP id v14-v6so22835393qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 18:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=OZZ9FcNi3tT8GKvVPXviXaIzxMTzqnAYwnDgoXOeAT8=;
        b=E4IvWnqwfyhMT3LkN7FHBEFQY7VhClCRmIC/dtV4hsucxObyArX7tYpmwCccu6sbJo
         fDrqfWkcT/p9GZkahSGGBsK/5bhEpCOP7XIsNvboa3l44WkwgvnfwVNcO8n7zPnVvtSx
         mnVfSR9SWhRQD5AWPlvICLBnlFO5xZ7OzO4W/DSKCbVaZMffN7ZkPFIRvLJWoOTfe8UI
         LDxNyeYyaJGgufwhTy/Q5ncQutNfSl+LzGHpUHmIgDmc24qnqZrYgvup3fkiXy/9opq5
         s+NbszC7ZuYn8rn97+dAicjmnFkfkuCRu9h2F6tNuj9LIUL9UNI5bWfkHWzDPFcbJnsw
         btSw==
X-Gm-Message-State: ABuFfoh3DvwGMhfacewhEEFJSESzlRuEZr8ykqSgGCd9VlwciVrkbWIV
        rf3eAjqjw8bmVgggGMJbGYlaPRDI59trteTxfECA5CLF0CMssIRC1GIeYPbL5uPaSMQ1GxBzh1j
        /N75+LrPvieZleMskHHs0H+LFbpINNWPO7Oc=
X-Received: by 2002:ad4:518e:: with SMTP id b14-v6mr21664535qvp.101.1539047243899;
        Mon, 08 Oct 2018 18:07:23 -0700 (PDT)
X-Google-Smtp-Source: ACcGV61k8RZW98PubmxVSGs5HM1L5loKokrLSRWnqCRidJQrm7Gn68WXCHnJWcgjXE7o/V/4Fd0ktw==
X-Received: by 2002:ad4:518e:: with SMTP id b14-v6mr21664520qvp.101.1539047243499;
        Mon, 08 Oct 2018 18:07:23 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::be3])
        by smtp.gmail.com with ESMTPSA id m6-v6sm10724383qta.50.2018.10.08.18.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 18:07:22 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     wang6495@umn.edu, kjlu@umn.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: btf: Fix a missing check bug
In-Reply-To: <CAPhsuW5nPGMOEMKa1UFwgquoUeYiUV8i8nVgWfM6McH2Ri1esg@mail.gmail.com>
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu> <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com> <43898.1539033428@turing-police.cc.vt.edu>
 <CAPhsuW5nPGMOEMKa1UFwgquoUeYiUV8i8nVgWfM6McH2Ri1esg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539047240_7716P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 21:07:20 -0400
Message-ID: <9337.1539047240@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539047240_7716P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Oct 2018 17:44:46 -0700, Song Liu said:

> I think I get the security concept here. However, hdr_len here is only used to
> copy the whole header into kernel space, and it is not used in other
> logic at all.
> I cannot image any security flaw with either hdr_len > btf->hdr->hdr_len case or
> hdr_len < btf->hdr->hdr_len. Could you please provide more insights on what
> would break by malicious user space?

Say the biggest allowed value for hdr_len is 128.  We check the value, the user has 98.
They then stuff 16,383 into there.

Now here's the problem - hdr_len is a local variable, and evaporates when the function
returns.  From here on out, anybody who cares about the header length will use the
value in btf->hdr_len....

(And yes, somebody *does* care about the length, otherwise we wouldn't need a field
saying what the length was....)

Now think how many ways that can go pear-shaped.  You copied in 98 bytes, but outside
the function, they think that header is almost 4 pages long.  Does that ever get used as
a length for kmemcpy()?  Or a limit for a 'for (i=start; i< (start+hdr->hdr_len); i++)' that
walks across a variable length header?

Can you cook up a way to have a good chance to oops the kernel when it walks off the
page you allocated the 98 bytes on?  Can you use it to export chunks of memory out to
userspace?  Lots and lots of ways for this to kersplat a kernel...;

--==_Exmh_1539047240_7716P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW7v/SI0DS38y7CIcAQKEFgf9E+sMPZmhYDvR8pRqDx1ieuHDbfnaMBNm
PDfnp/S5xMWASD9bEEGu5xtSYC9aR1GjTFFtyW/ytz1wIpXHyf7XZgOf4HqJfrkK
DqqTOxkzkuTcyNafTbyrv3Mpzu/VhnHnjnRv45BYWCOXGJzXALgjeyvywJcJuzkH
7Vd0n0GGc+aHxBhAbTYPx1es+lrD9MaxJzMwbPp0u6zMAIFr1GMtwihu1GfDjEM+
1zLllX8a/tIEaCpTbQuYli8gWVbMfWELartMBm8taFfppIj+/op4UMH79FZY96gy
8nTQZgvIlIWbNrAyydG6P9lPFTBT/d7n9c7TQeCWkwoPRvBU7pB1GQ==
=h6iu
-----END PGP SIGNATURE-----

--==_Exmh_1539047240_7716P--
