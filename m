Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9EE208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="e+2I9X4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9EE208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeJAV4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:56:09 -0400
Received: from mail-eopbgr660119.outbound.protection.outlook.com ([40.107.66.119]:38488
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729480AbeJAV4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector1-raithlin-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVSCN/QDuNV06m3fSctd7PQJWfDuhp69YSBVpzpECmg=;
 b=e+2I9X4Opz9K2UmxHOvw1IFBvJeb8hhQ68RY5LbkCyCxaBpno021LxwViLN7+EJ5sOIEuWS66X2w64PHkKuo+RQvEI7VnN0+DT7lpO/nJCJpEvE2IAqJDyON8zYr0Uda3xpt60pqxWMYiYO3KNC9IGtfNfkHxYoGryQ7Bm+g+hA=
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM (52.132.75.145) by
 YQXPR0101MB1062.CANPRD01.PROD.OUTLOOK.COM (52.132.78.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 15:17:49 +0000
Received: from YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ad39:95c2:bd53:f191]) by YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::ad39:95c2:bd53:f191%5]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 15:17:49 +0000
From:   "Stephen  Bates" <sbates@raithlin.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alex Rosenbaum <alexr@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: Linux RDMA mini-conf at Plumbers 2018
Thread-Topic: Linux RDMA mini-conf at Plumbers 2018
Thread-Index: AQHUUQ58NJBNjs3N6UuufiqZnKEsv6UKHFwA
Date:   Mon, 1 Oct 2018 15:17:49 +0000
Message-ID: <0EFD8B7D-15C2-4314-B099-B7621AECFC4C@raithlin.com>
References: <20180920181923.GA6542@mellanox.com>
In-Reply-To: <20180920181923.GA6542@mellanox.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.11.0.180909
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com; 
x-originating-ip: [70.65.250.31]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YQXPR0101MB1062;6:GFPRq6gDrl3x/OCjxjRxVVtKtOLqgEqLzhZ54EbHmHVnnvRb6xdXRdU9V730CXg43UuwqK/pO5g+HJ/DedXhBf27mIlUsJpodFeMFChhqY/jIG+iHcrSJDoDCgvKwYInQblWa+679466zJpw0ukbpCb/8X08AJEXa7T5q2apYannspl84zY52uOUyRRcEKYw+ck+wg4VCanYnIS2sS/PnrlEkAqtWLtu6y+tCHUJ/HDKwzhuiXt4R7gZa3rJB0Xx/1El2tBCqdG09MczdtcGuq8ib7sLgnSUshkGZTF3xWOJx5s2Dufk/qoiXmEBm3edmTv7PizeuKK+o5O2npemaHvSjdCq0SRcdsnsY3KCxs9uvUfC1zw42c7awsyDCV1jwX0VcS0BNXAL9Rd29FrOj+2ld4keZVd/bFp3sHpyB6jhxrB0uLGGWL3kRAm2YU+omtupcH6yiJjQnx3wMPoLig==;5:uT4BcsatxJw0hjcgbPCwSCVXSKkHrvLRjqxkpa12FmJ6965r4+kV0hO1XhrhCDgdZOfWzsH4UrA1/HOpK6yI7yIj3lKPFiR7y5sxW97BEDeMdoVDX7Nm4pNll6kuBLgiIxfhhwTSln/nGP91aboiMT6Rbmg1Lbrg76uKg045E1U=;7:T30QmkHQhYtduVGyiypy5yn/wtcd0fZnWXuszcnggiQw3aDY31u3wchHmkcF5Np0xT3GpfGkABo4utSMg+d5XGy46dIU9AOeaweRVetUbJ8hWBlHmVSTyITtP+0hn3tOozR8FQ03BgZkhAVy2GDrMwurcAtndYdMAwdvylp9gamlL3h0KGS3EBuo9+7vfCjc+XxIQm3eHLecLSbr/bjgf86A3vOoSQoZ7GPznpuKWcJ+jTugVXuyi2h3IiVJpc0k
x-ms-office365-filtering-correlation-id: 58fae2a1-0b1f-44b1-1beb-08d627b10c81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:YQXPR0101MB1062;
x-ms-traffictypediagnostic: YQXPR0101MB1062:
x-microsoft-antispam-prvs: <YQXPR0101MB1062A6F4DE8FFA5677223454AAEF0@YQXPR0101MB1062.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699051);SRVR:YQXPR0101MB1062;BCL:0;PCL:0;RULEID:;SRVR:YQXPR0101MB1062;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39830400003)(376002)(346002)(199004)(189003)(6116002)(3846002)(83716004)(14454004)(76176011)(5660300001)(33656002)(36756003)(508600001)(486006)(110136005)(26005)(6246003)(66066001)(54906003)(58126008)(4326008)(99286004)(305945005)(7736002)(102836004)(25786009)(186003)(106356001)(105586002)(11346002)(81166006)(2616005)(81156014)(446003)(8936002)(476003)(68736007)(2906002)(7416002)(8676002)(229853002)(97736004)(39060400002)(256004)(14444005)(6486002)(2501003)(5250100002)(86362001)(6512007)(316002)(82746002)(2201001)(6506007)(53936002)(34290500001)(71190400001)(71200400001)(2900100001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YQXPR0101MB1062;H:YQXPR0101MB0728.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: raithlin.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kprmU96w+M5qHK53JPV1rP+o/VPkIUdReJJA46AygnESK+ZSKViYpF2ah+vRIwUlX3TVF7BWu/tPByARMxFb3xsnEfM/H1l7xVAQpiqpwkK/TRYan9AnUB1fiJiFsrsjoj1cP9cD8Kp4LULALgbVmSnthK9wX+nyD1dyE7fU+aSkgSNh/RayiSK9kwYWCJmd6FdepYIPbICoPYNN1/4pV2C1BuKWL54QuZ+bdBiROB8wszmHvBH3uKa0zFJWshDKfYUraoTp+h28RJplIysvA5w+abLgfX3u7tIqxS5OVk50o9jDZI2x0duAJe2QJI4nfGJE7NPaufgm7LK/ax2rWI1T4vaXHJ2CtdU1BNzdwPM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AC2C04C8000D049B71172CF35C98ED4@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fae2a1-0b1f-44b1-1beb-08d627b10c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 15:17:49.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR0101MB1062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24gYW5kIExlb24NCg0KPiBUaGlzIHllYXIgd2UgZXhwZWN0IHRvIGhhdmUgY2xvc2Ug
dG8gYSBkYXkgc2V0IGFzaWRlIGZvciBSRE1BIHJlbGF0ZWQNCj4gdG9waWNzLiBJbmNsdWRpbmcg
dXAgdG8gaGFsZiBhIGRheSBmb3IgdGhlIHRob3JueSBnZW5lcmFsIGtlcm5lbCBpc3N1ZXMNCj4g
cmVsYXRlZCB0byBnZXRfdXNlcl9wYWdlcygpLCBwYXJ0aWN1bGFybHkgYXMgZXhhc3BlcmF0ZWQg
YnkgUkRNQS4NCiAgICANCkxvb2tzIGxpa2UgYSBncmVhdCBzZXQgb2YgdG9waWNzLg0KICAgIA0K
PiBSRE1BIGFuZCBQQ0kgcGVlciB0byBwZWVyDQogDQpJIHdpbGwgaGFwcGlseSBiZSBhIGxlYWRl
ci9vcmdhbml6ZXIgZm9yIHRoaXMgc2VjdGlvbiBhbmQgY2FuIHByb3ZpZGUgYW4NCm92ZXJ2aWV3
IG9mIHAycGRtYSB0byBnZXQgdGhlIGJhbGwgcm9sbGluZy4NCg0KQ2hlZXJzDQoNClN0ZXBoZW4N
Cg0K
