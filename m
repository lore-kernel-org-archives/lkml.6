Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726062082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NmaMJRDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726062082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeJ2W4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:56:45 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:62208
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbeJ2W4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhcJXDokZOM1+DahOopeL/F4sqw39P5nwt2JHq7z2bA=;
 b=NmaMJRDwvJzsvTEzgwZMdxlOPbOuQeMBXgSPkfYDntpPBVHhL8PliyfVDrLdhuqgyoiqbDyIAmYr6tk4L0Hig3UEHeDFRXGNkcWivfX6xaFOqUKO/YXZ0BD7SHMEt21JmhV9AcuJMpK2bnhRDcv85kVD4odR8lTOz4Ug62D5/34=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4323.eurprd04.prod.outlook.com (52.134.126.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Mon, 29 Oct 2018 14:07:52 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::989c:6296:ecdc:89ff%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 14:07:52 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lars Persson <lars.persson@axis.com>,
        "chris.ruehl@gtsys.com.hk" <chris.ruehl@gtsys.com.hk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH AUTOSEL 4.9 33/98] ARM: dts: imx6ul-14x14-evk: Add ksz8081
 phy properties
Thread-Topic: [PATCH AUTOSEL 4.9 33/98] ARM: dts: imx6ul-14x14-evk: Add
 ksz8081 phy properties
Thread-Index: AQHUbG0nXiS9QEXk0UalXiNlzQUvdg==
Date:   Mon, 29 Oct 2018 14:07:52 +0000
Message-ID: <AM0PR04MB42906FF43CCBE63339E25462EEF30@AM0PR04MB4290.eurprd04.prod.outlook.com>
References: <20181025141423.213774-1-sashal@kernel.org>
 <20181025141423.213774-33-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4323;6:Gob+UfcDi1eIunQ4/YGQjnV+kY8TCAYer9jdjq+3sNzYf6lYuQoD1a78epmwBF/KRbgjzqvIsnjOQAls3X6yXtSIdUFPUyK6hXFF7rV+JhSOwUyKb34NGvaUaxnxyeb/AW850DmWxQvb3ExyImJ2jA5c1MSRC8EA09fEM+aimrYYP34PaBuxSl9ziW4kFU+mfNuH6k5Y1a102LBk5d8N7YLNyyBOgCQf0A10yjgmXXyTIns3ytsMTxTL41/Q7e/Efunesp7GTK8Sd5459NyBc1drPpJajBHNcMYyQhQR+bT9/MfZdLSoNQvTYiNP9JkX9FjuZCw6dAYwlO2tH/w3SxIngshxxVHNxw5qZjwnXuuJKgkA6fSjg0m86UPEu45EB0H5ZskmBlFZQP1DgBmhuoqnd9F5JrJKtSiOdYENrRdeLfFlE+8DQyiaMe1ZUhoNpnukzCjXxsoV5XLN0U2E/Q==;5:w5s5VpKdRN1U9+OwhIibuhQX+70fvIn8iExJpJXM7jW+Wa5BkY/UPpPDm73a50w5wJ/pPN/u5x4v2IwFVJJeNUZ4QEaWV6adZ5qYxDZ9CXZCMPYs2ODof53/EZfZhwaFGb5qUjY8Ppobz7IYpia2wCL2itj45r9rrEHmERXRMUQ=;7:tkmdTtW76eq+TYAI+YIhBjoXSNtQqCAX+u1vm18Zzgkr4Z5UPILqYx0ClCF87MuhyNSuWJjPuSlxawFp05MEuDItWpZY6NHVRw3Kjk7t/11u5fLDrQhEPQTuJeJkvdnYytc1z+puUqVk8OJCf+nG0w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 847770d6-9ac4-4a8b-214f-08d63da7eac4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4323;
x-ms-traffictypediagnostic: AM0PR04MB4323:
x-microsoft-antispam-prvs: <AM0PR04MB432338275B06B9AE3DB79D08EEF30@AM0PR04MB4323.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4323;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4323;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6436002)(81156014)(55016002)(7736002)(8676002)(9686003)(14454004)(7416002)(44832011)(6306002)(68736007)(575784001)(86362001)(106356001)(71190400001)(71200400001)(105586002)(81166006)(74316002)(2900100001)(305945005)(53936002)(8936002)(33656002)(486006)(76176011)(99286004)(6506007)(97736004)(66066001)(5250100002)(2501003)(7696005)(6246003)(26005)(186003)(256004)(25786009)(4326008)(476003)(966005)(2906002)(217873002)(229853002)(110136005)(54906003)(3846002)(39060400002)(6116002)(316002)(478600001)(446003)(14444005)(102836004)(5660300001)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4323;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FVUrxauPuImzEgMpCedc5gc1VtgGKnKglbhvQVpxcor2uRXB/3U4ln2BYwQ/g4emYUCDEp9xIjgpuYXDWicj3wt36JfayNVyfErezJhdTMVWKVqdP26igo1GrY3aR+xYh3EyMzkB2G6ZPBkYoZi8UZmtWXyt2JUQm9zUbsx3jptw2WJT88g5MAFWSQAR/efQA1wbIcMM2YsYINnP2gvPEqlvoy6tF1f3mb3V64+XOgwVitgO5Rt0yi/BtS4zsiPxEDPWr7Yo7Wt9xXErhkcLO86QBYYiCO2bhSvFo9spWW18W7B25a+w1A9qxxUZmoHRpx+5GpnuWbgxC8mWWQBO+It3Ti2RGE1YRANTJjRomjM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 847770d6-9ac4-4a8b-214f-08d63da7eac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 14:07:52.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 5:15 PM, Sasha Levin wrote:=0A=
> From: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> =0A=
> [ Upstream commit e6f4292ae0a1e73fae26ced57de13a48f71ad1fa ]=0A=
> =0A=
> Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same=0A=
> register values can be set through the micrel phy driver by using dts=0A=
> properties.=0A=
> =0A=
> This seems preferable and allows cleanly fixing suspend/resume.=0A=
> =0A=
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>=0A=
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>=0A=
> Signed-off-by: David S. Miller <davem@davemloft.net>=0A=
> Signed-off-by: Sasha Levin <sashal@kernel.org>=0A=
=0A=
This patch only fixes suspend on 6ul evk in combination with =0A=
79e498a9c7da ("net: phy: micrel: Restore led_mode and clk_sel on =0A=
resume"). It is otherwise not very useful to backport just the DT patch.=0A=
=0A=
That patch was earlier backported but then reverted from 4.9 because it =0A=
unexpectedly caused issues when combined with other phy patches applied =0A=
out-of-order. It seems a correct fix was eventually made (by backporting =
=0A=
bfe72442578b) and 79e498a9c7da could now be restored:=0A=
=0A=
     https://lkml.org/lkml/2018/7/11/972=0A=
=0A=
I'm not sure fixing nfsroot suspend/resume on dev boards meets the =0A=
criteria for linux-stable, especially since it already caused trouble =0A=
once. In general I'd class "fixing things that never worked before" as =0A=
not particularly suitable for backporting.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
