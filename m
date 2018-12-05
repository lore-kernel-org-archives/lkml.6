Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77066C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5BF213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJV447WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5BF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeLER7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:59:46 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:3072
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbeLER7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY8yRBBSE5BBymmR35/sa1FnkUAXicRrtcDEumoxqqw=;
 b=nJV447WMeyqD7SWubEIUDpyUB/z6jG4tG8nK1/ilaDMNxa6jq9pEmGCHSEuEDSSwbj/PujJukRF6qWww468D8KR2H1G22yKaQVvl5bvhQi7ANecrROoa+SkDUMIuqn0WpJ8mnevHbqkLfmJM0TE5v+71b0cjI7tdK8/rj1FVknw=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB5266.eurprd04.prod.outlook.com (20.177.42.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 17:59:41 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 17:59:41 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: edac driver injection of uncorrected errors & utils
Thread-Topic: edac driver injection of uncorrected errors & utils
Thread-Index: AQHUh0sNWF6V8PY2qUSDyCw1nmqn1g==
Date:   Wed, 5 Dec 2018 17:59:41 +0000
Message-ID: <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic>
 <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5266;6:kRoYOovWtDbeMI0TPUzx3WbUGzW9R8EtFxTQR4cLfshGFqykD/ymJEGPamIM4Wfgm9eRWpCL+3GIt10UqBuF8W4GJS6gR6pLPYV0aq4Ty08LtChoz3ZLCGItraotv77ezs5BFestUKwCULjm331gDAp9oDKmKGYzpEuutogKDwBQGTp4DZ5JMjRXl6lQ9i6i9w3NP2kG8LUUk/eJewHJA5Q7P+N6cwVXF7lnsdId3LjeyQCYYUJRT7cD8Qu8DEiGzcdgmeZph4JQZp0lTeNwJQh99jeQb4h4r/bTyCTHV7dEGMmXZENJtM1zF9LTN8gbdjhS5T7TPHnWLtSJ+qY/9IaKjN7mkN45lT2jB56VWYDzt5MPNQ68/aZKCPtkHs4TVoIrahss+PovvWiGTDPBhXURoNZqLHr0+B14QOVrA3CXrNICc4NOckF8z8u0zTOxzuppf0X6QK0+hoVocK9fcg==;5:1s2gSll3uA5kueZk8Z5y46NBwv+k9obhP8BS/Ph/bmB2sgZ/FJehTbHJ8zSPLCxBJgB2RUNGqzvumnha9GtTEwInTxRSeiIxxxJxXdOnmQp/yyAKA/rw4TXaA6ikLe6awtlYL7a1Q5e3tsFLcOBJISPTdHdC1Tx+yNUeg/1HB4w=;7:nWzIunBgY6jahj0WKiXNVQgV2Nx20j4Xe+ApTpn0TnzgXXWXulbS0WOboKNjLqW8DcyqT22wjGZjBhO3FzjkMWj6rRQhEOgHs5yJ6kgKd7eeQoq4sQQhwpoNvE/Q85XT9Xm9RX+8Y+fw0olqYwMVSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3ef7fa59-d5c3-4f0e-fb58-08d65adb6e4f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5266;
x-ms-traffictypediagnostic: AM0PR04MB5266:
x-microsoft-antispam-prvs: <AM0PR04MB5266DC87C1C77262668E4F679AA80@AM0PR04MB5266.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5266;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5266;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(3846002)(316002)(33656002)(446003)(6116002)(26005)(478600001)(110136005)(6436002)(54906003)(74316002)(186003)(102836004)(476003)(71200400001)(14454004)(486006)(99286004)(97736004)(6506007)(44832011)(76176011)(4326008)(66066001)(39060400002)(53546011)(2501003)(305945005)(7736002)(7696005)(71190400001)(81156014)(81166006)(8936002)(9686003)(8676002)(6246003)(2906002)(25786009)(53936002)(256004)(55016002)(68736007)(86362001)(229853002)(93886005)(106356001)(5660300001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5266;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9LqnDIzqEHzSf2wbGJ+Vwl0EpS3UNeolYaWWxrATiEWDjmUzsw4jt/uuTPFMSOnMhZZXcIPrDITjActfg5WHPtBpfGC6L0Q1EejbutxK47k+d+ZDPdBQDEeoEHg9T4pWPV22xp1lddkegu0ApKPjHQmXgjZgc9KvaTxFTMlpBw6/SXSlI0KeLwrOrCTsp89Ddsprnqbb+XsMT2u6VkKu41v0aDNmZB+agjy6jwQFO0K0cRty9KVEF2AEfg8aseIUjgG+ed7byNpWTR58AZWlBZZkHgOnl5LeApWfDuhawkYUNdG7xJTM6NCw7zBcF9CE98HyO0bpwLFmj/AOTWjq6i1GAe8VCExZZ86cGPoPGbM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef7fa59-d5c3-4f0e-fb58-08d65adb6e4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 17:59:41.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 8:38 AM, Tracy Smith wrote:=0A=
> This is more directed toward York for layerscape. I see some edac code=0A=
> that seem to do periodic scrubs based on intervals or scrub rate, but=0A=
> that is not needed for the layerscape driver to correct errors because=0A=
> errors are scrubbed when found by the edac scrub block or is it=0A=
> because the memory controller itself does the correction/scrubbing=0A=
> when an error is found?=0A=
=0A=
Single-bit errors are corrected by memory controller without involving=0A=
software.=0A=
=0A=
York=0A=
