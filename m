Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87121C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243DD20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FfFWYri8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243DD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbeG0ViB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:38:01 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:35654 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbeG0ViB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:38:01 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0274024E0E74;
        Fri, 27 Jul 2018 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532722473; bh=YjdJ/cb5nG7EIatGjIltA+ZdkpMjNfSDFh8tr9N3PUU=;
        h=From:To:CC:Subject:Date:References:From;
        b=FfFWYri8FPs0ChhH1EGSVj4cw2kmGcPOeAIJ4yWwxrYv6iqWJKU6eowDCnp0jdQj+
         WS101cNWj19LsJVDth+dw4hm78QoXriCOpiDNBZ3pKorx32NOWtJsvJAoB/x0fIuIQ
         zX8Q2SFcNcnjTR36E8iOjqx7x5xF/N28/LsvL5nPo0/wKSlTAfNWFQD3muZtzAmTkT
         DITSU8yUrlvZ6YP0FAupkICgqbrQZRakXsgH3lXYSDhWQB6kVvpfMZ096Lr9nlB1jd
         9QxE9OVloFZjzntodCxyR1mxdlGJ7LbJybfMQ2OyaVGogrLcMtdCHYeSfcdupVUihp
         YPfMaRq5yMe5A==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1745256BF;
        Fri, 27 Jul 2018 13:14:32 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri, 27
 Jul 2018 13:14:32 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     "Ofer Levi(SW)" <oferle@mellanox.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: arch/arc/ allmodconfig
Thread-Topic: arch/arc/ allmodconfig
Thread-Index: AQHUHyKW1M3GsAcZr0iuL832AquqnA==
Date:   Fri, 27 Jul 2018 20:14:31 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B08679D@us01wembx1.internal.synopsys.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
 <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B07F319@us01wembx1.internal.synopsys.com>
 <20180723165110.GR3189@mtr-leonro.mtl.com>
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

On 07/23/2018 10:02 AM, Leon Romanovsky wrote:=0A=
>>> diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h lin=
ux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h=0A=
>>> --- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07=
-22 16:16:09.000000000 +0300=0A=
>>> +++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07=
-23 11:18:12.179402620 +0300=0A=
>>> @@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {=0A=
>>>  };=0A=
>>>=0A=
>>>  /* AUX registers definition */=0A=
>>> +struct nps_host_reg_aux_dpc {=0A=
>>> +       union {=0A=
>>> +               struct {=0A=
>>> +                       u32 ien:1, men:1, hen:1, reserved:29;=0A=
>>> +               };=0A=
>>> +               u32 value;=0A=
>>> +       };=0A=
>>> +};=0A=
>>> +=0A=
>>>  struct nps_host_reg_aux_udmc {=0A=
>>>         union {=0A=
>>>                 struct {=0A=
>> Thx for this change. Can you please send a proper patch with changelog, =
citing the=0A=
>> issue as Reported-by etc.=0A=
>> Also if Mellanox is interested in maintaining the NPS port going fwd, so=
meone (you=0A=
>> ?) should add their name to MAINTAINERS file under arch/arc/plat-eznps a=
nd send=0A=
>> that patch as well.=0A=
> Hi Vineet,=0A=
>=0A=
> Thanks for your feedback, I'll work with Ofer to make it happen.=0A=
=0A=
Ping, folks can one of you please send a formal patch for this ?=0A=
=0A=
-Vineet=0A=
