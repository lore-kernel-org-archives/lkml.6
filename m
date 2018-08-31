Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292DAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FB620839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 00:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HjEDhl5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FB620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeHaE46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:56:58 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:53444 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeHaE46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:56:58 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5771310C0A42;
        Thu, 30 Aug 2018 17:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535676729; bh=4J1u43kDnY1Dyx4f+fujDT7t8cS8RbnNVtZwezUM/28=;
        h=From:To:CC:Subject:Date:References:From;
        b=HjEDhl5EExW2miM92ZjDEG3slWJU2ulpYRDoXhJo3X6HPCxUyI6sln/iDVATeuYUw
         zifKjdEUZ5hJT2iXk3C5sSuvBul3Q0YfxFPoEQR6X6PHoYHf8m4MUBPYBl7Hu2li42
         sdKjaZ8qzLPA5lH1ahEGCSD5bnE71p03et8tkkiCaiu7H8xssn68SG2erxUUD3j8h9
         kNjHx0xKfw0a3wkktGzZfOjez0+QofYJTW47Kmjg97XBbZObFDNCMzZup3tu0t/CSy
         pxag4oCCXbvmvg1dQeeBqiN7TbeE4bmCJgNjAExSJ2w5ff3rndytV/fBfeajEZMc/t
         94rAxPFEibAAw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3BC233AE7;
        Thu, 30 Aug 2018 17:52:09 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu, 30
 Aug 2018 17:52:09 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arc: remove redundant GCC version checks
Thread-Topic: [PATCH] arc: remove redundant GCC version checks
Thread-Index: AQHUPbM8zg2W2Lq+m0K78lxlPbYixQ==
Date:   Fri, 31 Aug 2018 00:52:08 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B09102E@us01wembx1.internal.synopsys.com>
References: <1535339257-17620-1-git-send-email-yamada.masahiro@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/26/2018 08:08 PM, Masahiro Yamada wrote:=0A=
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")=0A=
> bumped the minimum GCC version to 4.6 for all architectures.=0A=
>=0A=
> With GCC >=3D 4.6 assumed, 'upto_gcc44' is empty, 'atleast_gcc44' is y.=
=0A=
>=0A=
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>=0A=
=0A=
Added to ARC/for-curr=0A=
=0A=
Thx,=0A=
-Vineet=0A=
