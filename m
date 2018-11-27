Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF02F2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="qzK6rUzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF02F2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeK1Evs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:51:48 -0500
Received: from mail-eopbgr760127.outbound.protection.outlook.com ([40.107.76.127]:6160
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbeK1Evr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2V1n/cshd3N+bruk0UAi68dJupB+gx+GS0lfBM4cFo=;
 b=qzK6rUzgTFVQs84F4gflNbP5ti6OO5Yqmwa4wQCuQ6fuNtS2Elz2W/MloLN1PBop2iNGqNxtPR2Jn+3/Kkm1m21XQDGWFtriPRfcXwv+AtmzDsqROXBhbf2H4lIiTqNHVpG/dwl/wTyu7Aw26dWe2A0RFtDGTL4TByjt/jLCM0U=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB2939.namprd11.prod.outlook.com (20.177.217.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Tue, 27 Nov 2018 17:53:03 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Tue, 27 Nov 2018
 17:53:03 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Grant Grundler <grundler@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhbhJ96XSCK8z8UOo2bPiHw7S7qVjg1+AgABlRSA=
Date:   Tue, 27 Nov 2018 17:53:03 +0000
Message-ID: <DM6PR11MB3131108A98DB6394C3009D4BE7D00@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
 <20181127115035.GB3206@sirena.org.uk>
In-Reply-To: <20181127115035.GB3206@sirena.org.uk>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB2939;6:iGso+H+53QR3kg72tLsrriguXbA49CJRvuFjN7zSiqLpFEXSQl/9tJu65x8ERMODvKGFoIce7RKa/s6r91U6vuttNwVS9e0PXNp6LvQ1yO0TFt4kWRF0kxTnlOJCv6QD1TItkRLn8SeiFA2JXV+a0+cjdknfoDGGwaoA26L/4x7C99fLfkIkuIuGlBpSCN6ZUIu67JTH0uJxV1XMfxeCPTp/s4T0zc4+fFst9MkiZTJqvs+cxnNdhU2h8NJ0rk3RW4NXDR5Gq5i5kiFhaia4sebMJbNpG7PU8W7Th0GX0IqaM7xz5IkfVIbxuHw0e1IwoGWhPIDfsbKuUUBe+yzh9JrU0JmqJtR1NR6B+gy6xztvisdzcNtY7j307QtXOX5jMfZ/fB3JRQH8WaKmZi/GUCq5EdlD4KMIPofcACRxOTvMPIziD9CAbjStPsPkEn70dT8TY55eQU7PoB8inEWiYg==;5:whDjfZPMyrHRKtYzOAiOSTnj6ZkKZwx4KbL95U+9wGsegnan6p+em8yRJL/BwS8VDZQBsTML2gDYMVkS1pH84JnhJYkhhWsOK4qNeacA/TP/n6QGpeHk+FOpG7HfCRclJZikiEIpXVROv9Yny/pRx4E0FLA4r3pxjPz9fv+JoLQ=;7:h+QK0TP/L+LfeDKnGrIZedQh9mqJ2KrW7g6t2jrRaxtm0Z/bsgDoyS9h630YCXxPueHbG3OHEcZq4uppHQKylfj7XOWoXp0lABV7GeDgIs0PrP6BZy5mX2ZQpRsQakZPkXp9G4TlT89b05G12mLsfQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e5554c72-178d-45bf-ef91-08d654912dfb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2939;
x-ms-traffictypediagnostic: DM6PR11MB2939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-microsoft-antispam-prvs: <DM6PR11MB2939126FF37E55352D9C439FE7D00@DM6PR11MB2939.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB2939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2939;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(39860400002)(366004)(136003)(54534003)(13464003)(199004)(189003)(6246003)(39060400002)(97736004)(72206003)(68736007)(3846002)(4326008)(102836004)(478600001)(186003)(99286004)(2906002)(6116002)(86362001)(6506007)(476003)(7736002)(11346002)(7696005)(66066001)(446003)(76176011)(33656002)(305945005)(26005)(8936002)(6916009)(71200400001)(8676002)(5660300001)(54906003)(6436002)(71190400001)(74316002)(486006)(316002)(14454004)(25786009)(106356001)(81166006)(55016002)(9686003)(14444005)(53936002)(105586002)(81156014)(256004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2939;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: X8jhaCyL9Mh1M8AvZlb6soP+ilqC4U9eaTUEf7HFzR9Sgrk0g6BtBWs/X3R8nAL8FPv6CbotZPqmxy5jBebXl4NbSD6QsIYFkJFqCmEwuBxaE2r3pbvB504cOKDcW6+es7oLWaIKkCbQM6X7T74BSNVvGEgTBFHRnTa2ty4D8AxnGfQrc7580unJjpxkVAyg59w1HoWu0oxQwzO6O0DYjkab1ZKpER5uZYWq5LNl2BQdQK+hSW2uH0XjOmF03g0hb95ukeLyphdjuOgOZCkl80e5KdEnWjLHHfwqkO4hE0Ie40AkiAJP7vm+CvO2lqLKmRnYfNQUA5ro5Y/tox9c1GJCRPDg1haeDew3R21K9zs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5554c72-178d-45bf-ef91-08d654912dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 17:53:03.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Mark Brown <broonie@kernel.org>
>Sent: Tuesday, November 27, 2018 3:51 AM
>To: Ryan Lee <RyanS.Lee@maximintegrated.com>
>Cc: Liam Girdwood <lgirdwood@gmail.com>; Jaroslav Kysela
><perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Grant Grundler
><grundler@chromium.org>; Kuninori Morimoto
><kuninori.morimoto.gx@renesas.com>; Benson Leung
><bleung@chromium.org>; alsa-devel@alsa-project.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
>reset
>
>On Mon, Nov 26, 2018 at 06:46:05PM +0000, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
>This really needs a changelog to explain what is going on here, and we nee=
d
>some more documentation in the code.  It is *extremely* unusual to have to
>poll for reset like this, and if the failure mode is I/O errors that's goi=
ng to be
>pretty painful.
OK. I agree that this is very unusual. I wanted to make this code change ve=
ry conservative and this caused unusual overhead.
Let me fix this.
