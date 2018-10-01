Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F291C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED87D2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dxjwGiCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJBGBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 02:01:03 -0400
Received: from mail-eopbgr40102.outbound.protection.outlook.com ([40.107.4.102]:17040
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbeJBGBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 02:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2KNZAm+OA0ZQXcWLA8BzV/hcebFUqEjBK3sBd4cZOo=;
 b=dxjwGiCXejJ8I3AyVCrj5YWxnS03ztPtSQmMapdGVSCA6tu0A6mqtNcFUQJuiDzbQPmRwcxR4V7QXtbgxVjNa4kGx0DZmJOhLyOtMftcCnugN9+NwR3WYzVMgzKH6gEuni+rUlXKiRWddmnYQgTgPWhoNbZGSwaZHxiSLwzX4Mw=
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com (52.135.164.146) by
 AM6PR08MB3525.eurprd08.prod.outlook.com (20.177.114.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Mon, 1 Oct 2018 23:20:47 +0000
Received: from AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::a458:ca6c:fe4e:fc39]) by AM6PR08MB3253.eurprd08.prod.outlook.com
 ([fe80::a458:ca6c:fe4e:fc39%4]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 23:20:47 +0000
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "criu@openvz.org" <criu@openvz.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [RFC 00/20] ns: Introduce Time Namespace
Thread-Topic: [RFC 00/20] ns: Introduce Time Namespace
Thread-Index: AQHUUFpuovisR+B/R0ChKHU4yyCZyaT6rFafgATOTICAAIlk1v//x8cAgAMSiTyAAdN9gIAAA0KAgAZk6gA=
Date:   Mon, 1 Oct 2018 23:20:47 +0000
Message-ID: <20181001232033.GA31324@outlook.office365.com>
References: <20180919205037.9574-1-dima@arista.com>
 <874lej6nny.fsf@xmission.com> <20180924205119.GA14833@outlook.office365.com>
 <874leezh8n.fsf@xmission.com> <20180925014150.GA6302@outlook.office365.com>
 <87zhw4rwiq.fsf@xmission.com>
 <alpine.DEB.2.21.1809272247270.8118@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809272335430.8118@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809272335430.8118@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.10.0 (2018-05-17)
x-originating-ip: [2620:0:1000:fd1f:f3f3:aec8:82f8:da4d]
x-clientproxiedby: BYAPR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::26) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3525;20:IDGB2QNUGWnQOaoqD0JL4b7nun++UNsYiqnUqcIMNpAlppiQp1bnPcUlwQkK+mz001DMwg5MLpwL/AkXVF8rswcpx3HLRtOb3PW7lZecCHkxX6pkDznBrPbGdTP+chAGauJe+0E3/iI+cBsnrAyY1XVFS/ZP8C9WlnN8wS2QYy4=
x-ms-office365-filtering-correlation-id: 5a94aac5-68e0-4c12-cac4-08d627f48498
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3525;
x-ms-traffictypediagnostic: AM6PR08MB3525:
x-microsoft-antispam-prvs: <AM6PR08MB352521669438FEF51709761FCFEF0@AM6PR08MB3525.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR08MB3525;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3525;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(346002)(39850400004)(199004)(189003)(6506007)(76176011)(8936002)(99286004)(9686003)(316002)(52116002)(6512007)(229853002)(186003)(2906002)(7736002)(305945005)(5250100002)(106356001)(6436002)(105586002)(33896004)(81166006)(93886005)(386003)(33656002)(8676002)(81156014)(68736007)(6486002)(86362001)(446003)(476003)(102836004)(486006)(46003)(97736004)(53936002)(11346002)(54906003)(58126008)(6916009)(256004)(6246003)(71190400001)(39060400002)(71200400001)(5660300001)(14444005)(14454004)(1076002)(478600001)(6116002)(7416002)(25786009)(4326008)(2900100001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3525;H:AM6PR08MB3253.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 52yttdDprk08GiFXgBfp+Ya5PzNvp8ay3nJIYPazgiMooEyXlRQx5XS6aYVwCz0Q5MOzPIOPD1N8AiU5NwZZ4Zafw7Cu69veutQzcYy0RQcbJq3hjG/MPJjzQc+eT95V/1PJsesd6s1JEwCDm93lAG57G6XN8F3/fG4/PJbGkJ/0WiKOq5zDzkImFQvKn0fJkpzP+gO0/ABtSxS+QFZd/R4J2c2eDIzKxi65gQbrB1w56sdi5bVoqseI/QbuOM8ydNyWIegrJ6rGuSb82NJuIItD2XiKY4UVaQHM3mj+CbpGxhzbqHt18BDP1Dw6hURxpEfhnkGZgASRaHcVfp+c1v/iamVJyX6ZHgCWVP4Aiho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="koi8-r"
Content-ID: <8C46EDA933FB6941ACA5110F5EB9E607@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a94aac5-68e0-4c12-cac4-08d627f48498
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 23:20:47.4846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:41:49PM +0200, Thomas Gleixner wrote:
> On Thu, 27 Sep 2018, Thomas Gleixner wrote:
> > Add time skew via NTP/PTP into the picture and you might have to adjust
> > timers as well, because you need to guarantee that they are not expirin=
g
> > early.
> >=20
> > I haven't looked through Dimitry's patches yet, but I don't see how thi=
s
> > can work at all without introducing subtle issues all over the place.
>=20
> And just a quick scan tells me that this is broken. Timers will expire
> early or late. The latter is acceptible to some extent, but larger delays
> might come with surprise. Expiring early is an absolute nono.

Do you mean that we have to adjust all timers after changing offset for
CLOCK_MONOTONIC or CLOCK_BOOTTIME? Our idea is that offsets for
monotonic and boot times will be set immediately after creating a time
namespace before using any timers.

It is interesting to think what a use-case for changing these offsets
after creating timers. It may be useful for testing needs. A user sets a
timer in an hour and then change a clock offset forward and check that a
test application handles the timer properly.

>=20
> Thanks,
>=20
> 	tglx
>=20
