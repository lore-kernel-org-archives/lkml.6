Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348FDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD9121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD9121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbeKPC5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:57:53 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54980 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387833AbeKPC5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:57:53 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wAFGnIu5001063
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:49:18 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wAFGnDgs032678
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:49:18 -0500
Received: by mail-qk1-f198.google.com with SMTP id d196so45899924qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 08:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=qHcLC4CEUoWxYpQg2rsNMeaPzsHNJ9rAWnmWKbwnlhI=;
        b=MEuSvta+m4S85g2SZXVcHl7lscP/vfFGMMIG9GZu1DkFG5T9zvoE/DyrgsAZVqyDxj
         CGUEnt5QQqiXeNFnY7yVCinUojvmsLJSlVumrp/tNl1aBN2Jpp384xPBpFbfK0vAioYq
         TIsy8+v2hiXPB+POQIN0luJvZpcdbLXRPvzjY7c0UD9ziAFozYtIjviUDpx97MP/nANi
         aX9d9BdHf7OfBpI4sds5LzuksjYcCnBCD/fueoF5AX2bNMcTLhNyCQyF2uQ6MJaDioeZ
         O31Pg8XwF8GS0+o+wWNP+pap9R829HEm8lzVYwm72e9Zrg+3wA79aFz9momY0xnD+jit
         1Gmw==
X-Gm-Message-State: AGRZ1gJu6xasi6BYATNG/Gkm43p4Zm+y3E2RMJi/Ue2xr1T9a2MGyZTp
        31WBQOjcfL6bV6ri2KIBhadRXj2Iu5HWwqaXF34nZjUbahCn4Vpls77sqkZlPaT+DhkwWke07h7
        LeZHFc7BEWmH07WaiDsuAOOK80h0ifqXfEYk=
X-Received: by 2002:a0c:9384:: with SMTP id f4mr6918804qvf.239.1542300552857;
        Thu, 15 Nov 2018 08:49:12 -0800 (PST)
X-Google-Smtp-Source: AJdET5cVTBLiCSlATS56F1cVNGpPehzaFeU4W2Lo/ieGsLnZJPiMkgrUKoXDhrpy6mQ54mkB/b34Ow==
X-Received: by 2002:a0c:9384:: with SMTP id f4mr6918778qvf.239.1542300552514;
        Thu, 15 Nov 2018 08:49:12 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id n92sm1076581qtd.85.2018.11.15.08.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 08:49:11 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org, jungseoklee85@gmail.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        takahiro.akashi@linaro.org, mark.rutland@arm.com,
        barami97@gmail.com
Subject: Re: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1542300549_2379P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Nov 2018 11:49:09 -0500
Message-ID: <28496.1542300549@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1542300549_2379P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Nov 2018 18:52:39 +0530, Pintu Agarwal said:

> Currently, when I tested this (as a proc interface), I got the below output:
> CPU    UNUSED-STACK    ACTUAL-STACK
>  0         16368                     16384

> 3) How should I test it to get the different usage values for unused stack ?
>     Can I get these values by implementing a sample interrupt handler,
> and printing information from there?

Hint 1:  If you're in a state where seq_printf() is legal, how many IRQ's are
on this processor's IRQ stack?

Hint 2:  What are the chances that some other CPU is currently in an IRQ?
(run 'top' and look for what percent of time that's happening)

Hint 3: what are the chances that the value of irq_stack_ptr is already stale
by the time seq_printf() finishes running?

Hint 4: what happens to the validity of your output if you get rescheduled
in the middle of that for_each loop?

(In other words, this code is terribly racy and is probably not going to answer
whatever debugging question you were working on..  If your question is "Did one
of the CPUs blow out its IRQ stack (or come close to doing so)?" there's better
approaches.



--==_Exmh_1542300549_2379P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEVAwUBW+2jhY0DS38y7CIcAQJbXAf/Tzi661RNRip58FF5Idc+J3pchStOvO5N
wYs3oy48KyG/cR71n8Ypwg6Lt5YKS13l/mrO17as+fwJwTMtTYJ5nZVUQVWQZEkE
ME1vBAMmE/Xs1uBTwuy+Hnxi525xIKXE74iM9qChoRer2+VM9fTo7uCY3KcrGFRq
RzTh2GkosxuzYdLM5w3wLEo1Y46egkCCKYPH+SfohiFdnn1m40LyinF5y+OSH6xZ
ZJw0RUWEbJ0SZu5XHyEKVzeW9xXPluDvv13QC/qaTrUeGgzY6/lu4Gnp56rYDhLy
aiQluwSzLN5Egl45pQlFz3oYa1Qg+ujSay7x7xlWJPKrdgNZWE4Nzw==
=N6Jk
-----END PGP SIGNATURE-----

--==_Exmh_1542300549_2379P--
