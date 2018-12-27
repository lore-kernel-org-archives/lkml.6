Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFA72087F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6rjo3Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeL0OVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:21:12 -0500
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37326 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeL0OVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:21:12 -0500
Received: by mail-vs1-f44.google.com with SMTP id n13so11386314vsk.4;
        Thu, 27 Dec 2018 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H3rlV8LZOCBI4MgjGcKbhjcNRM8sCP3Xe0DERlNs+9w=;
        b=P6rjo3MmJCNEP/GhM1bEYzfqDXrPcgEYj7S0hoElMJI/FaGS504hP7wUGcEaF+Y/Xf
         no4iK0gkFAtdfaNItGvsBEWgsdJp2AoOtVgpdN6WgffDJDx4XmEqjVSDBZYhZ8hhqO7H
         iBKt81uK9m/eShsYLfaP4U11l5fqFDxMD59mEWUA8u5+px3twjUUhAtgW6XajM9Y1pOn
         WYROFzJU6gitexEUnuhu4jxgXNNFcQFSsrUh5v9cXQntpTBuR5ZfXqi0PNQpC7+Vqj8B
         hCHMvNnmklIKFfLp40LvvtfxLDhh5P2hyhwm7oa/NN7I3GT3Q5blZW/Zs/TFSG0PkZYk
         diIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H3rlV8LZOCBI4MgjGcKbhjcNRM8sCP3Xe0DERlNs+9w=;
        b=rok9y0hVMfklbkrJst687VxMFEtiMRvus/GFgiH/G3g8JJmBpRmnwnQ3+fNSbgOTcT
         ls33NOBexU+WSyPksRbg8/ExQOMrIms02x05GCQWb1gQxUhX3vlcqYDqZkcHmAl1G9b6
         uF/CNcs0rC/MqsTq1JVHcA/Ga876FhlYstietpLz/1nhrtyeN0KyRn1Jj+zXuLUX0j6m
         2TYePagONYZfHkGyTJBWkYxVFjhs8zPpwlyJZLit4Ou7g+obhXrCr9EkOuSbLrSeXcXH
         2eOM9rMiDXzVX6gwppADGssseOu6jCyP+Bw8tZDkU5XOkfo0dbcal9MT+9UXWTzlZzMZ
         w1Ew==
X-Gm-Message-State: AJcUukcxeCvoCgG8AzPdp1hjQ/Mfe5XlvelNXCRtZ5K4Cobzz8LRyGGH
        FcdaanA1RI1miB34Fhts6db5yuad4Q4QSAejbbI=
X-Google-Smtp-Source: ALg8bN6gOpxFJydeZuCYGF4gRBwmmmYSf6Sp+m5wU4JTdSO1RovCy6S98Fic/K4YJrK0KRA7A2Oz4HtW/6aXM0JHdYs=
X-Received: by 2002:a67:c806:: with SMTP id u6mr8174131vsk.206.1545920470820;
 Thu, 27 Dec 2018 06:21:10 -0800 (PST)
MIME-Version: 1.0
From:   Stefano Cappa <stefano.cappa.ks89@gmail.com>
Date:   Thu, 27 Dec 2018 15:21:00 +0100
Message-ID: <CAKRytNzMHS-wN2_xSncf=a1Bgd=PVBV_GKHJw4tw1gc=_fkeNw@mail.gmail.com>
Subject: iMX6 FEC driver Linux-fslc 4.17 - IPV6 Multicast not working when
 unplugging/plugging ethernet cable
To:     fugang.duan@nxp.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
I already posted this in NXP forum as a comment
(https://community.nxp.com/thread/359397), in yocto mailing list
(https://lists.yoctoproject.org/pipermail/yocto/2018-December/043664.html)
and in meta-freescale mailing list
(https://lists.yoctoproject.org/pipermail/meta-freescale/2018-December/023625.html)
A user in meta-freescale's mailing list suggested to resend this
message to the emails obtained running "./scripts/get_maintainer.pl -F
drivers/net/ethernet/freescale/fec_main.c".


The problem is:

If I boot my iMX6 device with ethernet cable attached and I execute "ping6
ff02::fb" to ping the multicast address I get this response:
~# ping6 ff02::fb
PING ff02::fb (ff02::fb): 56 data bytes
64 bytes from fe80::c2f:eff:fe11:2d71: seq=0 ttl=64 time=2.057 ms
64 bytes from fe80::809:1bfb:8d4c:ae54: seq=0 ttl=64 time=73.101 ms (DUP!)
64 bytes from fe80::3e28:6dff:feed:5b97: seq=0 ttl=64 time=150.772 ms
(DUP!)


Otherwise, If I unplug and plug again ethernet cable, I cannot ping the
multicast ipv6 address anymore.
The result is:
~# ping6 ff02::fb
PING ff02::fb (ff02::fb): 56 data bytes
ping6: sendto: Network is unreachable


The original NXP discussion was about older version of Linux, however
this issue is happening with both Linux 4.9.88 and Linux 4.17.
Probably also with the latest version, but I didn't try.


Do you have any suggestions? Is this a bug? This is really a
frustrating and I'm really
surprised to see the same problem also on Linux 4.17.


PS: I'm sorry for the double email, but the previous one was in html
and it was rejected.

Thank u.
