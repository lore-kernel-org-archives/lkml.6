Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF195C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7C217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+jMwqN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F7C217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeHDOgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:36:53 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58467 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbeHDOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:36:53 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Aug 2018 10:36:52 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4AC7430E;
        Sat,  4 Aug 2018 08:30:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 04 Aug 2018 08:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DCW2Vk
        h86TTCQMxQ4zQWTCLH1cOAyg4wsTa2BiGw7J0=; b=v+jMwqN/hAYe98mo8KDHr1
        KAlmERZvwu7EUNlkXKnpd2mQBMBWDw1uMWE6oDINJPaeXRHyoUs/gwGqNSWOUSR7
        fLkDsoNlop6PCiS/RgxtqNwWpGfbDoRENo/1aLyLzIfr2+lTLcZ4JzESrQwkuHik
        Lv+l84KTcvqV6Gz/0p++lGmIhP5GIIj3FMODerFwFU/unA3BzNhXkBmR6/pKg5kl
        RGAB72VEydcX/6bL1u7sI/Bn2jpkZ5d26TA9/JqYABRtveUvNGPKIZeqcGtCYkrC
        prZzMgEwOVWHfle73gljTcmEvrzjlWFxFXpl09eHJl3JwBs6Ug5u6FZ82taFzAJA
        ==
X-ME-Proxy: <xmx:aZxlW7HejbVTHtuc-Q68LwIXzMLQ8g6Ke1CIkMr7cR9MEoeGTl38Fw>
    <xmx:aZxlW_OMBdIuKcR15w-nUs7SiDU-qYS4eklsRzA0x3e9oKaZAVKtsw>
    <xmx:aZxlW23nKbxq60F4X3DKQRikGKqtPJiwNJ-gzZdb9t8UZ8_QH2MOcw>
    <xmx:aZxlW9CgqEc4zADspGRtsnppN0SqMq57nKb040IShQcjthDwrD3yKw>
    <xmx:aZxlW39XOuLhWSJRFSxp8NOmr-uvcYs8iLjbY-GxPo56SyDSz3-38Q>
    <xmx:aZxlWzKye3pB5OpY15veL4vbiIw2vlFyvbjtcayzi8LmaJHAuOJt4Q>
X-ME-Sender: <xms:aZxlW_w1IZboT3cn4j7V_mxYTX-HaAir6es_88Ckq0BCoSOsTzdseQ>
Received: from [192.168.178.24] (ip-213-127-46-170.ip.prioritytelecom.net [213.127.46.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA65CE405A;
        Sat,  4 Aug 2018 08:30:32 -0400 (EDT)
Date:   Sat, 04 Aug 2018 14:30:29 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
References: <20180803062828.GA9708@kroah.com> <afe8b55a-6cd3-b193-4cd6-8f78baa5298d@dev.carbon-project.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 4.17.12
To:     =?ISO-8859-1?Q?Kai_Wasserb=E4ch?= <kai@dev.carbon-project.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
From:   Greg K-H <gregkh@linuxfoundation.org>
Message-ID: <364B6D5B-B609-4AA4-B1E6-F93B965FD010@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 4, 2018 12:56:23 PM GMT+02:00, "Kai Wasserb=C3=A4ch" <kai@dev=2Ec=
arbon-project=2Eorg> wrote:
>Hey Greg,
>as with the 4=2E17=2E11 release, there is no signature file for the patch
>(<https://cdn=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/patch-4=2E17=2E12=2E=
xz>=2E Could
>you
>please add a signature for that patch?
>
>Thanks,
>Kai

https://www=2Ekernel=2Eorg/minor-changes-to-tarball-release-format=2Ehtml
