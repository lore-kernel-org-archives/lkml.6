Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C2C20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="nHWXbYxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C2C20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeK2HGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:06:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:13287 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeK2HGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:06:12 -0500
X-Greylist: delayed 14530 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Nov 2018 02:06:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543435402;
        s=strato-dkim-0002; d=xenosoft.de;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=IAnc86Mm74e3jfu9BA5jYDElkumimEEMJY+DeZ1NOtY=;
        b=nHWXbYxEYJhIRZJcc76WsUTd7PYx0SXa/SCKBEXsn3KdQPJtlH3eGng6oOBeLiiVEB
        8irZAolWLaFoq5ldhfs6ovRmY4OcsqIm9ftfT08M+P0k8qVbvtGGFzw8c/R0Gop5PI+7
        AduF4tN/JHOVzmWQ10BAkwkJpUTx2vcZuFsSixezu+33szzeymNpTpTB0JYlC4k+RYK+
        kdMvdB5KbHAnJg+9jj+fDHCChaUVSKhG8lR2q8ZpL+W35azGiygeq6KdEjiaE7FAZsxF
        xGFmPflMQVlieaNarIyejV5BxnSmjYpponNT3RS0kGmub+jdKGQAIVVS5NP+p4eWuv2O
        8VPw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6Kxrf+5Dj7x4Ql+BpvNtdS8exnpixq1SAU6WYzmze+IMPjvAQ8O/7g=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:bce9:f264:6445:f38f]
        by smtp.strato.de (RZmta 44.6 AUTH)
        with ESMTPSA id 404b20uASK2q8Eg
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 28 Nov 2018 21:02:52 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Date:   Wed, 28 Nov 2018 21:02:51 +0100
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B91760F-AFC3-4C8C-9B9F-FA0E9AD76B0C@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will compile and test the kernel from the following Git on my PowerPC mach=
ines.

http://git.infradead.org/users/hch/misc.git

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.

