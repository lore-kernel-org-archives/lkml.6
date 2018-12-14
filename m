Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4FDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6539820449
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VtKydcCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeLNN2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:28:37 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47998 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbeLNN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:28:36 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D62C210C1804;
        Fri, 14 Dec 2018 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544794116; bh=0xapzIaPNV3sNu+v49VfcOx7SrIFUNXX3URot2SaQMg=;
        h=From:To:CC:Subject:Date:References:From;
        b=VtKydcCfTcVisLRNHZne+SMFOhTLWzur/SSIlbRka52HSwSd52C+x+NyrZsRMsAVv
         WOjCfkbUeQjr6HU7QUiiVVnW3SzQdhJc8eBQrbVDjzheKXA7QYnrgMoLsK3Mppf7l9
         MBwhHTbV1tIf4//bVk7SIK7nuVzams3FrDUTZ0jdo/ItUjlt3TPDaud1Fhz/vEIskG
         wIWpevXmradg6HKw45MPJi1C0kShtUhZ0t37NyNC+QOt6xUeXLCSeFoyJyvp4bp3n7
         EhEzxi8JHNz42MbUGxjaQmn+oohKeDWnTydcp5A1G5QqkMg+MQg40WxuCALrOwfp/L
         92pcPdqOllUaA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id AFFDA3EDD;
        Fri, 14 Dec 2018 05:28:35 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 05:28:35 -0800
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 14 Dec 2018 17:28:32 +0400
From:   Artur Petrosyan <arthur.petrosyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Artur Petrosyan <arthur.petrosyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Topic: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Index: AQHUgOcejqdk/wCle0CvR7QZbzdrlQ==
Date:   Fri, 14 Dec 2018 13:28:30 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532CAB6E@am04wembxb.internal.synopsys.com>
References: <CGME20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3@eucas1p2.samsung.com>
 <20181120153815.31897-1-m.szyprowski@samsung.com>
 <3AD91E696667BF4BA728303C178E8A63532C68EA@am04wembxb.internal.synopsys.com>
 <abb9bb4d-968a-6c78-14c2-5b56b769572b@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.105.9]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,=0A=
=0A=
On 12/6/2018 18:20, Marek Szyprowski wrote:=0A=
> Hi Artur,=0A=
> =0A=
> On 2018-12-04 15:28, Artur Petrosyan wrote:=0A=
>> On 11/20/2018 19:38, Marek Szyprowski wrote:=0A=
>>> Power down feature of DWC2 module integrated in Samsung SoCs doesn't wo=
rk=0A=
>>> properly or needs some additional handling in PHY or SoC glue layer, so=
=0A=
>>> disable it for now. Without disabling power down, DWC2 causes random me=
mory=0A=
>>> trashes and fails enumeration if there is no USB link to host on driver=
=0A=
>>> probe.=0A=
>>>=0A=
>>> Fixes: 03ea6d6e9e1ff1 ("usb: dwc2: Enable power down")=0A=
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
>>> ---=0A=
>>>    drivers/usb/dwc2/params.c | 10 +++++++++-=0A=
>>>    1 file changed, 9 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
>>> index 7c1b6938f212..266157ae179a 100644=0A=
>>> --- a/drivers/usb/dwc2/params.c=0A=
>>> +++ b/drivers/usb/dwc2/params.c=0A=
>>> @@ -71,6 +71,13 @@ static void dwc2_set_his_params(struct dwc2_hsotg *h=
sotg)=0A=
>>>    	p->power_down =3D false;=0A=
>>>    }=0A=
>>>    =0A=
>>> +static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)=0A=
>>> +{=0A=
>>> +	struct dwc2_core_params *p =3D &hsotg->params;=0A=
>>> +=0A=
>>> +	p->power_down =3D 0;=0A=
>>> +}=0A=
>>> +=0A=
>>>    static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)=0A=
>>>    {=0A=
>>>    	struct dwc2_core_params *p =3D &hsotg->params;=0A=
>>> @@ -151,7 +158,8 @@ const struct of_device_id dwc2_of_match_table[] =3D=
 {=0A=
>>>    	{ .compatible =3D "lantiq,arx100-usb", .data =3D dwc2_set_ltq_param=
s },=0A=
>>>    	{ .compatible =3D "lantiq,xrx200-usb", .data =3D dwc2_set_ltq_param=
s },=0A=
>>>    	{ .compatible =3D "snps,dwc2" },=0A=
>>> -	{ .compatible =3D "samsung,s3c6400-hsotg" },=0A=
>>> +	{ .compatible =3D "samsung,s3c6400-hsotg",=0A=
>>> +	  .data =3D dwc2_set_s3c6400_params },=0A=
>>>    	{ .compatible =3D "amlogic,meson8-usb",=0A=
>>>    	  .data =3D dwc2_set_amlogic_params },=0A=
>>>    	{ .compatible =3D "amlogic,meson8b-usb",=0A=
>>>=0A=
>> Could you please provide dmesg logs with verbose Debug enabled=0A=
>> configuration and the register dump.=0A=
>> So that we can see what the issue is related to.=0A=
> =0A=
> I'm not sure if this helps much. The problem happens if usb cable is not=
=0A=
> connected on boot. Then, when I connect and disconnect USB cable,=0A=
> strange memory trashes happens. From brief tests, the trashing doesn't=0A=
> happen when debug messages are enabled, so it is related to timings.=0A=
> IMHO the simplest fix for now is to disable powerdown on Samsung SoCs.=0A=
> =0A=
> Here is the initialization related part (booted without usb cable=0A=
> connected):=0A=
> =0A=
> # dmesg | grep dwc=0A=
> [=A0=A0=A0 2.261821] dwc2 12480000.hsotg: Linked as a consumer to regulat=
or.15=0A=
> [=A0=A0=A0 2.266410] dwc2 12480000.hsotg: Linked as a consumer to regulat=
or.12=0A=
> [=A0=A0=A0 2.273996] dwc2 12480000.hsotg: dwc2_check_params: Invalid para=
meter=0A=
> besl=3D1=0A=
> [=A0=A0=A0 2.279405] dwc2 12480000.hsotg: dwc2_check_params: Invalid para=
meter=0A=
> g_np_tx_fifo_size=3D1024=0A=
> [=A0=A0=A0 2.287882] dwc2 12480000.hsotg: NonPeriodic TXFIFO size: 768=0A=
> [=A0=A0=A0 2.287894] dwc2 12480000.hsotg: RXFIFO size: 2048=0A=
> [=A0=A0=A0 2.288003] dwc2 12480000.hsotg: EPs: 16, dedicated fifos, 7808=
=0A=
> entries in SPRAM=0A=
> [=A0=A0=A0 2.296631] dwc2 12480000.hsotg: DCFG=3D0x08200000, DCTL=3D0x000=
00000,=0A=
> DIEPMSK=3D00000000=0A=
> [=A0=A0=A0 2.303044] dwc2 12480000.hsotg: GAHBCFG=3D0x00000000, GHWCFG1=
=3D0x00000000=0A=
> [=A0=A0=A0 2.309437] dwc2 12480000.hsotg: GRXFSIZ=3D0x00001f00, GNPTXFSIZ=
=3D0x03001f00=0A=
> [=A0=A0=A0 2.316258] dwc2 12480000.hsotg: DPTx[1] FSize=3D768, StAddr=3D0=
x00002200=0A=
> [=A0=A0=A0 2.322630] dwc2 12480000.hsotg: DPTx[2] FSize=3D768, StAddr=3D0=
x00002500=0A=
> [=A0=A0=A0 2.329099] dwc2 12480000.hsotg: DPTx[3] FSize=3D768, StAddr=3D0=
x00002800=0A=
> [=A0=A0=A0 2.335521] dwc2 12480000.hsotg: DPTx[4] FSize=3D768, StAddr=3D0=
x00002b00=0A=
> [=A0=A0=A0 2.341900] dwc2 12480000.hsotg: DPTx[5] FSize=3D768, StAddr=3D0=
x00002e00=0A=
> [=A0=A0=A0 2.348366] dwc2 12480000.hsotg: DPTx[6] FSize=3D768, StAddr=3D0=
x00003100=0A=
> [=A0=A0=A0 2.354802] dwc2 12480000.hsotg: DPTx[7] FSize=3D768, StAddr=3D0=
x00003400=0A=
> [=A0=A0=A0 2.361169] dwc2 12480000.hsotg: DPTx[8] FSize=3D768, StAddr=3D0=
x00003700=0A=
> [=A0=A0=A0 2.367637] dwc2 12480000.hsotg: DPTx[9] FSize=3D768, StAddr=3D0=
x00003a00=0A=
> [=A0=A0=A0 2.374059] dwc2 12480000.hsotg: DPTx[10] FSize=3D768, StAddr=3D=
0x00003d00=0A=
> [=A0=A0=A0 2.380526] dwc2 12480000.hsotg: DPTx[11] FSize=3D768, StAddr=3D=
0x00004000=0A=
> [=A0=A0=A0 2.387079] dwc2 12480000.hsotg: DPTx[12] FSize=3D768, StAddr=3D=
0x00004300=0A=
> [=A0=A0=A0 2.393589] dwc2 12480000.hsotg: DPTx[13] FSize=3D768, StAddr=3D=
0x00004600=0A=
> [=A0=A0=A0 2.400055] dwc2 12480000.hsotg: DPTx[14] FSize=3D768, StAddr=3D=
0x00004900=0A=
> [=A0=A0=A0 2.406611] dwc2 12480000.hsotg: DPTx[15] FSize=3D768, StAddr=3D=
0x00004c00=0A=
> [=A0=A0=A0 2.413120] dwc2 12480000.hsotg: ep0-in: EPCTL=3D0x00008800,=0A=
> SIZ=3D0x00000000, DMA=3D0x0562c0d2=0A=
> [=A0=A0=A0 2.421236] dwc2 12480000.hsotg: ep0-out: EPCTL=3D0x00008000,=0A=
> SIZ=3D0x00000000, DMA=3D0xba24bb0f=0A=
> [=A0=A0=A0 2.429526] dwc2 12480000.hsotg: ep1-in: EPCTL=3D0x00001000,=0A=
> SIZ=3D0x00000000, DMA=3D0xe1e5d4d6=0A=
> [=A0=A0=A0 2.437684] dwc2 12480000.hsotg: ep1-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x866fd8ec=0A=
> [=A0=A0=A0 2.445930] dwc2 12480000.hsotg: ep2-in: EPCTL=3D0x00001800,=0A=
> SIZ=3D0x00000000, DMA=3D0xf04672ba=0A=
> [=A0=A0=A0 2.454091] dwc2 12480000.hsotg: ep2-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x254f4cad=0A=
> [=A0=A0=A0 2.462292] dwc2 12480000.hsotg: ep3-in: EPCTL=3D0x00002000,=0A=
> SIZ=3D0x00000000, DMA=3D0x0031e893=0A=
> [=A0=A0=A0 2.470494] dwc2 12480000.hsotg: ep3-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0xa1fadc63=0A=
> [=A0=A0=A0 2.478740] dwc2 12480000.hsotg: ep4-in: EPCTL=3D0x00002800,=0A=
> SIZ=3D0x00000000, DMA=3D0x070100d6=0A=
> [=A0=A0=A0 2.486899] dwc2 12480000.hsotg: ep4-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x5b73f99f=0A=
> [=A0=A0=A0 2.495147] dwc2 12480000.hsotg: ep5-in: EPCTL=3D0x00003000,=0A=
> SIZ=3D0x00000000, DMA=3D0x22862241=0A=
> [=A0=A0=A0 2.503306] dwc2 12480000.hsotg: ep5-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x3e6dd3d7=0A=
> [=A0=A0=A0 2.511508] dwc2 12480000.hsotg: ep6-in: EPCTL=3D0x00003800,=0A=
> SIZ=3D0x00000000, DMA=3D0x49d40c13=0A=
> [=A0=A0=A0 2.519711] dwc2 12480000.hsotg: ep6-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x75ef350a=0A=
> [=A0=A0=A0 2.527956] dwc2 12480000.hsotg: ep7-in: EPCTL=3D0x00004000,=0A=
> SIZ=3D0x00000000, DMA=3D0xea58422e=0A=
> [=A0=A0=A0 2.536115] dwc2 12480000.hsotg: ep7-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0xf3ddcb57=0A=
> [=A0=A0=A0 2.544362] dwc2 12480000.hsotg: ep8-in: EPCTL=3D0x00004800,=0A=
> SIZ=3D0x00000000, DMA=3D0xc643412d=0A=
> [=A0=A0=A0 2.552477] dwc2 12480000.hsotg: ep8-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x4ff685bc=0A=
> [=A0=A0=A0 2.560768] dwc2 12480000.hsotg: ep9-in: EPCTL=3D0x00005000,=0A=
> SIZ=3D0x00000000, DMA=3D0xbf80c044=0A=
> [=A0=A0=A0 2.568926] dwc2 12480000.hsotg: ep9-out: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x7a4d7ff5=0A=
> [=A0=A0=A0 2.577171] dwc2 12480000.hsotg: ep10-in: EPCTL=3D0x00005800,=0A=
> SIZ=3D0x00000000, DMA=3D0x095249a9=0A=
> [=A0=A0=A0 2.585418] dwc2 12480000.hsotg: ep10-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0x53d9dd5c=0A=
> [=A0=A0=A0 2.593751] dwc2 12480000.hsotg: ep11-in: EPCTL=3D0x00006000,=0A=
> SIZ=3D0x00000000, DMA=3D0xb6367224=0A=
> [=A0=A0=A0 2.601954] dwc2 12480000.hsotg: ep11-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0x78fc77d9=0A=
> [=A0=A0=A0 2.610331] dwc2 12480000.hsotg: ep12-in: EPCTL=3D0x00006800,=0A=
> SIZ=3D0x00000000, DMA=3D0x703a61f7=0A=
> [=A0=A0=A0 2.618588] dwc2 12480000.hsotg: ep12-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0x4b6fdce6=0A=
> [=A0=A0=A0 2.626909] dwc2 12480000.hsotg: ep13-in: EPCTL=3D0x00007000,=0A=
> SIZ=3D0x00000000, DMA=3D0x9028b9a8=0A=
> [=A0=A0=A0 2.635155] dwc2 12480000.hsotg: ep13-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0x9ce3fc49=0A=
> [=A0=A0=A0 2.643487] dwc2 12480000.hsotg: ep14-in: EPCTL=3D0x00000000,=0A=
> SIZ=3D0x00000000, DMA=3D0x142fa3a6=0A=
> [=A0=A0=A0 2.651690] dwc2 12480000.hsotg: ep14-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0x992fdfec=0A=
> [=A0=A0=A0 2.660067] dwc2 12480000.hsotg: ep15-in: EPCTL=3D0x00000800,=0A=
> SIZ=3D0x00000000, DMA=3D0x455906b0=0A=
> [=A0=A0=A0 2.668312] dwc2 12480000.hsotg: ep15-out: EPCTL=3D0x00000000,=
=0A=
> SIZ=3D0x00000000, DMA=3D0xd74dacd5=0A=
> [=A0=A0=A0 2.676643] dwc2 12480000.hsotg: DVBUSDIS=3D0x000017d7, DVBUSPUL=
SE=3D000005b8=0A=
> [=A0=A0=A0 2.868931] dwc2 12480000.hsotg: bound driver g_ether=0A=
> [=A0=A0=A0 2.873603] dwc2 12480000.hsotg: dwc2_hsotg_pullup: is_on: 1 op_=
state: 3=0A=
> [=A0=A0=A0 2.873649] dwc2 12480000.hsotg: FIFOs reset, timeout at 100=0A=
> [=A0=A0=A0 2.873685] dwc2 12480000.hsotg: EP0: DIEPCTL0=3D0x00008000,=0A=
> DOEPCTL0=3D0x00008000=0A=
> [=A0=A0=A0 2.873696] dwc2 12480000.hsotg: gsintmsk now 0xd88c3cc4=0A=
> [=A0=A0=A0 2.873719] dwc2 12480000.hsotg: DCTL=3D0x00000002=0A=
> [=A0=A0=A0 2.873731] dwc2 12480000.hsotg: GLPMCFG=3D0x00001483=0A=
> [=A0=A0=A0 2.876743] dwc2 12480000.hsotg: dwc2_hsotg_enqueue_setup: queue=
ing=0A=
> setup request=0A=
> [=A0=A0=A0 2.876756] dwc2 12480000.hsotg: ep0: req (ptrval): 8@(ptrval),=
=0A=
> noi=3D0, zero=3D0, snok=3D0=0A=
> [=A0=A0=A0 2.876773] dwc2 12480000.hsotg: dwc2_hsotg_start_req:=0A=
> DxEPCTL=3D0x80008000, ep 0, dir out=0A=
> [=A0=A0=A0 2.876783] dwc2 12480000.hsotg: ureq->length:8 ureq->actual:0=
=0A=
> [=A0=A0=A0 2.876795] dwc2 12480000.hsotg: dwc2_hsotg_start_req: 1@8/8,=0A=
> 0x00080008 =3D> 0x00000b10=0A=
> [=A0=A0=A0 2.876807] dwc2 12480000.hsotg: dwc2_hsotg_start_req: b7043000 =
pad=0A=
> =3D> 0x00000b14=0A=
> [=A0=A0=A0 2.876816] dwc2 12480000.hsotg: ep0 state:0=0A=
> [=A0=A0=A0 2.876825] dwc2 12480000.hsotg: dwc2_hsotg_start_req: DxEPCTL=
=3D0x80008000=0A=
> [=A0=A0=A0 2.876836] dwc2 12480000.hsotg: dwc2_hsotg_start_req: DXEPCTL=
=3D0x80008000=0A=
> [=A0=A0=A0 2.876847] dwc2 12480000.hsotg: EP0: DIEPCTL0=3D0x00008000,=0A=
> DOEPCTL0=3D0x80008000=0A=
> [=A0=A0=A0 2.877402] dwc2 12480000.hsotg: dwc2_hsotg_irq: 04001020 000010=
00=0A=
> (d88c3cc4) retry 8=0A=
> [=A0=A0=A0 2.877420] dwc2 12480000.hsotg: dwc2_hsotg_irq: USBRst=0A=
> [=A0=A0=A0 2.877430] dwc2 12480000.hsotg: GNPTXSTS=3D00080300=0A=
> =0A=
> Best regards=0A=
> =0A=
=0A=
I need info about which power saving mode your core supports =0A=
(hibernation, partial power down or extended hibernation )=0A=
=0A=
For that could you please provide me the regdump.=0A=
=0A=
BTW we would like to buy the board on which you are having issues and =0A=
perform testes.=0A=
Could you please provide a link in a market, so that we can buy the =0A=
exact board.=0A=
=0A=
=0A=
Regards,=0A=
Artur=0A=
