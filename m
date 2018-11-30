Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB41C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB3820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HS0eWDst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB3820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLAGkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:40:04 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:53756 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeLAGkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:40:04 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4F2D610C1050;
        Fri, 30 Nov 2018 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543606185; bh=q2GNK6YBsTlz/DUIohoAV0KIDZTNxA7yvSkHVOOTzic=;
        h=From:To:CC:Subject:Date:References:From;
        b=HS0eWDstR6b+ODPG2eOmxsLocDmmHfCN9wH4rXPlGLrOXjTUZWbANQadp1L4nuORW
         w4WP74xFzhxikTbteHNQ1XuplJiu01yyJwnevuTT+voNZm1yCGf8RKBWCzMV5+nKR7
         SrQI1tqgAW2CqsddHYmzccUIHGz9U4Jqi6x5/1HMY9jHqlahC5Q3dqRMhzGFOEMs+Z
         JfdjomkYKZEuZ6oUv88p8TBxdLHBmyFtRxXE0/lSSCUx/Me6rdRzBeY17bBlAxS+op
         WI3JjM/dVaw0nrgLTTq96NwjEahYPJzOPHXHmxhvhv0gQ85sWiocakTr8dSa10e8pr
         F9Mt0uwXXj/Sw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 353235DCC;
        Fri, 30 Nov 2018 11:29:45 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 30 Nov 2018 11:29:45 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v3] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH v3] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUiJG/o7fyzIGCckGLnUFm4swJ4g==
Date:   Fri, 30 Nov 2018 19:29:44 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641A449@US01WEMBX2.internal.synopsys.com>
References: <244eba764469e8493f2d0c85a6d965aad6cd8128.1543571088.git.joabreu@synopsys.com>
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

On 11/30/18 1:47 AM, Jose Abreu wrote:=0A=
> Some ARC CPU's do not support unaligned loads/stores. Currently, generic=
=0A=
> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.=
=0A=
> This can lead to misfunction of some drivers as generic functions do a=0A=
> plain dereference of a pointer that can be unaligned.=0A=
>=0A=
> Let's use {get/put}_unaligned() helpers instead of plain dereference of=
=0A=
> pointer in order to fix. The helpers allow to get and store data from an=
=0A=
> unaligned address whilst preserving the CPU internal alignment.=0A=
> According to [1], the use of these helpers are costly in terms of=0A=
> performance so we added an initial check for a buffer already aligned so=
=0A=
> that the usage of the helpers can be avoided, when possible.=0A=
>=0A=
> [1] Documentation/unaligned-memory-access.txt=0A=
>=0A=
> Changes from v2:=0A=
> - Rework commit msg (Vineet)=0A=
> - Check if count is 0 and return (Vineet)=0A=
> - Use two different loops (Vineet)=0A=
>=0A=
> Changes from v1:=0A=
> - Check if buffer is already aligned (David)=0A=
> - Remove 64 bit mention (Alexey)=0A=
>=0A=
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>=0A=
> Tested-by: Vitor Soares <soares@synopsys.com>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
> Cc: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: Joao Pinto <jpinto@synopsys.com>=0A=
> Cc: Vitor Soares <soares@synopsys.com>=0A=
> Cc: David Laight <David.Laight@ACULAB.COM>=0A=
=0A=
Applied to for-curr after some minor chg (added a comment about accessor)=
=0A=
=0A=
Thx,=0A=
-Vineet=0A=
