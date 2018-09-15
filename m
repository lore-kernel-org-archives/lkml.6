Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FA2208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cJVyx3nO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FA2208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeIOGso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:44 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727866AbeIOGsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZA1WiwF3kkGC389GH6ZOLLzxbhR2iAp1iZjZFLbiKo=;
 b=cJVyx3nOmyTYtb6x+PwWvefCVYUIpfwo/JtYbs4UaBJ6q7o9Ac2LMnnYIgh1+1hhxnU8Gg+Oda/oYRLdMvzZ7jgMYzmSYn6ipeoVDlQPymyTjpeRG1uXcheUm3QaZmBtSiMngLiqXX62OE3/Mp+oqP/n2vR1fpLqFtZrcHDw5Bo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Shuah Khan <shuah@kernel.org>,
        Pintu Agarwal <pintu.ping@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 69/92] selftests/android: initialize heap_type to
 avoid compiling warning
Thread-Topic: [PATCH AUTOSEL 4.18 69/92] selftests/android: initialize
 heap_type to avoid compiling warning
Thread-Index: AQHUTJO1M56Xi+ELZkWzyXvWDdnR/Q==
Date:   Sat, 15 Sep 2018 01:30:38 +0000
Message-ID: <20180915012944.179481-68-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:bzmTbpV5Mg6rCG4Yl+zYCwgGfaxZJwOEyx+PCUlcuIHYVo1NR0TrQwKTGbL8/QmpTWBOmeKD6zw6HUdvZ9HpOApG30ej1QXQ1zl+1Ru3VKGem/2yBP5AKlqUSm58NfKs2iL4fNm2gwGNl4QOZ+tuamuXQS+83ApIq8uDIzWnVaWAWZ8kuYs1FrjN+hbE1+feHaJAOngIG+P/XuuL1TpE69q5q9OkDA1C6PqCXhstofxJt6CnWzZ85Vue5A2886LMswq7oU9O97LjU7qsh1bGg5sFxe3c9N6ThHm65BobmQ1MTMCXZQhoCBNxSKlKilg8v5uCQ4o9jJeRyBzmfJL8YSDMLf3PgAliVP5zXR9ZA1c0aJJsIH+BlBhaQ29K7deDMDZCSy7ad76XA+kPK6G5MfrluTU4zjDE4SZ1Sx+ZF9xsX470CSnOdl8JPY+tWlojxrG4CtNnhegMEK5tapO8SA==;5:0rOBcjtZmBBaHFn42iOJB5gbhr45SKX6cqcfh/g8pGb4K7XQ3/anmQ8CpqieuIieHv28vgd04o7dtvptyjEKmWdV3vbbL+nFL2hY8tRTJ6spXSxc0VWCIbj05LmpwqByfaEwGNGNWaLV3N7U7wFiPEGCUfn86FEu8kXFO347BHk=;7:1Ho3Z5OH7ojbck3Evb3fu7FpVQLMJceWZKLnl1mOdz4MnRsd6jaZv9ejnbcDlY9Y5EN8kwfUl6pYqy2B6CIG5iQZQTK4nKG/NC6V7PFG8FqTlm/Prfq9m9ONL8z2GlkFt0e5foA//YcXZ81q3UdhaFMOBdQTklBUPgEidKGkfD7er1LrOaFKqFulOdb9u+2RqQHs9q2HR29Ou5JKF9l77R21lBmSUgxEJN75WPXFFmsH+jTch+VpvEs+DY7kUTBt
x-ms-office365-filtering-correlation-id: e526b32b-3df1-4fda-f1ca-08d61aaaf89c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470A9BECB9C159CC927980AFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(170618885588394)(268935105599563);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(39060400002)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: zd6JjyoedCt6imLtZjMki6/YQGaoggrMRG2ULsgONDX0WpyTuzh4/urbGI6CYlbXNTWSRZPtt+4PchBRO9sLJmEjHcSdPzyDVl18D6i9Arns6wWe1fi0KgdX0wAMsib0OSnB7OhHbdqRe7Qwh73KBlztXI6ZBJ+VYz0xtCckOeckzHQPx4LCmfr25G/lyr6r54LJY5k84MoSUG9lNcX2uHdimu0mXGqtnOoTeX7M2iY1Ly+Ref2VvB021DDEentAPLjbMNfY8wwLsndxGaQGMNaeAaj9J8RwBew09cF7zdhSsW4EYP8LRMSnrR7ufgFPED7Z/ZjZ06xAAuBr6iv5HJiU7IGhlDwUUxTtnJt98cQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e526b32b-3df1-4fda-f1ca-08d61aaaf89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:38.3230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

[ Upstream commit cc7c673032fc7427087e74b75f732b43db38a256 ]

Initialize heap_type to ION_HEAP_TYPE_SYSTEM to avoid "used uninitialized"
compiler warning. heap_type gets used after initialization, this change is
to just keep the compiler happy.

root@vm-lkp-nex04-8G-7 ~/linux-v4.18-rc2/tools/testing/selftests/android# m=
ake
make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make=
 rule.
make[1]: Entering directory '/root/linux-v4.18-rc2/tools/testing/selftests/=
android/ion'
gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../us=
r/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o iona=
pp_export
ionapp_export.c: In function 'main':
ionapp_export.c:91:2: warning: 'heap_type' may be used uninitialized in
this function [-Wmaybe-uninitialized]
  printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CC: Shuah Khan <shuah@kernel.org>
CC: Pintu Agarwal <pintu.ping@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/android/ion/ionapp_export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/te=
sting/selftests/android/ion/ionapp_export.c
index a944e72621a9..b5fa0a2dc968 100644
--- a/tools/testing/selftests/android/ion/ionapp_export.c
+++ b/tools/testing/selftests/android/ion/ionapp_export.c
@@ -51,6 +51,7 @@ int main(int argc, char *argv[])
=20
 	heap_size =3D 0;
 	flags =3D 0;
+	heap_type =3D ION_HEAP_TYPE_SYSTEM;
=20
 	while ((opt =3D getopt(argc, argv, "hi:s:")) !=3D -1) {
 		switch (opt) {
--=20
2.17.1
