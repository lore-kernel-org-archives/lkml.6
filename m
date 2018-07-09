Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B24C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4A208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF4A208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeGIE2z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:28:55 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:41163 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeGIE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:28:53 -0400
X-Greylist: delayed 1606 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 00:28:53 EDT
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id E6025AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 04:28:52 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Jul 2018 04:28:52 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G9W8672.americas.hpqcorp.net (16.220.49.31) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Jul 2018 04:28:52 +0000
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 9 Jul 2018 04:28:52 +0000
Received: from DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM (10.169.86.139) by
 DF4SPR00MB011.NAMPRD84.PROD.OUTLOOK.COM (10.169.93.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Mon, 9 Jul 2018 04:28:50 +0000
Received: from DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::54e9:f706:bfef:bd7d]) by DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::54e9:f706:bfef:bd7d%7]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 04:28:50 +0000
From:   "Arackal, Paulose Kuriakose (STSD)" 
        <paulose.kuriakose.arackal@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Query regarding Spectre fixes - IBRS/IBPB/SSB...
Thread-Topic: Query regarding Spectre fixes - IBRS/IBPB/SSB...
Thread-Index: AdQXPQF1JiuRQacUT3KgKJJQdm0HUw==
Date:   Mon, 9 Jul 2018 04:28:50 +0000
Message-ID: <DF4PR8401MB08890C669B2EE304B8401C35B8440@DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paulose.kuriakose.arackal@hpe.com; 
x-originating-ip: [16.242.235.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4SPR00MB011;7:dlkknR7heF0GV06BmAcF07VMseTZJoAwULnOjA7DPIdtqOtRzOiSroPTH2oFGiGlT1KMZygWOHeYrA9RWKXMI7HJC4n8m4yrPKwUDpwmPMj7KTKUzizKzyYPtVZ8CSP23tTGM/KgnuDbK9T46c09spLhsA+Tva0u2s40j2+NFKZp4J11yTGPjR7EuMWG5ZrAfl10GyqS/Npi/nDmIHerDBLmP7lQTB4Y0Ujwxb/X77EL0EJxsKPLLxH4xo6uXdAG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 997dc6fb-1308-4a66-900f-08d5e554789a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DF4SPR00MB011;
x-ms-traffictypediagnostic: DF4SPR00MB011:
x-microsoft-antispam-prvs: <DF4SPR00MB0118D2AF3365BB10F5785AEB8440@DF4SPR00MB011.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DF4SPR00MB011;BCL:0;PCL:0;RULEID:;SRVR:DF4SPR00MB011;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(14454004)(6116002)(478600001)(2351001)(5640700003)(2900100001)(3846002)(6916009)(6436002)(966005)(5660300001)(6506007)(102836004)(33656002)(186003)(26005)(99286004)(7696005)(68736007)(2906002)(106356001)(316002)(14444005)(5250100002)(25786009)(105586002)(97736004)(256004)(305945005)(7736002)(53936002)(74316002)(476003)(486006)(66066001)(2501003)(81166006)(9686003)(6306002)(55016002)(8676002)(81156014)(8936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4SPR00MB011;H:DF4PR8401MB0889.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: F3dUnY9AW3TtO3OH/wNsDm0NZwsjMO6PcW2XvyEKJszhj/gmuUrTIakfTVuPk7GWH2KB4iH4p0VclhCqXF7ZtMi477ciC74toMbh1CA21Snu86QWeBTUxDSWTL7S1sehrPHjLTirRczjgXQRQQ0TlHl8nWm880TbO/yqHBAVMhgiW4AteO+W1ELzt6xHMh4L/PCk1ISiwgPYlLiECjw8mnDnM7by6kvE/8BxiE3DG9rz+NIXYO+yrOKezdQef9WC1FVlWRvWnjMQWzzVZMVUkWB2e4sUqdYsGbafSJ5xQCuNMjsOoraxEZBsRpzbCIiTRG8cCwMSXXHQ9SnvsAmfzzTpbxFWM3BvfhP9kdvG65c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 997dc6fb-1308-4a66-900f-08d5e554789a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 04:28:50.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4SPR00MB011
X-OriginatorOrg: hpe.com
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2018.7.9.42116, AntiVirus-Engine: 5.50.0, AntiVirus-Data: 2018.7.9.5500000
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1400_1499 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FROM_NAME_PHRASE 0, URI_WITH_PATH_ONLY 0, WEBMAIL_SOURCE 0, WEBMAIL_XOIP 0, WEBMAIL_X_IP_HDR 0, __ANY_URI 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_XOIP 0, __HTTPS_URI 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_URI_TEXT 0, __NO_HTML_TAG_RAW 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NO_NAME 0, __URI_IN_BODY 0, __URI_NOT_IMG 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0, __URI_NS , __URI_WITH_PATH 0'
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been tracking Spectre related fixes at Linux kernel 4.4.x LTS branch, for some of our products on this kernel version.

One thing I noted is, some kernel fixes are added at upstream kernels 4.16 and 4.17, related to IBRS/IBPB capabilities and SSB fix.
Few of the related commits listed below:

    x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.16.y&id=df35c3e66e6da210fed4a011722644cf1de590dd

    x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support
    Expose indirect_branch_prediction_barrier() for use in subsequent patches.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=20ffa1caecca4db8f79fe665acdeaa5af815a24d

    x86/speculation: Use IBRS if available before calling into firmware
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=dd84441a797150dcc49298ec95c459a8891d8bb1

These changes are not seen backported to 4.4.* LTS. Have few related queries:

1. Is a microcode update of IBRS/IBPB/SSB fixes alone good enough for cover from the vulnerabilities.
2. Are the kernel changes as above a must to utilize IBRS/IBPB against Spectre vulnerabilities.?
3. Is there a plan to back port above fixes to 4.4.* LTS branch?.

Thanks,
Paulose.
