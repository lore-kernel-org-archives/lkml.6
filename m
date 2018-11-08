Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7FAC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC952086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="QP49yELk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC952086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeKHU7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:59:04 -0500
Received: from mail-os2jpn01on0136.outbound.protection.outlook.com ([104.47.92.136]:39975
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbeKHU7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNy0DKcatxsUN0tgU1aGveozwF2NednRbDemoK9cmDw=;
 b=QP49yELkN/P+5FjaQ6wwf9zANqmVLB9bMCFETmOhw5amIYlwqaHzbIdoG32P6KHYGOIS6Ptf8dLZvRglVeFrgs6qcIIwHeeELS4WHCPrJqIqTJpWlqAijYOISfLFj+B/95UKcr5RTfNKOF6lC06mGSQEhRO1WznXXx40JvxDckE=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1104.jpnprd01.prod.outlook.com (10.174.225.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 11:23:58 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::708f:601d:1cf4:6095%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:23:58 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Thread-Topic: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
Thread-Index: AQHUNjcFVnH3t67d7UOm/r2/5E0IhKVGPoRA
Date:   Thu, 8 Nov 2018 11:23:58 +0000
Message-ID: <TY1PR01MB177011B91A9CA579E01760A4C0C50@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534516265-10059-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1534516265-10059-3-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1104;20:A723dBLqYXeWZl53LVb8tuLwa0G8RunL3noIQnIsNYTB861BNfwEhe7ZiBBDlIYHiFZ3gQzh1gC1vnjlMIRNUc2IPC+vtXywwIwKRU9cRNPEPQuBXucU1hY10FEjUP9FRLPShXVBkmET1r+CikfJgJ+HFE0qSnj0NQK++PWzHWs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 17769207-7545-4527-7d02-08d6456cad32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1104;
x-ms-traffictypediagnostic: TY1PR01MB1104:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-microsoft-antispam-prvs: <TY1PR01MB1104A355644930F2C90EBE4AC0C50@TY1PR01MB1104.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1104;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1104;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(68736007)(3846002)(7736002)(81156014)(81166006)(8676002)(6116002)(5660300001)(305945005)(6246003)(256004)(55016002)(9686003)(6436002)(26005)(71190400001)(71200400001)(6506007)(53546011)(102836004)(76176011)(99286004)(7696005)(53936002)(110136005)(316002)(229853002)(86362001)(54906003)(74316002)(2906002)(476003)(8936002)(97736004)(11346002)(446003)(186003)(66066001)(2900100001)(486006)(33656002)(105586002)(14454004)(478600001)(413944005)(44832011)(106356001)(25786009)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1104;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q58R5CX/Gi2hm7HZKEJ2ZWxUeg5mki/eeVvm31UH3clnNmcX2Vr5PDnSY/Q3uzOEmularLbj3/wlX2+qtzJXPa/ZRUSI2KDTkMsAGjvKdmh1BILMkGpx7nKwN91HouVUT4fB9io8iaWX2cHqerysnCx4hWb8YEUVhtwjaePehEtSXfhW5KkxC0IQAwOXL5b8pbh9M8YjQYUkh1aCBx07yorxQviRaO7/ssEdmSxZyaPMKM4htQtXnDrlbzYA6xR4+xJcfOHXoLNXB0rV2vChojrG/fqDWRZVpQeSFcqA3rf8hKfEn5oz5DlE8xn6IeR7vLs5nQgJiN6SAfPm2kx1pdeQKooXPItz6mz3BwqocgM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17769207-7545-4527-7d02-08d6456cad32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:23:58.2344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

Who is the best person to take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 17 August 2018 15:31
> Subject: [PATCH 2/2] dt-bindings: iommu: ipmmu-vmsa: Add r8a774a1 support
>
> Document RZ/G2M (R8A774A1) SoC bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180817
>
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.t=
xt
> b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> index ffadb7c..68446dd 100644
> --- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> +++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
> @@ -13,6 +13,7 @@ Required Properties:
>      - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
>      - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
>      - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
> +    - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
>      - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
>      - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
>      - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
> --
> 2.7.4




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
