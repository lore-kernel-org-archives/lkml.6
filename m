Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551E9C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2255420868
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 01:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="IjV2gtpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfAWBeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 20:34:18 -0500
Received: from mail-eopbgr800091.outbound.protection.outlook.com ([40.107.80.91]:32183
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfAWBeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 20:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beKCi1VUWcccvXDOtLmYLzBCbZ40g5fb3qKe2NJ5ie8=;
 b=IjV2gtplnKhsaSr8Bis7OdkrMQgFS74r0065CAB72+6flnl3r+lYRR2gVWqBsPiwqx9+YPDHPvsjlhiAvVmgHQU1GaaLUaPq4Ul/xWqngYrPlTVWtHjoNEnhJ23hdEfcQIoldJZn4H/WpzBwb7reOVqjdXjMxuVheSk/1MTOxKE=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.216.146) by
 CY4PR2201MB1287.namprd22.prod.outlook.com (10.171.216.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Wed, 23 Jan 2019 01:34:15 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::f560:2a93:e4fd:f50e%7]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 01:34:15 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 0/5] mips: cleanup debugfs usage
Thread-Topic: [PATCH 0/5] mips: cleanup debugfs usage
Thread-Index: AQHUsmLqvXHpNOo1Ok25FH2VHUwLZKW8EreA
Date:   Wed, 23 Jan 2019 01:34:15 +0000
Message-ID: <CY4PR2201MB1272FAAE61FD55AB320AB0B6C1990@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190122145742.11292-1-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0036.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::49) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:61::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [96.64.207.177]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2201MB1287;6:DskdtVPnsYIDsJ6xS2WCkhF4Z5VUVWTU9xFWkTIpcG9QOxrZLZfzSduSHnqoTwHtI2JRGEGH72PEBbD7pnrFyHybosOUoZjio2wabHeRcHGJ6rq+iB5nLxUNKxmQPlcvtETmALgBRlOShY6gWw4ipObS0V8XBY+D4RWXNP6sIscJu7K5BY+yVLEMHc50Ky7meS3M+NQMD45YKa9JV+v8R0HWqYoN/pS+bycwmRNOccXDvJeLcGBxnCUWL6WdkoZX4vWLocLK0osH9dkscasb4isCW1w+CZ3iShg8iOPcOaC2rlewB1TePCF/1G5MKZQv62AGjJDtKgOm2mKxbasN1fhI3EH+VHZWirFnaUdgsU862HMUBMFXg9NR204sa7TUxX6okgFcai8mPFguBGQV73FcBJpFtjKGNORCEqd60q50g4TF9HArg1SSKOOm73x7QPUdtD4vwHumIPYwXJt2Uw==;5:R+EIAsUT7JmZOmJA4rykuhji7Hb4MU142L1PMREHTYXVwGa2dsacAaErfTXdU7nc8sib8/eVbqSNsntbsQWVIDHj2dSaF1k4qo+tzq1NE9G9p/tmo8YEoSqqfmYR/nM8JHYLUQd4vlJnFGCjHKTyJRkF6A+sxeWYLy0LuBoH7ipE1OJlbko7ETJZJhn6adeOWzoTQeJUOt+CbFH8Lnu9vQ==;7:cmG4OzYk9ySwus+DM+ED5qib0XxtuHR+F6g0gMWPjbVfx6jcf3M8XcNg+B1cPordovjmBwMH6iCB1ppHf9+Cmd6Y4zJPoU54ybRHyPsraZ6xw42Xv0tS4o/a+HUi8FDmc6aoQPzo1uwGrXOFYTV9VA==
x-ms-office365-filtering-correlation-id: d592108d-487f-4de8-c174-08d680d2e25e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1287;
x-ms-traffictypediagnostic: CY4PR2201MB1287:
x-microsoft-antispam-prvs: <CY4PR2201MB128794F583C34021600664ABC1990@CY4PR2201MB1287.namprd22.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39840400004)(366004)(189003)(199004)(11346002)(478600001)(102836004)(8676002)(386003)(26005)(25786009)(97736004)(316002)(81166006)(8936002)(186003)(81156014)(14454004)(6916009)(229853002)(7736002)(71200400001)(71190400001)(6506007)(305945005)(6246003)(446003)(2906002)(33656002)(476003)(53936002)(44832011)(74316002)(486006)(4326008)(52116002)(7696005)(105586002)(6436002)(106356001)(99286004)(9686003)(76176011)(66066001)(3846002)(55016002)(256004)(68736007)(54906003)(42882007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1287;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gX+F7MqNlpsTn2h8+vOMm++C6CJLBXI/hjyfQAv56UMNcK5m+lTgTutAzPLpoe22SuE9/q0XzuEI2FBwK/b1EXcbJjtnH1Ajrquw4c0ExZl8Y5QKBHc+ERN0B6zTARa8LAzm7FipJ0aWrP96AcPL6ubW32GQnA2ajv+7mVfIG5PndQp6mCXI3qm0dc7VH7at8HZLwV+hhwtdsq1bW7youD0flqnN6xUSz6Vg1RO1UQuBpC4WBOnofkuvxfPZ1Qe6bjgB3DCUcle8QuxNpmyeSKp/onWcOUO9sh4giWwBVuMLRMCjOrWBRzD3seXLH61CyHR0gDNbBZrhXlbWrci7TTbeTdrgDj2lT2a4hY+7PsfFVH78dci+rwRxZIHvLtf47sPsvajdBtI8DFBdQ6hBAbD+jqtXU6Oosl/u/FWCc0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d592108d-487f-4de8-c174-08d680d2e25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 01:34:14.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg Kroah-Hartman wrote:
> When calling debugfs code, there is no need to ever check the return
> value of the call, as no logic should ever change if a call works
> properly or not.  Fix up a bunch of x86-specific code to not care about
> the results of debugfs.
>=20
> Greg Kroah-Hartman (5):
> mips: cavium: no need to check return value of debugfs_create
> functions
> mips: ralink: no need to check return value of debugfs_create
> functions
> mips: mm: no need to check return value of debugfs_create functions
> mips: math-emu: no need to check return value of debugfs_create
> functions
> mips: kernel: no need to check return value of debugfs_create
> functions
>=20
> arch/mips/cavium-octeon/oct_ilm.c     | 31 ++++-----------------------
> arch/mips/kernel/mips-r2-to-r6-emul.c | 21 ++++--------------
> arch/mips/kernel/segment.c            | 15 +++----------
> arch/mips/kernel/setup.c              |  7 +-----
> arch/mips/kernel/spinlock_test.c      | 21 ++++--------------
> arch/mips/kernel/unaligned.c          | 16 ++++----------
> arch/mips/math-emu/me-debugfs.c       | 23 ++++----------------
> arch/mips/mm/sc-debugfs.c             | 15 +++----------
> arch/mips/ralink/bootrom.c            |  8 +------
> 9 files changed, 28 insertions(+), 129 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
