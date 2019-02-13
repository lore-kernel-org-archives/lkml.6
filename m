Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17345C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4807222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="lZqrL6D5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392729AbfBMQ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:29:16 -0500
Received: from mail-eopbgr10115.outbound.protection.outlook.com ([40.107.1.115]:57173
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732888AbfBMQ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0M0XSAmRXqKxkyrl6/lasSGTctU6T200qMFkEsaLRg=;
 b=lZqrL6D5osoPW1WAoBidQgNNmvkrgKjGz+0ZQ51V6iW2rBKeq5md29ZQcXVyLt+9WMenNzv5MgaTEXnnBWdhwiq7wOKa8B+6XrLQHweWw6Qo9WRewACPSQw1xDTMxd34QYN1s5MTDVky5mQIPiRg/DUGZlkCNfUao8JCAPDymBk=
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com (52.133.6.141) by
 HE1PR0702MB3721.eurprd07.prod.outlook.com (52.133.6.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.13; Wed, 13 Feb 2019 16:29:12 +0000
Received: from HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128]) by HE1PR0702MB3675.eurprd07.prod.outlook.com
 ([fe80::b49f:d20e:88d4:128%6]) with mapi id 15.20.1622.016; Wed, 13 Feb 2019
 16:29:12 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.14 0/8] uio backport fixes for 4.14
Thread-Topic: [PATCH 4.14 0/8] uio backport fixes for 4.14
Thread-Index: AQHUw7lA+gqYmN8I3UWRTPZhFsXzaw==
Date:   Wed, 13 Feb 2019 16:29:12 +0000
Message-ID: <20190213162845.11688-1-tommi.t.rantala@nokia.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-clientproxiedby: HE1P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::29)
 To HE1PR0702MB3675.eurprd07.prod.outlook.com (2603:10a6:7:8d::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d7a1176-8327-4a02-2c9c-08d691d062dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:HE1PR0702MB3721;
x-ms-traffictypediagnostic: HE1PR0702MB3721:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;HE1PR0702MB3721;23:lN6rG5aWCAnR5bND0hqNe+CDgV03Ax36eqWUW?=
 =?iso-8859-1?Q?KsSesqsi42vXUJ2z4qJKDKscr+1IONwPLK2Z7tyyJ632WqYkVOa12IowCg?=
 =?iso-8859-1?Q?lBx+Utr4E+Wylq2rZP+iDCUDQLZsYmaUdQl0pZK02iUe3OeiDVM8tN9icj?=
 =?iso-8859-1?Q?9rMxIr8G3Ivx/ToudsH4zgOkuyQtgUAe66Fy4YvSyV+Se3CY/tNrAfwJau?=
 =?iso-8859-1?Q?TVpcj2Fc91ktDpl4LxJjSGyF6ncVXEgtIgkrIH2hlgaxN8oE/8LsjUJcK+?=
 =?iso-8859-1?Q?PcXxd779qJ+dXJWk7Ekgl9luNf7DKh8PM/++6aRNbEWML3aAQS2kq79Uuc?=
 =?iso-8859-1?Q?FKfesy/nhg6aZCJrCJ79K32uJw9HrD2f17ciDIYg9zCa4I4gUyBiBWuSn0?=
 =?iso-8859-1?Q?d7BhJxoYurVvdPbLm/eUXE/o6BD/1xkDSYHisOEgc+a+uvWjKbAPCGF4Pb?=
 =?iso-8859-1?Q?6feblGVW2AebtwQGjFPahoyRhr7pWJjCOc8ZtNSynFM8Ixc+C8MIVH2sZM?=
 =?iso-8859-1?Q?gZGCieQ80CwXKLceFqJiI/8Q7WoQsoK7Q36kTgMWVIB9bx4XiNr6X4RnA/?=
 =?iso-8859-1?Q?wNkSuv/mTrn8qnmWr7jH/6Iwb3noD/VEKrk+ZHJa9AYZwC367LLdE8yjIv?=
 =?iso-8859-1?Q?vHQ0BVQZbvARQ0mz8GsNgcb3LONj0k1b9KflXT/cjYjtFPQk9dHip3cbw2?=
 =?iso-8859-1?Q?mH+UUAXtsv1/T5ojc3Rt9FpEse653R13nNow4FyE/OYPa69KumQQQ3nS3j?=
 =?iso-8859-1?Q?kYyTB0mWEWzwLDEFYYfMimAQHYLvHUTVoWtmSBQDVw1sVhPhq+txf1lUOQ?=
 =?iso-8859-1?Q?p3A5k3QSpHIEA3815a0aqwuGghUvrTNDkxQ7CyByGOUH6jn3eWkZZta7d8?=
 =?iso-8859-1?Q?Cuwk7/+EiTYKZb0aMd78sQjnNwTJ574xiOc2mtoZYEAcy79CAEBCypEIhP?=
 =?iso-8859-1?Q?Jici/aQJaQnxwJzxzOld256SrUeCHDBhAUucbUJzvleOL1f7TQYVuGEJCY?=
 =?iso-8859-1?Q?Gbrz9TZ8zGSA5HCbC8Q7DGEmwjlqgxdmBEPX3lgnJ1TO2cFyQBobMzR0Wu?=
 =?iso-8859-1?Q?9wErRoDTO7vTKfShjKpQW2nFoUgdy0szonJXqVLn3Be6wDuG/x6B/W82gw?=
 =?iso-8859-1?Q?wGZ7879zXOXUpd0u4IXgG+mhwvd9+Oz0DMaFECPqW1ItCdygBmlY3NUgqe?=
 =?iso-8859-1?Q?VmLyZEDtfCiWi7IShyb1V/UeHjFpvzEThnU4X4Qw3+y7Sd9N3si1+l9l6d?=
 =?iso-8859-1?Q?Hz7MmqLqVr4dHbEr/zHFJ3uWMxS7lcjDCgOVkG44n06OUIkZlfGisjXdtD?=
 =?iso-8859-1?Q?OUjkyOtP+aJEIkCbzd7odUOCUoCS/YbYWm5HSmVLg0TN3eLcvmDdeCjXZk?=
 =?iso-8859-1?Q?Dr3QGaNWKk=3D?=
x-microsoft-antispam-prvs: <HE1PR0702MB3721C18DC46CD055B5C15954B4660@HE1PR0702MB3721.eurprd07.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(2906002)(1076003)(68736007)(71190400001)(71200400001)(486006)(4326008)(4744005)(8676002)(450100002)(478600001)(5640700003)(81156014)(1730700003)(97736004)(6512007)(81166006)(105586002)(6486002)(2616005)(476003)(6916009)(106356001)(6436002)(2501003)(14444005)(256004)(36756003)(99286004)(186003)(386003)(2351001)(66066001)(50226002)(14454004)(8936002)(54906003)(3846002)(305945005)(25786009)(53936002)(102836004)(316002)(6116002)(26005)(107886003)(52116002)(7736002)(86362001)(6506007)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3721;H:HE1PR0702MB3675.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SYaHJ9R0ctVn1YtEuqe64yGhrglCCzaRhwYQZmNe7m1OGNORKHIHiyIGzqTg39zyzYZwvhAvsRGWLoOxf3LgDZ8kbgfEVvV2nN6coTNpEC6ih2BAzoz9mgJKil4MIYNhbl1v/oHKImj5plIkeYcy25ucYRMpimBjxIOahhUIetdYqDJozAKwDcv1VBOBUecCjNMHjamyugqojgVgkB3TRF32WbZjVzfJvMSTa19XHlJTKyeDImWYhwNsByXgrahha39IgXNpdIMWyVSsJfreNtEJR8R6j9Wvm4w/2DbIO0DWWN6Az9IyvKd1HcTBEiM9kTlfI4bV7OyVzm3NJoyHzh8yBFPXQTCNkVRreCZzedeI0/3yCeOy8qr2QdIJO4clNthztvhpsIU6YtiXNcZjKbxknRBvT+rmwzo25I9dVko=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7a1176-8327-4a02-2c9c-08d691d062dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 16:29:11.6400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backport uio fixes to 4.14, to fix use-after-free memory errors.

Changed __poll_t to unsigned int as the former not found in 4.14, and
resolved some patch context conflicts.

Hailong Liu (1):
  uio: fix wrong return value from uio_mmap()

Hamish Martin (2):
  uio: Reduce return paths from uio_write()
  uio: Prevent device destruction while fds are open

Xiubo Li (5):
  uio: use request_threaded_irq instead
  uio: change to use the mutex lock instead of the spin lock
  uio: fix crash after the device is unregistered
  uio: fix possible circular locking dependency
  Revert "uio: use request_threaded_irq instead"

 drivers/uio/uio.c          | 206 ++++++++++++++++++++++++++++---------
 include/linux/uio_driver.h |   4 +-
 2 files changed, 163 insertions(+), 47 deletions(-)

--=20
2.20.1

