Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEF120657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J1ddJhMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfAQS3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:29:08 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41394 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfAQS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:29:08 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2D07E10C0A39;
        Thu, 17 Jan 2019 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547749747; bh=q+wmsno1ErM+0BRbQfcK0TkrpwIkbYy4fM/At7+mljo=;
        h=From:To:CC:Subject:Date:References:From;
        b=J1ddJhMhNf79xYcnz+vmTOGiKQObKPbBlD6uLKGaS3Bsdn5FwstPsD4llza6mQwU+
         hAjRwlYdNoHTOcsdMZfv8swutBpM0OiOsNM75IPNUBk0KtteWkY+CRTbSl1r6HYC7H
         cM8TOnt3qaT94QtDcEzZswFbLjnYCs1eigYRSB+DzF1D1w2hqFhgQ3keNifIWW8rZn
         +BhLvqcaUqCVF8XFusEK4MQqwkHhGI30tcROLe3ipzhhmLAOy3ZckHpl4e6eD1rwT4
         VollQIAm1TjdSfhqul6w0nIFJIMfbBFHRb7TYuasJiNhlNx2UHEuV5iJPSeZLuLsGb
         xEyLwCl94+S4A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 646E84D69;
        Thu, 17 Jan 2019 10:29:06 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Thu, 17 Jan 2019 10:29:06 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Topic: [PATCH] arc: remove redundant kernel-space generic-y
Thread-Index: AQHUrhRmvaLBn21IZkyFbbYx474xYw==
Date:   Thu, 17 Jan 2019 18:29:05 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146429030@US01WEMBX2.internal.synopsys.com>
References: <1544969781-14506-1-git-send-email-yamada.masahiro@socionext.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641FC6F@US01WEMBX2.internal.synopsys.com>
 <CAK7LNATJVGVJi_S99zfEpKe+HYWpk+TkfT4gCFZVVTibyP=ThA@mail.gmail.com>
 <C2D7FE5348E1B147BCA15975FBA2307501464221E5@US01WEMBX2.internal.synopsys.com>
 <CAK7LNAT99BNySdeUK=qhXnYSwry=8wADOd7KLjVUAdgQoKjeuA@mail.gmail.com>
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

On 1/16/19 7:26 PM, Masahiro Yamada wrote:=0A=
> This was not sent in the previous MW.=0A=
> (Nor did I see ARC pull request.)=0A=
>=0A=
> Is it aiming for v5.1-rc1 ?=0A=
=0A=
Sorry for the delay, this will happen in next few days !=0A=
=0A=
-Vineet=0A=
