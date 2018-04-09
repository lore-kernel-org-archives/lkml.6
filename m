Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246970-2-17506738126440055041
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246969; b=FX7BNZ49fcJIezCg7YS3Gp5a7kRBvH92IL83XDdwVf0GZaBi46
    lt5LFj8aSvnkK0fboA+E9srD/jG1XMXvq8DHcFVFjTVvTcICIbebTCTe+oemwqJa
    cYrGllhlG+3OQpHYjDICievwAl5UfWdctmwiOXcaI5bjRBGxWdk3q0eNhNbiAx0l
    xeG23XZskc6wHT1WH6GuQAXPN8WW4ngRr30CAMCcSglMkEsr/WWnjVFZTfvH7GTc
    hWUFRY1YTIi5U7sMOvKZcdMH14ceCMWik8t9j3l97iunjWEQXi9awcnx5RlUdtmR
    P+RcHAVjx3rDjgKqfndIJTQ9V9UeoCW3VwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246969; bh=3O4dNRB6BQ
    RaZjhFlK0bdKyYn4v3g0sfGiuhYW5h/So=; b=f4z0J3HcOiW0RFZRGsgAPn/ue9
    zH4YXjZqxM38LQNv4DSVXLXLA9JYwzwL47TngsxpsuZCUcZOFUpVGXNUp341AZNz
    qIT+xF6qTc25+z8pxu80LGc+W+Im9ssh8xO0OtA7ZXerRz2gMKTmXx63m9d4LGL3
    MtVCkNF7uM189we7eTXpZuBbl+GTr0B68V1wvx3sA9EAo8mjilZfRgvyNNCB3uxA
    oUdCqqGJC7FTd+S8qDhxSHAppUOZw2Pg8HdoGM52It1+DEYjR5rtdte9oB6xe+po
    9XHbUVzozbeOJD7slWGkO1xbOcA7kvGcplhPokTFtVs2b4KGmGO3q01xAwvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fBfbB/K0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fBfbB/K0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHzQ9PDautL6Vfvg9bx3/eTca00Y+voaN0z7d9oRlE4KOaSIzaC9MzmUusNvEpY5hcXsQmKzUaZBffuZDTEMWUS/FQuG+lZDkf2aRHI9S1S+09TiAk0b
    qqNOZ0MoCP+31hhvJFHh/C7eNgeAUzxGDHP2ixrglu7/HarM6/TMTIZQve6EGnoSaoaDPo3qkR88N+PZdrOp1+f3WY5NVAvBxDQvWVQtRloGT8ZYqTwQU2Mf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=nzaWDj09C8IvQ_L4_H4A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754168AbeDIEIe (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 00:08:34 -0400
Received: from mail-co1nam03on0128.outbound.protection.outlook.com ([104.47.40.128]:49080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753065AbeDIARI (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 023/189] libbpf: Makefile set specified
 permission mode
Thread-Topic: [PATCH AUTOSEL for 4.15 023/189] libbpf: Makefile set specified
 permission mode
Thread-Index: AQHTz5gWxTIyBx6D60iT/JVlILDR9w==
Date: Mon, 9 Apr 2018 00:17:03 +0000
Message-ID: <20180409001637.162453-23-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1127;7:kzKZe6r/mjEiMM5g0xUzAVdLZut/trZ1oRkTNoiGvxQmXSX7dmtAnwGT4xTK1v6bWYJAcaV0ZxTrHhDkJ5pGgWOtkb2U6qkId/g+pC+8ercvVyDfieTb1sd3NO+IMjdxCXRYbIp29l9W5b9pdxPMOIrx+7za8aM/u/r3OBriPLQVVgIy2THApRSBKoaBDnxa2pDSTq94DcePdq6c5Wb2eDW7EPxnBWyQtz+aXV3Z3I66ft7qdaibALoE8YA73cuW;20:V47xmsJw2SGpHgpMLTTEfk4Ny+2Yonw45fTAdQKLb7K9Jssbw/L1yWRvXnfHOiy5pH34SkirvouWKtaqtpRbKtNI91mNBhwWLW+phwSn2io0jFlvEM54nC60t+cyLlp3GVa+HkgAmRTWCAkQ78YcC5fGNwqhTOjlrscMMCb4ZnI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41e327dd-da55-48ca-0743-08d59daf38cd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1127;
x-ms-traffictypediagnostic: DM5PR2101MB1127:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112778E361C708F0355573A7FBBF0@DM5PR2101MB1127.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1127;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1127;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(346002)(366004)(189003)(199004)(105586002)(186003)(66066001)(6486002)(54906003)(7736002)(26005)(86362001)(316002)(305945005)(110136005)(478600001)(3280700002)(86612001)(10290500003)(25786009)(5250100002)(2616005)(99286004)(22452003)(5660300001)(3660700001)(2900100001)(81166006)(3846002)(2906002)(106356001)(6506007)(59450400001)(107886003)(486006)(8676002)(81156014)(14454004)(10090500001)(68736007)(4326008)(6116002)(1076002)(72206003)(102836004)(97736004)(11346002)(8936002)(476003)(2501003)(6436002)(6512007)(446003)(76176011)(36756003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1127;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: p+ds7fkblekl7o3N1RhzuzPlFbTfcnP62EtQREgDqDozg/+y1JwxWVDmWYYHBuMje3pYq7JoN+GNSD3nJyvud+wqy8SgFe3pr1/8FCjTY7VGHPMjm6C071/rCrlHzYFd3NrYd4hXlVeONcnRjzJJ1LyMAothvvJtwMCagT/c+N+/b7USL9nj6ZJFJ6HzryH4iZ+fks+Jgc9Xz+JUqPg2LWsH6KmhRhVJAW6s6LjYHRIJ+l6RAFBn1tBSUtsQ8woHTs/g2VJwzD1xWVRMv7P/v5JQCOWJHQIxL8bkVfvl8Nx8uqmqBJKpTojYy0dgYKZGuvrFGyGiQd/R59f8Etnywt7gOI1xEr4vdiAmTASNsCdkhJqUI3hUAQ5Ni3GQ7xoKygYAME5YJ5CFyJBsqgFjkAhUEdoMDcWTHw/0+k4e6M8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e327dd-da55-48ca-0743-08d59daf38cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:03.9029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jesper Dangaard Brouer <brouer@redhat.com>

[ Upstream commit 7110d80d53f472956420cd05a6297f49b558b674 ]

The third parameter to do_install was not used by $(INSTALL) command.
Fix this by only setting the -m option when the third parameter is supplied=
.

The use of a third parameter was introduced in commit  eb54e522a000 ("bpf:
install libbpf headers on 'make install'").

Without this change, the header files are install as executables files (755=
).

Fixes: eb54e522a000 ("bpf: install libbpf headers on 'make install'")
Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4555304dc18e..f02448e86d38 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -183,7 +183,7 @@ define do_install
 	if [ ! -d '$(DESTDIR_SQ)$2' ]; then		\
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2';	\
 	fi;						\
-	$(INSTALL) $1 '$(DESTDIR_SQ)$2'
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
 endef
=20
 install_lib: all_cmd
--=20
2.15.1
