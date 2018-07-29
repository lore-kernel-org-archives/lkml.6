Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A2F83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02320870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="hkTOHZTR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmNIbupV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeG2M0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:26:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56891 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbeG2M0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:26:03 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AF147219FE;
        Sun, 29 Jul 2018 06:56:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 29 Jul 2018 06:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=HNVPgMwaKf+xi9lU789xV7HyEEw3D
        JG+9HeFS10R7zs=; b=hkTOHZTRNXrgAC1pp4groe71MJsB/nSt8VawUHW97WqKL
        AFndinFnhLob3VVBoA8jOxP5p5kV3m+fjiEXWUw62GoaUt8j5bodglsl08PAyiKk
        ihtou1B/HLr4I9C/yCk4O5VKN232/RZuLxWhAMSDBQZbt7o4jwuVH5h3cVsG/rPY
        Q47+iYZ81bAoLcdBoR0qXARh44j1zg3pZWyB+vNXdK+QA9ScoZB62A28nFUNLoUO
        WbnxVF9BlGipT/POvGuTzwmt3gPXIBigMjHgzOkHfvgsjYRRdnFE3S2JuSH/pXUB
        883NwCOWBCDJ1HB00Z584W4htzv6g7YUmaiEiCaHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HNVPgM
        waKf+xi9lU789xV7HyEEw3DJG+9HeFS10R7zs=; b=JmNIbupVbHq0oGTPOGoRWq
        b+9IvTnnpaZrJ8lRFzRxMAoqL7WXMvTL4raDeQsG2vzZqBG2Q25Hb/u/LX4o7S08
        kiFp95P+ifsHsodRn9R0F6jPxqjISLeHTJTju67ZB8LBiDGFWNBdq7hpDEAl9WGV
        4QwlVtu9f1QGFlflVaXj71ropeQS5HCkXx1Q76sqKxU9ZZGpiirNTPFpZqLQBM04
        3qNxhlXU0vs3ah41jAKPVNTsj+/1HT8oWVX4OIGsXWptXHmpUFED/K3q0FYRyKMw
        bcXFP8lfepbOlAhjjFFiQe+gAboY+KNSFM5jBUcm/VVaOavCV5wXKa4S/hinDW0g
        ==
X-ME-Proxy: <xmx:QJ1dW13PZ0b5VBwEHtbZXAbA6Dih2ch3B8ge_K4g8WHjjvTuJEgVIA>
    <xmx:QJ1dW3zr1vi0vcTOrT4a41fi0SyFWIz2JQZcp9b5fRO-wMZnDozEyA>
    <xmx:QJ1dWxiRz61WxG4QhOyHBtuTk25-3UTA1kHsiL-HucpkgFsDwqvHBA>
    <xmx:QJ1dW--1QP_SUWcIlMPG9P2GTQI7bvcxfd6anGIpM9ymQ5v-L9XL9A>
    <xmx:QJ1dW-aeDm58JmvtvClpG0q7w4jLumLcsm8hRoIJRigIcqRDi_qhiw>
    <xmx:QJ1dW10OOIOMVRJitt-vi52T4RMjsroN-j3n_k_VWr6ZDm4tWI-Yxw>
X-ME-Sender: <xms:QJ1dWy4xZB797pEF2xPLqyEPH4Zu3m7F4X9SY6WF5Um9sv28m-n4hw>
Received: from [10.75.146.250] (unknown [37.170.65.248])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65455E4512;
        Sun, 29 Jul 2018 06:55:59 -0400 (EDT)
Date:   Sun, 29 Jul 2018 12:55:54 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <2964e51e-f5b5-dbb7-8975-09fa74b8295a@web.de>
References: <20180728062700.GA12127@kroah.com> <2964e51e-f5b5-dbb7-8975-09fa74b8295a@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 4.17.11
To:     =?ISO-8859-1?Q?J=F6rg-Volker_Peetz?= <jvpeetz@web.de>,
        stable@vger.kernel.org
CC:     linux-kernel@vger.kernel.org
From:   Greg K-H <greg@kroah.com>
Message-ID: <A7A60EC1-4599-4075-B663-1DF7527A19AF@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 29, 2018 12:47:16 PM GMT+02:00, "J=C3=B6rg-Volker Peetz" <jvpeetz@w=
eb=2Ede> wrote:
>Greg KH wrote on 07/28/18 08:27:
>> I'm announcing the release of the 4=2E17=2E11 kernel=2E
>>=20
>> All users of the 4=2E17 kernel series must upgrade=2E
>>=20
>> The updated 4=2E17=2Ey git tree can be found at:
>>
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable=2E=
git
>linux-4=2E17=2Ey
>> and can be browsed at the normal kernel=2Eorg git web browser:
>>
>	http://git=2Ekernel=2Eorg/?p=3Dlinux/kernel/git/stable/linux-stable=2Egi=
t;a=3Dsummary
>>=20
>> thanks,
>>=20
>> greg k-h
>>=20
><snip>
>
>Hi Greg,
>
>your signature files did not yet appear on
>https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/ =2E
>Any idea?
>
>Regards,
>J=C3=B6rg=2E

https://www=2Ekernel=2Eorg/minor-changes-to-tarball-release-format=2Ehtml
