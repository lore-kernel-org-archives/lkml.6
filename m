Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523236767-2-1279414552834658273
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
    1523236766; b=Qgg7EvMPb3qqMU18mgn4J1GTMhcb8p4obWMvxV5R1et9UxEu4t
    tEYWEQPuMnJAICmyvGS05ZkEete/POmQ0d4ahoP7VgZi2dGjOtCg6Jq78UzoNZ1g
    qRp88+wSNuVQPkT01x8OgFKCPbWQydKLdf/OFbluZGoP5e+QqD2Y7g7ZZ0cvcNYw
    TTQogA9nOESv5yP7jrJNOCXw+MYcgaG6a5YZaLuKs2+BcZcTNCnApAUCAjPI+Ugy
    bNWoNl7FlnYN9mXHHrqlg5FvjyID/pN1HgA7GHNEmJFOb1XmPkYY0hIYt7FHZ3O5
    WTVcuwvoBWn1/1d4DGVQkj3ra/rGvlhiyDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236766; bh=Jxtnj9YhDH
    gMsiJRXhEhxv7SKsRuSYjGLlg6qfudq5U=; b=LOp6CwH9t29Xx51Y8Ejc3C4z7I
    Y05PeQ6qUDBlDQ2oXaVlL2Dajjg+bYxzCRqEcBZKdLmztjf6X59kzD3k92jcd/Ve
    l2aMnoxJgvZoola2sOyahlhXAa/EF7/tdMFdEuGAGcrQL57oOyhMGJoTV+bhglFl
    azLwtt3S8qjJFb6tvk2fkSP4sxrQHGOLd5umuzDZ67XbF+JljLBDyJdPlV7CpSdf
    FUOQthym7ZIfaYAX7LPW2zHw2pTdAal1X2TRIXl6e7ddeHGbiiFtSnfao9tfP9B/
    JvEsQi/Fguu2hVhHZwdSyCuMZyBDzH97efeBi0CqLRC6Tl5gnFnKszCPPQlg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kbFfZH8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kbFfZH8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMog38x04Pet0pWYV97ARtDysH9Hacn7AUn7sQakChYbLbcphF1zDKRFllwHQME+02fc3LYToRP+0UqB7Dd0qxqeikupYXduowEoSIw2bDKcwoCxkDfF
    /YqTVwxcb+z6+pX+W6No2eirEuczr8eDzGyTwAxGkUiTbqBD22qNb770WOXc1wiOJVcYHqqBXNDnrpE7AKY25aoy3byS+AswVQsIC6AnIenzU8vHdMZTX3ev
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=EM_MaSWp-SDTO4W7sSsA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbeDIBTW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:19:22 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:3040
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932820AbeDIAhp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 096/162] perf intel-pt: Do not use TSC packets
 for calculating CPU cycles to TSC
Thread-Topic: [PATCH AUTOSEL for 4.4 096/162] perf intel-pt: Do not use TSC
 packets for calculating CPU cycles to TSC
Thread-Index: AQHTz5m+oALNFDerpUatPCekgmdJIA==
Date: Mon, 9 Apr 2018 00:28:55 +0000
Message-ID: <20180409002738.163941-96-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:vJWr2TkcA+G6A67ZD7xq/ALLbLLneVQphNY+pjzuENwuwezE+aPC58r9NoWomHKJJVp3BFz47yxPtFu/t3JkusexyuqJu6FLwuSoyRi9Lah2Uhuz/gkpwjz1utw3LtcZJoRt5cxW7nvNDJUhoP5vFe8frkQPUulvxOe6vViu26BCDTsVP7YuGB/ZYVMOZw1Zg1ks7aBOC+x56YO/70u/DtgzrRmjFeZtNteO8aLr12YLBhvMRrtM1MWoJl/mFcb7;20:US3IXXd/udv7yOyev6iJoIlH2ySuxmVAo0ElGaQqaOkTzhcJN0tn0Mr3R0gwnqsIl2377JwQjXLpzHI38S8fkrIG2abnty67K9VHN7Wcso9E6bxDmzLPHbb3ziEUURO7zLhhTLLW70mE3ljm8x5LdNMVX9VQ3ruOy0W/6kbx1Io=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66b66669-d090-436c-f9b7-08d59db21a98
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031727D0721022474EF511BFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(966005)(7736002)(11346002)(26005)(6666003)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(575784001)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(110136005)(316002)(6506007)(446003)(107886003)(53936002)(4326008)(105586002)(6306002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4mr8Zxh2LfiPxUXQ5HwQC2xclNvd1XyCjLtRzYfCvgnHj/XEVTh16tm4BQ0awMsVggDLYGVFGSBJl2fQtd+oHvBChMMm73wE9Ojv/zCZrO3ZIEyOSzQVsFBy4Na/QbXRzCfEeUe5wtHu9KSkP2cqHBq3ghOajumHHZY/n12aQiswMRBdfgL3VBNrQ8V9ihy3gg4CIaBC9yJ3b4M2WiSuSmU1v6JxQgqTRBax4TB1ZHoFIjbViN8tfSo0baptUfpnJGoN49bMF0EOA3aLxLfA/Ns7IhlXiiv+3+IbUZPRMWBgVYuTOrKMgGfn+jDHTT+lt+nIQvRpwmrPyoYcaUkSfBMYueW7lzJrYQ5etyOM58aLJNpe0EhsdoyHL3z5HNxLMqFkLPHkOFE3GdwqCzpJTJz3dOVhcu3KwkJId9AXHQ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b66669-d090-436c-f9b7-08d59db21a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:55.0366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 38b65b0891dc129dc0a5ce148a21c481e667b395 ]

CBR (core-to-bus ratio) packets provide an indication of CPU frequency. A
more accurate measure can be made by counting the cycles (given by CYC
packets) in between other timing packets (either MTC or TSC). Using TSC
packets has at least 2 issues: 1) timing might have stopped (e.g. mwait) or
2) TSC packets within PSB+ might slip past CYC packets. For now, simply do
not use TSC packets for calculating CPU cycles to TSC. That leaves the case
where 2 MTC packets are used, otherwise falling back to the CBR value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/1495786658-18063-37-git-send-email-adrian.hu=
nter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/pe=
rf/util/intel-pt-decoder/intel-pt-decoder.c
index eeeae0629ad3..fbfe97dcdaf0 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -696,6 +696,12 @@ static int intel_pt_calc_cyc_cb(struct intel_pt_pkt_in=
fo *pkt_info)
 		break;
=20
 	case INTEL_PT_TSC:
+		/*
+		 * For now, do not support using TSC packets - refer
+		 * intel_pt_calc_cyc_to_tsc().
+		 */
+		if (data->from_mtc)
+			return 1;
 		timestamp =3D pkt_info->packet.payload |
 			    (data->timestamp & (0xffULL << 56));
 		if (data->from_mtc && timestamp < data->timestamp &&
@@ -808,6 +814,14 @@ static void intel_pt_calc_cyc_to_tsc(struct intel_pt_d=
ecoder *decoder,
 		.cbr_cyc_to_tsc =3D 0,
 	};
=20
+	/*
+	 * For now, do not support using TSC packets for at least the reasons:
+	 * 1) timing might have stopped
+	 * 2) TSC packets within PSB+ can slip against CYC packets
+	 */
+	if (!from_mtc)
+		return;
+
 	intel_pt_pkt_lookahead(decoder, intel_pt_calc_cyc_cb, &data);
 }
=20
--=20
2.15.1
