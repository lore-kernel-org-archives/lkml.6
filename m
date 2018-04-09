Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239159-2-6445494856545443631
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
    1523239158; b=B+7PXB9HeptWdhpIHcueyuuA5z9TSA3d5uOC74a+WDer9LqK8a
    P70e/lHsC2q6knFBBnzoXZ6RiC74cqJ6ZilR7Ll8bNdelNfpo3Ew+jNg43LQ0Aip
    Gqjm5j7TGeLDz+cecC4NPculg8Dce26wXYBN1jnFSMd3Ra2nfn32MCVXAgS07O3u
    fP1zat2IXnqmtN7VuJeuzjzOdwl6kyi0itZ0enJ858dxPahZ94FOexigBHrw/wjc
    2yXvuF9/gy7y5NGKs428rqKlb892gh5KB6RMVe1y40yQQA2ETSDBKq1OFLxgbqhW
    7yK2SJmtI8tki1eRjVFjb9vQHDtcD/xkBPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239158; bh=h/ok66dCn+
    +IhbcSbC/KnQk7w9N0o+KLJhX+4oQvobI=; b=n1UoqTIzaAroudNbHyPn79qf6v
    pec/FpqtJC+4frBrzCPryYwoxEvUVp4fkbkjWdiGV1dXbewdx8eQSWe4j1b3LGWD
    VRolQr9zt34uO/JRf6REgv7eoqz4yGQOcd1BeVAn0wu5JZvOZZ35prbVu98hJNxJ
    92CArZXX2fDBjY0DuAy4w8vFWenpleFr/Ojo5w6dVrZuJ+J++UiX3GmJZddqOw/e
    nC92iCO/digzagFFN2bafZ55g2NIwcMn/H+KOAh8EUPsj+oNII0mzsxIKW1lj72S
    +cRq6vQLWUsU5Lu7UbQuhW7vfDHOIINmSqAlN02GQWDwg+X3Pv8JhV+nNnPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aa9YHH6M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aa9YHH6M x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLkR9cwpPL7SmHBis8bnGCyMPeA0mF1kaighSl0UAbVY782ICKH/gLJQkhe3s4Dx4OzxRKwCMqv45tkggY2kW/UeC3EII8BZsFaXWG4gdWkPQ6QF0Int
    vHyUvLr+2yK6YG/c+X7ScHUInRSSiOwd/Hbcl8G9GrTYg5AcHGzeYZHFf2vvp2bFym3iUPPA2Qp7pegjTDxsjSTA6d0o8lDbGcUTxl1wCeIJO/xN77kWszAy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=uTJJjIG0AAAA:8 a=20KFwNOVAAAA:8
    a=pGLkceISAAAA:8 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8 a=PebE5CFpDZZ97Ntc4S4A:9
    a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Oxz5h5Y_mNNx07kSEfs-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755231AbeDIB7M (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:59:12 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:51937
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756486AbeDIAcR (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:17 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        He Kuang <hekuang@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 208/293] perf unwind: Do not fail due to
 missing unwind support
Thread-Topic: [PATCH AUTOSEL for 4.9 208/293] perf unwind: Do not fail due to
 missing unwind support
Thread-Index: AQHTz5lHHRYH+9j5+Uuk6HAGe+lFVA==
Date: Mon, 9 Apr 2018 00:25:36 +0000
Message-ID: <20180409002239.163177-208-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:ZqlyGXy9uLJNC4I0Wtgi8H/oVULrlZrWEYT8tQiuipOjrm3yBwnbBPcDhCEXdqOSH7jOrP72oup8Gf7sNgiPs4qXzIWkkRC7s7YvgXl5TNdO2ydXMpx8yb4jDzmoSoV7ZFYrXnsX70EHTVIILjntVB7GoYLreDNbTuEQGm9XKFdObgNSBSKeNJ5xeJoPeVo1xJ49+MbBuiEkktxaiRDUjoy2TiT2KPS4BZLeQiU5ycs5Pgy26a2in7bhMRPOkOZ5;20:z4Dyjru6cSXOoZtv1j+Vu3fMNAKZUy3Dcp1jqTBCiw+2aYvRqkbjfqpgVzudJbb+pc3WeVLMA4T8M0amb/bf1+eehaP4Q5EQeW9fuvbOnc8kUkR4YuAjabyvfVaIG3RH+Rhi/2fC/gEpZfldFryL4bvMVfgG7eMW2ONtDb6EmII=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 496a11fe-7816-4d70-4b77-08d59db155fd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870BB69EBBA5A921AA13766FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171)(50582790962513)(85827821059158)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(6306002)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(39060400002)(486006)(107886003)(59450400001)(2900100001)(97736004)(966005)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: JbnZAtaFsL1tKOcQf7NzFh82yNYzSVx72Ma8f5fHC+oFrASA3X8qLI/gO9ssQ8neJaJ9WLTb/kK/j6Jsm2t4q5qM2Crg41JO+CEmEBlxWyPfchXL6U722wycRRt9FVBcT8mhoehrRWwCXJSI4Id4sVtQXscJ2ygP7Wo56zsw4aF2TkoEaG+FmTcez0QU3WqHSeRqedvTbVRSMv8Xt6icH6lBzeFx8mommLMWyPEq3WPTsAsUvonaV58jg8iwwr+35vIqfPDf8pRp/uC+Fmh9TVLAl3kugDuUA5qRoMcH+egJSJNW6tLN5f9YFLLEH5JtzZrVsv2+376fzPfyaiHIVr6JRXfrPSrJx9QxNdSXSkyf0ngvJKboHOTO53usHSMkP4Li0dE8FxLUZIh3JUdPf1EwPX4tJvAb1xLY8UOpJsw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a11fe-7816-4d70-4b77-08d59db155fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:36.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 1934adf78e33fa69570a763c7ac5353212416bb0 ]

We currently fail the MMAP event processing if we don't have the MMAP
event's specific arch unwind support compiled in.

That's wrong and can lead to unresolved mmaps in report output for 32bit
binaries on 64bit server, like in this example on x86_64 server:

  $ cat ex.c
  int main(int argc, char **argv)
  {
          while (1) {}
  }
  $ gcc -o ex -m32 ex.c
  $ perf record ./ex
  ^C[ perf record: Woken up 2 times to write data ]
  [ perf record: Captured and wrote 0.371 MB perf.data (9322 samples) ]

Before:
  $ perf report --stdio

  SNIP

  # Overhead  Command  Shared Object     Symbol
  # ........  .......  ................  ......................
  #
     100.00%  ex       [unknown]         [.] 0x00000000080483de
       0.00%  ex       [unknown]         [.] 0x00000000f76dba4f
       0.00%  ex       [unknown]         [.] 0x00000000f76e4c11
       0.00%  ex       [unknown]         [.] 0x00000000f76daa30

After:
  $ perf report --stdio

  SNIP

  # Overhead  Command  Shared Object  Symbol
  # ........  .......  .............  ...............
  #
     100.00%  ex       ex             [.] main
       0.00%  ex       ld-2.24.so     [.] _dl_start
       0.00%  ex       ld-2.24.so     [.] do_lookup_x
       0.00%  ex       ld-2.24.so     [.] _start

The fix is not to fail, just warn if there's not unwind support compiled
in.

Reported-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20170704131131.27508-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/unwind-libunwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-li=
bunwind.c
index 6d542a4e0648..8aef572d0889 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -50,7 +50,7 @@ int unwind__prepare_access(struct thread *thread, struct =
map *map,
=20
 	if (!ops) {
 		pr_err("unwind: target platform=3D%s is not supported\n", arch);
-		return -1;
+		return 0;
 	}
 out_register:
 	unwind__register_ops(thread, ops);
--=20
2.15.1
