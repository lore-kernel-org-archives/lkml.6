Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5F420661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 02:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dPPf3NwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5F420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeH3Gr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 02:47:29 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:14607
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbeH3Gr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 02:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYML1UsO5UBb38CF+yDDAWEvMcqo166H6jEEmC8s4Oc=;
 b=dPPf3NwCWmAtYCbRmmRn73Fs4eZsmdGqI8aju3TNEqYQuTghwjwQ3e/gO7M0ScMK6HJePtQbEj65ZRSNxh3RNM2RM5HP4w4qPQdYTLAE4sKSFgOczOVfe7m2msBwUY28hM++s2rBtZVwKUzY9uAvtNXH7v6Ad0e352339GY40tk=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB1230.eurprd04.prod.outlook.com (10.162.121.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Thu, 30 Aug 2018 02:47:31 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::c529:ccae:df5:7515]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::c529:ccae:df5:7515%2]) with mapi id 15.20.1101.007; Thu, 30 Aug 2018
 02:47:31 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Thread-Topic: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
Thread-Index: AQHUP9N/HX+zHHR6w0a20w6D3Q62YqTXl5iw
Date:   Thu, 30 Aug 2018 02:47:31 +0000
Message-ID: <VI1PR04MB32475E7E36BA8467FC07B01D91080@VI1PR04MB3247.eurprd04.prod.outlook.com>
References: <20180829200425.16435-1-robh@kernel.org>
In-Reply-To: <20180829200425.16435-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1230;6:trHGQrCbdQtbmzhOPLujULY7lvXoyI0N4jOD4RFbQe1FWW2xOOp1UrC94nZ+hbMWGVRRS6zDAOqV950G1ihcXdgDPdkLcs05FWCGF3EPekczbDUcGO+e1A9Jebfl/3Sy++qsYbFPSTmGbQl1974X/pfCrOuErwQauSskMMfvIkVgV+Pt5ZZm8OffqlzBlZrA1o00OxRRLMaJUu5IB1sJ3cqRJK19gNJQNVvGb7baHSuVrgJM9InvLq5ZvlIWr/RVSbmVBCz/o8LrUifnMa1vqLkf0/RqUftVRbfyedRubgGZyQlft0uigbtEbIDH39O9VE/ztIg7qHL/zu9PA/jGtxBxDAb7aOjokOtdXgkw4sG/5fSODl8X9EoBZmMfljNbeQxYJL9VV4ScT37AMk/4KtBDCkQrMEJ3L5TwDQ7UI4GmhDBcfUFAIWmdgEBfMqVOtMZtMugtgIWuWADJdiplAw==;5:4N+6dJdFWgMH49VIZAJE0gLFpPkdY74BqOw6Rwc2UPs9uuyHijCmYU7xvW8V8WdscsPstLrBlIp0YawI7EqTUdmQJLQCY6OsTQJihu/RDPpbJDBUoX/by+YLFXmsdrBm6LU7OdWEt0+o6fd5/R61AP2um7DikEwjt+umKbKLx68=;7:vDGJs9v+n2PRC4lKA+a55fCY4taxHKUQDmv7+k1XV2AH8S8CUCsOW0lY5cf2mWfEtm3eIj286+amAOqTX+u4nI1KRRUiK2N4o/BkjvWx34xa3Huu3rMiyCAyFG7XWZSq3T8OLV1TPEf/SscCqc5PlMIBgqGs6nSgU84THdjd9jCagoLJylYJeRNm7fbstfdWvhBy09BHk2McY+dbGVaQRFgiXJoPke07scR5TowWf1xPbkdROgVwfIuOlk0WjHjr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 51ad0338-8666-4dff-6681-08d60e22eeca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1230;
x-ms-traffictypediagnostic: VI1PR04MB1230:
x-microsoft-antispam-prvs: <VI1PR04MB12300143AE3E270B52AE26A691080@VI1PR04MB1230.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR04MB1230;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1230;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(376002)(346002)(136003)(396003)(189003)(199004)(81156014)(8676002)(81166006)(5660300001)(316002)(54906003)(76176011)(97736004)(7696005)(74316002)(99286004)(6916009)(7736002)(305945005)(106356001)(25786009)(478600001)(105586002)(33656002)(5250100002)(4326008)(6246003)(2900100001)(14454004)(68736007)(8936002)(229853002)(66066001)(53936002)(6506007)(102836004)(86362001)(2906002)(44832011)(186003)(26005)(446003)(9686003)(486006)(11346002)(476003)(6436002)(256004)(3846002)(6116002)(55016002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1230;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u3dW0WKOveqY7qfdiE6UTyrHWGXdvr7kLa3Ni7Fk58Gh20QjFXy3+4TKQWiU30FPCe+ypjvUT8u8x4XA0ngJHzjRyrUTuHmyXAFx0Bi+azdh0e/C7wj7jfnfNiXbkJPjGmY3ILzAMfUwf34HdmOrVFe2YbM2N76yaCr7p+fGentoJ0jDvZM3xZPSN7QXiCMhdKuBu+5qEc+u2b4j+HVbyBCokSGqZRndwdZmTsaX2z78KZXxxvLzoIEAsHFWXWS+QXjOKspV6/5xq+EAHGIcMjieLisQrZ392kZ4boXeuomE/fXC7enaqIHQxikvecUVwN1O2UaodXtQQDq9U3ybq4yHKbraw/uIt4QKb2URWU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ad0338-8666-4dff-6681-08d60e22eeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 02:47:31.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>
date: 2018/8/30 4:04

> To: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.com>;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH] soc: fsl/qe: Use of_get_child_by_name helper
>=20
> Use the of_get_child_by_name() helper instead of open coding searching fo=
r the
> 'firmware' child node. This removes directly accessing the name pointer a=
s well.
>=20
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/soc/fsl/qe/qe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c index
> 2ef6fc6487c1..612d9c551be5 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -588,11 +588,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
>  	}
>=20
>  	/* Find the 'firmware' child node */
> -	for_each_child_of_node(qe, fw) {
> -		if (strcmp(fw->name, "firmware") =3D=3D 0)
> -			break;
> -	}
> -
> +	fw =3D of_get_child_by_name(qe, "firmware");
>  	of_node_put(qe);
>=20
>  	/* Did we find the 'firmware' node? */
> --

Acked-by: Qiang Zhao <qiang.zhao@nxp.com>
