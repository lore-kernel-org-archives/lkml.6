Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32369C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B9321502
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 05:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dX4jLjGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B9321502
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJQNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 09:53:33 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:40082
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727193AbeJQNxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 09:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQlW9Mbzr2KSbicHSp38xBkj4CTYRgNbdsDFhtoPmE4=;
 b=dX4jLjGETgefD5Uw8d9ilt8BuAEK44jjZq4K/OFQFKaXOHMaHUJmgwJJZbHHLdYA3Js088CKcIpDtrt85gIU7z9UWnGwBl/1375YdsWAuMIvA4AXuS7m3dmbJMTo7v63IQnByg+nxRB26u836YdNO80ozLeh3umKbjFwF02H8XQ=
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com (52.132.115.32) by
 SN6PR2101MB1021.namprd21.prod.outlook.com (52.132.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.1; Wed, 17 Oct 2018 05:59:31 +0000
Received: from SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791]) by SN6PR2101MB1118.namprd21.prod.outlook.com
 ([fe80::dc2b:5afa:e768:4791%5]) with mapi id 15.20.1273.004; Wed, 17 Oct 2018
 05:59:31 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: RE: [PATCH 4/5] Drivers: hv: kvp: Use %u to print U32
Thread-Topic: [PATCH 4/5] Drivers: hv: kvp: Use %u to print U32
Thread-Index: AQHUZcefPnSMZjU6g0umtzP+U/kkpKUi4h+AgAAOsxA=
Date:   Wed, 17 Oct 2018 05:59:31 +0000
Message-ID: <SN6PR2101MB1118E7BF71E281E0273F2810A0FF0@SN6PR2101MB1118.namprd21.prod.outlook.com>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-4-kys@linuxonhyperv.com>
 <20181017050411.GC22447@kroah.com>
In-Reply-To: <20181017050411.GC22447@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:506a:a801:e603:e795]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1021;6:3WSNN0emPtJ9cf5xq/rCMr3gZ4qXbAXPkK5ukA8FZyUtNULTL8zAClw0Zhwf2wvXo7dsPehhmlzFuc+LlFx2wS3xrK4/TdApyKy07XGNJQ8xKMR+LZRWq8L5O7ETgcUIawf+uqplVW9CCfdCyzVkTai6eoq97n0VuShObjc9PjEVx6hIUIdKJviZkchhy+zogubQhKkhKgCJkT6XUCLwZsBKpoOFvQDySe0T66XwpLyLQrUILUPviB4mEh8QIa4g7I/AFBuZ6DCip/u+xrIuJfvu4qQBuktVcFejcX8wfEzV6jc2ifeJHJ9s8ZIgFOk/gVbs6yIuSaPCvVdBy9a7GRSIjhh5Y2nmqYVqJ5PUTUdDXqZry+Mfdk+KhRB+GNUg5DuEAqhgJ78Fbf/bGAhJ7nOn21o68B5YIoeomeImylKiUMWyW8KN0bVxGzM621ihB8nc0AXahw5h1jRerxjc7w==;5:U91NV07o+++kmEXQcAsNEhiecDZO1GwA89GdC7hR/6EEuVmyKmf+F60ynRkig0/wdhRG14Fd+KyVofsFr5LeUyijK/2GJCYu9CHSfzrfGVn0sDG8995pBEis+QLKQ0K71HANDdtaI6xN16MnEqScYlTOvbGZhomtQHbcsTlKuAY=;7:LHAuVSFOeaZ0WmLDayRmB9vxggr6AodW1GWvaQefoARqPGsWKPs3Jhht3vZzYwRAYuwxBJLjIxl3K832E0Npsl8BXPgRHM1fMu27V9uz4TabW/in6GuOl4UESiTCwxn1p1/IS21nvuD4XTCnJaOTUw==
x-ms-office365-filtering-correlation-id: 61233dc5-57d0-4565-e4e5-08d633f5b4e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB1021;
x-ms-traffictypediagnostic: SN6PR2101MB1021:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB102145A2DA5D18E38FB3AEE2A0FF0@SN6PR2101MB1021.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(198206253151910)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991092);SRVR:SN6PR2101MB1021;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1021;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39860400002)(346002)(396003)(136003)(13464003)(189003)(199004)(305945005)(8936002)(53546011)(33656002)(7736002)(6116002)(10090500001)(76176011)(81166006)(81156014)(46003)(8676002)(8990500004)(6506007)(71190400001)(106356001)(71200400001)(2900100001)(476003)(446003)(105586002)(11346002)(5660300001)(486006)(68736007)(93886005)(229853002)(97736004)(10290500003)(86612001)(5250100002)(54906003)(478600001)(25786009)(53936002)(316002)(86362001)(256004)(22452003)(99286004)(74316002)(6436002)(2906002)(4326008)(102836004)(186003)(7696005)(6916009)(14454004)(55016002)(6246003)(9686003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1021;H:SN6PR2101MB1118.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q0URVBqOuGWUf59FswxASgAUSabEnLMnKu/MTZSO8/IBEc20Xp1w++xLxUGh+3zErGSbjzPSP2EEvaJa2IbT/OG48Krtq/S57FZy2YMQrCbebywJNSQi4AvEAw94UgGBsTIfZKOwNgr/XulkcVPYEit/C+Nt+Y2qiTa7T2LmccGxteKmzoYUNFmYpBczXV5hl5HbFP5YsUKjDIwodxAi1Ejue26ExFTlqHiuYF4JU4E9Gg7Y4fTf0kzk/wD7P+wZFrPcAcpaWdN/38ksUJXUua2hA1m5RHCDcZe8fq0W42nFfbyFkBUE+hGjxKXgu91EVkX1df0823zIX6Pav50t8MOs9M4KAzfMtGR96SyhKDM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61233dc5-57d0-4565-e4e5-08d633f5b4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 05:59:31.2649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 16, 2018 10:04 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com; Stephen
> Hemminger <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stable@vger.kernel.org
> Subject: Re: [PATCH 4/5] Drivers: hv: kvp: Use %u to print U32
>=20
> On Wed, Oct 17, 2018 at 03:14:05AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > I didn't find a real issue. Let's just make it consistent with the
> > next "case REG_U64:" where %llu is used.
> >
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: <Stable@vger.kernel.org>
>=20
> Why is this a stable patch?

My mistake; I will resend.

K. Y
>=20
> confused,
>=20
> greg k-h
