Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD4ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EB5204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="FvkEYJ97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EB5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbeIVTeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:34:00 -0400
Received: from mail-oln040092003036.outbound.protection.outlook.com ([40.92.3.36]:56576
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730087AbeIVTd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpfgxssl2iGVVt1EE7BgTHzVmmTvXpdlvmPZkPkJB1o=;
 b=FvkEYJ97ZYMxIkJ7P6O/mEw6iY4vLDsC0Nw+XxwCUGwMKLhFdYQbiUmRIbMBBGQKJ2FYCXRl7L1502ULr0dbiiLGpiZQUflpWl1Y+aAcvnXUczwRXTiuU+WdxyTfSUveqPSB4mVmoIPc2/ryQmaySz6vL0bnxa2fF4i86V2HDpz3k8ubwV8dYawV+Sp425it/Af8v3fj64ypehnLurQ5G47SYjW7ucORu9WvA7xjwG/4ruLl7VSdpGTL4OtD0p04PBYOet0oex+x+S7qf8RRbbg5bcSqcnVqAai9iyMBkBTw2sqjknY3O+AQ2CB8EmP/dIImkVP0aQgD64AXcxJ5/g==
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (10.152.72.56) by SN1NAM02HT099.eop-nam02.prod.protection.outlook.com
 (10.152.73.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.13; Sat, 22 Sep
 2018 13:40:19 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com (10.152.72.54) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1164.13 via Frontend Transport; Sat, 22 Sep 2018 13:40:19 +0000
Received: from BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf]) by BN6PR17MB0996.namprd17.prod.outlook.com
 ([fe80::2cd3:5085:8114:52cf%4]) with mapi id 15.20.1143.019; Sat, 22 Sep 2018
 13:40:19 +0000
From:   Karthik Nishanth <nishanthkarthik@live.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Thread-Topic: [PATCH] Fix clang warning -Wpointer-bool-conversion by removing
 unnecessary check in regd.c
Thread-Index: AQHUUdAzTB9srBlPUkCULV35zqxrLKT8QGQAgAAPiQA=
Date:   Sat, 22 Sep 2018 13:40:19 +0000
Message-ID: <BN6PR17MB099607D1E30583A179197495CA110@BN6PR17MB0996.namprd17.prod.outlook.com>
References: <BN6PR17MB099677ADA332476DC575F2EDCA120@BN6PR17MB0996.namprd17.prod.outlook.com>
 <20180922124432.tcykwwisip3rl7ll@mwanda>
In-Reply-To: <20180922124432.tcykwwisip3rl7ll@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:3:2::30) To BN6PR17MB0996.namprd17.prod.outlook.com
 (2603:10b6:404:6e::10)
x-incomingtopheadermarker: OriginalChecksum:1759C294C5BCE528B6D8130DE0B55A62F76B6A9660756E0B05A46BFA7D0F10EF;UpperCasedChecksum:12CEB4E81E2409D2EBEC9C0A898FAD6049DC039EF3021ED9649F5D6BD3F216DD;SizeAsReceived:7794;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lj4zsDO0AZ+6HMqaB62zZaDX7sK4K+oM]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1NAM02HT099;6:nEOCJAk4yNow0rqg4LHqo2ARD4UgsjvzHWyQ3z9OoWoKkT9KHb/9VpAc0LcGzkzHUa4z+X25R92Ors28d7jw6fIJaUFSOzk+TA885HlT5Lpf5Ke01w2TRhfvg+HapR5+hifJGOmLyna4Ixs8kpQ007B1uIEqGb8DiGsipT+DZYcEtfqbA6DiwjP3OGiSeNVVpiIgQZU1kdVK0cM4DTTtTfJqxD4rWUW4UFzqImFjW5G0jVyYxTSCNEkeUTxlPvEnKwzxgHn3sYx48zZQLQqfEza8Agpliv3FRH2icCT0A7+aPxPoR9K+ZI0YiaiW+ooVod6uJa27okRJsgv+as4LXxqRT1diuB0je9p5PWsv6u+OvJg2N6BK3wzubvqoSw5SnTMcNMoFIhX2RBQCoXmECX7OdHMmmpri/4ZANG/DaNWcilofd7rm1YEfoahsHh5BEkfPsb49ABH/wHKiYaDaBQ==;5:HsFOiBb8WgQ+t1qfIgNtVDjMXUsX3VMTlV2tZ/IaVn4+hy8LyVBImTOIrFx0sUJjt0APH/Ni5fDEWalun6oci67tOeCBd0r4sq7wNaM0A46a7kQLB4UsEYcji4YICZkYml/huBw4os9gcHhkJU5jZV/YWKerzASDTWMP6uraTVQ=;7:nNHc3lgYaj/E0j2aQ3c0Mx1WYMmDmyHn3rUPS6W+4KoDqH5WX1aSg0E2MIhC5C91s8zb5EyTB0idmsiZQTXvmT4kwNPjwoSciR1bCZLXR+tkV+PAVG9v9Xi7p4ARvjhU1mwj0K+Itvz8job9tM+npB8WtMZg5x0XASj44gbOCfJq+91e+gzXCFKd1zDPDgkFyN+65mn0qWUJLPybvmFekGiH3L0FSrh/E8XXsvL9grCmbJFolWM+yNwgP+qlf/c8
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SN1NAM02HT099;
x-ms-traffictypediagnostic: SN1NAM02HT099:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SN1NAM02HT099;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM02HT099;
x-forefront-prvs: 0803A0241F
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(189003)(199004)(5250100002)(229853002)(104016004)(55016002)(2900100001)(8676002)(9686003)(6436002)(97736004)(33656002)(5660300001)(105586002)(558084003)(14454004)(305945005)(86362001)(106356001)(74316002)(6916009)(4326008)(82202002)(25786009)(68736007)(54906003)(8936002)(6246003)(6506007)(81156014)(11346002)(446003)(476003)(6346003)(99286004)(26005)(102836004)(71200400001)(256004)(71190400001)(486006)(7696005)(76176011)(56003)(386003);DIR:OUT;SFP:1901;SCL:1;SRVR:SN1NAM02HT099;H:BN6PR17MB0996.namprd17.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nishanthkarthik@live.com; 
x-microsoft-antispam-message-info: IDnMTYEUc8Mscs5lgdvs1FOoidmaGE7anY/kNB4Ndk5Fw0WgV0tqw0Vv7RpM+gzNcfS2/6zT0MenXft1M1thgcNntSW/7dlaJ8WIYq9YyL71aEo0DdFAMpzEtG9EEXqgTfjIO3NkRdwiaUKJl6J4+PikwSRPJDSkleOhx56i1nVHtAFV6+d0Y2SpbicY5hzks/C/Rwt62kbvyxrBR7QjogDXR7iRU/pMe87NVSJ+DLQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <908EFEBDFC85FC4AB447A1503F5CD06F@namprd17.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a192c92-c7d2-4188-47ee-08d62090efd5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: c001924d-3e68-4f40-89c2-901a49278da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2018 13:40:19.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM02HT099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do I submit a new patch with the modified subject?

On Sat, Sep 22, 2018 at 03:44:32PM +0300, Dan Carpenter wrote:
>The subject needs a subsystem prefix.  It's also slightly long.
>
>[PATCH] Staging: rtlwifi: remove unnecessary NULL check
>
>regards,
>dan carpenter
>


Karthik Nishanth
