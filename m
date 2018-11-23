Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A373C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5583920861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5583920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=corsac.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439702AbeKWXvd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:51:33 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:35470 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403801AbeKWXvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:51:33 -0500
Received: from mail.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e20::5])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 092DD780336
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:07:24 +0100 (CET)
Received: from scapa.corsac.net (unknown [IPv6:2a01:e34:ec2f:4e21::1])
        by mail.corsac.net (Postfix) with ESMTPS id BD79792
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:07:22 +0100 (CET)
Received: from corsac (uid 1000)
        (envelope-from corsac@corsac.net)
        id a00ca
        by scapa.corsac.net (DragonFly Mail Agent v0.11);
        Fri, 23 Nov 2018 14:07:22 +0100
Message-ID: <df9bc91da52405f4cf1e75e2530151317068c46f.camel@corsac.net>
Subject: Re: [PATCH] usbnet: ipheth: fix potential recvmsg bug and recvmsg
 bug 2
From:   Yves-Alexis Perez <corsac@corsac.net>
To:     Bernd Eckstein <3erndeckstein@gmail.com>, davem@davemloft.net
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 3ernd.Eckstein@gmail.com,
        Oliver Zweigle <Oliver.Zweigle@faro.com>
Date:   Fri, 23 Nov 2018 14:07:18 +0100
In-Reply-To: <1542977486-15363-1-git-send-email-3ernd.Eckstein@gmail.com>
References: <1542977486-15363-1-git-send-email-3ernd.Eckstein@gmail.com>
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Fri, 2018-11-23 at 13:51 +0100, Bernd Eckstein wrote:
> This causes the following problems:
> - double free of the skb or potential memory leak
> - in dmesg: 'recvmsg bug' and 'recvmsg bug 2' and eventually
>   general protection fault

For what it's worth, Bernd contacted me because it looks like this was the
cause of https://lore.kernel.org/lkml/20180605085450.GA3506@scapa.corsac.net/

I wanted to try Bernd patch, unfortunately I wasn't able to reproduce the
freezes on more recent kernels, so right now I can't add a Tested-By, but I'd
be happy to be kept on CC.

Regards,
- -- 
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAlv3+4YACgkQ3rYcyPpX
RFuuoQgAhJHvzpl1yr7ZM215DviNj8Q/n7WpiWSk6ik5Ts8n4qsgIRcXojhEPfkw
KAmpJ7G1zRgxRtZayiKLUl7RE3uWNOjTph3pzztBmMI+P7C/R4pVdZeRlandGsju
YH6G32u+BB55tJw/TYrahlG3Ni0HNDoL+QfgJJno6/dr9V+YFr+opTCuDchaBHeJ
acVsogUkyclvAutHt3UMjiDvVB12mW6IFz997y1Fv3JMT9HTQrDT9VdMUSr2WC5s
rb9ONoim1ADDgTBN10mbPWZ80aooR8GtNEGpFa2EL0vPdNVlqyZqV46hYbLuZZ42
tMF3AD6hrQqxitCS3QGJpWjFFscFMA==
=OkrF
-----END PGP SIGNATURE-----
