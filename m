Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03370C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF91206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="D67SOLbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF91206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeI1X5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:57:02 -0400
Received: from mail-by2nam01on0099.outbound.protection.outlook.com ([104.47.34.99]:5632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729515AbeI1X5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz29PPXSyFECIqSFVnFK3rUP8PfHhVUPi2DosrLqYIQ=;
 b=D67SOLbI6CeJGL1yRSWkEKlSodX3Rx09Qnxo0lDokRPCPdNdUsVyfI/V/UKbWQEQlG5yeT/FxgRdClru/UgUBzagZzFjna4jZvopRGhCYDk09cSHn1Mq1vqz+H7/dTk529lMp+C3lFGULBaeOZXq9wrmmlGBK7P72MjJ84xNKoQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1389.namprd22.prod.outlook.com (10.172.63.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 17:32:11 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::1886:62b2:fbe4:9627%9]) with mapi id 15.20.1164.024; Fri, 28 Sep 2018
 17:32:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: stop using _PTRS_PER_PGD
Thread-Topic: [PATCH] MIPS: stop using _PTRS_PER_PGD
Thread-Index: AQHUVw4iuooAWZR9UU2Eb/T7e2lfTqUF9EGA
Date:   Fri, 28 Sep 2018 17:32:11 +0000
Message-ID: <20180928173209.4ewtus2afrgyk265@pburton-laptop>
References: <20180928093202.15426-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20180928093202.15426-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR19CA0015.namprd19.prod.outlook.com
 (2603:10b6:3:151::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1389;6:1XFLQSrhwKMglbUpYEIuFbt95joC+KZ1AFo1DvfZLH6D64wf7iqcNpzrvhdLTiwfWYr8DzI/8k85SFF6FY7QvERBsxlgyZhw5DaVubl5GZIr0hdVaFpJMKOiPnNabGT0yESvYrNr5qKqV3FDnwS08R5bGgvmBYrqTC8utKpv19kWa7ebDiyIJP2HQbKcagLR0/wwoNpA0TgROSvejOjkapa31eZSMt1PWIpWRPQHSBPLpgpGyn5/4tXrxMXq1tekuiDT5uXs86Ew/28HZjnDJZ+iTurT+H6mC4L9dnx+OssDxI5Br5reoTDuj17Eyg2av0+Fu9wAlI3vAx/cJ4uAA1Y5WLtfxAt5/hVlTDheWCZrjAeVUB76HpiBBul/+bV2kmZLjDqE8s4CTXTmm3USl0H4nNW2p/ZmkC8p5tTrUO5joT/MFIqdDxbaDKRV//JlOkkyrpOJTQSWGv9AZAgGVQ==;5:wW6F4Y9ixRGGp2BICJHvohjtaW7uh9M3cadv+svkHyKrmx2BhmPCrh/EAHhW2yIyY2cMbwNr8YKVRO1wq43F96iLVV0qiFfPi2BLlONzM4hU57Ih9tm9VuyuSqNu0oNproEXT+AGbPPdpb0RdaC7Rd4Ytk/FRd0/5LvMtkWafMI=;7:d7P+SekVnC5s2H6EBwH1XCBXkZAd0i2co9Y5NhZIfZqmpLSk0GohxicQknNSLvtROk6zM1Id4F2hQxYtESKzNOQSyQRltdD6p7ZZJRMnOuaH/grTv3farF4sXHo51CoR6DD+h8To9IKJlALBMJ8ms2fMfgHklZTAyegLZopwrkJyufnrMDKmDn2Zc5k6yIYtHDZMWKQjhckrxdFfV9qGB04cR+pc3/T/wHrWHgg/WI+E0ma1V0fLAuv+COa/LEOF
x-ms-office365-filtering-correlation-id: 74fd19c9-a949-4640-36ea-08d625685293
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1389;
x-ms-traffictypediagnostic: MWHPR2201MB1389:
x-microsoft-antispam-prvs: <MWHPR2201MB138975F686CE875C3238E716C1EC0@MWHPR2201MB1389.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1389;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1389;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(366004)(39840400004)(396003)(376002)(346002)(199004)(189003)(6116002)(3846002)(8936002)(105586002)(14454004)(316002)(508600001)(106356001)(6436002)(97736004)(58126008)(5660300001)(6916009)(2906002)(99286004)(54906003)(6486002)(71200400001)(71190400001)(68736007)(305945005)(229853002)(33896004)(6246003)(44832011)(25786009)(76176011)(9686003)(33716001)(186003)(53936002)(446003)(26005)(11346002)(476003)(256004)(7736002)(1076002)(34290500001)(81156014)(42882007)(5250100002)(81166006)(52116002)(2900100001)(6512007)(4326008)(386003)(486006)(102836004)(6506007)(66066001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1389;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lUfeoG46Q6DF8aGqOyNcLWCC8Ih/5C0yxQ8Q8FBVE9/ITip+1RsOnv4i8PTCzM7D4RmON4ZqfcKBJlMybTWnQfwTrNZTiQWs7tgCzxXswJqqBGOaprut2/EnyDVkuBFwinSln1D0jso2wLiFeEl6N8XehoqAupz1GkqC9mmZCBPMycK8bweCtvS2yc6nN+ZuWMIcPoBh/46BNm7uVO7uj8sLijid8ozpm9A3k3oiN0mHV/tX5LHTQgkI+3kI70Tmz+pVqIse8Paklar/2CNGEmQfg/J3MkQR7ZxEV/tG3rgnbCUkJiVQbzR3KnuOU8CPQHL4vjAXq7jEyJnMRdnaPxl99SB9QO1DbtXUvYrp450=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D9910F8B7B7D8409ED9CCE5BBE900A2@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fd19c9-a949-4640-36ea-08d625685293
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 17:32:11.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1389
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri, Sep 28, 2018 at 11:32:02AM +0200, Alexandre Belloni wrote:
> gcc 3.3 has been retired for a while, use PTRS_PER_PGD and remove the
> asm-offsets.h inclusion.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/mm/init.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Thanks - applied to mips-next for 4.20.

Paul
