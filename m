Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69502C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21436219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZDaGwQJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21436219E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeHHStU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:49:20 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:47266 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHStT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:49:19 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8B53B10C0443;
        Wed,  8 Aug 2018 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533745733; bh=4AGcqB+e4qeZArBdVTGSB7BzPos15PYRiaTR0Pg75rk=;
        h=From:To:CC:Subject:Date:References:From;
        b=ZDaGwQJZe61Z1Beiy2JUcVG8iQ77/ECfvTSJZVP5A8oEYt2JdhepsJK4DSbzWmkpr
         wqp1G++QrnAd/BwWQudwoerXrpY5WEBJG09BtTHfN2SNGUm97rWLO+JFGJ6ni1GeVD
         3lV6fGTrNF3sLK3AUYBHkiK+uTkpHFebUTWhp01y8V63YH1KTwcL883is8CqvxOSnN
         w3xVvHQsKZWf/FCHNADbWTIGCbyxr2K7wSXSq7TlSEkvLtcgb2u9UtaK6XpAZA+jDN
         4rW26FTGKVsgvu0G34zapWf/aooUZfNlJZgeHVDFLb6nO5tbkN5yF3RVaeTPOZJPW7
         lnb0M+tvl02wQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 77C013909;
        Wed,  8 Aug 2018 09:28:53 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed, 8
 Aug 2018 09:28:53 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: [plat-axs10x] Enable SWAP
Thread-Topic: [PATCH] ARC: [plat-axs10x] Enable SWAP
Thread-Index: AQHUKj3ZPcml6naXiUuGnFek+z5LzQ==
Date:   Wed, 8 Aug 2018 16:28:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08A875@us01wembx1.internal.synopsys.com>
References: <20180802085016.16000-1-abrodkin@synopsys.com>
 <14efb038-3fa4-9f92-740f-46ec982f2c8c@synopsys.com>
 <895ec9ce12151312c093a6676c68cd00a06df5aa.camel@synopsys.com>
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

On 08/08/2018 06:35 AM, Alexey Brodkin wrote:=0A=
> Exactly - in HSDK we happened to have SWAP from the very beginning=0A=
> so my intention was to align other boards so we get exactly the same=0A=
> behavior on all boards once SWAP was fixed by=0A=
> commit 6e3761145a9b ("ARC: Fix CONFIG_SWAP").=0A=
=0A=
I figured this - the patch was pushed to my for-curr yesterday for 4.19 !=
=0A=
=0A=
