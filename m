Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A67C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I2SRhAWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A67C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbeKVGCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:02:54 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33516 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeKVGCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:02:54 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6D95324E11EE;
        Wed, 21 Nov 2018 11:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542828438; bh=oUbD/pTlA89Y7EbU3qH3E2Fn8b/1mUJJWoBD9bajiDg=;
        h=From:To:CC:Subject:Date:References:From;
        b=I2SRhAWroGOlE8WtEYrVD2qeC4beeFArKTureSPONBW7hV5AwnJXcoscNLlutZthV
         SWs4Hqam2qtxT/ndpmTE6q7xCQUX6lLKyFdaBXJh3oDkBeloZy+FqvCOrEnW9ayHE0
         2LZ9NYFySBLMMBt3DhhpO+WPUSvVDrmrcVNqINI2cnlvti3wxzJL5L44kZ4bk3/g4a
         3OpDNSLUIn0yF5O8IAvFXGt1J8/5MY2uc2vZww2Q4Df8NYo+UCbFMw7LCQafustGvb
         zg34YW3ca2P7JVEfJK8T6WBmS9tMxJREjLnJzSfnFfRLur1iJ29SDEDBP4W3iy1vXD
         hurhezV9VRRrQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 61C463330;
        Wed, 21 Nov 2018 11:27:18 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 21 Nov 2018 11:27:17 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cupertino Miranda" <cupertino.miranda@synopsys.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] arc: [devboards] Add support of NFSv3 ACL
Thread-Topic: [PATCH] arc: [devboards] Add support of NFSv3 ACL
Thread-Index: AQHUgLwOF1eu85U5oUezfol+m7ZGcA==
Date:   Wed, 21 Nov 2018 19:27:17 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501464157E0@US01WEMBX2.internal.synopsys.com>
References: <20181120103019.12852-1-abrodkin@synopsys.com>
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

On 11/20/18 2:30 AM, Alexey Brodkin wrote:=0A=
> By default NFSv3 doesn't support ACL (Access Control Lists)=0A=
> which might be quite convenient to have so that=0A=
> mounted NFS behaves exactly as any other local file-system.=0A=
>=0A=
> In particular missing support of ACL makes umask useless.=0A=
> This among other thigs fixes Glibc's "nptl/tst-umask1".=0A=
>=0A=
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>=0A=
> Cc: Cupertino Miranda <cmiranda@synopsys.com>=0A=
> Cc: stable@vger.kernel.org=0A=
=0A=
Applied, with stable restricted to 4.14+=0A=
