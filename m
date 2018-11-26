Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kHtkYZPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5244E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeK0IxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:53:15 -0500
Received: from mail-eopbgr20135.outbound.protection.outlook.com ([40.107.2.135]:43568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbeK0IxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CSDt8LUuF40fJFttK5oiHM0poaqbAPfL6iMqMnQ74U=;
 b=kHtkYZPFvL1GdC857MDhPESbaWvrO2ZsVqBoWHak8SHg+qAk6enNmfRWQxblQOZRn/+WH2tRn5OBFMx1gNX9YiNJMWJO0dbFDJO9GDXqtbL9vgbYZvPB9Rx2oR+s85wDtqbZ9Qo2iEYwtUcETEWr+AUCPIB0D30e/V51wo6/OX4=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2414.eurprd02.prod.outlook.com (10.168.64.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 21:57:36 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::8de8:73c4:92c8:6c22%8]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 21:57:36 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Subject: [PATCH 0/2] add config option to center the bootup logo
Thread-Topic: [PATCH 0/2] add config option to center the bootup logo
Thread-Index: AQHUhdMKyLUqi6xXOEWrIib9lapb8g==
Date:   Mon, 26 Nov 2018 21:57:36 +0000
Message-ID: <20181126215725.2548-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2414;6:0+5XoVC8+kIU9NxO3f3IAzxn35GSJmA7gLgKRsum8T29ZyW5qzzfrtKv6JVIn4AtU0oyCAiFA1qZZuNim3+lVELye06Ux+RgYCum2A4Gxn/87wmdDSVRGHGXDB51EYUYcDZncOALm943NSnqGthQ8wOugtgdVn5OVEFQeI+M6I5hIgdRsSePZH+h9P70dSycDo4wUssyzoreTSHSz8M/0YxAQReYSqdamqQ5fkmbppdNQk4KomB2JPA8IAwseGp1V/7JEDJLCOPrC1sqMt37aj8XxqLUkbj3ZMYl6BfS+Wo5MIPKU1ksVd1D+0Usz0uruYt00txmfHQ2L7LBs631shEj8Fy2vVRM4TgG9/95fykhudDvv9sLof1XLkaetoMQEEWPY3h9hs3l6nwvCbF9qPAXJ814LC3QahPPsh7lbIuf3lFlS9Vy+EsozHjHSDoWzQxFxqaZge4Uv4i2iCd5NQ==;5:DSWFdZ0VOp2qLsB0hOACirOA4xzzD9NS6/VatW6Lm9Dubr9Iiy0E+3EtyJ0zpCJDxx4RQ//dB5ZwZiadgc+MvBIaZ1j9BN+dPChC1LFCl/RqxgPtNlis5HN3CanIcewYe0G1ZB00spy/n1hcAH69FOuATCAPAwK4bzd3snQ6qq0=;7:Bot2ZhIMo5t3IBUBmDle0q5HJr1AaHnHCknKbpRDF3DzCXoIgmUW5W7JeDf0v9mjcG7x1QuW1TGIizge67UjQROuFCPZ7Qb7V4uQL0dWbhXXPTw0mIRYF71oyCNoTnFuol3VyDXiVaOyebGH3D1KxQ==
x-ms-office365-filtering-correlation-id: 6b67a6d2-c23b-4a6f-a0f2-08d653ea2cff
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2414;
x-ms-traffictypediagnostic: VI1PR0201MB2414:
x-microsoft-antispam-prvs: <VI1PR0201MB2414BD6488A1B751FD21ACCFBCD70@VI1PR0201MB2414.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231443)(944501410)(52105112)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2414;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2414;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(346002)(136003)(366004)(199004)(189003)(6506007)(386003)(7736002)(68736007)(99286004)(305945005)(102836004)(5660300001)(3846002)(6116002)(71190400001)(71200400001)(86362001)(36756003)(476003)(66066001)(2501003)(52116002)(1076002)(2906002)(74482002)(2351001)(316002)(6916009)(6436002)(14454004)(54906003)(4326008)(6486002)(6512007)(256004)(5640700003)(508600001)(53936002)(2616005)(8936002)(97736004)(8676002)(486006)(186003)(25786009)(106356001)(26005)(105586002)(81156014)(81166006)(50226002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2414;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LtpJove7w4dSQP8GTSPywXHEoDuZZDu+dV5mjxVBxyw66kvOat6k9bdy2Xbnc9DzKOB8cqw9N0zqSjbQ7LM7rhKbH48rwyq29hy3wpf7BFTI16AoIDkbQPmnZmwkEuHS9xIGuaa3vMJ5m7QCKi11lWjXHSDd1FhEV+jpvfPk/P5aPvWEzL6IBZJ4ygymBg0fcr2Qa4VDkvuMVfJ06ypGwoG3NYA8aT9jEdJLrcTT4gXv70lSLN28DOZ62hxlzUb3RlFEWlzXoN8+vN16MBVsHq//2uWw9e7Aicnaa8BTAYxQAh4a1cDIvVfC8/EVkBgrT4ulwXvjPZuy1L+Fm/HcG4doYTKyyjRXv+3ZKoL974w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b67a6d2-c23b-4a6f-a0f2-08d653ea2cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:57:36.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm using these patches to get early display output at the center of
the screen. Maybe someone else will also find that useful?

Cheers,
Peter

Peter Rosin (2):
  fbdev: fbmem: make fb_show_logo_line return the end instead of the
    height
  fbdev: fbmem: add config option to center the bootup logo

 drivers/video/fbdev/core/fbmem.c | 31 +++++++++++++++++++++++++++----
 drivers/video/logo/Kconfig       |  9 +++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

--=20
2.11.0

