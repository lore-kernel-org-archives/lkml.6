Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245974-5-17741051495418124899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245974; b=ouX67VDCj/9qLwhh/GTWztku7KFsqwy8NDnc6ab2WBIQdBAo3P
    PHWhtaYXDc4SvyxZXdVBeBW3TaxeBb/HUY2j1xllES3MpRft0Q5BwLmgzsc2tisX
    rXLppFxl4VfS0rF4kH9XtNXz6XnjH2HTG6bA01CgSUJENHIg4iwhm/sw2+dEgYdh
    fliqk7yqzlPUP8QmfwQ93JtzSo1AmOgfsWr0ZXagvwD4Ysyg/zIT2HNYEKXQmVNI
    E3zEihBcK58Jec+rufDxVgg9mQ002SI8Brn2wJ4CkZJdl7a0d6s7DgN3teni1a/O
    Xm11aH5eGT/bxjBbAEy1IcrcXs4ArEauClVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523245974; bh=RAmpGm9R6NHK9tIKBfjZ2mivYR2gONTLtQq3mqSTKMI=; b=
    gL4XmYnLWRyhONNtx4etuhUuJ5HTTYVOoD0n9Go8upyswPAfplqywXm9PNey/iM1
    4//noa8Ek1Alz6wPciLUtki7JUZgvb0F1BZLJRyCLBJwohmGbd2h2qZd+Fd+CTMI
    bkpZoxMOwPQE52UBoE/glizVlfjLzAbUELhmMSZn2M5xzdc7KS0vRNS1anetpWQk
    NXTDYriu+TpDwgd2f1xHuZPPGwtCFmo+yHRJ4BaCSzM+MTeb/nF6p7XQcQxQsQkn
    t08d15u42rRtg5hUQH0kyhl8l+6EEhFzh7N9pOsNRbj6CzQfKpROb/yC89S/uI4s
    NSFoLA5muX9QSjYNs7yg3A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T/H0vWkx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=T/H0vWkx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLWRCJsEp6dgB2b6uyVHDpctCqz8yDj5AIXA2EHNrsCamngqOqVGSrqOftTqGJSXq7vGJX8IW20EH6jtxQtvw8lcotRcoUify/uQjsR8kRuKVpSfH7JE
    jcQl5r6ZCNJPR2dLoGFJzMt85Exp3GtkPejyqBIIfeWvtoqyhfJg+LrY6uN3I/gXiYz65f26iTmVbxm7wMsYc00kITT7l/OdvaCFM9ge6v/GLFmZYskxcm6d
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=edGIuiaXAAAA:8 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8
    a=yMhMjlubAAAA:8 a=c6t4oUsiJohOfOJFmwwA:9 a=QEXdDO2ut3YA:10
    a=4kyDAASA-Eebq_PzFVE6:22 a=AjGcO6oz07-iQ99wixmX:22 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeDIDwv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:52:51 -0400
Received: from mail-bn3nam01on0100.outbound.protection.outlook.com ([104.47.33.100]:20288
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753949AbeDIATY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:19:24 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 100/189] samples/bpf: Partially fixes the
 bpf.o build
Thread-Topic: [PATCH AUTOSEL for 4.15 100/189] samples/bpf: Partially fixes
 the bpf.o build
Thread-Index: AQHTz5g6KDdYT16SB0iD2rBQPzHkRA==
Date: Mon, 9 Apr 2018 00:18:05 +0000
Message-ID: <20180409001637.162453-100-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:vSCOd4f65wmH1FyNaGR2R5AaePNF9fTuMnVL6NfJTOT9tTfET0AdAa5wOQqkRd5sPAjOFbRklEK7wYyEp1YMVa7kLgUIu5MI9pPvdORKM6vQAeA1lYBy9IavO0OA7lOIxxqhTX9+0ejjBizgM24POhBk7BRgwGTj8fW4AujfxQMIYOs/PtS0i1z0tFSeLVdKHzgsCyvcdRr2W+2zKjM3pRTyYtto8XuU3ZxRUULkJSOAN9ibxCiT7Bf10yueTT+m;20:2KpUJVxY1eQN1IuzJrBBnrxwqo2xDcsw5NyfF5JBgiN86tZKN9QxEi/tzCbuYE9J7dXbXJe3CVQpVk9m2GyKo1OLE3UsMzeBYOG/FHg4CXZKoMZbru0NWIObBYoc1AqdbrkUX9tapW3X72Y19Rw+Bq+p2darHygkGos6i9P0pGc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbbfbc1b-1edb-482f-0c0b-08d59daf89ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106360F03A35086C29584F5CFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(59450400001)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oy5ohR+GctSMm7wi0k/DceL+PNWFaGoRo3+m24BEAEPFYgr0/QGm7Qfa3ZvMxZAqcHyIcmuXGafFcMy3BoUCflEdIsHDX4APPCtujlxfs3yMGxBHYwjpAkiQ7yWWibL8eXVNN40SJZpz//obsD0grwi7bxunSwldu1+mBqLcnWhX1BrzhTZDw2D29D+sepKYfpjtNBmGh6XKtpOqJQR28UktMEHSXqIf2/5C0vIECyWAdDIRjXw107t+ieFFJ1VueEVJNlqB/zK2MbkgIJkOzOlOUGo7dYUF/BrPN7bJjRRDOxhlsR15ym8kQRKTgxdbNQh5frWkFgy7APvfoQgjGTB9jdPxTbp/uj7VJHDpZ1xbtudZbu50tgM4Q6NXRkVF2Lt7ehyx8LqEEmDLbptpFUCC/tSYZJ/Gkcf3dC/2yQE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B633060D300B44C85B39ECCFFF6D633@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbfbc1b-1edb-482f-0c0b-08d59daf89ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:05.2878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogTWlja2HDq2wgU2FsYcO8biA8bWljQGRpZ2lrb2QubmV0Pg0KDQpbIFVwc3RyZWFtIGNv
bW1pdCBjMjVlZjZhNWU2MmZhMjEyZDI5OGNlMjQ5OTVjZTIzOWYyOWI1Zjk2IF0NCg0KRG8gbm90
IGJ1aWxkIGxpYi9icGYvYnBmLm8gd2l0aCB0aGlzIE1ha2VmaWxlIGJ1dCB1c2UgdGhlIG9uZSBm
cm9tIHRoZQ0KbGlicmFyeSBkaXJlY3RvcnkuICBUaGlzIGF2b2lkIG1ha2luZyBhIGJ1Z2d5IGJw
Zi5vIGZpbGUgKGUuZy4gbWlzc2luZw0Kc3ltYm9scykuDQoNClRoaXMgcGF0Y2ggaXMgdXNlZnVs
IGlmIHNvbWUgY29kZSAoZS5nLiBMYW5kbG9jayB0ZXN0cykgbmVlZHMgYm90aCB0aGUNCmJwZi5v
IChmcm9tIHRvb2xzL2xpYi9icGYpIGFuZCB0aGUgYnBmX2xvYWQubyAoZnJvbSBzYW1wbGVzL2Jw
ZikuDQoNClNpZ25lZC1vZmYtYnk6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29kLm5ldD4N
CkNjOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPg0KQ2M6IERhbmllbCBCb3Jr
bWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgQm9ya21h
bm4gPGRhbmllbEBpb2dlYXJib3gubmV0Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFs
ZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogc2FtcGxlcy9icGYvTWFrZWZpbGUg
fCA1ICsrKystDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvc2FtcGxlcy9icGYvTWFrZWZpbGUgYi9zYW1wbGVzL2JwZi9NYWtl
ZmlsZQ0KaW5kZXggYWRlYWExMzAyZjM0Li45NjFiNDVjNWVlZTAgMTAwNjQ0DQotLS0gYS9zYW1w
bGVzL2JwZi9NYWtlZmlsZQ0KKysrIGIvc2FtcGxlcy9icGYvTWFrZWZpbGUNCkBAIC0xOTIsMTMg
KzE5MiwxNiBAQCBDTEFOR19BUkNIX0FSR1MgPSAtdGFyZ2V0ICQoQVJDSCkNCiBlbmRpZg0KIA0K
ICMgVHJpY2sgdG8gYWxsb3cgbWFrZSB0byBiZSBydW4gZnJvbSB0aGlzIGRpcmVjdG9yeQ0KLWFs
bDoNCithbGw6ICQoTElCQlBGKQ0KIAkkKE1BS0UpIC1DIC4uLy4uLyAkKENVUkRJUikvDQogDQog
Y2xlYW46DQogCSQoTUFLRSkgLUMgLi4vLi4vIE09JChDVVJESVIpIGNsZWFuDQogCUBybSAtZiAq
fg0KIA0KKyQoTElCQlBGKTogRk9SQ0UNCisJJChNQUtFKSAtQyAkKGRpciAkQCkgJChub3RkaXIg
JEApDQorDQogJChvYmopL3N5c2NhbGxfbnJzLnM6CSQoc3JjKS9zeXNjYWxsX25ycy5jDQogCSQo
Y2FsbCBpZl9jaGFuZ2VkX2RlcCxjY19zX2MpDQogDQotLSANCjIuMTUuMQ0K
