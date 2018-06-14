Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34889C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDA2208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ssXc2M6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDA2208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755041AbeFNKMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:12:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:23056 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754963AbeFNKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1528971157;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=PPha2CR8y4y/2MF6RdBzKizzPD9FSt8Jze15DvFE2dM=;
        b=ssXc2M6sb1EHz9o+KKICFn1eAYZhzsgwTs0KX5+pjXEvEztXQd1unWpBvcAIZHtX6p
        O/ODKaQRGMC/cPrFdDhurBWoZJL9eTwUpoyWq12JciNfVmziNngTVBddOSkdwJZ4Fbhj
        z4+G/pwU+zeKoZNmAUjIf7IlHxZZL3+1OFfXrYEJMP9gMI0UdjHdFcinzOiRetwJLZLb
        ErSBH+zBkbD+OMbl9SGpw55UOrtGYPI5WavlD94gYZz1ZdBUlrBadKFP2pYiH4A0gQh5
        e3v9jnoNfWYGOLmenZtYI3R5OEgJNdgdaJbb/tSU7jM6YC8FxlMaYpZ69LoVb/1oWwhw
        UFNA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WisdN2EjaY"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id 407f97u5EACZQsi
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 14 Jun 2018 12:12:35 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bug with dwc3 id detect and regulators
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5B223D61.3030303@samsung.com>
Date:   Thu, 14 Jun 2018 12:12:35 +0200
Cc:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        linux-omap <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D8FE29AA-5EAE-4F1F-9F7C-8928624EEBED@goldelico.com>
References: <FE91CFE8-B9E6-4A14-8F5A-4D6AB0955290@goldelico.com> <CGME20180611085358epcas2p31227dd481046041532c7fc7a00c8e088@epcas2p3.samsung.com> <941bfd38-e975-e460-81aa-ce8d90c7a3f5@ti.com> <5B21C2E5.2090004@samsung.com> <e5e0aeaa-727f-7ae9-6ef0-e423dadb64e7@ti.com> <6A5F47F7-FDB8-4181-BE88-0D82A3053D9D@goldelico.com> <5B223D61.3030303@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

> Am 14.06.2018 um 12:03 schrieb Chanwoo Choi <cw00.choi@samsung.com>:
> 
> Hi Nikolaus,
>> 
>> So you can add my Reported-by/Tested-by.
> 
> Thanks for the test. But, you have to reply your reported/tested-by tag 
> to patch[1] because all tags should be remained on lkml.
> [1] https://lkml.org/lkml/2018/6/14/2

Well, I can't reply to that mail because I hadn't received it (yet?).

Maybe it works if you forward a copy to me.

BR, Nikolaus

