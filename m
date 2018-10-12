Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98902C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CB7213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pBb64K6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CB7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeJLWTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:19:36 -0400
Received: from mail-eopbgr20107.outbound.protection.outlook.com ([40.107.2.107]:12111
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728697AbeJLWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDOsc3eBzr9XUx3p3UhaxB+tPzBCU1PvQ0DApGQgAaI=;
 b=pBb64K6Y6x+X5iGvLoEAZrdR1sS4mWdhgzFRvn1m2VMtkeftMSXHtWZkJduZidf5bv2gDWn+jC103GW0DtV0RSfoePug7G4gm54xaPlDP4s7Ex0C4gkQF/N7QBxuvJJfreE2sx/BlffX/pHgtp9YscYhekPR1+MmlC15gpd6m5g=
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com (10.168.64.135) by
 VI1PR0201MB2320.eurprd02.prod.outlook.com (10.168.63.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 14:46:46 +0000
Received: from VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905]) by VI1PR0201MB2464.eurprd02.prod.outlook.com
 ([fe80::9d75:5038:5eed:c905%7]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 14:46:46 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: use the correct location for dt-bindings
 includes for mux
Thread-Topic: [PATCH 2/2] MAINTAINERS: use the correct location for
 dt-bindings includes for mux
Thread-Index: AQHUYjpmcClsJ3fOMkqQ+eIoPz+fzQ==
Date:   Fri, 12 Oct 2018 14:46:46 +0000
Message-ID: <20181012144625.9345-3-peda@axentia.se>
References: <20181012144625.9345-1-peda@axentia.se>
In-Reply-To: <20181012144625.9345-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0216.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::16) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0201MB2320;6:brJy+4iUTCXep0sfBbLftmE596cEEMMUwrjkyPN7tPUT2JyAZhfSqN+7OjZzK/tdVKumgM15EMQbx96EqHR41gKVmKNr6V+Y/JaBMp4XfRZIYSUNGcjzDRu4wOKGZ9xGHDp/nQqXtWOF97gk3gY18a9dFUAaO7qvAeTBBTGYzj83LC/3QNl0KVb5iSIU+u9E4CAA9zJvGxoCL8B6MiDA1XAmfq7kYxdkuXKC5mN065SHRATshdhEzCrGq0CXKpjzevDkqEmA5AnVhapS9vIBARcWiEiN1u81UJ8McId8CJaUcs/9BphexeXtPkg90/xmn14xAXyn38FCSZYUruKn+K/S2smvPfE42wfC+UOomxjfT+LXE/iJUNzMoDxt39GRGzBqGMniqJDdaSb6S2yX3EZHMaurlGgAAjaKGOVDvZjobv2BPjqDGb5ykVfHMCj5fK37akx+rvBrz7pEB3Ivfg==;5:2dDnQuiOmRjxXgXmQ9ANvDERMAJQVkTrq41eHLQoJ9XPPPjGEasaUWT+T19Q4ewWxYCvK4/7cmqVoziaYYhSUrl+6Z7mmdQVh9KfCyA3tnBBMokr2fSa+v2eg14RiYWKpxXZsx5nowG7EPj78N/Ok/6taqt8htRhkDrRBfO5y2A=;7:3aR32pL0lcNHSKDaFaEyfE8x3fqzNzZAu1iXWCKyHxEKzodjKXb0SMOlV6eqAfYndvmvs4GXyDJLkNUcG1SXdWYHq4v6GvKHma2nr/qrPExpvROXWW2e1cJgdOWVuSueraEV8KeHbqvCLpGwzn2I53+b5XHajAB8k/JdmmdWQfF6Y8UjclePTHpQhxm3gO0BwVX6TtJqMR5jGtGTYWnAF7XvSewtKU7Vhd244NzQBG7LYhVUIZTVYpXo1vbRPXcn
x-ms-office365-filtering-correlation-id: af7e5cb5-79d7-47da-0455-08d630518868
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2320;
x-ms-traffictypediagnostic: VI1PR0201MB2320:
x-microsoft-antispam-prvs: <VI1PR0201MB23208E2EBBA1E3322CC83A6EBCE20@VI1PR0201MB2320.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991067);SRVR:VI1PR0201MB2320;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2320;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39830400003)(376002)(396003)(199004)(189003)(316002)(99286004)(4326008)(8936002)(97736004)(53936002)(68736007)(5660300001)(81156014)(71190400001)(71200400001)(81166006)(26005)(5250100002)(54906003)(305945005)(14454004)(76176011)(52116002)(2900100001)(66066001)(256004)(386003)(6506007)(8676002)(7736002)(102836004)(508600001)(50226002)(6436002)(14444005)(186003)(6512007)(6486002)(86362001)(11346002)(446003)(6116002)(3846002)(6916009)(2616005)(476003)(105586002)(106356001)(486006)(1076002)(36756003)(2906002)(74482002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2320;H:VI1PR0201MB2464.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fl/ai3OgwVrzHfCIWvmjlZnpLbex63CvcWxIHYI6iYptXRKfzBqDhdz3pEtZwNamDywjCRLCUx4bZLJ9FGwa3YFgbRiNa+d/tIhsd8AdViw0ckwSfPe7Or/Y1wmcErivtzDIdlxwU7T/JLiNgPiyUTr3Wn6UIe81VRoz62a1+8S5DvZA1O72VoxSEJ0pS3705344NhoQxV6TbJzkBSqAHxZr2Id2ORRbHUmSKgwEi2GO6BIszwtCYDtyhLiPUKxau4K8rApt12zon8htEMOSHNPTC1zsTaGpDVZcaW5qelr/+RK+F6/u84yhuYhy82Srib6rM5wTWkXE3CjG8Xc9eXnNa54d9S6mYE0fbcnNdU0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: af7e5cb5-79d7-47da-0455-08d630518868
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 14:46:46.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just drop the "linux" part of the path, it was never correct.

Reported-by: Joe Perches <joe@perches.com>
Fixes: 256ac0375098 ("dt-bindings: document devicetree bindings for mux-con=
trollers and gpio-mux")
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48a65c3a4189..11cc90d7fb85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9864,7 +9864,7 @@ M:	Peter Rosin <peda@axentia.se>
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-mux*
 F:	Documentation/devicetree/bindings/mux/
-F:	include/linux/dt-bindings/mux/
+F:	include/dt-bindings/mux/
 F:	include/linux/mux/
 F:	drivers/mux/
=20
--=20
2.11.0

