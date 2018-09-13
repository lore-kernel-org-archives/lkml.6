Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5BB2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fJ31VN9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5BB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeIMOw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:52:26 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:57024
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbeIMOw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ep0EpRG9AnGv7LJXbiD97I4cq+STSBiv9aqWWLIrkc=;
 b=fJ31VN9Wf0NtYoH88FXjzJOBJG/voDILk9U6nkhwNMVlxBFhyC4NiEECl0iHC5h29wPQpzFfLQWzhQgZKrIyGZO/L/Ck/xtk02YDTdqY3l9u99D2GJ3LvP/XYcNw6S2PAvfDRb7kV9dj8RwHO7ySlJSVU7aMXSCYZzyvMiM+g8U=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.72.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.18; Thu, 13 Sep 2018 09:43:40 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%5]) with mapi id 15.20.1122.020; Thu, 13 Sep 2018
 09:43:40 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] thermal: qoriq: add i.mx8mq support
Thread-Topic: [PATCH] thermal: qoriq: add i.mx8mq support
Thread-Index: AQHUQAfSxMPEgrN75UK17vsyUvyBu6TfWj4AgA6yI+A=
Date:   Thu, 13 Sep 2018 09:43:39 +0000
Message-ID: <DB3PR0402MB3916E21AC0E72E5F1EA0DF4EF51A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1535595286-18371-1-git-send-email-Anson.Huang@nxp.com>
 <5b8e8a6d.1c69fb81.cdb61.0b30@mx.google.com>
In-Reply-To: <5b8e8a6d.1c69fb81.cdb61.0b30@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3947;6:nYK/S1SU5iS0PS2T+tlOdyfW3kl0J2lldZH5XZEWxUfDfKPJIjq90G1fStZ1no6UMYEGsi8OupW2RcnCSu5ZxqUFQWVr+hIIQNG8SEUVMQgFHyLguhtZ9/efpa2qLbZW0kFwNVtITyveDR/9UxIWaWKzBhjEkUsXvnwWhdYhccGZb8mdCfeeEU2JnJeFimoIS6HoBFTXE9zXPFxUiSffh4zNSu/ezxUF7f6T1Bb5lutMvUCiYbYhSkuTZ5CUs6xrSVs2O14mRETqk0z5UQohH//udrThWSPYEkQBdX+DI5XLS+xrsrYmzQVTPMiX7Bdi4yT31nJsFciKHP0u3qgFlUMeNAmLn5XVTmQYaUQPjdK7WSP4nK1M8GudB7fid6v2TlGzS7GKXfI0MWEeRukhnsVVhnqnHnTsPHz23wobCZrAvtySnFNZaxo27F2tb4lEDtDg9RA+w/BDrIYNd0Aj4g==;5:oiVcFG6PPJMvu27vM9nwc3g1JDe8ATUDJkpsailoQbRPx5XQeV1Wr69UHNIAaXaY+UgUHYiVZP9u/7fCuyer4BMKuSYcPqrDbKL6qPpJUlHFbI8Ciux4azLxAVEPPniyqcwVpDCeDZ8WT0iaHBG/q33cdlI+T1ob24ja6QWE9/k=;7:f+jKLJgh4V/bOcTedTpfHz/PGyC0ZK+TBdhXWTtwz3hWBaQCGfQ33qRlZzj2MdBHT0zzffYA6DlIOxzSMpRIcNLsBbS2VRRwZuwpnsr6M4LauYJT95q0oFWDjVLlv6eE30PdLWSUpQJmAEa5Q0jhW+8IuwzRa2cwUlh7ucINpFx6Q8ZsJtInH7zaVhgqGKZZI3CCORi+sGmq3B8zjcEiCzg3a7/cRIGWAfarnpiiy/DEXDnoJXHq8h7CXC8UkkEm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4aab21a2-e8d5-44e2-82f1-08d6195d62d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB394762A37FD153957F8E0A37F51A0@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:DB3PR0402MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3947;
x-forefront-prvs: 07943272E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(13464003)(97736004)(5660300001)(99286004)(8936002)(5250100002)(2900100001)(81166006)(478600001)(54906003)(6246003)(486006)(66066001)(81156014)(6916009)(8676002)(86362001)(14454004)(68736007)(4326008)(39060400002)(76176011)(55016002)(25786009)(2906002)(7696005)(229853002)(6506007)(256004)(33656002)(9686003)(53936002)(74316002)(53546011)(476003)(186003)(26005)(11346002)(316002)(446003)(102836004)(44832011)(3846002)(6436002)(305945005)(6116002)(7736002)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IAoimKrO36j3fJXxEXK/1WXjKX+5VvJRcyopv/OXeZJPCTWbalSUzMfyyeKoWk+J4gQiz14l+TS5dpz4WRM8gCbG940jbRV38yQRDfQ7bBibt2OCQcRXFI/TxK3biplx46ju0c7r5vNGqitSkiTAKlwt1LjCJadrqmev5zrmQ/K/w2txmWZqs9q54J4Qup2h0ciMnIWGWzW0irJ69JAMQJOczqfxb0bN1pbEvkKK+ZiVG7l+c/Pq2uEhWzoYhAehP+DQrYv19G9LklwEUsaKt0tmRWx3WGaQxhe0VB0tzegnV9Feol14s0EPgNgpCPRT5R1YjBXFJF1+V8iV1fUtX74bs8BHM60Ej7yjyUGEeIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aab21a2-e8d5-44e2-82f1-08d6195d62d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2018 09:43:39.9677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping...

Anson Huang
Best Regards!


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, September 4, 2018 9:18 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: rui.zhang@intel.com; edubezval@gmail.com; robh+dt@kernel.org;
> mark.rutland@arm.com; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH] thermal: qoriq: add i.mx8mq support
>=20
> On Thu, 30 Aug 2018 10:14:46 +0800, Anson Huang wrote:
> > Add i.mx8mq specific compatible string.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 6 +++---
> >  drivers/thermal/qoriq_thermal.c                             | 1 +
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

