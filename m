Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9271C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931A82086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931A82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbeKQC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:59:34 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39970 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728684AbeKQC7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:59:34 -0500
Received: from mr2.cc.vt.edu (mr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id wAGGkQF3011157
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:46:26 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id wAGGkLa1001817
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:46:26 -0500
Received: by mail-qk1-f200.google.com with SMTP id k203so52731956qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=L+HvCfaw6B+/0898uN9T+FbMSCTpuoGPTvXnfrwkt4o=;
        b=AvgSj9QG/PiHCiQSs+drLojtTspFBidG/CaTCqo1QelrlgUpV68uKiqnftKF6ynOc+
         VAH6V4Qq9XtQo3WHl+8ZNHlt2PLczim+NZfCBIViXZZFMv0emsfGz6OFADIq0qh3HXtO
         lfFZdpmdTXicGYPVQneQzcB+v4fNQxu/Is821SXRTwOyRYU3vDw6Gn0xYFVn8eJ3w+O2
         up5SVR/Ys7Gwy+Xla8BDD25g4R/68veCIBFG69nLPYmfsjkctiSRLlHf1YNlQb78maSC
         Apo4GaKrUyuRKRyeWo0Dx29F92R8wgOs/Cu1C1ZDRRJtFW1wd7owsb5dyNrK+k8Hno0z
         f+bg==
X-Gm-Message-State: AGRZ1gLpiudAqhoxN4U209yyrMiffdI417TDR1faz67gBhNliiJ+6tfC
        nNvr4VKb4ddSXoEubdc9FUifUZBdDnEAugP87h87ElUwtn8Kbg+WVuXUXsCxi4k6MMKTTL8vpiU
        sjQ9Ef6P6zxc/EvNRxis+hSupFzUkG+da4Z8=
X-Received: by 2002:ac8:f6f:: with SMTP id l44mr11190149qtk.158.1542386781342;
        Fri, 16 Nov 2018 08:46:21 -0800 (PST)
X-Google-Smtp-Source: AJdET5ctxrVsytH4TdXJ9ATAZshv+8vMZgQhDWTgwzQEld2Q6ADChqIm+Tw+nChrzYlNFIMB0rw3Vw==
X-Received: by 2002:ac8:f6f:: with SMTP id l44mr11190126qtk.158.1542386781030;
        Fri, 16 Nov 2018 08:46:21 -0800 (PST)
Received: from turing-police.cc.vt.edu (turing-police.cc.ipv6.vt.edu. [2001:468:c80:2103:f21f:afff:fe0c:8ada])
        by smtp.gmail.com with ESMTPSA id q62sm14694178qke.67.2018.11.16.08.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 08:46:19 -0800 (PST)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
In-Reply-To: <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com> <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com> <49219.1542367988@turing-police.cc.vt.edu>
 <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1542386778_2640P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Nov 2018 11:46:18 -0500
Message-ID: <5997.1542386778@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1542386778_2640P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Nov 2018 20:10:28 +0530, Pintu Agarwal said:

> > Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'

> For example: is it possible to keep storing the irq_stack_usage (for
> each cpu in a variable) information from boot time, and then use this
> variable to dump the irq_stack information, after the system booted,
> may be from proc entry ?

Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
for stack usage.

--==_Exmh_1542386778_2640P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEVAwUBW+70Wo0DS38y7CIcAQLyhwf+LbdeW3Fad1NYpj/avYgiq5aRcD8rafL9
r4vTU7D9o2U5jdYjXMB1UzRo26TrtjOY1FsutOPony+g3iOQhNR29GoIyXxprSPH
nf3UAwmyNkbPijEZYYv8Q5icfGZLCJarb+hR0fcfJMXO1H3ukkCbwUa4F8ntL3os
iWDOeh8EFALCb5C4c1+zyUDxr3mRHlbktg5lHooCaso5OPtqy4XOYi27Q7i0E6eO
UqKnVh/wf/TlNLxaKQBMx2b3wBSczP8hIdAxuDRmXc66X9VFef+Z9w4dZAP5EgQx
eAk9BbRs6FG4zzl/sxTxP6PWtPdToZF8LuJTYqNShSYdbXcarweuLQ==
=MIk6
-----END PGP SIGNATURE-----

--==_Exmh_1542386778_2640P--
