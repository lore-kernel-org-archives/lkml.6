Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F0C2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ldEdBwU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F0C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeK3SR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:17:28 -0500
Received: from mail-eopbgr1320104.outbound.protection.outlook.com ([40.107.132.104]:17047
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbeK3SR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFpXIYwihPvLNr0BnPZH+lhv8B/u0loGZ20ARjtX3dQ=;
 b=ldEdBwU2cscdI+dtd85yDLFEAyaJVd+gorYUzGVXWMo3KkIyB0Zi4pPqmhHESiiUftg1GG6OuDyCU6TM+tfG34548ndJAKrJf+8C30o09gFjNNOeRMzDl7lrRAx1YRpVrhY9l6X9iX1Wplo1MHfW1kzU1/dOb1N6gvnJHJer3GE=
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com (52.133.184.14) by
 TY2PR01MB2219.jpnprd01.prod.outlook.com (52.133.184.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Fri, 30 Nov 2018 07:09:02 +0000
Received: from TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::98d3:2fbf:ca47:f033]) by TY2PR01MB2297.jpnprd01.prod.outlook.com
 ([fe80::98d3:2fbf:ca47:f033%3]) with mapi id 15.20.1339.036; Fri, 30 Nov 2018
 07:09:02 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     "kishon@ti.com" <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2] phy: renesas: rcar-gen3-usb2: follow the hardware
 manual procedure
Thread-Topic: [PATCH v2] phy: renesas: rcar-gen3-usb2: follow the hardware
 manual procedure
Thread-Index: AQHUiHrHPIINEz1Uf0eW1vj3kW5pjaVn5aJQ
Date:   Fri, 30 Nov 2018 07:09:02 +0000
Message-ID: <TY2PR01MB229720D5323203C501260AACD8D30@TY2PR01MB2297.jpnprd01.prod.outlook.com>
References: <1543561257-27594-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1543561257-27594-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB2219;20:98GCogQ4yQoq/lZJYLOhuIQJVE9I4TcJnOu5zXIZ/1p0YeXqoeCp6l087OsZBgrKxFAm3bUUTbPlFddzx1zZ6RgbffJoLx2+PE+BL4JLzKnUMiWIbzDubCxrvLvKPlAWSA7n17UUCv6yI7+fj4IRjDfMkjY3c3aM8XXsbbbzjyw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cbdc2e92-e3d1-42bd-280e-08d65692b55c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB2219;
x-ms-traffictypediagnostic: TY2PR01MB2219:
x-microsoft-antispam-prvs: <TY2PR01MB22196B8BE80DF59EEE72E04BD8D30@TY2PR01MB2219.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231453)(999002)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB2219;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB2219;
x-forefront-prvs: 087223B4DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2501003)(7736002)(478600001)(3846002)(966005)(6116002)(6506007)(316002)(6306002)(53936002)(486006)(9686003)(66066001)(2906002)(256004)(11346002)(5660300001)(6246003)(476003)(71190400001)(71200400001)(446003)(55016002)(6436002)(229853002)(5640700003)(102836004)(33656002)(7696005)(76176011)(4326008)(14454004)(106356001)(54906003)(8676002)(105586002)(74316002)(8936002)(6916009)(26005)(86362001)(2351001)(68736007)(81156014)(1730700003)(99286004)(305945005)(186003)(97736004)(81166006)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB2219;H:TY2PR01MB2297.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SLZMg8PJptfrw8HLHg7/txSDF7HMD3Y7g/kquQYS0Tt82DzT9dS4hAxNIRpDmiifjsP1k49IViwSFGNQV+/oQvDKMgyN7griM8+yuwRYnVLBhv2wWeUtSzQbTck+Xac/ZRxfXOWGkEhJZHMTW1HWwYf9RxC1C8F1ZsVXTJYn9lkT93G/VRARoSDD0ygXRkN2fQSu2XRe7bSfbRBVHsJbw2hVQx94cT2tXgh6x50gaTxbfaZ3SB7zjxJApWf1BABHUfLw7CINVVXiTTgTSiIerTb6Pm9gk/KrH/+sAKcu4YOjECXVVpBuWMDtbzsUYL1gqSXF+cTbN88nnpr/MWzAfBt4TUKYgmGjY+cwGYj7Z6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdc2e92-e3d1-42bd-280e-08d65692b55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2018 07:09:02.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Yoshihiro Shimoda, Sent: Friday, November 30, 2018 4:01 PM
>=20
<snip>
> Also, this is the first email I send after changing the email server
> to avoid using quoted-printable encoding.

This seems to work :)
https://lore.kernel.org/lkml/1543561257-27594-1-git-send-email-yoshihiro.sh=
imoda.uh@renesas.com/raw

Best regards,
Yoshihiro Shimoda

