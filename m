Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF03C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747C1218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="Hw+YlL5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfAaK1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:27:18 -0500
Received: from mailout.micron.com ([137.201.242.129]:60518 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfAaK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:27:17 -0500
Received: from mail.micron.com (boexchangeum.micron.com [137.201.21.209])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x0VAR9OF025177;
        Thu, 31 Jan 2019 03:27:10 -0700
Received: from bowex36d.micron.com (137.201.85.223) by bowex17a.micron.com
 (137.201.21.209) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 31 Jan
 2019 03:27:09 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36d.micron.com (137.201.85.223) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Thu, 31 Jan 2019 03:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5PcXKGn2LxevR3F9NdZ0MaXVtUKWfq/xRHmgq95EDs=;
 b=Hw+YlL5CujmOxVfJqyhDidSSN28HGTUXNsqWkMwBLhZYQY38tiwjtc6bg9bNs2XafVBvRuUftRoSD0TA2Mxn52myEOH55l6Irb7pUQa3V3s7nP8b/7/4/r2csTHTJiaRbY8EN8iCu0L6LLwtKyDuO+M1MASm9vfPlYD6CtYYCLw=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4741.namprd08.prod.outlook.com (20.176.255.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 10:27:02 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%2]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 10:27:02 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
CC:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: RE: [EXT] [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Topic: [EXT] [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Index: AQHUtg8oR+N9rA0U5kyng+UGpHaTn6XJKbGQ
Date:   Thu, 31 Jan 2019 10:27:01 +0000
Message-ID: <BYAPR08MB453315E3E66C8FB0E6E89094DB910@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
 <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4741;6:lP+s9a5XXIczpz59JkDX1FRt8hhf/Tb9VAc5vBd3g+RIn0+3rgc0yrQYxaZo7xafKjlBTJrb2lHgV2maqLU59LKoHdJPBqBqt9yt4+5I/wOnlEvXn/1DsUT8RkKTYCpZ5YffNZ+i6JVzkjDX+De+O5HUIR+dRh8x1qNDUGHsHuc1fVuIqKylrjjiTo90/USfV/MQNJFTvucJVgls56aG8O39I6dYls5YT+vRWPiN1VeNDt/0zh+pdZiyVeY9CYoYsSFzttMzwtOV8aL8cO2nvIBpGxKsk37JKqSfmxVN2DMX6rWJjsxva76MKT51ZQDcxzdy+qIfwu/hH54+TG25dcTRytEdBLyhr2mwKZohICHFup8dz0D+4Ild/dj8IznesmiNzTbtJbUv7iXmcXZuXCwzdUAMZu6zFoDNFMVOkFZRXd7v0axFamUJYhjiu54Oz7e+cn/ljkjwLCZ2sZkgCA==;5:FSdgpbrkIrdHySIwjTCJKK1/H1/F2Zq3z1G0EiSv13kAGlKC7SGsHvrntEAfYq77x27qxY+h6aqbN6w1N0veI74FlA7JST6INULw+Q4qFvc3nDv46JrquN44N6xhiLe2GjaOw91NaUcIlBukvvE5lw1Qdj0+42xvFkhk8lDiSxt3zRo0gEss70L9oFSmRwEExcXE3LiPY7F247iOb2jE5g==;7:1cUwxGnwi7QV8WkQjXoqIXmuxkMH2/KWrymIdLE9BKOcZxgr71W+iXb58Qbgx67Oua4XSqIYosvevgQ5cN6FsW7OhpWq9pcAKl2uhToVzsgv+eNBvpnO9Xma5t/9mY+Xq5whUBXk3QC7+FJTXUc2UA==
x-ms-office365-filtering-correlation-id: f21bfe36-4b7c-4018-1f05-08d68766a398
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4741;
x-ms-traffictypediagnostic: BYAPR08MB4741:|BYAPR08MB4741:
x-microsoft-antispam-prvs: <BYAPR08MB4741FF53328809F9C6730166DB910@BYAPR08MB4741.namprd08.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(13464003)(76176011)(66066001)(6246003)(3846002)(9686003)(478600001)(33656002)(6116002)(99286004)(7696005)(55016002)(14454004)(53936002)(2906002)(81166006)(81156014)(110136005)(54906003)(316002)(106356001)(8676002)(105586002)(305945005)(97736004)(68736007)(8936002)(74316002)(7736002)(4326008)(71200400001)(476003)(2201001)(486006)(14444005)(229853002)(446003)(86362001)(11346002)(256004)(186003)(4744005)(6436002)(102836004)(6506007)(55236004)(26005)(2501003)(25786009)(71190400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4741;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0PCgTObT6iBoV3LlVwjG5bCAbO8Ni2zJN9BsawLs3enx7KoWV9bUQGEGg2uwHkTqExDSDjp4IszBwvjRpZ6/j8i8DM7wYmxbqgKBs1Vqwlgr1LlXnuX0j1guTCS4ErNvzdnFVo6n/25fWFBNh4FegNL7PCETtKUey+B7880vxXqqiN48GJ8jh33bX7UqBcFSKdBY3bl40p5kTpPYo8mWMy2co2zN+6Ta3NwnqadqkMb/xxEs6pRHNMGWbRlLzAHRfpH1wmBVmVQuVzdeFP/e2kv474Z7BHl16sYGt6+8ev4qbKenmiH1tTKblAr9FyqK5U4mLw7PzcRScULwp7MLxY0bG5kiJQv4hzlRQGswQvKje5TwUSs+aCYKuYm+kn94dl/fyoaC0hsE9eqBDakz9WGO3OrZa9nAxS3n541XYbI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f21bfe36-4b7c-4018-1f05-08d68766a398
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 10:27:01.8812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4741
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24400.005
X-TM-AS-Result: No--5.160900-0.000000-31
X-TM-AS-MatchedID: 150567-157008-139010-139006-700648-704287-703523-701960-7
        00574-700416-850702-106660-105040-704421-702598-860560-700398-700293-707163
        -700756-701475-851106-148004-148007-148020-148050-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
>owner@vger.kernel.org] On Behalf Of Avri Altman
>Sent: Sunday, January 27, 2019 8:08 AM
>To: James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen
><martin.petersen@oracle.com>; linux-scsi@vger.kernel.org; linux-
>kernel@vger.kernel.org; Evan Green <evgreen@chromium.org>
>Cc: Avi Shchislowski <avi.shchislowski@wdc.com>; Alex Lemberg
><alex.lemberg@wdc.com>; Avri Altman <avri.altman@wdc.com>
>Subject: [EXT] [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
>
>Add this functionality, placing the descriptor being read in the actual da=
ta buffer
>in the bio.
>
>That is, for both read and write descriptors query upiu, we are using the =
job's
>request_payload.  This in turn, is mapped back in user land to the applica=
ble
>sg_io_v4 xferp: dout_xferp for write descriptor, and din_xferp for read de=
scriptor.
>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
