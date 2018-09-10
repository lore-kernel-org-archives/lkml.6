Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF3DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4712120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="jiEBscSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeIJRG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:06:58 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:47140 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:06:57 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 5567EAE002F;
        Mon, 10 Sep 2018 14:13:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536581588; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1JRr6btLiTvcbIB/c6MMSGgl7eI1r9n7QL7cbahoJA=;
        b=jiEBscSQ6y7aB4ZEjooZAsmDE6nixq7q2ZlC5KI7DyW8u5bWQHRudQTDaOH4wtCRl90yGu
        aGRfYSr04JiN/0K0SyjgxtRqXiMQBWNfH7eFrl6yY3q5AscvqCLHipGZI5k61O0U6LdHjm
        ExlEehyF/X+oje6HI54AX2gloslx9yYBHohpeePBVnSgoC5kTorXEyAbcSNqE8Iwo3FgHS
        8BItJ+ql97iCa8xAX9LB8a+jJ89V5FyE10FYCnRa0Z2pVVMDtBWOCBR91QI75lXK2UA6uc
        HD98MxMjjU//duckgYjYqXg/Wws8jJmpqyiVFfEJO+9l2fqBTPn1fxerzSV1Jw==
Subject: Re: [PATCH v3 2/3] dt-bindings: add bindings for mtd-concat devices
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        kernel@nospam.obeliks.de
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20180908131345.8145-1-kernel@nospam.obeliks.de>
 <20180908131345.8145-3-kernel@nospam.obeliks.de>
 <CACna6ryWCwKZJm2rq0_KeaKve8Ym9zi6AU+Kat9cpYAqtzCMdg@mail.gmail.com>
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
Message-ID: <bf3d2900-aa99-e39f-24af-aa57d1f41928@nospam.obeliks.de>
Date:   Mon, 10 Sep 2018 14:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACna6ryWCwKZJm2rq0_KeaKve8Ym9zi6AU+Kat9cpYAqtzCMdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.09.2018 um 12:51 schrieb Rafał Miłecki:
> On Sat, 8 Sep 2018 at 15:14, Bernhard Frauendienst  > <kernel@nospam.obeliks.de> wrote: >> >> Document virtual mtd-concat 
device bindings. >> >> Signed-off-by: Bernhard Frauendienst 
<kernel@nospam.obeliks.de> >> --- >> 
.../devicetree/bindings/mtd/mtd-concat.txt | 36 +++++++++++++++++++ >> 1 
file changed, 36 insertions(+) >> create mode 100644 
Documentation/devicetree/bindings/mtd/mtd-concat.txt >> >> diff --git 
a/Documentation/devicetree/bindings/mtd/mtd-concat.txt 
b/Documentation/devicetree/bindings/mtd/mtd-concat.txt >> new file mode 
100644 >> index 000000000000..2daf3157b163 >> --- /dev/null >> +++ 
b/Documentation/devicetree/bindings/mtd/mtd-concat.txt >> @@ -0,0 +1,36 
@@ >> +Virtual MTD concat device > > I think you forgot to include the 
documentation. Please ***describe*** > that binding.
You are right, I'm afraid I was mislead by some of the rather sparse
documentation files in the mtd directory.
Would something along these lines be sufficient?

--snip--
Virtual MTD concat device

A virtual composite device that concatenates multiple child devices into a
single mtd device. The child mtd nodes must also be defined in the tree and
are referenced using phandles.

Required properties:
- compatible : must be "mtd-concat"
- devices : list of phandles to mtd nodes in the order they should be
         concatenated

The device tree may optionally contain sub-nodes describing partitions 
of the
address space. See partition.txt for more detail.


Example:
--snip--

Regards,
Bernhard

