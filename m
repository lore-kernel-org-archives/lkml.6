Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C6720811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="uS5P818M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C6720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeLLIBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:01:12 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:44392 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeLLIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:01:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="21408302"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Dec 2018 01:01:11 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 12 Dec 2018 01:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp3TN2FM2N/jzUjImueFMw1gazVj9UDXBFw8liAKvYA=;
 b=uS5P818MZRsMpfwhN77RqLLqRvTSKrg1png8+0JmbeblzILiV02oEHUuEhnw6yfER7h7o21g2xN4HW7FETDOpqvWOjRcDaEz1qH+vkKYHd4TvkHgIoJburJaKA85CrrN1Yr78ccq/z5qIyZ0No2EQnE3gkPTNkPvgPQdaQpM1JM=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2274.namprd11.prod.outlook.com (10.174.113.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 08:01:08 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 08:01:08 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Thread-Topic: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Thread-Index: AQHUkTmSRQO8vdR2CEWafmmGWx4+QaV5v9kAgAD/PoA=
Date:   Wed, 12 Dec 2018 08:01:07 +0000
Message-ID: <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
In-Reply-To: <20181211164706.GL6686@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0095.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::24) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2274;6:Mafc3gjPG7KuqbsnWfaY3Yod83DzCEYgiTtQ1JIhPt6zsp4kTGRalrsGs9lY7W7Gdxa39OcE0uS3f0MtX1oGUIVYHSHSBbNPjW8ynCI0HR1ZBpzHYrwck9t0Ma39aex3l7kkLCZ2RjqrDEnS8/1wXFYmgKElc6wh1aYeWzNjaLLZJ6KiFxF/z0GXn+HNVUp6LL4N2jLOdbtIc6tl0Tt3+6sn84ehUHLV7X5GqmPy+0J4XpFo4e1+RhY5ekAFDSPbuvhf8SpK0PDv5NaEJ5DkBNhm5rjQ9/gBQk0Xugk569qOEXl4N6UY/dRkJfAX9McsbAWLJ+vn8t/G3rwVA3gmTFr2hLU15V0NNn7eWjUXxtfsn5+UtFZxshwxkYfc5HqqF1kHqM1q8EvQIElvy4Mc4ZlwllX9rX9hWrYKb05799ccJQ/k112kE5CmKmZ+kuAzyrqVY5guhKrQuDY76h44Fg==;5:4zZNSqmn/3lP0F+Ouu9xdb9yPd7oGh2Z7hL/2rvo2yv9EqbfxahNF3/w/rbYPiYga14ioRnOcyJ+ndMaV5+L9/xyawewsVwyDjbSOHXcWFm1JzKfivbM5dslvH2nnFzFwq5xjbsFhwQAN6Vd9/dxlV4JaVleA3SE49zzuod1PRg=;7:epKtnGHB13Rr/4l9uDmMbSGJx35VCux2W4AhLnmvg8t2qivCkL7wz4K6UcxOrS14Hurtx+fsccK/VHH6lBiGb5io/EEbahLe7RlKDAeQkkPNajveGwBACkoR41M+Z2975feUH1gn0SxBP4+mDeqn0A==
x-ms-office365-filtering-correlation-id: 538334d8-e2d1-4c46-98b1-08d66007f8d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2274;
x-ms-traffictypediagnostic: BN6PR1101MB2274:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR1101MB2274534B30741C0B848A19D4EDA70@BN6PR1101MB2274.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2274;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2274;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(366004)(189003)(199004)(71190400001)(31696002)(52116002)(39060400002)(86362001)(4326008)(14454004)(217873002)(8936002)(71200400001)(6436002)(81156014)(2906002)(72206003)(66066001)(81166006)(229853002)(5660300001)(478600001)(36756003)(6916009)(68736007)(76176011)(316002)(6486002)(305945005)(26005)(8676002)(386003)(6506007)(7736002)(6512007)(6116002)(3846002)(106356001)(102836004)(345774005)(54906003)(25786009)(99286004)(53936002)(105586002)(14444005)(446003)(6246003)(486006)(31686004)(476003)(2616005)(11346002)(186003)(256004)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2274;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RG+W+eY78E4ec4WN2yv2yMZyDsggjhtQ9zUgpqJyxn/VBloFO6qjixnJUWbcl5GgX4lc8v67ZChCvr9IYAjjZ5M0OQv/ZdlDcvGE7EDjMlNAnMcugRXfnZAz3Q8VyYSwe4H8KICtnSFZPg0dhJ2j91KPTLmtx5piCbPyA/UjW1ILwtL4wqBGPMjmc16pFauhhRjeInKynQubl10N5ebHUjfroLJLLkg2pC4SbqFIzJqTRRliFJUUuSLO1WkEMt+Yp6p/vreMNJqc/4B8eRdzpeYLCeWPug5Ekvpi7Ly1XGoQCyRe1cWrGkGJAua39wg1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <140B56071DCEC6418A084D1F57E0E1C3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 538334d8-e2d1-4c46-98b1-08d66007f8d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 08:01:07.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2274
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for the review.

> SPDX headers need to be C++ comments - please make the entire comment
> block a C++ one so it looks more intentional.
I sent a new patch (v4) with the modified comment.
>> +#ifdef CONFIG_SUSPEND
>> +static int mcp16502_suspend(struct device *dev)
>> +{
>> +	struct i2c_client *client =3D to_i2c_client(dev);
>> +	struct mcp16502 *mcp =3D i2c_get_clientdata(client);
>> +
>> +	mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM);
>> +
>> +	return 0;
>> +}
> This puts the device into low power mode when the suspend function gets
> called but this might not be safe - devices using the regulator may not
> be suspended yet so could still need full regulation.  Normally a GPIO
> triggered transition like this would be being done by hardware as part
> of the process of suspending the SoC.  Is there some reason to do this
> manually?
There is a line from the MPU (SHDN) which goes low only when the MPU
turns off. That line is already connected to the PMIC and it differentiates
between suspend-to-mem and standby. To switch to low-power, the PMIC must
be controlled by the GPIO pin LPM.

The suspend sequence is:
- LPM pin goes high (PMIC enters Low-Power <-> Linux standby)
- SHDN goes low (if target suspend state is mem) and then PMIC enters=20
HIBERNATE


Best regards,
Andrei
