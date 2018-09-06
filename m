Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C23C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090222075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iY9fpRPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090222075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeIFQ70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:59:26 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:39612
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIFQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfLEI5UDE7QmC7e0xlBtfHlfPpqrJI8QIGBoNzg+MOw=;
 b=iY9fpRPekOkvUkE/P1TvGE7VGKD2nWTnaIVYyJ/GxiYEyfCmIF4m8qOfS9m/IGQJU8XqKSs3OY9juqQGN1o+Iu8Ziz019WAC70LodypzdTuxyZiwDvREFNE4Czked402b73cOds4dpWxgiQxXxI1p+9a/XHuITyhsBlcaFBs2Qo=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1053.eurprd04.prod.outlook.com (10.161.109.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 12:23:17 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::35a6:f753:27fb:b6e5%6]) with mapi id 15.20.1101.019; Thu, 6 Sep 2018
 12:23:17 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI controller
Thread-Topic: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
 controller
Thread-Index: AQHUQRXg7xCIqf0FokqnnQfU8ng4SqTgPV4AgAExaGCAAYWLgIAALnEQgAAI2wCAAAVtgA==
Date:   Thu, 6 Sep 2018 12:23:17 +0000
Message-ID: <VI1PR04MB103829FBFC128073B370B56399010@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1535711404-29528-4-git-send-email-yogeshnarayan.gaur@nxp.com>
        <20180904165842.774ed960@bbrezillon>
        <VI1PR04MB1038CE65EF4E98ACBEA9990B99020@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <add79e8b-1ab7-e465-5f65-eed6b78161e1@exceet.de>
        <VI1PR04MB1038AB7497A2FD3E73FBA6D699010@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20180906134356.10e740fa@bbrezillon>
In-Reply-To: <20180906134356.10e740fa@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1053;6:ToP8zoR5wdxKhyveWH8bG+6GtkynFBI0i2UmjyMUj4YUAsixw/z+uMyze3eZz+Ca2APIs6uMt+FQrkVLWJuyYwMmsejP8OtS6SmrrUKpIUKojsSWz4bdJFSOIdwzGPL6Z1ix64s31EIaVL9AgIdN9VdVoiNlgsvrnpFlXYn7IH+vNAauOJxppkWqpDKXIxUgIr/g7XK2vbilR9CTYqOktqKf4rmN4J+RANUza/O59a9QjZ8YwJjjuN/VlCcrEZtrbIw/ToAXQfFmJniAuq+SeHGksuX3xARn3QOu1gRju2BpeNFN6T6w8Vgp2VPYOpx2B3JTzBGXmDQYXpJgnjretMvsbyJbysTT2HEKfzi9To0DiaOW7B0XbYk3cR+st69HR9Q4K0v62IX2mDCduYuwbbJux2JdpMq9axzJVZq1eL6TPE5/SJGaTsnNQCTUKuVWBaAJtsQ8GW21Oy/24JgdEg==;5:LzByhit0cZjjzjZUIBAXXY2GOGfPZ9RBk0QMgXDkH1fuqcSUram2PEmcHZUdhxaStS7OH1J3Zi0LiP93h2tuid4T4GP3ZgG566chxz4szy1ZE2HgDm5DHUWCjGNMb84W2i6DbmJ9o9vp3JZoCVfjnOHbMgXTq0f8vinuOcqfcbQ=;7:+j/viOuvQYkRjApWSQhbK84UCpuXH0FT5ExV6RrQf82O409yXgryR/N4aQWJ2AGb/SMu42aHB8n9MShytpNxMgUhopJi32pBhxhdVO71kuD8K5raJivqBrkG1VSk0opL1659jco5K0kLqxBmpPD5E8m9gtJ+JkqvvO6of3n4fW0eNrtwhmSa/bXZPrCc+g9r2HaDr6LB62yjx9AwV2PZ1qleEvZc+l3ehAJyWRb6A59rVwBGpOfb5kbqTovLAD6z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3a3b8b8a-6b91-4f17-b57d-08d613f3869c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1053;
x-ms-traffictypediagnostic: VI1PR04MB1053:
x-microsoft-antispam-prvs: <VI1PR04MB105384CD1CFBF690FEE4BAB999010@VI1PR04MB1053.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR04MB1053;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1053;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(136003)(376002)(13464003)(199004)(189003)(81156014)(486006)(7736002)(33656002)(99286004)(446003)(105586002)(11346002)(6506007)(476003)(53546011)(55236004)(186003)(93886005)(305945005)(102836004)(26005)(39060400002)(7416002)(5250100002)(66066001)(54906003)(97736004)(2900100001)(81166006)(5024004)(14454004)(5660300001)(25786009)(229853002)(8936002)(8676002)(2906002)(478600001)(316002)(76176011)(6436002)(53936002)(6916009)(68736007)(74316002)(9686003)(4326008)(7696005)(86362001)(55016002)(256004)(14444005)(3846002)(106356001)(6246003)(6116002)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1053;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xeiO6OuYWGfp8jIspkkN2XbtODjOwRJ8UvYyRlQDPzhO67WMkaivcNaj2maihptau7w80X7hMcTOowg+3TWw0VsO4usKHS/vEoJ5u5PslwIUeCtQWD5gsggtWNti03z/wsysY0VW09ykLMCaqKz8HWaztY3mAhPxYVbUJ+uqMoJsq4ifT/2jI56uPPYN4DSsC+/Cy+Q1eUYdT41wwzNAiOMdRC43rLzHFUFyoAyNetWBDJQ9ZAHmRjDcYiYhqR2QC8dh15IK2rwoj1pDcPNw1Q6NPhIKcUZhSiCm5IrcXAz1PrJQuB7xbzbpm2ICZDBK+58OIMIvVQ2yv7taUUIfXHX4jd5w7yRos5QVsU3Nlik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3b8b8a-6b91-4f17-b57d-08d613f3869c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 12:23:17.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, September 6, 2018 5:14 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Frieder Schrempf <frieder.schrempf@exceet.de>; linux-
> mtd@lists.infradead.org; marek.vasut@gmail.com; linux-spi@vger.kernel.org=
;
> devicetree@vger.kernel.org; robh@kernel.org; mark.rutland@arm.com;
> shawnguo@kernel.org; linux-arm-kernel@lists.infradead.org;
> computersforpeace@gmail.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI contr=
oller
>=20
> On Thu, 6 Sep 2018 11:35:13 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi Frieder,
> >
> > > -----Original Message-----
> > > From: Frieder Schrempf [mailto:frieder.schrempf@exceet.de]
> > > Sent: Thursday, September 6, 2018 1:56 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Boris
> > > Brezillon <boris.brezillon@bootlin.com>
> > > Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; linux-
> > > spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> > > mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> > > kernel@lists.infradead.org; computersforpeace@gmail.com; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH 3/7] spi: spi-mem: Add a driver for NXP FlexSPI
> > > controller
> > > >> Hi Yogesh,
> > > >>
> > > >> On Fri, 31 Aug 2018 16:00:00 +0530 Yogesh Gaur
> > > >> <yogeshnarayan.gaur@nxp.com> wrote:
> > > >>
> > > >>> - Add a driver for NXP FlexSPI host controller
> > > >>>
> > > >>
> > > >> Yep, I had a quick look at the code and they really look similar.
> > > >> Why not extending the existing driver instead of creating a new
> > > >> one from scratch?
> > > >
> > > > FlexSPI is different controller not related to the QuadSPI
> > > > controller in its working behavior Both these controller are
> > > > having
> > > > * Different registers name, registers address, registers
> > > > functionality etc, section 30.5.2[1]
> > > > * Different programming sequence for initialization of the
> > > > controller, section 30.8.1[1]
> > > > * Different programming sequence for performing Read and Write
> > > > operation using IP, section 30.7.9[1] and AHB mode
> > > > * Different programming sequence for checking controller current
> > > > state like busy or not
> > > > * New mechanism to program for the connected slave device i.e.
> > > > flash access mode and flash memory map 30.7.4[1] and 30.7.5[1]
> > > > * New entries added for FlexSPI controller for LUT_XX mode for
> > > > various commands, section 30.7.8[1]
> > > >
> > > > There are few similarities between these two like LUT programming
> > > > logic is same i.e. LUT needs to be programmed in same sequence of
> > > > 'INSTR
> > > PAD  OPCODE', but again LUT register address and LUT command mode
> > > values are different.
> > > >
> > > > Creating common driver for both FlexSPI and QuadSPI controller,
> > > > would
> > > involve creation of one more layer between driver/spi/spi-xxx and
> > > the actual controller driver, this layer would going to have less
> > > functionality like doing LUT creation programming and then would
> > > re-direct calls to the respective controller driver functionality to
> > > perform desired programming sequence.
> > > >
> > > >>>
> > > >>> (1) The FlexSPI controller is driven by the LUT(Look-up Table)
> > > >>> registers.
> > > >>>   The LUT registers are a look-up-table for sequences of
> > > >>> instructions. A valid sequence consists of four LUT registers.
> > > >>>   Maximum 32 LUT sequences can be programmed simultaneously.
> > > >>>
> > > >>
> > > >> Do we really want to have this level of details in the commit
> > > >> message? I mean, this is something you can document in the
> > > >> driver, but not here.
> > > >>
> > > >> BTW, you might want to have a look at [1]. I think we can get rid
> > > >> of the ->size field you're adding if this driver implements the
> > > >> dirmap hooks.
> > > >
> > > > I need size information for the connected device to program the
> > > > controller
> > > register FLSHXXCRO as Flash Chip select is determined by flash
> > > access address and Flash size setting in register FLSHXXCR0[FLSHz],
> > > section 30.7.9[1].
> > >
> > > It's the same situation we had with the QSPI driver before. We
> > > decided to **not** pass information about flash size directly to the
> > > controller for now. That's why we currently don't support mapping
> > > the flash device in the implementation of the QSPI driver.
> > >
> > > I think we should not start this discussion all over again for the
> > > FlexSPI driver, but stick to what we decided for QSPI.
> > >
> >
> > There is difference between FlexSPI and QuadSPI controller
> > functionality in detecting the current CS.
> >
> > As per table-10.32[1] for QuadSPI controller, access to flash is being
> > assigned as per the address values provided i.e. it would be
> > CS0 if address is between TOP_ADDR_MEMXX and QSPI_AMBA_BASE and CS1
> if
> > access is in between TOP_ADDR_MEMA2 and TOP_ADDR_MEMA1.
> >
> > But for case of FlexSPI controller, section 30.7.5[2],  CS is being
> > defined as per the address value lies in below range
> > - Flash A1 address range: 0x00000000 ~ FA1_SIZE
> > - Flash A2 address range: FA1_SIZE ~ (FA1_SIZE + FA2_SIZE)
> > - Flash B1 address range: (FA1_SIZE + FA2_SIZE) ~ (FA1_SIZE + FA2_SIZE
> > + FB1_SIZE)
> > - Flash B2 address range: FA1_SIZE + FA2_SIZE + FB1_SIZE) ~ (FA1_SIZE
> > + FA2_SIZE + FB1_SIZE + FB2_SIZE) and FAx_SIZE is determined from
> > register FLSHxxCR0[FLASHSZ]
> >
> > Thus, for QuadSPI controller we can actually go away with the flash
> > size requirement and with the code logic which you have introduced, of
> > using 2 * ahb_buf_size data size for TOP_ADDR_MEMXX bits in SFxxD
> > register, things are working fine.
> >
> > But for FlexSPI controller its required to have the connected slave
> > device size to detect the current CS.
>=20
> I don't see why. You should be able to take an arbitrary (big enough) siz=
e at first,
> and only extend it on-the-fly when a dirmap request is done.
>=20
> > I have tried the quadspi driver
> > logic in flexspi driver code, but it gives me failure.
>=20
> Can you detail a bit what's failing?
>=20
> > Due, to this
> > reason and requirement I have come-up with this solution of getting
> > the connected device size and programming correct value in
> > FLSHxxCR0[FLASHSZ] register
>=20
> Alternatively, what we could do is split the memory map in 4 regions of t=
he same
> size and stick to it. That works if you can define an offset to apply to =
the address
> when an access is done through the direct mapping area.

Ok. I would try this and share the result and the failure point, if any.

Meanwhile, can you please review the rest of the driver except _select_mem(=
) functionality and provide your feedback.

Also, as question asked for AHB RX buffer flush when using both IP and AHB =
mode in quadspi driver.
Same logic has been used in the FlexSPI driver as it's required to flush th=
e AHB RX buffer after using IP mode write operation.
But, in FlexSPI, SWRESET register bit is w1c i.e. it automatically get rese=
t to zero, after setting to 1, after 64 clock cycle. Thus, no explicitly ud=
elay() needs to be added when doing AHB RX buffer invalidation.

Thanks
Yogesh Gaur.

>=20
> >
> > > >
> > > > Link for reference of the driver implementing dirmap hooks was
> > > > missing in mail,
> > > please share.
> > >
> > > I guess Boris meant to link to his PoC implementation of the direct
> > > mapping API [1]. When this is available we can easily add support
> > > for direct memory mappings to the QuadSPI and FlexSPI drivers.
> > >
> >
> > I have checked the link, found that size value is being derived from
> > spi_nor.mtd.size variable. Same being performed in this patch series
> > to detect the size of the slave device.
>=20
> Well, yes, the result is the same, except it does not require adding a ne=
w field to
> spi_mem and ->attach/detach() hooks to the spi_mem_ops interface (which
> your implementation is lacking BTW).
>=20
> > As per my understanding
> > developed with Boris's code implementation, when direct mapping API
> > interface are available then both QuadSPI and FlexSPI driver needs to
> > be changed as per new introduced ops structure.
>=20
> It's not a hard requirement, but they would definitely benefit from this =
extension
> (mainly a perf improvement).
