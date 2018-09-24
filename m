Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E88ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1882087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z1rIqjQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1882087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbeIXUxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:52 -0400
Received: from mail-by2nam03on0094.outbound.protection.outlook.com ([104.47.42.94]:22973
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388787AbeIXUxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjLJ87+c0oECD5F0TVCRYLRPCzPpvA3uJUTH06wJZzc=;
 b=Z1rIqjQ0o6IctU2VwOtOCB3Sn8LTdZtJ+xWEYwu35alFK0kjuZtw6ZmRiFfuH5Np4TBWQ1Md2M3LU0idBI5sx7h2o1hVVnBf4ALh34UpeUIj+io/0dWRAqaqS4om9fWYEfu4/vvsyWqKi4LHdJGf3XID3gOplET9pVmaSTW08ZM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jon Kuhn <jkuhn@barracuda.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/23] fs/cifs: don't translate SFM_SLASH (U+F026)
 to backslash
Thread-Topic: [PATCH AUTOSEL 4.9 16/23] fs/cifs: don't translate SFM_SLASH
 (U+F026) to backslash
Thread-Index: AQHUVBXOfSgLOZ1bpU6sLJsCGE8D+g==
Date:   Mon, 24 Sep 2018 14:49:32 +0000
Message-ID: <20180924144919.164617-16-alexander.levin@microsoft.com>
References: <20180924144919.164617-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144919.164617-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:Hk8j4Xab5sKT/Uc70GZcWTg8Q/T6slvVTWeLgaNLJ+0x/Fqq0Fvi7A7PosZW0gWK3QNiQYfv93ByNyRqHAYCQcdmh6Qne/h+yb/9dgmLmw1feWXO5ySO9JOWk4GEVjjznPPcvXiW1usq9JFF+5jqFoB7gqKIue7OAgtSwUvixth4u979xmjuvNq08dXqRa3SDkfezujW4hK99jkbBKSIg/AaKrclLDFfZjV6Dm5kwaRm3d4RBnscJIhropUxe5Pd+Zh8qgzXo12Y5XFDh35urT22T3Bbaajkg8cgEbZxPxcqruK3fPiGHtWxz0u7ck5k3ZIgrNYrGm9Tu4ZUh9X8UjBH0nzzhzEwfrMXZZoJYwlppwRA3SKArJyYZ7sy8MPNl7VuEEhxStR8+yO9iL2qxmxjLA/d7BwlBYIG70hogNUnmFAIzjGMuH1nVvQmJxr9TySaiCHgVG3k9KjtDZdjuw==;5:SCEhsgrLPePXzRfOY6aom1fYX+VmtQy7ykCLB6s34D5BNIf7P9Tqr5kz3C55gcT5pqQJ/XiXbeOK6wTsaFmm+evzT+0jmmITV89FIMsJ3Ka9mXbOxnqU/t0FLAypqYtY3J+M0D6GoGUd7g9xrE6qFDXfQ1V9Hzi/H5QhC9eFvxY=;7:eFMMLvbH1Q8A62NpQkf9BzyT2aAnxehHxqEP9g3YWOl/wg5mjPlVCXRnUxjwZ7VHIELGCKkJCkyIwJ9d1/pTLn9IfnxZsYIaLxrtQr4JQ6NXa5T5OCm3LZzxQkzZxL1VD7jrC6D+mq2kk2LbL3OYz03vaqv65rehaXGPeHlOdCtTjURID8vDR1cuXrTdfE6SUcXZBuzbRBTIdB7Ve2GRUCoX61V4G0lwppf01EoqdvNQHKDLU5w6W2vIYxYriYyB
x-ms-office365-filtering-correlation-id: 6bf5fc5e-8a12-4fe4-8ef3-08d6222d2563
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01812E73054DB0B40F882575FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(129605872554195)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lO6zutv7FIDeGCa4S0GEQknLE1orPcpOLOge0PEzJEM7qbGsLkgzlaccnbwlG+QQEafphTPVd5beskj83WUCQZIRoqWP44Hmnq3wf41uf58suAwY7bkag3yGARSw3YnQQZyFZz5ydRH0EiiOG5hAAMyQZX7q2mBUbLiUHTCYO7LCCuJQWJtvCQcBgZd4QkVy5J3LLej/p57cMzs/naCLf+qkZlV/l/ENSkn6b+UhrbeBpLdgypuiRlpxLV8MY9anSdepfbpXsFVIxS/wVsfDKSbD1dsswq2mSqGnPRD1HETK9CLWgcHnlaiM8fXqtbCGKsvrm9J37qICXdcigT4GS53+JPJK8N12Bls2fi2J93w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf5fc5e-8a12-4fe4-8ef3-08d6222d2563
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:32.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Kuhn <jkuhn@barracuda.com>

[ Upstream commit c15e3f19a6d5c89b1209dc94b40e568177cb0921 ]

When a Mac client saves an item containing a backslash to a file server
the backslash is represented in the CIFS/SMB protocol as as U+F026.
Before this change, listing a directory containing an item with a
backslash in its name will return that item with the backslash
represented with a true backslash character (U+005C) because
convert_sfm_character mapped U+F026 to U+005C when interpretting the
CIFS/SMB protocol response.  However, attempting to open or stat the
path using a true backslash will result in an error because
convert_to_sfm_char does not map U+005C back to U+F026 causing the
CIFS/SMB request to be made with the backslash represented as U+005C.

This change simply prevents the U+F026 to U+005C conversion from
happenning.  This is analogous to how the code does not do any
translation of UNI_SLASH (U+F000).

Signed-off-by: Jon Kuhn <jkuhn@barracuda.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/cifs/cifs_unicode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/cifs/cifs_unicode.c b/fs/cifs/cifs_unicode.c
index a0b3e7d1be48..211ac472cb9d 100644
--- a/fs/cifs/cifs_unicode.c
+++ b/fs/cifs/cifs_unicode.c
@@ -101,9 +101,6 @@ convert_sfm_char(const __u16 src_char, char *target)
 	case SFM_LESSTHAN:
 		*target =3D '<';
 		break;
-	case SFM_SLASH:
-		*target =3D '\\';
-		break;
 	case SFM_SPACE:
 		*target =3D ' ';
 		break;
--=20
2.17.1
