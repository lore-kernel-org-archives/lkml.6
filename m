Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244340-2-15928257946889135212
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
    1523244340; b=rmAw48MxqeBjDLVExToqb9aHk6wJLUQm/QGvaoBa5mK78pjGr+
    QH90EMbw7R17saqsKPsMzfQPumYfwG+xnsnhuzhleDf0uAWTXbUB4kzgsK3GaJhA
    CyjpqhQtVsNf4Q0wTJ946+4cHCfV9/BZQBarEnWR+qUyMzyWNXw0IjvqS4PTVqv/
    xdLkoySglWigTaTpzpMzukspDm3QLhTZft5w2dO2rhLA7jaR7nxU61XqdjbVdIRC
    a7Fi5SZyjVv1d7UXI1j9bBUmaFxhqBO2oVn+2n2pviHF7Ba6MkZw++KcK1Yq2on7
    +jRMFEnh6A8FrEmMrQk+7sKcJiBfFzp/tYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244340; bh=3O4dNRB6BQ
    RaZjhFlK0bdKyYn4v3g0sfGiuhYW5h/So=; b=jaUSLHmqVLe08JQSxMj1WMI8yY
    z+tGl5/uvXzIQGZgfRTmd6cJBqrtgT515Mimv2LipdWuV0uR+xnxuWQbvg/aWNq3
    3e+j+1Gl0eJostKy1w4ysD9jRIIAJ1ueNSnXQIagRQY40Iz0T7Xr0SVor5bdcMgd
    uqoKgbZAxr97lQGr228H1FnPp8HPbb9yeonO/pY0SXGcduinglck0FKBoYMGv2bm
    DaTncS+ukHcU464U7GZvTfQbhwFT6zoBWNiMK2O7t1wUjRaqOOTqf+LPo+S+p+tW
    5Z2a0WgTuzUZ0YgrAhVaOWn59WmZ+2GyV7ESfCelrXcu0qcL6XajgiHmTHGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XktOC0+r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XktOC0+r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPL101+it6EBZ2SJMuibjxfBs+BJygPBi3V9oC1bUlkzID4ASchvaqc1k77xOK83LPoExGb4eJ0nzJI67UPKIcnvsBNbLJJ7lQayoUVm1nfM05+mlaep
    wrl97/uRx27uRf+BKuIpC0+xlUhOP7LIp4WkyW+wr5NIF2iyvk12wEgK8AeS/8XiWSZA8PurUkL0OAYxDrEUY1dUl3/CE2RcBAypII+EbwLADf5C0bu9RBKJ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=nzaWDj09C8IvQ_L4_H4A:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753549AbeDIAWl (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:41 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:31261
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754641AbeDIAWJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 019/161] libbpf: Makefile set specified
 permission mode
Thread-Topic: [PATCH AUTOSEL for 4.14 019/161] libbpf: Makefile set specified
 permission mode
Thread-Index: AQHTz5h9BrbhsQfiOkyq/+cdYdT16Q==
Date: Mon, 9 Apr 2018 00:19:56 +0000
Message-ID: <20180409001936.162706-19-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:ncScINQUwRS/q7t24CBBavHWsqW4qwHagFRHkgg2FY42J2Ie8PFfXwvB7v5Zli+BXfTo7fjNptmwzUcIxq+tIegX0tHEXQiKAjSviGRa0dk15ZYAa31j+9qcoGmZadyec6+PJLuOljt7CSCCZD3MgVEzleXxTXfwCPLxBzRTLNs/0mpYCMa0lGxSv7f8mIYGNjnFCrdjTYuBrGuYYnEdFw2d4Pf2x2hfktPN4V8elZLvH3IhSaU/icAr+gNBu/32;20:jpE+rb2fHXnBg+K4PAEqLsU5oNVV63qnKmjIRIVnRsOzxYGvRZ4sNGtx1wS86yYgKJMI9Fnb72UjypSsX6xsazVMLN0/VL8uXkF5QZ7sORpBbiN4DmRmvuisu8W1pxzJSvrmpP8y6p9FFpHiwkYz8vZT8ifT92PVXhTc41cjpkA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8815f7d0-db1c-4250-bda8-08d59dafed27
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966C137F3B5D9A8F1F655DEFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6666003)(2900100001)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FDY9nX7i2Q4557+o2XiYbbwnoCapULL/c6gddGGF4WIjvcykI8uRCnWD/UhdBG5OuQP0Y4tBxKGzxRa95hRaKvTxKwti0W6uxqjs9FwYp+MUkG20ORI91F8jdU/4/2NBlnLPSer03uDxBooNUM6p7U6RvtTm7S43GNp18DOfC5pfLhma2gxCWZ3RGr8jXMcU4F9JIee/LItDW3bUnCFZDFjUzPdiI++eVj0dOJUE7OyY+imt5vflJdg0NlEQMFlsERFTbe1CJWpF3XiMEj1zl9W/c2E0PMuhfYz86X7sKnWRk/jHTIXOEuuPzoVKLWxviPNQ/wPuxx9svx1CpnAKlCNy0Y2crNHne+2PeLu8wuCShLkATbH882+Xs6OFuCB25w4RmoH1RaYRAlbHCMLrghSRq8A5ZLneEnyUS09sxD8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8815f7d0-db1c-4250-bda8-08d59dafed27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:56.7075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
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
