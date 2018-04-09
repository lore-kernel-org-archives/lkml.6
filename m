Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243715-2-18249097173351051797
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243714; b=qVe9HfyqMU2aFoHfoznYEC4mt4/mfEUjtkifzQABpJQLIlp7Dc
    Sg5VpGEW0d3Y8JWJ3HejqGKwUG+i7yjbROalGtobLngHs1E7/1/PCr/HTyyN0yEO
    oCmxEAe4dZI90H5FnoHSauJFa5z/SKXu//XMxDKoETewNRY600PduPbgCDVyvCQ6
    Vd4rD8Cswyl1OP9hSDqgxgYShr3bHG+563enXBYb6rKKGaxugHtYQ9ggu7yUcBRP
    IROZ9eabwe6Ip/YNjRfZCSupudUB4pg6VZd38VtZ28elO/1NFHMEvRL/ODr7g0qo
    59kccOXbY5jaIOf0L8oExBPmaxtnRHzjdcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243714; bh=lLZIdX5CgD
    Z08SWfXVHt8psMO1O5AJtaP5ml5D9Y2a0=; b=pMhfaCM/vSXDrMu0Dmh+WirMT2
    W7o7KGjTg6YvCu1TpuSVpF5cggvq0x2A618T+LAMv3jTjuRrPmH3uyhcidO3M7+V
    z54yYsqFIIzgY2MsEFiPsfuoRq2xvUHu+S5jgYyfnWHmDGyhteAfRE4c2JGZoOnh
    VgBADQ7gOujUCpStRmHPJ25O/omelDqk4/oYnTOgM074iyUEyz0KkWe50Ro9ucbX
    QyNqLVVURaEc4+5fYqR9xic+bKLU05odUvCwGBrixCeic93RPnCd4nc4/jMfFAGV
    k40UnsnH2RMTH5RScQkvw/kUmZy77LMkvrcDRyoQ8Ax0s/0yg9jY0G3S7Zvw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DdNcmRWL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DdNcmRWL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDplqyPPI+Bq2x/rHs+8ZNIJ/pNhM/EFkdVQIzTE1VBsJEpi4sxyjuw1JLsStkISkWWOtfFD9tUy/Abhp6xvnxSwChMzPc+HZZkM6ePb03agi3UKYnJA
    dYHWnNC5NTYE49xIVxDIIvBBv62fM7EOS5/oHVltlGhbrocdHfafot826PZ7WsicRSqaIz/w+qsvkLZB4JPcPHlRxtxzQlD9NO08hZDyeL3ryYvVOyyMvKa7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8 a=N8YU52xSM6bygaFl0ccA:9
    a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754924AbeDIAXs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:23:48 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753655AbeDIAXp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 065/161] bpf: test_maps: cleanup sockmaps
 when test ends
Thread-Topic: [PATCH AUTOSEL for 4.14 065/161] bpf: test_maps: cleanup
 sockmaps when test ends
Thread-Index: AQHTz5iWM+6T7Mt4h0G4VPJ5zW+3Og==
Date: Mon, 9 Apr 2018 00:20:39 +0000
Message-ID: <20180409001936.162706-65-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:+sNV7MFKVKP+h428u8JOdvbWXDIBy8ROYQSi+LJDu40QQc5gUiRh4rNwPZF46X5aLFsjvNJF6PRHDs5T9N9hTfndYdw5f215NG04nO5b7tWHmLQ6ppD0q614KCA2tr7KPN/ptm5FLncWm1lJuAOyFPFNKZPeXNYXp0SroukNeXIFL0xGIWxWWRiEYlrK8NCG9e3rwDdeBXszRn8CT7ZyfAGM7FXpL8y5ieOQfPziBJwtFIHzAm1qz1nJGQj47q7e;20:9XUpX2t6qOppMt2S3Rm7AaKh7E4ME6CIWHnBWCeIxvp8tJisrAn4N5cIiW97gEKLq8JryqE2aPb4ukWYLxcivHXdkcOawkj5zqYnry/dYl8CT2cKQAnahdw2kcbARSmiSxSQsRZfIkAnip7B7DlI+Ov4MY+M0n1vydIApoi1YCQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b3286d9-19bd-43e7-1d69-08d59db0268b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108042FC22E1C7B2E6B9D667FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(6666003)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(575784001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kRIs/LtReeb+83AxFc/Y9wGDfbdxNdWg2zqOdnM8+gKQAcboqUSOjZwryXZy5Ib+tcoMQNojgjwd+2PWkPLON7y/t63crpHnJObnhjqcUxVoyubFbTtCzvD2bWmYxZqPkYjql4a8hLFRTv/y1Db8lqdLKxlTOeqflXk4SnwQXy3ckFp3odnygOkbcL2RA5kbvW6mfWVVOcPbgNpb6Jqgqjf5Wp2mutpuxFve/feoZzHEkPNhhGaNZJmorJnOWG1tbmb3nrTXYJu9fWgSBJkoP6+6Iu+miu9lSuwse+JkLRvvWTchHFhViH1g+wXzO7gBYiaYgK7AtfGBObGQhx+NEb307QrtxrRnUBc0uHCzt/UZZDY41HfKsCix3qjZ4T7KxPjUabgCc3UEegtGj5KCLj4Dn6Y1ncUaJEk8IAAoi0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3286d9-19bd-43e7-1d69-08d59db0268b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:39.1754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

[ Upstream commit 783687810e986a15ffbf86c516a1a48ff37f38f7 ]

Bug: BPF programs and maps related to sockmaps test exist
in memory even after test_maps ends.

This patch fixes it as a short term workaround (sockmap
kernel side needs real fixing) by empyting sockmaps when
test ends.

Fixes: 6f6d33f3b3d0f ("bpf: selftests add sockmap tests")
Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
[ daniel: Note on workaround. ]
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/selftests/bpf/test_maps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selfte=
sts/bpf/test_maps.c
index 50ce52d2013d..8b9470b5af6d 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -463,7 +463,7 @@ static void test_devmap(int task, void *data)
 #define SOCKMAP_VERDICT_PROG "./sockmap_verdict_prog.o"
 static void test_sockmap(int tasks, void *data)
 {
-	int one =3D 1, map_fd_rx, map_fd_tx, map_fd_break, s, sc, rc;
+	int one =3D 1, map_fd_rx =3D 0, map_fd_tx =3D 0, map_fd_break, s, sc, rc;
 	struct bpf_map *bpf_map_rx, *bpf_map_tx, *bpf_map_break;
 	int ports[] =3D {50200, 50201, 50202, 50204};
 	int err, i, fd, udp, sfd[6] =3D {0xdeadbeef};
@@ -868,9 +868,12 @@ static void test_sockmap(int tasks, void *data)
 		goto out_sockmap;
 	}
=20
-	/* Test map close sockets */
-	for (i =3D 0; i < 6; i++)
+	/* Test map close sockets and empty maps */
+	for (i =3D 0; i < 6; i++) {
+		bpf_map_delete_elem(map_fd_tx, &i);
+		bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	close(map_fd_rx);
 	bpf_object__close(obj);
@@ -881,8 +884,13 @@ out:
 	printf("Failed to create sockmap '%i:%s'!\n", i, strerror(errno));
 	exit(1);
 out_sockmap:
-	for (i =3D 0; i < 6; i++)
+	for (i =3D 0; i < 6; i++) {
+		if (map_fd_tx)
+			bpf_map_delete_elem(map_fd_tx, &i);
+		if (map_fd_rx)
+			bpf_map_delete_elem(map_fd_rx, &i);
 		close(sfd[i]);
+	}
 	close(fd);
 	exit(1);
 }
--=20
2.15.1
