Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05DAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9011A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 05:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CkL62PiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeLQFAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 00:00:43 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60352 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeLQFAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 00:00:42 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C6D5724E1033;
        Sun, 16 Dec 2018 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545022842; bh=iAIn2IWAKHLWsHfUxt+ZXHl5Fx+BvH6F/8IBfkHMbCE=;
        h=From:To:CC:Subject:Date:References:From;
        b=CkL62PiOxwZX5RWiAjy4KlUXLpq9MqUQrIzwgYiQRzOFR5Q83UklDQcT4cQWNM4JW
         griih2ZXGhjQHMKh7vU9PTJP44nStMekMZikPlBWytetQ8LyXtS6zcG2E0Q9j51+CT
         2qdpVud2f3z/4+mN6vstgYFvDdaE3vK4S2Jt+XHHblyW8BxBKlF4r8tIVTRs0/qjKC
         9sNKUdDUZPULW6WdeZUoJPgWyXlOLzQDo6gO/1nup4Gvs5EruEmQbd1RrHgN/JqTbW
         oXP539J57fsNqkk46hs4mI+bC3A7wE9kjAffqwNbhpRc0r+Glo7LKCECJxVUkz8aB9
         6G2OlQNLG6hLQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5A9B8424D;
        Sun, 16 Dec 2018 21:00:38 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Sun, 16 Dec 2018 21:00:38 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Topic: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Index: AQHUlUobY6gxmBuDVUmOQANdccHfKg==
Date:   Mon, 17 Dec 2018 05:00:37 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
References: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/18 6:17 AM, Masahiro Yamada wrote:=0A=
> This commit removes redundant generic-y defines in=0A=
> arch/arc/include/asm/Kbuild.=0A=
>=0A=
> It is redundant to define generic-y when arch-specific implementation=0A=
> exists in arch/$(ARCH)/include/asm/*.h=0A=
>=0A=
> Remove the following generic-y:=0A=
>=0A=
>     dma-mapping.h=0A=
>     fb.h=0A=
>     kmap_types.h=0A=
>     pci.h=0A=
>=0A=
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
