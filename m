Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5227C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602272075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EjrGcssD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeIECBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:01:46 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50330 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeIECBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:01:46 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DFDCD24E04B9;
        Tue,  4 Sep 2018 14:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536096887; bh=xAZTeEXefI009SC/MAaSkD1PBIujZvFdYkzXeouXKKU=;
        h=From:To:CC:Subject:Date:References:From;
        b=EjrGcssDan9/UW1xTPTUZ0gkzHAAc4t/5a29AkQnlwS7Qh1+Q0CGAjf0ed+e8tJrz
         VjgZBPVxfmcEW2p2beWxwDMIjv+E0XWMqcbUBdnDfwr8rYbwdXL8cr4ggEa96JaTTr
         YJ+9X9YXdv23Nva6yq1QikVzec0l7BMXoPhDVUyiGEOu9qhm9Wqtor0hrXovHuF4on
         qy9pe0CJBk68fTmB+Y/DoDzMSlfKL9lszTUnnqQbubIfS2NmwCgxSElCNfH3qXqKaD
         iSme5ozzzfQ1AW1GQO7CS7j6Jm/DMukcplxUGEhh35IKD8vXyAkNxY8Ml5bB/fNCIA
         2QM/RpJ/Bj4uw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id C8043591E;
        Tue,  4 Sep 2018 14:34:47 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 4 Sep 2018 14:34:43 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUKCIZ2r1FEf6H/EahxizEoOt7oQ==
Date:   Tue, 4 Sep 2018 21:34:43 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B091717@us01wembx1.internal.synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
 <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
 <20180904211107.GA8202@lst.de>
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

On 09/04/2018 02:07 PM, Christoph Hellwig wrote:=0A=
> On Tue, Sep 04, 2018 at 01:14:49PM -0700, Vineet Gupta wrote:=0A=
>> Apologies for the delay in getting to this - series applied and pushed t=
o for-curr=0A=
> This is going to create really annoying merge conflicts with=0A=
> work pending for the dma-mapping tree.  That's why I requested earlier=0A=
> to merge it either via the dma-mapping tree or some shared branch.=0A=
=0A=
Sorry I missed that request of yours on top of the last msg. I would really=
 want=0A=
this to get into 4.19 (understand that merge window is done etc) given that=
=0A=
there's a bunch of other changes lined up behind this one. I was just sucke=
d up=0A=
into "other" stuff and could not get to it sooner. Please bear with me this=
 once -=0A=
hopefully it would be smoother going fwd.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
=0A=
