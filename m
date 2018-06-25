Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FACCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E82565D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="43uW+UHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3E82565D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbeFYJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:06:56 -0400
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:30903
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754537AbeFYJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YGa86YOjo5lozWQxy7d+TpyLK9QctKzEiQWwuySBHo=;
 b=43uW+UHtpphI/B5w9PdAhohHZQ8PlqKHAr0aU9tNsTdP585u/fcdO8PDEv9x1rp1UUZ2To5g8M8gPYA1qjJ4iSRLJ6hzIEkZqrHrA9sDkzVFpWKSnu1VyWVqTrRy+YXdG4ps/PAxtGioUwfkoXuiXQHFYIvcvKPfqzTlYaQ0xaU=
Received: from SN1PR02MB1693.namprd02.prod.outlook.com (10.162.129.23) by
 SN1PR02MB1693.namprd02.prod.outlook.com (10.162.129.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Mon, 25 Jun 2018 09:06:50 +0000
Received: from SN1PR02MB1693.namprd02.prod.outlook.com
 ([fe80::40cd:bd4b:87bf:d382]) by SN1PR02MB1693.namprd02.prod.outlook.com
 ([fe80::40cd:bd4b:87bf:d382%2]) with mapi id 15.20.0884.024; Mon, 25 Jun 2018
 09:06:50 +0000
From:   Appana Durga Kedareswara Rao <appanad@xilinx.com>
To:     Radhey Shyam Pandey <radheys@xilinx.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical
 flip property
Thread-Topic: [PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add VDMA
 vertical flip property
Thread-Index: AQHUAukYEcog/BpNL02AwmXvADRV96Rwwa2w
Date:   Mon, 25 Jun 2018 09:06:49 +0000
Message-ID: <SN1PR02MB169323BF21815A019D0C486BDC4A0@SN1PR02MB1693.namprd02.prod.outlook.com>
References: <1528875288-9140-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
In-Reply-To: <1528875288-9140-2-git-send-email-radhey.shyam.pandey@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=appanad@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR02MB1693;7:P7tfXK7D/YqFApp8MzR9VYAZN1qXIdLAaSFVAZQUFauCdqxHPBzH0M4dzQMdRWWl1zeFNTsksq2smRQW2TC8xj4E9sPmosgENMafubv9WL8jLhNEjnyshEkKAkU6cxyNsJa5dIRjuHu8rrSPX3LQdltqxmQ57GNme2+S8xOas7l/wHvsQzUJQLSTwRYKMy3pcYlOASkGElyA7agJ8HsAkXTYV4IzVv5nGy71OiE4qSdP9A8E5ANS0pnqxo4Ts75v
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 748c22de-fd70-4e9f-2889-08d5da7afca0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR02MB1693;
x-ms-traffictypediagnostic: SN1PR02MB1693:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN1PR02MB1693DC4A93035F421F5417C8DC4A0@SN1PR02MB1693.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1693;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1693;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(6506007)(59450400001)(97736004)(102836004)(76176011)(7736002)(9686003)(66066001)(305945005)(7696005)(5660300001)(8676002)(81156014)(68736007)(8936002)(81166006)(478600001)(3660700001)(3280700002)(74316002)(33656002)(14454004)(2906002)(110136005)(316002)(54906003)(105586002)(53936002)(2900100001)(3846002)(99286004)(106356001)(6116002)(2501003)(2201001)(446003)(107886003)(476003)(11346002)(4326008)(486006)(5250100002)(6436002)(86362001)(55016002)(25786009)(26005)(6246003)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1693;H:SN1PR02MB1693.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ad9QM5jJHhAE440Byoei1tY7OPw3OvPsHIi06xQeFJnWqzpQZerRLLGCa7OgjTqruCGRmLkRz0TgfpZLiN7ZYL4Gw88SrSVd4No4s7YJMLDb5z6uObOOa4UghgXJozRhFwqVj/HSEiWXNjEd9lN15PUfUtXVJySf9LK9lp4kcoi1cXs5BnpizmqyDyJcD2LqBTIW/FEEz23E7DtIsx84zI+b97u1OQEYHdsbkE25aR5gBAKMTBgAlfw6pnkD12ecVV3xKa6ROrpfGKRNc9I5J2jY33JacW9R5zp29GMaz2FnqtawF3zCsB5i7gLl7DEHxVl8NfcfkGQLu4c586NSWJY7m8JOvcspOhMGE/uxWyo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748c22de-fd70-4e9f-2889-08d5da7afca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 09:06:49.9512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1693
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Snip>=20
>=20
> The AXI VDMA core supports Vertical flip in S2MM path when Enable Vertica=
l
> Flip (Advanced tab) is selected. To allow vertical flip programming defin=
e an
> optional 'xlnx,enable-vert-flip' channel child node property.
>=20
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Kedareswara rao Appana <appanad@xilinx.com>  =20

Regards,
Kedar.

> ---
>  .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> index a2b8bfa..174af2c 100644
> --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
> @@ -66,6 +66,8 @@ Optional child node properties:
>  Optional child node properties for VDMA:
>  - xlnx,genlock-mode: Tells Genlock synchronization is
>  	enabled/disabled in hardware.
> +- xlnx,enable-vert-flip: Tells vertical flip is
> +	enabled/disabled in hardware(S2MM path).
>  Optional child node properties for AXI DMA:
>  -dma-channels: Number of dma channels in child node.
>=20
> --
> 1.7.1

