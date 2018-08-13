Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F522177A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nyluezPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F522177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeHMVta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 17:49:30 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:53184
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730093AbeHMVta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 17:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16bqmjDpt2Yv/68aCT6KZYjmqkZj5S/PkQs4PmKo8VA=;
 b=nyluezPCAvRg7xmbSMegyZ+837bmmDXlD+tCs8YSe3wNmq1p2YBXOzL8WPnlwAf9GOOUxIwPJZf7gLOJSOXiLPsY3G3ifa9OpiFvRr7Zsl/qd/QR8LfIoge7Dwgp3JuKCgBlZGst9qlzzLHrsSi7DrIBM9zfHQrRSxBgWcIiEQM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.1; Mon, 13 Aug 2018 19:05:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1080.002; Mon, 13 Aug 2018
 19:05:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH 2/3] tools/lib/lockdep: add empty nmi.h
Thread-Topic: [PATCH 2/3] tools/lib/lockdep: add empty nmi.h
Thread-Index: AQHUMzifjjcwEw0PP0aeP8eg9bsXqw==
Date:   Mon, 13 Aug 2018 19:05:38 +0000
Message-ID: <20180813190527.16853-3-alexander.levin@microsoft.com>
References: <20180813190527.16853-1-alexander.levin@microsoft.com>
In-Reply-To: <20180813190527.16853-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0279;6:Rbu5oPhIGqe1Sp5WGaZ0eTZ2fDtKOGtc8HpFpX5rVLNEYuR2EJDZpgGkt3x5zYNKLdl6l2PnDqvHpjz45iVJTr9hN5d2whhNmzDrb5ZS/4ScjsV1ztJzqyQI4SkMnNnudYnlaybZK2/lYxG+gVip7wJcatB+V+Q4ZRTsEo+QmHmNPuPs+Xy54b8BycFtk9YckGk/KSv1ovbdo5r1V+DIGsjTuigyB76zjTnhX3GittAnEsLJm/A5HoDjDcyUVKYSzkTKLtJ13dAmfJrYDr4MztAus6J0/dOGPGdD3UuxspNw8/XdEb6FHHY4Herr5jEKEuPCKDNqSJqZATFEYhOszBi2IWSWTi130HT87RW97sihLQ3PNxagetmt0kj4z2xOxp8pgZTTY05XhQPN7qQxmOa1OTsd+IfsWpJ6h6C1MLvFWrLqv7r4IiR0Wd5ALK+yZKOtUDFG1lztfZdnKdvMCg==;5:myvWfgikAEAdB26yxcWMmS6BBMgL0qWbzR9Yv4RrocrkTYWV5yG3JgUDTEY992PV+uPtFK0+SK4b5KK/6UOr7ZgC5ysz/9A8Cz9T0iJvI97tuI1qtSd2rm2v6h6N5sj4Z8tu0yfG96QXvlDJLiTWrVCWKIvLqa7YhszeAyPYQ28=;7:Jbxi/wvSQcxqqGQG6xNUJ+b+WLFT1uga0ecdpHIiCC+GV5imhUgWY7xsRgJAxj/DKVYu8BS1wBjC8EfdHRTMKI8KOIu8WDkLWpxsYwryyjfi1PiL7ZH/lU1xSfj4RPvkuH8xzAHqTm2ecA+Ytj4IBJypl2/x+x03CNCDfyKJFCvw5/UGjIaEKryCFWANPEl59VAtobjgUFoAr3D5joS6jRXSv6ZSk60hIP99h8kDlOK42j5cUsuap1JyO9bEv1v8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 53164c9c-908c-4014-5ab8-08d6014fc1f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:CY4PR21MB0279;
x-ms-traffictypediagnostic: CY4PR21MB0279:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB02793882C15B4381BC788D2BFB390@CY4PR21MB0279.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR21MB0279;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0279;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(102836004)(66066001)(106356001)(26005)(478600001)(107886003)(81166006)(81156014)(10090500001)(8676002)(186003)(99286004)(10290500003)(86612001)(14454004)(11346002)(86362001)(2616005)(476003)(72206003)(446003)(105586002)(486006)(6506007)(76176011)(4326008)(6486002)(110136005)(54906003)(6436002)(22452003)(97736004)(5250100002)(256004)(316002)(6512007)(2501003)(25786009)(5660300001)(53936002)(7736002)(305945005)(2906002)(36756003)(8936002)(68736007)(2900100001)(1076002)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0279;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qhrHTef8wsx43yQNQ82O2AQ2Slr9zQwjEhZxeOKR7xC6TJPe+7KEpxKWKPLKWNURbx8KwdFG6rFL814ibfAeiHiphKZC4aF/vvZZjVmMHsPfkEjTC0wdGOMmvaqMkZrJMoTyg67fCoN4rBC2FrMGa4DToXvCgq0XKKMFDseEOAbBv4FTrCgaiZx48axcVy5S6jrn/CvvB/bqXY9BpK/Xw0taVNnj1D9/AkyE4nvAQoeUH+6EqEHHY0GhqKKHSfTO0IgvDT4u71xobezhkcF1SeqpgTHd5Am2mUF5+/i/NtBWrg8eD1og7/h/fU0/ak+keQl8ifqQostG5N3dXwFe9KmSp4292t+42KwIw9mQoAk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53164c9c-908c-4014-5ab8-08d6014fc1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 19:05:38.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Required since 88f1c87de11a8 ("locking/lockdep: Avoid triggering
hardlockup from debug_show_all_locks()").

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/include/linux/nmi.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tools/include/linux/nmi.h

diff --git a/tools/include/linux/nmi.h b/tools/include/linux/nmi.h
new file mode 100644
index 000000000000..e69de29bb2d1
--=20
2.17.1
