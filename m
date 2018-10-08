Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FFCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FA9213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FA9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJIEa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:30:59 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59826 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726103AbeJIEa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:30:58 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w98LHGj5004321
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 17:17:16 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w98LHBas017803
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 17:17:16 -0400
Received: by mail-qk1-f199.google.com with SMTP id a130-v6so22240410qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 14:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=8QU2EILo8GuvQMIgvFTpu0YfleCpISuNvAYLcJ+MBYk=;
        b=K5QCYyHAI7VUPf8yEcEtgQkdQrG0tT8UhhUB9cGbNB/84+vO9JCAx2U/M4RL4/rW9J
         1lDA9rFehHGthaKfdvu9FjY0EcNOc8Jg1YEeKLPhuNasFOznrEb6/HqaQUhyGX7AbeW2
         cniduhvnZp9n42xoNfzemLEPKeQueu8y3TzQeF1r7QGaJyVutd8PFMnaIti25zB/I8wI
         +favGYG+rIL0azUBf+4hAhDu+MF1Xc8BeNBvDzGmL7UMq4mixXasL6bkwpcTyrp6aQiw
         0EeSGdxvFhCE1Mb3dNo9XsYXeXY1fzeQa8JgQemDegVGbT4xxd8glpcQmJ9/0a3yk17I
         lSsw==
X-Gm-Message-State: ABuFfohJgHvdtUWZpCfFE5fH3HQ9vkTuN4hf1/t6cuy1keWBtXAMvE7h
        et0PiycxnqvXwpU26r+icLawUoryn9i/lklKWxNf7EwlkrOBb2EGaJVxvIv+z0TdNMwJZR+Pph/
        Raov8ilZIzDrLSlydWCzeCe/Dk+R0R92nbqA=
X-Received: by 2002:a37:a141:: with SMTP id k62-v6mr19799006qke.276.1539033431576;
        Mon, 08 Oct 2018 14:17:11 -0700 (PDT)
X-Google-Smtp-Source: ACcGV6088EUDc8acLsZY5B+k9q3JOkSzF/qy9a4P3pJZMu/vm0dcsi32TVWeDQOoSVRXCh49Pw43dw==
X-Received: by 2002:a37:a141:: with SMTP id k62-v6mr19798981qke.276.1539033431146;
        Mon, 08 Oct 2018 14:17:11 -0700 (PDT)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id t12-v6sm9101328qtc.67.2018.10.08.14.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 14:17:09 -0700 (PDT)
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
In-Reply-To: <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com>
References: <1538943795-30895-1-git-send-email-wang6495@umn.edu>
 <CAPhsuW5vnVjRS7DWFYPSmq5G-dAFxOrHCAOMkK-iaOoirzMazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539033428_2640P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 17:17:08 -0400
Message-ID: <43898.1539033428@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539033428_2640P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Oct 2018 13:51:09 -0700, Song Liu said:
> On Sun, Oct 7, 2018 at 1:26 PM Wenwen Wang <wang6495@umn.edu> wrote:

> > same value. Given that the btf data is in the user space, a malicious user
> > can race to change the data between the two copies. By doing so, the user
> > can provide malicious data to the kernel and cause undefined behavior.

> These two numbers are copied from same memory location, right? So I
> think this check is not necessary?

Security researchers call this a TOCTOU bug - Time of Check - Time of Use.

What can happen:

1) We fetch the value  (say we get 90) from userspace and stash it in hdr_len.

2) We do some other stuff like check the hdr_len isn't too big, etc..

        meanwhile, on another CPU running another thread of the process...
                3) malicious code stuffs a 117 into that field

4) We fetch the entire header, incliding a now-changed hdr_len  (now 117) and
stick it in btf->hdr->hdr_len.

5) Any code that assumes that hdr_len and btf->hdr->hdr_len are the same value
explodes in interesting ways.



--==_Exmh_1539033428_2640P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW7vJVI0DS38y7CIcAQL5pwf8Co9z9WwdEhwn1zFByzTwSeNE/fwictdL
EwWkOJb6Q5B8O2QDZrcx2ZSXWEyqDQ8h5gLcyf1q8fenNIfAPM7SkBOUBQEjQMdU
zTwALpsm6IkcoasNe7LpVkVUc2dM4xclyayJOlcahNfDzYiWt1vXsPFN0aGy/Rx0
UQNc09M+6ClxQOcKuQ2leAsvKPghrkfuLOqCBVCaCbCPqrZxI1FDkBg4y3DqOziB
GPBNk0stfa6R5EeWPDsaWXmaCr36e0IWj9mcObUtWtzS+BwR2komgSPJAnoczBaX
0uWV5G/5GfI+tOlk4AcYD7rirsWCFGmDMM/qVLB2NdKbulpabX3XSw==
=m8eg
-----END PGP SIGNATURE-----

--==_Exmh_1539033428_2640P--
