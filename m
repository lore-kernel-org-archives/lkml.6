Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD280ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5920852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jZofVk37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbeGWRjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:39:00 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:48575 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbeGWRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:39:00 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7786E10C0443;
        Mon, 23 Jul 2018 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532363818; bh=DdwxYamuIUQ8T+lPNOZFITrRzzFqHFdmHyyHOncyJXo=;
        h=From:To:CC:Subject:Date:References:From;
        b=jZofVk37TZqOh+lbNf0e3GqrDHY6CCMKehZkBvDTEmjcpMsgi3kh/4uTkRCmD0zDx
         wF5xllD6ygWfuLCaHtodnrffjca6LIZBsjVGBFA0ZP7mvBLgscPV24TKXv0cyUZnsd
         nluMr4KmT6FmaT/qqVIL/X4vFjuYj9Ybz+l8nYYtucNz+9+nZAFnawcyqeC44LqMES
         BjTV6ZAVGBENIjxVHwXKAPSvB0fWVfIw8vg3/udyjHtV7CkbIhsAe2tJnuD431W34N
         KaKq0O5jeyaHi+zWBwzZsp0XdOcWIvkjzHgrAZMEMgmjLqne5qiTLlgjQG+ULtq/Zk
         WNTtcCVdonZHg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4197C5CE1;
        Mon, 23 Jul 2018 09:36:58 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 23 Jul 2018 09:36:57 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     "Ofer Levi(SW)" <oferle@mellanox.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Meir Lichtinger <meirl@mellanox.com>
Subject: Re: arch/arc/ allmodconfig
Thread-Topic: arch/arc/ allmodconfig
Thread-Index: AQHUHyKW1M3GsAcZr0iuL832AquqnA==
Date:   Mon, 23 Jul 2018 16:36:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B07F319@us01wembx1.internal.synopsys.com>
References: <e074d0ae-6d79-d21a-2278-15d516bb943e@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B0724EB@US01WEMBX2.internal.synopsys.com>
 <AM0PR05MB42600653CF591791731CCCD8DA510@AM0PR05MB4260.eurprd05.prod.outlook.com>
 <DB6PR05MB4597A63819F227B17652B5B2B2560@DB6PR05MB4597.eurprd05.prod.outlook.com>
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

Hi Ofer,=0A=
=0A=
On 07/23/2018 01:34 AM, Ofer Levi(SW) wrote:=0A=
> Hi Vineet, randy=0A=
>=0A=
> Indeed this structure is missing, following is a patch based on linux-4.1=
7.9.=0A=
> Sorry about that.=0A=
>=0A=
> Thanks=0A=
>=0A=
>=0A=
> diff -uprN linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h linux=
-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h=0A=
> --- linux-4.17.9.org/arch/arc/plat-eznps/include/plat/ctop.h    2018-07-2=
2 16:16:09.000000000 +0300=0A=
> +++ linux-4.17.9/arch/arc/plat-eznps/include/plat/ctop.h        2018-07-2=
3 11:18:12.179402620 +0300=0A=
> @@ -143,6 +143,15 @@ struct nps_host_reg_gim_p_int_dst {=0A=
>  };=0A=
>  =0A=
>  /* AUX registers definition */=0A=
> +struct nps_host_reg_aux_dpc {=0A=
> +       union {=0A=
> +               struct {=0A=
> +                       u32 ien:1, men:1, hen:1, reserved:29;=0A=
> +               };=0A=
> +               u32 value;=0A=
> +       };=0A=
> +};=0A=
> +=0A=
>  struct nps_host_reg_aux_udmc {=0A=
>         union {=0A=
>                 struct {=0A=
=0A=
Thx for this change. Can you please send a proper patch with changelog, cit=
ing the=0A=
issue as Reported-by etc.=0A=
Also if Mellanox is interested in maintaining the NPS port going fwd, someo=
ne (you=0A=
?) should add their name to MAINTAINERS file under arch/arc/plat-eznps and =
send=0A=
that patch as well.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
=0A=
=0A=
>=0A=
>=0A=
>=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Meir Lichtinger=0A=
>> Sent: Friday, July 20, 2018 10:19=0A=
>> To: Vineet Gupta <Vineet.Gupta1@synopsys.com>; Randy Dunlap=0A=
>> <rdunlap@infradead.org>; LKML <linux-kernel@vger.kernel.org>; linux-=0A=
>> snps-arc@lists.infradead.org; Ofer Levi(SW) <oferle@mellanox.com>=0A=
>> Cc: Leon Romanovsky <leonro@mellanox.com>=0A=
>> Subject: RE: arch/arc/ allmodconfig=0A=
>>=0A=
>> Hi Vineet,=0A=
>> Ofer Levi is now the maintainer of arch/arc/plat-eznps=0A=
>>=0A=
>> Ofer,=0A=
>> Please take care of the issue below=0A=
>>=0A=
>> Thanks=0A=
>>=0A=
>>=0A=
>> -----Original Message-----=0A=
>> From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com]=0A=
>> Sent: Thursday, July 19, 2018 19:22=0A=
>> To: Randy Dunlap <rdunlap@infradead.org>; LKML <linux-=0A=
>> kernel@vger.kernel.org>; Vineet Gupta <Vineet.Gupta1@synopsys.com>;=0A=
>> linux-snps-arc@lists.infradead.org=0A=
>> Cc: Elad Kanfi <eladkan@mellanox.com>; Leon Romanovsky=0A=
>> <leonro@mellanox.com>=0A=
>> Subject: Re: arch/arc/ allmodconfig=0A=
>>=0A=
>> +CC some folks from Mellanox=0A=
>>=0A=
>> On 07/18/2018 10:37 PM, Randy Dunlap wrote:=0A=
>>> Hi,=0A=
>>>=0A=
>>> When I try to (cross-)build arch/arc/ allmodconfig, I get a syntax erro=
r here:=0A=
>>>=0A=
>>> ./arch/arc/plat-eznps/mtm.c: In function 'mtm_enable_core':=0A=
>>> ../arch/arc/plat-eznps/mtm.c:113:30: error: storage size of 'dpc' isn't=
 known=0A=
>>>   struct nps_host_reg_aux_dpc dpc;=0A=
>>>                               ^~~=0A=
>>>=0A=
>>> There is no struct nps_host_reg_aux_dpc in the kernel tree.=0A=
>>>=0A=
>>> Can you do something about this, please?=0A=
>> Thx for the report Randy. I'm calling out Mellanox folks to see if they =
can=0A=
>> provide a fixup, else we will revert the corresponding change.=0A=
>>=0A=
>> @Elad, upstream commit 3f9cd874dcc8705 "ARC: [plat-eznps] avoid toggling=
=0A=
>> of DPC register" added reference to struct nps_host_reg_aux_dpc but the=
=0A=
>> definition is missing. Can you please provide a fixup as I have no idea =
of that=0A=
>> platform specific struct.=0A=
>>=0A=
>> @ Leon, reaching our to you, since it seems you removed Elad from=0A=
>> MAINTAINERS file, so I'm not sure if he is still at Mellanox.=0A=
>> The two folks I worked with on EZCHiip Linux port Noam Camus and Gilad=
=0A=
>> have left Mellanox.=0A=
>> If you or someone from Mellanox are interested in maintaining this platf=
orm,=0A=
>> please update the arch/arc/plat-eznps section of MAINTAINERS file.=0A=
>>=0A=
>>=0A=
>> Thx,=0A=
>> -Vineet=0A=
=0A=
