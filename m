Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB33C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F185B21829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XLgS8dHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F185B21829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbeHMUXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:23:05 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:54624 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMUXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:23:05 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CA63010C06DE;
        Mon, 13 Aug 2018 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534181993; bh=z5oWvDYYOnBroaDnSJFiXvHXUv160mS6+0Mswv6hOzw=;
        h=From:To:CC:Subject:Date:References:From;
        b=XLgS8dHmRgNhnDYlLdEbj90paomcMdfg/B5hwFaw7okbJeWrTjqLH19UpA+pRmHI/
         O0U8wh44+Yf8nb3rxpyQswVsJiusQCBsxnDU4CF1lYgkZBEioE3ArHkMzwkN7AuheP
         Lbwc0TP1BB22WxMlL7/hc/K5/bvK47hbSYPxUASv7Sfx/5Kqqi9yfAtn2s3veexz7I
         cFtv5fwfgK5ZBbNx9D21JTU8GdofDe/G+3LmUU4s1lBMj641+GRLPwQNjEH1BLUtoh
         zTTZaeIz+//syp4A4cPGgmUUjnsME6MF8D4VyXfsfRfM5omzsTdRRHb6eHg9UThkKv
         i1Z6W31O4CUaQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id B597134E5;
        Mon, 13 Aug 2018 10:39:53 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 13 Aug 2018 10:39:53 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIZ2r1FEf6H/EahxizEoOt7oQ==
Date:   Mon, 13 Aug 2018 17:39:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08C903@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B08C82C@us01wembx1.internal.synopsys.com>
 <1534181238.3962.74.camel@synopsys.com>
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

On 08/13/2018 10:27 AM, Eugeniy Paltsev wrote:=0A=
>> You didn't pay attention to my previous comment on this !=0A=
>> IOC port can be considered a micro-architecture optimization (an importa=
nt one=0A=
>> though). The main thing is hardware snooping DMA transactions which enab=
led IOC in=0A=
>> first place.=0A=
> Ok, I'll rewrite this commit message.=0A=
=0A=
No need since this is a cover letter and will get dropped anyways, but the =
reason=0A=
I emphasize it is that it sets the wrong expectations for someone down the =
line=0A=
googling for this stuff ! And that someone could be other or just us when w=
e've=0A=
long forgotten about this ;-)=0A=
=0A=
>=0A=
>>> Some recent SoC with ARC HS (like HSDK) allow to select bus=0A=
>>> port (IOC or non-IOC port) for connecting DMA devices in runtime.=0A=
>> Again you mention the port but none of your 4 patches actually touch the=
 port=0A=
>> itself in programming it.=0A=
> Ok.=0A=
>=0A=
=0A=
