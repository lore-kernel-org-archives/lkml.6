Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A77C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3A12229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="n4nHKvgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393778AbfBNKjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:39:41 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:56603 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfBNKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:39:40 -0500
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; 
   d="scan'208";a="24657960"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 14 Feb 2019 03:39:40 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 14 Feb 2019 03:39:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUI6jeibGXItDauZ11I9USJA/o1jn/DgW4xy3IqTTUY=;
 b=n4nHKvgu5hgxS0wLX9iGNWRaqeGLOpNN3K3xsskR44D3ymf+IX6vqRoE0+2E2TA8MNaXykqQgx4+Ub3Ou1a1ftIzMQRiLbeEdPYZ/WGLSs3HYhai9ZnFD/W80mgQqpu7tfotqXH6PrvMGiR8kPRO8M8nLqPTX5JQckWhxkzh35Q=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1311.namprd11.prod.outlook.com (10.169.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 10:39:36 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 10:39:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/2] add slow clock support for SAM9X60
Thread-Topic: [PATCH 0/2] add slow clock support for SAM9X60
Thread-Index: AQHUxFGUN1PJs+Pmjka0w9X3F9luyA==
Date:   Thu, 14 Feb 2019 10:39:36 +0000
Message-ID: <1550140748-21714-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0131.eurprd07.prod.outlook.com
 (2603:10a6:802:16::18) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 694f6a89-2027-44b7-d663-08d69268b6c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR11MB1311;
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR11MB1311;23:yBWF+QhFqrLS26jsnMN85FNOIRZ05g9GIqRDM41?=
 =?iso-8859-1?Q?Owp5HhSmPw9NIeH1TWu5pquLDPcHyb0B3rQks8QZYrZ8VF/zLQVOiKzxty?=
 =?iso-8859-1?Q?bfFd/akfHG0cdohcfwIfS9NRRL7vRMK37DBAn0Swgpj1zgrK7Bjf983Eq9?=
 =?iso-8859-1?Q?yKJDkme6eH3OKTyWu+GrH8/iYoEB+yYCoa1tWYIWBPTc7yQW22QqgzMx+y?=
 =?iso-8859-1?Q?pgT2/FX8AOQ1eYWPC8cH2gH6JzjhP9lNvAlw74LrBTkQqmBf1iwwf49Z1v?=
 =?iso-8859-1?Q?yTU2yetbcLPurEXaqReNmhlFsxCUOwgvasRUA85S7Z6KoxQm7mKVcfsESc?=
 =?iso-8859-1?Q?aC+hmelNVEfaq7V8frR/rWSrtOKuai81As5NfTHpBzEMh1/ue9pkT8WTlj?=
 =?iso-8859-1?Q?FIgVSkh+fdZ24VGAfmst9nnb4fEDFV6am8CmpT+j7ugjv3jVYYoRgPCQER?=
 =?iso-8859-1?Q?gfgs2SHd4dGCKK67pK5OQiVEuWB5OZFjK2MNMYSSHUYpk15XqK+HE1mC7x?=
 =?iso-8859-1?Q?k7wAVffbFn91lb+1gwk7EgncK6EnhgOeK7yTqrQ/+gLdpn4+j7qIP8BCqE?=
 =?iso-8859-1?Q?p4VYHJYxtgsfLIrlYELi6C0JPU6K+cZje8He3kH9pErEt5HYvJscEAV1Tq?=
 =?iso-8859-1?Q?okBxPZ34xqAJ0F+41Wcz2YzruJI0oi05F/WeCZX9yN03/Zqdnh7lTfT8x/?=
 =?iso-8859-1?Q?L01nqC9BaSKH5SFpGjqg6LW+l8vgN7YT1N3yDsKSrLqoy1I2KsXfs5wRTx?=
 =?iso-8859-1?Q?K7bO96zmenXE9xQ8W8iPI6K9CpgM+QSMHn6x8I74gig4SXkXgrVc7IY49q?=
 =?iso-8859-1?Q?vpaTdlUoHsfFUy+l6kmSlegeGvHW0c8zaMzGkj2qdV74tIx5Ry3tNfQ8Yb?=
 =?iso-8859-1?Q?9ukQc0ch9k9UbjpxEKFi7fEfc0N+tMZ7gSwjdoTc2uLqVqh3TbZTtJ1TBr?=
 =?iso-8859-1?Q?mUgisWuEFxZUqETuU/ecgDdJOw1Lx7ZJm0uRny4h4tHU+G7ne+BoHQB3nZ?=
 =?iso-8859-1?Q?4jeVGHvviJoC5jQHsZQe29Y+Vq1iS0Ps4SMSExu6DKqUyKK8kC9de0XjaH?=
 =?iso-8859-1?Q?lTC6Bd+wNO9DC9oA7ujSoli9fGNVWfV0Ts+CIlB1cJD57p9pqcZW2yaIIx?=
 =?iso-8859-1?Q?KUOZj7rXXjKyEsZIyXAttbQBDE+iFvttgkmzgx8ozZd/McbmP4cMBN89WF?=
 =?iso-8859-1?Q?u10mqJddgZMzBF5EVQSIVsdomBZsM++jBQNivEETexphDvB2UTod6QKcBy?=
 =?iso-8859-1?Q?At5Wz15TdblBfu4Zk?=
x-microsoft-antispam-prvs: <MWHPR11MB13111A50DEDA23B63105C77087670@MWHPR11MB1311.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(189003)(199004)(53936002)(110136005)(105586002)(106356001)(72206003)(97736004)(3846002)(6436002)(478600001)(6116002)(86362001)(36756003)(6512007)(2501003)(2906002)(25786009)(68736007)(14454004)(50226002)(81166006)(81156014)(8676002)(99286004)(71190400001)(66066001)(4326008)(486006)(7736002)(4744005)(305945005)(71200400001)(8936002)(26005)(256004)(386003)(6506007)(52116002)(6486002)(6636002)(476003)(316002)(2616005)(54906003)(102836004)(186003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1311;H:MWHPR11MB1920.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /iejPDS3Tts2Wzf10oTDU8blY92w63oAOW/nB3tDx4o2JMIr6e6EUH5I4zF1crIQVKDwdOXfcEmNntbSDCY0MCbcp4d7mlebOwVWwSq/uiuR7NtV/LqTFq18WqZ8V++eMScp5KF77GDvu3uBy22BXVL5Nqgid09W9bqGI61HRtf7sE4shwNNFROCEBcTd0lWg+ik4+fVD/1V6bB/kkjSd7CB991PpFJzewNzDj9sQ7EKBHCPIIcLYKukhedZa2KU0yvVagFXDavrMELL05oPaFxD02uZyEnvx9I4hmfAVYaF6dJvn5dS3awsgoJEGNlt4Tlmri+kxVgZQAg2pwhPP1nK2tAtuWqYJKvQ5YvqzVtc+usPdV/Bzi+ec/eQpY9ln8zDc6yAGfZE+nUuwGdr4GmbyirGAW6w/1LPCgL1j/c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 694f6a89-2027-44b7-d663-08d69268b6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 10:39:31.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series add slow clock support for SAM9X60. Apart from previous IPs, th=
is
one uses different offsets in control register for different functionalitie=
s.
The series adapt current driver to work for all IPs using per IP
configurations initialized at probe.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  clk: at91: sckc: adapt sckc driver to work for SAM9X60
  dt-bindings: clk: at91: add bindings for SAM9X60's slow clock
    controller

 .../devicetree/bindings/clock/at91-clock.txt       |   3 +-
 drivers/clk/at91/sckc.c                            | 142 ++++++++++++++++-=
----
 2 files changed, 109 insertions(+), 36 deletions(-)

--=20
2.7.4

