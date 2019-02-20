Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0533CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A5120880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RuNFtIMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfBTNmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:42:49 -0500
Received: from mail-eopbgr1310137.outbound.protection.outlook.com ([40.107.131.137]:17920
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfBTNms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZ8/zHpjx3aJGAVCD5bQ4p5dxczTRYHRZBR+do6RYrU=;
 b=RuNFtIMMmHBrr377Cq2mwI4d4oQVL+mOnLQU9Iz+X6js2l0GtGQpDAeCBSHLfJpAhZsjDMxgNd53CceumZExUdRnRdFnTZdlUS4RDmM1Q7roRUUFhRkj2sFGi32K/8GusHOneTiXISv0swrklnGUKc14HBimdCvM/OZk1pvztY4=
Received: from TY2PR01MB4011.jpnprd01.prod.outlook.com (20.178.143.18) by
 TY2PR01MB3994.jpnprd01.prod.outlook.com (20.178.143.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 13:42:39 +0000
Received: from TY2PR01MB4011.jpnprd01.prod.outlook.com
 ([fe80::da2:717a:2757:1962]) by TY2PR01MB4011.jpnprd01.prod.outlook.com
 ([fe80::da2:717a:2757:1962%2]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 13:42:39 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/2] i2c: designware: Add support for a bus clock
Thread-Topic: [PATCH v3 0/2] i2c: designware: Add support for a bus clock
Thread-Index: AQHUySAKjIkozDkvvUSidL2EbbfE7qXoscqQ
Date:   Wed, 20 Feb 2019 13:42:39 +0000
Message-ID: <TY2PR01MB401156288B6D81D7089D5020DF7D0@TY2PR01MB4011.jpnprd01.prod.outlook.com>
References: <1550669148-6027-1-git-send-email-gareth.williams.jx@renesas.com>
In-Reply-To: <1550669148-6027-1-git-send-email-gareth.williams.jx@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588b6dae-cb8d-48e0-9e35-08d6973947e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB3994;
x-ms-traffictypediagnostic: TY2PR01MB3994:
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3994;20:VLCdt6ejPDVP/b2PGO4ZJkM8fANG000Rpnp2P5EkITROPEf8XqxYwZOUQ2CMpP93MInsHBwlhaHYl0l2FCUIULQPZNm5Ljv9s8RCc6DtJlQ9GFdc847gHg6HjHbZrqIq2VojelOPwlpCvsIr5Z4D0Gamtp2qnmlJl9JwdwftKPM=
x-microsoft-antispam-prvs: <TY2PR01MB39941410E11CC0425AD55890DF7D0@TY2PR01MB3994.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39840400004)(376002)(136003)(366004)(396003)(189003)(199004)(229853002)(8936002)(14444005)(33656002)(7696005)(316002)(54906003)(99286004)(110136005)(256004)(76176011)(81156014)(3846002)(8676002)(6116002)(81166006)(5660300002)(486006)(476003)(9686003)(55016002)(186003)(68736007)(6246003)(7416002)(26005)(53936002)(4326008)(25786009)(11346002)(446003)(478600001)(6506007)(102836004)(97736004)(86362001)(305945005)(53546011)(66066001)(71200400001)(71190400001)(105586002)(74316002)(2906002)(7736002)(6436002)(106356001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3994;H:TY2PR01MB4011.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 19Xi+hU2B5N38rRVkHTJ7PhQQubyu8QKmUUtjVv4zhbIxlj6DXeMUyZCUguK5DcuJ7YQC2MDn1NIoSXUb1QQRmsu0Ut7lKK5dgkGYsbQCxOOoZcSstcz08o38eqE63oBVOnD2gGgNvZCAM5zpkuPlxyb9ttnms1WZQiiA9grWIBNujbTJ/kZncmHckLypZvtXmWfC4RZhrJ9n7ORsAcLQcRyQ/T4eXTS8kjwRFLRGR0TknV/Xcg+HDPW+KReybnwmMPNfkekRJ30Dxhbb2zQ9f63SAcHyYaIAbNPnREGZ5SCumQmUKiEJgZAKzM5kl0IveB/vh4nGoXP22byEgH/Ke5H2hjlLpuZtyvn+CFF+RInYQGfGQakeogtOPHzQRYD7One5jcSFZXOqDuSWOhR1aoCCej4S0+bUks9s7mQszs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588b6dae-cb8d-48e0-9e35-08d6973947e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 13:42:39.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the email below was sent prematurely and will be resent shortly.

-Gareth

> On 20 February 2019 13:26 Gareth Williams wrote:
> The Synopsys I2C Controller has a bus clock that some SoCs require to acc=
ess
> the registers. This series also details the new clock property in the bin=
dings
> documentation.
>
> v3:
>  - busclk renamed to pclk.
>  - Added comment with dw_i2c_dev struct definition describing pclk.
>  - Added enable rollback of first clock if second fails to enable.
>  - Changed clocks and clock-names sections to use term "peripheral clock"
>    (pclk) instead of "bus clock" (busclk) in dt-bindings documentation.
> v2:
>  - Use new devm_clk_get_optional() function as it simplifies handling whe=
n
>    the optional clock is not present.
>
> Phil Edworthy (2):
>   dt: snps,designware-i2c: Add clock bindings documentation
>   i2c: designware: Add support for a bus clock
>
>  .../devicetree/bindings/i2c/i2c-designware.txt         |  9 +++++++++
>  drivers/i2c/busses/i2c-designware-common.c             | 18
> ++++++++++++++++--
>  drivers/i2c/busses/i2c-designware-core.h               |  2 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c            |  5 +++++
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> --
> 2.7.4



Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael Hanna=
wald, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse =
10, 40472 Duesseldorf, Germany,Handelsregister/Commercial Register: Duessel=
dorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr.=
/WEEE reg. no.: DE 14978647
