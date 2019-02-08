Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED596C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31A42146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="N8KAeQD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfBHSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:43:40 -0500
Received: from mailout.micron.com ([137.201.242.129]:30588 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:43:40 -0500
Received: from mail.micron.com (bowex17h.micron.com [137.201.20.32])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18IhSt8023636;
        Fri, 8 Feb 2019 11:43:28 -0700
Received: from BOWEX36H.micron.com (137.201.84.179) by BOWEX17H.micron.com
 (137.201.20.32) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 11:43:28 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36H.micron.com (137.201.84.179) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 11:43:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0F0rx2QylR4ITi6AVSiVJYUDFxsI7ZeEsAczGF4UZc=;
 b=N8KAeQD0CEzqPuzX9fCq2o1guNFexh0kfiDO0r+rMZeBSPofJ89Wz21D8wLrLOtZz3blAlXY6D+H7yaKsGywegZEZ+kMrbRIGm5MMgCEjRtSqyItXOeAr+Izpt54P+oSm/GrJwsnC5a2V5Ei/GY0fwgnl/RYhG8FBI++8XJqbTY=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB6104.namprd08.prod.outlook.com (20.178.52.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Fri, 8 Feb 2019 18:43:26 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 18:43:26 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>
Subject: RE: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAFVpvAAAQltAAACntYgAAFvxgAAAWkB8A==
Date:   Fri, 8 Feb 2019 18:43:26 +0000
Message-ID: <BYAPR08MB453327FB53F7DFE50C55C1B4DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
        <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
        <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
        <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <20190208184718.3c488d0d@kernel.org>
In-Reply-To: <20190208184718.3c488d0d@kernel.org>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB6104;6:zEcYamUxx08ggiQwlT+MKgK/mV/RRblTJVIXgA4YaYo8hRvIb8EwpfVFgpvtfuWiWhR8WudFBOOv30DuM+hj+wdk4eMBR31LRxaLqm1+0osU09vsCtTzABJM4ROjBg4CqA3tR5h4urTqtPH4TAj8qRcbhFtju0gThx3yMCh0p0jYXz55QqmL35xhTs2OKXzGfxxbmqdeq3bxO70XMWVuQS8r5y2tdPpIi2zhG2d2m5MRCxBA3AgZXypTY2TLAR/y4PlvgQBp6SPYogqqxOWHFo11dKe9GrFBVBYGvBQ+Z2kabZQvOHtXD1jHwfrpAUBIIfSjGxKlQOIYdGlgMOhZDLYZeLJN0Oh35ulCvI20gjMzb/iWZSh+KWbWjnrAEOE5E3OsCXNldUAdUeckWxncOj9fRcmguXUyy33p+bPMmDK5voJ/OAl1fRHhYCXXBMo1BAgODUYfEJo5EnHhglzcZw==;5:eNPMRWJ1d9hAGs3zsKLBmr6gLbjP9xhA7pYHaFyN0zbEKeft9BUdhccMQtEPlBov7Y2oG5hZcbaQvIamhcl/4P6vlWY65VDGD6dTteeNUBmyTnU7b17jnK5V++vJCxj7eEJodpLC5KywhkiAqMgS/JuZkZIjBI3tXcHJ2+2uY5BqmKkOwnmcbaGuvbh/sAM1DUOyJMr71GQZ1xgST8AZ8Q==;7:80X8JBMHQVsfix1UnX1aqlpronDkPw0aXxU1GMYka7Tu7J5xpeUMpoum2h5lPtkfTs1xSJQC3eH3UHmno+xM6ffoqW1ps9cV+DnQsHD0UBpHW6wglCX1VHgywukox9JbLzaHCJ/5sSsciAxldg1ncQ==
x-ms-office365-filtering-correlation-id: 7387386b-cbc8-4e91-a164-08d68df54ff0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB6104;
x-ms-traffictypediagnostic: BYAPR08MB6104:|BYAPR08MB6104:
x-microsoft-antispam-prvs: <BYAPR08MB610460A918BF7AC59DCDA552DB690@BYAPR08MB6104.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(71200400001)(6436002)(26005)(86362001)(6916009)(99286004)(6246003)(7696005)(76176011)(446003)(4326008)(8936002)(55016002)(66066001)(476003)(25786009)(14444005)(54906003)(316002)(53936002)(9686003)(97736004)(71190400001)(229853002)(256004)(68736007)(3846002)(478600001)(6506007)(6116002)(102836004)(93886005)(2906002)(81156014)(74316002)(7736002)(106356001)(305945005)(81166006)(486006)(186003)(8676002)(33656002)(105586002)(11346002)(14454004)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB6104;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7nvIwH9WeLOVKYQHOwn5YL/x8nzfWd2j7TByciTKJpZH77UKzv1Z2hFJhVsuC46XIgt3Rv2AnXFBtEwQDzZ/ohRIlfy7pyXBwCTeuvNaGJhCnzVV+rMQKNgwKQlV4jY12e/gwkwrXp07Y3xCRj1O74NDLh4MP6bx2PMN/9/60xT0pwJSt3GCH1C0yKpXjU9HWPnLf3z8tzJqnJC9PZiRYfJfDC5lXhdzYhR1tNh8GhZD6+teQ2+UwsfqrXQi31TZrEOQESZZQFLAsTVdkymxguPZt/ReObrQmOhs+xlSWocYNeiXJU9WscVaEJ6wmNeqkADmvBWiH6b/Bd/IA+8pvhR7xPzfq/QCniZiYxS+hqzT9UZOVM+j1x0P6GFT+Cag37DjTB6wjc4pH5mTp9fbWmsUx7Z7TQNgY9S2nwZAMWY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7387386b-cbc8-4e91-a164-08d68df54ff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 18:43:26.5226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB6104
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--13.683100-0.000000-31
X-TM-AS-MatchedID: 150567-701837-105250-780014-705178-703283-702050-700648-7
        03523-700476-706719-851106-700074-187165-711518-701005-701618-702609-700782
        -701702-707788-706249-121113-701305-703355-139010-700075-700107-701928-7014
        61-705388-703747-700752-702020-705518-106230-701236-700546-703788-701499-70
        1471-148004-148007-148020-148050-20043-36048-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Boris=20
I sent three times, seems last time is successful. would you check that is =
correct?

git send-email 0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
0001-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
To whom should the emails be sent (if anyone)? linux-mtd@lists.infradead.or=
g,Tudor.Ambarus@microchip.com,bbrezillon@kernel.org,linux-kernel@vger.kerne=
l.org
Message-ID to be used as In-Reply-To for the first email (if any)?=20
(mbox) Adding cc: Bean Huo <beanhuo@micron.com> from line 'From: Bean Huo <=
beanhuo@micron.com>'
(body) Adding cc: Bean Huo <beanhuo@micron.com> from line 'Signed-off-by: B=
ean Huo <beanhuo@micron.com>'

From: Bean Huo <beanhuo@micron.com>
To: linux-mtd@lists.infradead.org,
        Tudor.Ambarus@microchip.com,
        bbrezillon@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [PATCH] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Date: Fri,  8 Feb 2019 18:00:12 +0000
Message-Id: <20190208180012.25852-1-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1

    The Cc list above has been expanded by additional
    addresses found in the patch commit message. By default
    send-email prompts before sending whenever this occurs.
    This behavior is controlled by the sendemail.confirm
    configuration setting.

    For additional information, run 'git send-email --help'.
    To retain the current behavior, but squelch this message,
    run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
OK. Log says:
Sendmail: /usr/sbin/sendmail -i linux-mtd@lists.infradead.org Tudor.Ambarus=
@microchip.com bbrezillon@kernel.org linux-kernel@vger.kernel.org beanhuo@m=
icron.com
From: Bean Huo <beanhuo@micron.com>
To: linux-mtd@lists.infradead.org,
        Tudor.Ambarus@microchip.com,
        bbrezillon@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bean Huo <beanhuo@micron.com>
Subject: [RESEND PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Date: Fri,  8 Feb 2019 18:00:12 +0000
Message-Id: <20190208180012.25852-1-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1

Result: OK

>
>Hi Bean,
>
>On Fri, 8 Feb 2019 17:13:52 +0000
>"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
>
>> Hi, Tutor
>> Thanks. unfortunately, it doesn't work on my side. Problem is on our ema=
il
>server side, not my local setting.
>> I followed your configuration, then git-email failed.
>
>Can you paste the output of git send-email and the [sendemail] section of
>your .gitconfig so we can check.
>It shouldn't fail, really, because the server shouldn't check the body sec=
tion of
>your email, and this is where the extra
>
>	From: First Last <foo@bar.com>
>
>line is placed.
>
>> Please just change my S-o-b to 'Bean Huo (beanhuo) <beanhuo@micron.com>'
>in my patch to please checkpacth.pl.  It is not huge change.
>
>It's not a problem when an drive-by contributor posts a patch, but if you =
don't
>patch it that means we'll have to do it manually every time we apply one o=
f your
>patch, so please find a solution.
>
>Thanks,
>
>Boris
