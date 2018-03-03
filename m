Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124192-2-8813887680734264150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES dask.us-asciiro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124192; b=WUPXSJfM1ohe4zrZvuF5GZRVuqW+WJW0IlBoK/g8oLMJXS+
    cQw6EC6y97I4kbcllbN4KqV9/9cfCFaenHSGsrB8gOwkeOE/tX7zRCl66dKNBe0J
    iN+0st34AMlqPlp3RaH05ecYFZQ+QE9jzFy4YERn9gfRkGTX/Tnx9+7z2OlTYiDt
    w28JuMrAm2ewuRVlxxe84eCmUwEGr3rjRVniRozK/jxORhZDI9vAcZlXehJVxTqL
    qQFWz74TTgOSxe/8UC08cTTtMSkk0hKYjASJ5IACClb9uNiswbevKRqHMtNzR79x
    gAT4mWBYB11IKncDntVfcNb3n9kyrpLnITNt37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124192; bh=LQ9EfC
    cd5chc9un1BE21fhwPK68iJahImGJsKrJ1TN4=; b=v8SbL4RsnA7MPh5JJmLrCS
    bKDKRt0zz/0qtxL1SfPKNU9/Y3h9/0XOEpJPIekKhr3NQMlasyGJPy3dy7ZMfcxy
    vzJBVuBic0O0iQPC2xAUf6vzvupcS9m7wbQPY6/v1rSXx2mQEghQOPlWULbA8o/i
    B7HhWtUc5AV4NXVBChJLMdATAVVGMKWciksGjbOvpBwdJYwyKfHOAcTSjRkh/a6J
    rEWgp57DncCOycDYXsb91NmO3FqnvdZgFPa4L0gQkvI47NkSiQfFcyKndUm9vU3D
    ZZ7p/FfTamfacogMGpneYStQUm/YM0HNQIbn7cTIFhpytygxxGTz/F1fjFBg0Icg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lAf+H7Ck x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lAf+H7Ck x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeCCW0L (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:26:11 -0500
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:16768
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932576AbeCCW0J (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexei Starovoitov <ast@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 041/102] bpf: fix stack state printing in
 verifier log
Thread-Topic: [PATCH AUTOSEL for 4.15 041/102] bpf: fix stack state printing
 in verifier log
Thread-Index: AQHTsz5nvfAObu4f9EalOx8pUmKFwg==
Date: Sat, 3 Mar 2018 22:24:33 +0000
Message-ID: <20180303222318.26006-41-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:9NA2v3dmtvOjXGk8/A/peiu92RKBgihPQHjtvR52Viq8Unq6QgM3oD41/8wd1WZR4HBsvZBqNTDwVHrDe8vrxbazMGs0qFIiR/01T9RIEna/fOGATiFND1lGXbJsIIff99xnkuZTfl3vq0Te+siWKSCHC3YaU/V+eay55wetwBxaZvMQmc4iAk+DmWDkq5Ef7CCfsNMong6E5eLbHzDZ6AS3u9xBj+cIy6A52Me7WTXPKFBY7sWP2L32oR0w4FqO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe815802-55ba-4636-0328-08d58155bfd7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353B7F4B1CFD7E268A8117EFBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(67672495146484);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: aehEs83uDuQvJSJIqB9gh9RdxBVR8dllpVy/PxdH584H+rmXeE6lsjGow1SvMgEd1x/tJLcDKjKfkkjsRZ4p8wjXgl5L8xaVm8QtOGx2n6A7pEookk0jBW7WT0N8YWnFPReNHRhYOkNcaik2AB/PdXDpjEENVH9WynZf0BXYuTA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe815802-55ba-4636-0328-08d58155bfd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:33.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexei Starovoitov <ast@fb.com>

[ Upstream commit 12a3cc8424fe1237aaeb982dec4f0914ddd22f3e ]

fix incorrect stack state prints in print_verifier_state()

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13551e623501..51cb3f018606 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -279,7 +279,7 @@ static void print_verifier_state(struct bpf_verifier_en=
v *env,
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		if (state->stack[i].slot_type[0] =3D=3D STACK_SPILL)
 			verbose(env, " fp%d=3D%s",
-				-MAX_BPF_STACK + i * BPF_REG_SIZE,
+				(-i - 1) * BPF_REG_SIZE,
 				reg_type_str[state->stack[i].spilled_ptr.type]);
 	}
 	verbose(env, "\n");
--=20
2.14.1
