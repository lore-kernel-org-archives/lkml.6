Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746B4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175EE2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UIBSsr7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175EE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeI2OKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:10:39 -0400
Received: from mail-db5eur01on0062.outbound.protection.outlook.com ([104.47.2.62]:46304
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbeI2OKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6dMqTKGETSEoe8/9eospBmbLtvNwUBctmZ6gbY9+94=;
 b=UIBSsr7rlF2Wl2b1grKop6S/ewOFAis0MDs9hBVMCNCqg80bWrZIxKMbT4PitSQsB64uSiDDu9bvHSJgj+OZk/cMg6Ujn42hWE2S5RatClRCmFDuKYCdYiaqdXr4tFrxxEYsUEVdQ1lxNNByY5RLXnb6SA2nsZ+rsgwiw6sKuTg=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB1741.eurprd04.prod.outlook.com (10.165.234.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Sat, 29 Sep 2018 07:43:10 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::984e:2d7e:1a9c:c1b9%7]) with mapi id 15.20.1185.022; Sat, 29 Sep 2018
 07:43:10 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Topic: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Thread-Index: AQHUVlODYLzUr6TXRkCk3Aso2dGK1KUEHlyAgAEqd6CAAZdY4A==
Date:   Sat, 29 Sep 2018 07:43:10 +0000
Message-ID: <VI1PR0401MB2237D7CB808A32E3173F61C4F8ED0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB1741;6:VLJmd5vGMuU7YfVXZn+XX+Xe4IT9WkkcsqiJWSu3etwewPkMOqyxOgdW4iJ1bPJMDBXifzGNIRa0dLpKWd9aA+mYMZ8PmaWzJHFMlLU7+weLISFWfEMNRtDqW8gtrOnoQGeUMLs8LGyMF7RtG5RJOzN31cj6kUmakmTKqOnw/6uRqwTdW9lg/tD3f/0t1hKY1RJe5enF9Xqps8OejmSNXhmN91VVMfGniC5sI4enBX6vGiq4yKNqJLOfD1zUUh6eS02S6ebuQCCrzpNnt8V7fDZX/1SJGTsqLn78NkL/Y+dEXAO2K58Fi8WT3JaBtcGqkiaL09CI6nGmk6wzdpfebZUbfxZGgbPhio2zWh2IgKwawD0E9qf9iXaFYXkirKKzJVCLUpcOzeKLkt06l9qBk85u7V168WfweBh4zw0SugKEh8cLIFsLbos26GKcIEQh4bdvFvhuJYeoi05BylYWhg==;5:JKOWS1ExB9kqCZwoRtClRHXpD11WIXnwjUKj5HLAJUmbv/WnkuMxpL8jG2YLcs5z71X5iF1VoQuHxipWBH+x9Dmjpzw8fRYnEnTbhSXh9nd29V3XnKU5bUGwdneYhVYW9HLdpPa6PlsxWylYuEvt+uBOaW5fvvhctsSWKBXlE0U=;7:DumKLCpa7W0P3h0MmLa9JU8QSsSwJ1obQdnk5X+sGMElzGh9jjC8KMJ1wdvgJGIRRdLXgIIdmKk9gp/Xh6rpm2CqcWAaiGtDlTW9wCVNTozY7eLzHr9z7LTmq2S3J57DOCfEnGm8uvwJaYIyVuhRcNrs4R/XbAbmBHeTu4+Pl5wd/jC8L5y/WXAVuqWuGnmAKje3bEPaUREOxbT/aJRrOP+5ct+NOYr4cRuH2UGC8+QlnJ3aotZIhbbaWsDqa+yH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f43330e-25be-4fa5-73d4-08d625df343e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1741;
x-ms-traffictypediagnostic: VI1PR0401MB1741:
x-microsoft-antispam-prvs: <VI1PR0401MB1741FCF4DDD25F01BB1A09FFF8ED0@VI1PR0401MB1741.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR0401MB1741;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB1741;
x-forefront-prvs: 0810818DA0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(136003)(13464003)(189003)(199004)(53754006)(5660300001)(478600001)(39060400002)(99286004)(106356001)(6916009)(7736002)(305945005)(6246003)(97736004)(2900100001)(105586002)(6116002)(25786009)(71190400001)(3846002)(34290500001)(71200400001)(7696005)(86362001)(4326008)(76176011)(8936002)(8676002)(486006)(81156014)(2906002)(53546011)(33656002)(6506007)(102836004)(54906003)(186003)(26005)(256004)(53936002)(14454004)(74316002)(9686003)(68736007)(6436002)(316002)(476003)(229853002)(81166006)(55016002)(11346002)(446003)(66066001)(5250100002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1741;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r0XU/pkJ0Y92gCiAIn+8kLi4GkWYUaynmbMryG58wK2y3NZGhqDpr33RbVT8rwqxuIhAN4D8xlHBbsmAcqOjE5KQR2aS618+hTUHJPbT79cUkGjSy4FSJyHH6Pbw70dwoK6txzT9Z4K0lmEaKfYJ5y5nShEmLnAWxgXZHs2Jsi9UxERfak6QtcVeLgCPQN2iNm4306ZzB0Q0vO6Jb1QmjHa0gd6QCqkHh4mh3R7+ZeEVOiv9vRy+BAJYbgQ0jWm3U1aLlkKlPDm6km0jnePNVsWLYZ3QY6XSU+suPFcJC7L1aMyLC5Wgxj3TH2TW/7nuMA1CCQG4TN9xRHqAhYc4Gu4anAVkHBJtbbNEFlOuvaQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f43330e-25be-4fa5-73d4-08d625df343e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2018 07:43:10.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Sent out the v2. Please help to review.
Thanks a lot.

Hi Andrew,

> -----Original Message-----
> From: Y.b. Lu
> Sent: Friday, September 28, 2018 4:04 PM
> To: 'Andrew Lunn' <andrew@lunn.ch>
> Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>
> Subject: RE: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging=
/
>=20
> Hi Andrew,
>=20
> Thanks a lot for your comments.
> Please see my comments inline.
>=20
> Best regards,
> Yangbo Lu
>=20
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Thursday, September 27, 2018 9:25 PM
> > To: Y.b. Lu <yangbo.lu@nxp.com>
> > Cc: linux-kernel@vger.kernel.org; devel@driverdev.osuosl.org;
> > netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail.com>;
> > David S . Miller <davem@davemloft.net>; Ioana Ciocoi Radulescu
> > <ruxandra.radulescu@nxp.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>
> > Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of
> > staging/
> >
> > On Thu, Sep 27, 2018 at 07:12:27PM +0800, Yangbo Lu wrote:
> > > This patch is to move DPAA2 PTP driver out of staging/ since the
> > > dpaa2-eth had been moved out.
> > >
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > ---
[...]
>=20
> > Can rtc_drv be made const?
>=20
> [Y.b. Lu] Will use const in next version.
>=20

[Y.b. Lu] Sorry, just found it couldn't be made const. Warnings showed when=
 built with const.

> > Is rtc.h used by anything other than rtc.c? It seems like it can be rem=
oved.
>=20
> [Y.b. Lu] Let me remove it in next version.

[Y.b. Lu] Sorry, I still kept that header file since dpaa2_phc_index need t=
o be declared.


