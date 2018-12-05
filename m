Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE14208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxdqlP0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE14208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeLEWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:54:02 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:36097 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeLEWyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:54:01 -0500
Received: by mail-lj1-f176.google.com with SMTP id g11-v6so19898049ljk.3;
        Wed, 05 Dec 2018 14:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzC8fUCScosuPya/6tiSqS5z8Y/zmGX3vSVGUZgbK1Y=;
        b=KxdqlP0G4mguSvqgYyi+MC/ujTKgZXHjcUdAvqVdrr3UG2NM9WuIzQm4mZHZ1ICamw
         CNMY+uyw4J1sbPV5WP8UzRYZ4zZSEnveKpA3mDoRrUxiwT9KScCXcrECmHHdxKotsHaQ
         wTUGhf/Gf+ovVlL60UBC84KkLPioVHCuPz1ZglF4B3s6ljqSVhXW137/lnkNa+KUEh2I
         b7DmbKw/GfVNXyo0j+g6rgmvKiI6oy6aonLVQHehVnFYB0MaYBubxddQPCRFco9hxydf
         1ge2qoetB/l81D4IwSbzYkwxu/YO3GnQI2ERfHXxFVZp/d4/AP89GfCvuwpYykApGche
         O0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzC8fUCScosuPya/6tiSqS5z8Y/zmGX3vSVGUZgbK1Y=;
        b=BPw5/SkAsoh6VQaQ4oU+TcjMr8w1JHN7dKAzGtpjF2vQZfexeWEbgmiKIoojxi9kjK
         80O/bYfoPnqPq2tjMwT+KKtrU8AqvGXD1c+XBhTB3wTZZp6aaHzNU4iEB1irjk+/XHiI
         bXmhhskeNqpjLp5puBuiPhww4TpCn0iN17e9bhR4Vm3/U5aTsB/6W3+JiASx5WbVUBGq
         jhbR6e5VYqrchKnC3jUz0E4S5Jbtu5PdfAyCUzla1ppnIka0KiDsggIAraI2EBuLCzSp
         YEr8P/YEaNZ82de4uxpBvpcvCXsXfb+FXag+xQol/yPUYs70VGVhJ9H81D+rha9dr16i
         3wKg==
X-Gm-Message-State: AA+aEWZYsCsRJNUNYUhH/Lqy8NrpXP+MdhuicpB7zKmavXXfrLHw018U
        0+Dbcr7VMKOYZR8VcKydRZA6yWOFwnPb0+uJiIE=
X-Google-Smtp-Source: AFSGD/V8LYOGW/BMwENPsf7jG5fss5pBlMNsxT+ND6ZljPTMeSyx8R+AgnjO7PAeQaYB1uyewmNgclQmOZFYehOzsyw=
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr16670212lja.81.1544050439329;
 Wed, 05 Dec 2018 14:53:59 -0800 (PST)
MIME-Version: 1.0
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic> <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
 <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNxcpHDOn1Rkxwp8VbuN5-k08JfrgwdbN95uvMWVh1Rwg@mail.gmail.com> <AM0PR04MB3971DE1C9A0B3D6C938CBADD9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB3971DE1C9A0B3D6C938CBADD9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 5 Dec 2018 16:53:46 -0600
Message-ID: <CAChUvXNSGosbBbiBh-MF8FsnKpL3jMaS-fr_BzQAjEcPCWi7Ew@mail.gmail.com>
Subject: Layerscape behavior when a UE is detected
To:     york.sun@nxp.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Question 4) If so, will a panic ever be called if there is a hardware
>> uncorrectable memory failure?

>No. It is up to upper layer of EDAC driver. Layerscape driver only reports CEs and UEs.

Just to be clear, the upper layer of the EDAC driver will or will not
panic when a UE is detected on layerscape?

If there is no panic by the upper layer and no reset triggered by the
layerscape CPLD or memory controller, what happens on layerscape when
a UE is detected by the memory controller?

Forcing a UE by grounding a dataline caused a reset on layerscape
after a few seconds, but no panic. It is unclear why it reset, but it
appears as though a WDT was tripped. The UE was reported by EDAC and
seen in the log.
