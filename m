Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1898FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0C82082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kR55Cgmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfBDNyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:54:11 -0500
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:45280
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbfBDNyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ+6BoP8rV2bCHN7gXixy4Mkp+WfFRv6f/E1iK+8kzU=;
 b=kR55Cgmb+JRotlaUw65ykEsGIgVQv+7PHHl91mH3jS/vmOgqv7nh/5VZiOJONNkrcWvuI6VtdUsipJX92cKI8bfnYRCwUUHx91wnhBN3o1XW0r/hiomRE+Uw14NhUB+94oBD6wk1tpaOJKlpoCshnYxaqjlHZqLEbzNH3x10PMg=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB5501.eurprd04.prod.outlook.com (20.178.122.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 13:54:05 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 13:54:04 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     David Howells <dhowells@redhat.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: PROBLEM: fs: hugetlbfs: boot failure due to specs sentinel missing on
 linux-next
Thread-Topic: PROBLEM: fs: hugetlbfs: boot failure due to specs sentinel
 missing on linux-next
Thread-Index: AQHUvJEX9dctk+LFcUero9SvG9UD+Q==
Date:   Mon, 4 Feb 2019 13:54:04 +0000
Message-ID: <20190204135403.ttitgfy22cp7h2lh@fsr-ub1664-175>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5501;6:RMrd/pofP4DcERSlk9NyWJYMtH4RpqE2AZx/p5iTLgKiQmjGmK0NtgbgKNB6XnXaNIvurQm/JBL1pcPw6q5uPUWWT/BAreGrAg4joKJuTPAcvmVlLJ1tzAiU3E6P12jG+uYv14qxqVCRtO81F+ykCI1oAsTy1MGozrY86xKpNMkMQtgEaCEpEVOTz+0MhBWEiZsGbWWIeIjmTRUl55kqjyjCqZfpmj59Yz8v4pKF2XaCegcIAy5udxzHqDtXa7tGXK/VzOOGX0VQT5NRcq5TJuCbAwCx1l9KcJ6FvvICKUqQIJ2n+yVZDNmp2i+BJmqvQBfFoA9o+Fh8vRGHDs0cx8+j7fZaC1w63G819ZTfe+o+YH6CRXZSHnh6/gLObK58hHP75/Qly/qPBVk+irmztZj7XtfFknR+WbNikzLc5Yy7ebaCsD+mP6zX2eQIx2hw2NH2IG8wVI3AE6InwhIXNw==;5:3a3L1d2HLcj7Cpx6egUAp96jOTOKwdlXEvQe0rZk0PP7Sjz9FDUHBdRy+9cuhZGCrPBo4k8/hY5BHeFv6y0ooONkdfAPoQbvjjoo9v0KNargiVYUYr9i/FMoWI9R0W6kFhJofGhmXPBF5WVSk0COP6nkx1CH8pc3mBTcQ3lXB8KWkLgRr8MFLQO5GDqFHHUVM/4k8MbEP2gPHNXLNI3UjQ==;7:Zmo/tEHmIekMn2fXujyhR5YMc8EExwgWR/80BAmSX1YOa7xfwvjEce9XtlEaCXIqVcgOeHwYiJAHC+28Kt0OZIcDAJ2C3KPsgXyQ6k8Y7KXAGWnurP0Qg9JZPRQwfEbLc6WHlGbqeySipkjtY+ChNQ==
x-ms-office365-filtering-correlation-id: aceeaa09-ac8c-481f-cfc4-08d68aa839e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5501;
x-ms-traffictypediagnostic: VI1PR04MB5501:
x-microsoft-antispam-prvs: <VI1PR04MB5501E1329DF32250698AA58DF66D0@VI1PR04MB5501.eurprd04.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(189003)(199004)(1076003)(186003)(26005)(25786009)(54906003)(6512007)(9686003)(44832011)(316002)(6916009)(476003)(486006)(6486002)(86362001)(66066001)(6436002)(14454004)(71200400001)(71190400001)(14444005)(97736004)(478600001)(8676002)(256004)(305945005)(3846002)(7736002)(99286004)(53936002)(6116002)(106356001)(8936002)(81156014)(81166006)(105586002)(102836004)(33716001)(68736007)(6506007)(2906002)(33896004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5501;H:VI1PR04MB5008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +VsmiEGGpj5igBnmseLK4QnBN7AwCjj2O34J+181UvlLLQevBruwDKoznm0HV/hFIBlZ8ZKMKeiB93w8G+kDRYsLTTFa77wJH+epCHbLQ6KkExRiRmx6oHKQMCcB4N36ln/4VmORL+jaWqzG1Y8Ro4wpnIWk3KgQaUGu1gBB5S4/W62DU3he8rr+wxx2hUS7JlC8HgZyqqiYR9DitEULM/MAdNGTAFVIxokTj7DD3WGvHobLo3/eNoPC6iKMj9BwATznQxFLPz6jATO/sgOGXlDQ/wWIzUUaf3lDUrIi6qjNwkfwNiYpbuphSUhuDRgleZR25lARq+inRiGPUwy5EGUoi5uTFdlJyRpUaBSb84OFGDEfBQP5GEHq/fDb5AQWoHDtI0hR+AH69fPLwLdYvdby399tlLBqXiePGtBEacY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE2C79C4CA27304BBB9352571EC1B954@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aceeaa09-ac8c-481f-cfc4-08d68aa839e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 13:54:04.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I found this this morning trying to boot up i.MX8MQ platform.
It's totally unrelated though.

Your commit:
2284cf59cbcec "hugetlbfs: Convert to fs_context"
doesn't put a sentinel at the end of hugetlb_param_specs.

Then, the your commit:
f512b838c1048 "vfs: Add configuration parser helpers"
adds the fs_validate_description where you check for sentinel
but since the hugetlb_param_specs doesn't have it it freezes
inside the following printf:

+                       /* Check that the type is in range */
+                       if (t =3D=3D __fs_param_wasnt_defined ||
+                           t >=3D nr__fs_parameter_type) {
+                               pr_err("VALIDATE %s: PARAM[%s] Bad type %u\=
n",
+                                      name, param->name, t);
+                               good =3D false;
+                       } else if (t =3D=3D fs_param_is_enum) {
+                               enums =3D true;
+                       }

IMHO, what happens here is the missing sentinel allows your checking
here to go out of bounds and then the param->name is whatever garbage
happens to be at the end of that array and that makes the printf to
freeze.

This isn't something I looked at really close, so I might be wrong.

I wasn't able to find the mail with the patch to reply to that
so I had to write this as a separate mail.=
