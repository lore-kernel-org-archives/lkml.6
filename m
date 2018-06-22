Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A428C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E583242CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="LJaMFb9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E583242CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeFVNe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:34:56 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:31862 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751389AbeFVNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:34:54 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 22 Jun 2018 22:34:53 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 81C0C6F8A0;
        Fri, 22 Jun 2018 22:34:53 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,257,1526310000"; 
   d="scan'208";a="283302258"
Received: from mail-ty1jpn01lp0176.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.176])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2018 22:34:53 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/e433mrwu2QQczIe82d/Q0irpUV4l8A+wNPdtiXTb3A=;
 b=LJaMFb9cHuN7DOZ7wAx2qPcews8m0/Fro6udUWF+NaIEJWrJmsCbfLOay4lGE7j9Md/miyvfOFXnrsLVC6jaLY0Ey1hxKRH/N8wZ24KF85E0quWWuAOawMC9Bj5tA/ZSMjumYcGec7zItvaya7OoSocTd5hsrFtsMeymM2oymtU=
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (52.133.162.18) by
 TY1PR01MB0222.jpnprd01.prod.outlook.com (10.161.135.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 13:34:48 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d5ba:9747:d01f:427c]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d5ba:9747:d01f:427c%4]) with mapi id 15.20.0884.021; Fri, 22 Jun 2018
 13:34:48 +0000
From:   Chris Brandt <Chris.Brandt@renesas.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC:     Greg Ungerer <gerg@linux-m68k.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
Thread-Topic: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
Thread-Index: AQHUCXjQN59bwBmqP0OuNzrNny+ALKRsAk6AgABFZMA=
Date:   Fri, 22 Jun 2018 13:34:47 +0000
Message-ID: <TY1PR01MB1562CCB1FAC3AFA20CDBC9958A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180621155906.12821-1-geert+renesas@glider.be>
 <20180622092305.GS17671@n2100.armlinux.org.uk>
In-Reply-To: <20180622092305.GS17671@n2100.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chris.Brandt@renesas.com; 
x-originating-ip: [75.60.247.61]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0222;7:ptDF3ZTarl99Jsi3u+Z4vP1tOfYpVpB1g24XpPRFSJoY8wP1ScCwauI4Oqy2/9t8dV2MO2nFuuAbkuHIshdSLV2ytUFED5pDbDDqdzkbpvj9Ye2eASctDkt+i1yyTIvK1vNiWMKeAA6a+e3rq1n8S3oE5mMn78C8FNCykZGz981QSdMYTXWBHKI5qwixEOHbnqYVyYSU654YeFXsZaor9vmWzPRgeyZ/ii5iBexZhI58xiqiAnfcG4DOphWJDlDT;20:gtlam6/6yk+gzuP/uKwy68IcZ/YR6ETXXmogmP+cK7hBOEUAJKEI4N/3HsMYg8AA5CpJYhANKxeFkR/RWbG5IMiJ238sCPs4iNqP7ysQjyTxTBa32z7jXlbjLeP59XmjZNI2/n+IsLLpCB/k/GorrEXhGTBXukIcoZc+5fb0QhY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6455c9d-b189-477c-bbb0-08d5d844ec89
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0222;
x-ms-traffictypediagnostic: TY1PR01MB0222:
x-microsoft-antispam-prvs: <TY1PR01MB02222DDD3E54CBE7537FCA418A750@TY1PR01MB0222.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:TY1PR01MB0222;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0222;
x-forefront-prvs: 071156160B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(199004)(189003)(69234005)(81166006)(5250100002)(6306002)(81156014)(6116002)(66066001)(2900100001)(3846002)(3660700001)(966005)(6436002)(8936002)(14454004)(9686003)(3280700002)(33656002)(53936002)(72206003)(6246003)(97736004)(68736007)(478600001)(2906002)(6506007)(74316002)(102836004)(446003)(106356001)(4326008)(11346002)(26005)(110136005)(86362001)(39060400002)(7736002)(186003)(5660300001)(105586002)(229853002)(7416002)(55016002)(54906003)(8676002)(76176011)(7696005)(476003)(486006)(305945005)(25786009)(99286004)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0222;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: B83jkWK1U4azghrph9Z6ZmOEKjmYE8F1/82DtQhrnJvoDZ3KvN1dX0189Fy8zU2N9+HgywYGdpeR55P8HTxRhwINjb+zjcVmhQNIDF2hC1iU3xP0ZJZT+LIEJjsXrjmgAOTTqGOIC34SdwuP9wC74YkGwWymgdRpO2e9bod1N4BHHve3wmvOXYS4QFfPk77ygGV/u6LsiJmJty/fdXwKPos/PzNMB6RtDfHbkShoOi4oR/M4k9KtP7I4OlLVS3spmeZt6rk1cUaX+66vzkuOiQMXBn7shj1yYiMpcK/gUl2bstXuHMY53bnoJAKrGutfDTcMgRYvC1O6YgSxGfNMWw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6455c9d-b189-477c-bbb0-08d5d844ec89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2018 13:34:47.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 22, 2018, Russell King - ARM Linux wrote:
> We've worked around the issues with "multi-platform" XIP/NOMMU by
> using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
> (which must, by definition) have compatible physical layouts.
> Exactly the same approach should be adopted for other XIP/NOMMU
> platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
> to lots of non-bootable kernels.


FYI, I already submitted at patch like that:

https://patchwork.kernel.org/patch/9563975/


Chris
