Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241467-2-3941166780274507001
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
    1523241465; b=JYUyLhRNsOYZdSOhgX9J32qUPg+paerteujRxY6rrdq4l6DwUH
    gpQ1BzPgAPWcr87g1/tRzkD/+2HekUv/MHhT+dHGeB/GKbmxEdlBG6KkPVsgG33L
    cpIybN9sCKXHl50nN/LykG55b6M+VCHd40Uy7PhudBCSBYZNXIzd0Ls6nQUdnRaB
    MZg90HGu/+xvdFmlpFSHCLs0E/Bq6znmFDcgFlJqIvTvWW43rMvIF+LSMuIcSNj3
    cF3zqSgCjdBTPsWjy0LXmQbYVI9n8oTnYfbkJReJ3AqNnIMtUQx9ycso1uEMeTWN
    l0NPwqT4zYX7Bs5gQOiPLpbi/7rnQ18YnPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523241465; bh=MGKoYPxbUkYrx8tVEzkxuKAmP5dtFJ8hv/stAm72h8g=; b=
    o7lwawMdym867DSWPftZnCemc+q2gu2eIq4bi0trS1FZ2T1kXhU+dEsA20SA86K4
    xLWL1v1R+BEAHsxbFWS9mflZLQUxqmE0S8clSXoRewZMDcXpExnbENqYLlIS3KeW
    Xav9YzEyEqCT9nJPfjtpNo/AeJkOx6+qf7kC+YlSJLFJliTOpDhbvtOGYgI5I7ca
    LbZtnS2lv8byjKLZ7xUCEgr3L19dQVfHOAjzIU8Fir5I8hARfAO4sAiAOZp5Vd11
    rA6hA9FMlw/6o/AXnl/1qBJNLdWtp73ySnoe7GEFOlGhGyS9tfXAVjrKnd/g0iUd
    WpNoCIgFfs0z/Wd4O8dZkA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD+OndVp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZD+OndVp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEm4sTTgTLb3VGSQVFxOQVegPccy03xvhABkXYWis4Gu/CIFJbOpYBq/W1jwV3eux2WDcfpkPC8cU/IrXoDtZeoGkLjuJEiJyykt+SewWcPXyz/ZlC6R
    RxHrkmALxgfspGY6p5gFCr3FvlXH+z5N3oJs8TVt6R9VnijBkg2+2s9mvUobh9u1MXyjAtYLcLpkFwWOK+XehrxkXimMzR74afOeqWNYxpTpUb0sWpODDI27
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=yMhMjlubAAAA:8 a=cSqfOzabbhpC313mq-UA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757705AbeDIChO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:37:14 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:11355
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755593AbeDIA1b (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:31 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: =?utf-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 043/293] s390/dasd: Display read-only
 attribute correctly
Thread-Topic: [PATCH AUTOSEL for 4.9 043/293] s390/dasd: Display read-only
 attribute correctly
Thread-Index: AQHTz5j4pMf9WaA8mE+6ru2TwSlp5A==
Date: Mon, 9 Apr 2018 00:23:23 +0000
Message-ID: <20180409002239.163177-43-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1031;7:KQG6NXsiLVX+4t3J/2VHc3Cmf9yPBokCVEDbPwlOytm/5NPsOCmMfHqihLut2U2vXKl50l2IkbtQFu5YI13BfGAEwVp2meInna0q4FsLBQ/ys20CZ25PI9jfKwmUwELjRM9QzDM9mJO25A3gNFuHP9QSMVVyZwS/Jub4RL8LSqsHhBilFpeVcd1vdXveuPcueYuRSKL7AQzUx4fjUO4ZEmaY8N0gf+jqfeLOL5uWG7KWub6BsSVqTytnNVjBzBl+;20:x8F5F5Xrm0ngUuO0JIzXw+hMzFVrlSGqKy4QMC6xWRDbOUPlGztA2WYxkA973AGXkyhKk3ZMGr2+Wb2Cp0PqTAr/YuEmyFHpKovBUqwv+D3oHXC/tKkqTPIeRnJRtO7PVYrS5Q3V+ie11WpT4wEbTTJRGhhrbKsu7l1/9YJ0mlo=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5cf53281-69ba-4001-3c1d-08d59db0aac1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1031;
x-ms-traffictypediagnostic: DM5PR2101MB1031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1031BB81753F0567F4976E5FFBBF0@DM5PR2101MB1031.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1031;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1031;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(2900100001)(10290500003)(99286004)(76176011)(14454004)(7736002)(11346002)(26005)(86612001)(72206003)(478600001)(36756003)(106356001)(66066001)(2616005)(186003)(22452003)(86362001)(68736007)(305945005)(54906003)(102836004)(486006)(59450400001)(110136005)(316002)(6506007)(446003)(107886003)(5890100001)(53936002)(4326008)(105586002)(6436002)(6486002)(476003)(6512007)(5660300001)(5250100002)(25786009)(3846002)(6116002)(1076002)(97736004)(3280700002)(2501003)(2906002)(81156014)(8676002)(10090500001)(81166006)(8936002)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1031;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vd7fsn/pQRgrgO584VXO1XD7jnfKFl8nVsPdSs31+Dpo+J3C0kojtjLxQYoaYu9a6VyhsgJDk7SJHRnpB23JjrV0S2NkeXT9hTvWGO2VBmT2FAHaTkmLy3Fk8xBUovn2CC/eTg4aBko4iY6KbeP7o2WExnH42cCUOHR5LUcLIgid3a2YfIODuDKjffLpGKD29fzpP/hH1Q4vNbykyJplSCixZi1xUXhMNuWhXdNLq/52Rvcdp1mHUPK31SMMjIyHvp3YFNnS0B5ml6a7bw3rYrinvrHa3di1Ey3vi7/QsKFy3bV9fxH6ldTsdDgdZTUVi64MGAgyp9czZSKHU/ajJA78YhdQKKkDtLMmQEnecW2CGmCs1PLBFCunITKggPaRFOtUxVJ69oYiAJUT4Tx50WBqLrlfv/kjgw77UqTOy4Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <126C74B08482674981E9CE1FFB702404@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf53281-69ba-4001-3c1d-08d59db0aac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:23.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1031
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogSmFuIEjDtnBwbmVyIDxob2VwcG5lckBsaW51eC52bmV0LmlibS5jb20+DQoNClsgVXBz
dHJlYW0gY29tbWl0IGI0ODdhOTE0Zjg1MzU0NTg0MmEwODk5MzI5YjZiNzJmZTU2YzQwODEgXQ0K
DQpXZSBoYXZlIHR3byBmbGFncywgREFTRF9GTEFHX0RFVklDRV9STyBhbmQgREFTRF9GRUFUVVJF
X1JFQURPTkxZLCB0aGF0DQp0ZWxsIHVzIHdoZXRoZXIgYSBkZXZpY2UgaXMgcmVhZC1vbmx5LiBE
QVNEX0ZMQUdfREVWSUNFX1JPIGlzIHNldCB3aGVuIGENCmRldmljZSBpcyBhdHRhY2hlZCBhcyBy
ZWFkLW9ubHkgdG8gei9WTSBhbmQgREFTRF9GRUFUVVJFX1JFQURPTkxZIGlzIHNldA0Kd2hlbiBl
aXRoZXIgdGhlIGNvcnJlc3BvbmRpbmcga2VybmVsIHBhcmFtZXRlciBpcyBjb25maWd1cmVkLCBv
ciB0aGUNCnJlYWQtb25seSBzdGF0ZSBpcyBjaGFuZ2VkIHZpYSBzeXNmcy4NClRoaXMgaXMgdmFs
dWFibGUgaW5mb3JtYXRpb24gaW4gYW55IGNhc2UuIEhvd2V2ZXIsIG9ubHkgdGhlIGZlYXR1cmUg
ZmxhZw0KaXMgYmVpbmcgY2hlY2tlZCBhdCB0aGUgbW9tZW50IHdoZW4gd2UgZGlzcGxheSB0aGUg
Y3VycmVudCBzdGF0ZS4NCg0KRml4IHRoaXMgYnkgY2hlY2tpbmcgYm90aCBmbGFncy4NCg0KUmV2
aWV3ZWQtYnk6IFN0ZWZhbiBIYWJlcmxhbmQgPHN0aEBsaW51eC52bmV0LmlibS5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBKYW4gSMO2cHBuZXIgPGhvZXBwbmVyQGxpbnV4LnZuZXQuaWJtLmNvbT4NClNp
Z25lZC1vZmYtYnk6IE1hcnRpbiBTY2h3aWRlZnNreSA8c2Nod2lkZWZza3lAZGUuaWJtLmNvbT4N
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWljcm9zb2Z0LmNv
bT4NCi0tLQ0KIGRyaXZlcnMvczM5MC9ibG9jay9kYXNkX2Rldm1hcC5jIHwgMTkgKysrKysrKysr
KysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZGV2bWFwLmMgYi9k
cml2ZXJzL3MzOTAvYmxvY2svZGFzZF9kZXZtYXAuYw0KaW5kZXggMTVhMWE3MGNhY2U5Li44YzRi
Y2JkNDkxZjMgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3MzOTAvYmxvY2svZGFzZF9kZXZtYXAuYw0K
KysrIGIvZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZGV2bWFwLmMNCkBAIC03NTcsMTMgKzc1Nywy
MiBAQCBzdGF0aWMgc3NpemVfdA0KIGRhc2Rfcm9fc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQogew0KIAlzdHJ1Y3QgZGFz
ZF9kZXZtYXAgKmRldm1hcDsNCi0JaW50IHJvX2ZsYWc7DQorCXN0cnVjdCBkYXNkX2RldmljZSAq
ZGV2aWNlOw0KKwlpbnQgcm9fZmxhZyA9IDA7DQogDQogCWRldm1hcCA9IGRhc2RfZmluZF9idXNp
ZChkZXZfbmFtZShkZXYpKTsNCi0JaWYgKCFJU19FUlIoZGV2bWFwKSkNCi0JCXJvX2ZsYWcgPSAo
ZGV2bWFwLT5mZWF0dXJlcyAmIERBU0RfRkVBVFVSRV9SRUFET05MWSkgIT0gMDsNCi0JZWxzZQ0K
LQkJcm9fZmxhZyA9IChEQVNEX0ZFQVRVUkVfREVGQVVMVCAmIERBU0RfRkVBVFVSRV9SRUFET05M
WSkgIT0gMDsNCisJaWYgKElTX0VSUihkZXZtYXApKQ0KKwkJZ290byBvdXQ7DQorDQorCXJvX2Zs
YWcgPSAhIShkZXZtYXAtPmZlYXR1cmVzICYgREFTRF9GRUFUVVJFX1JFQURPTkxZKTsNCisNCisJ
c3Bpbl9sb2NrKCZkYXNkX2Rldm1hcF9sb2NrKTsNCisJZGV2aWNlID0gZGV2bWFwLT5kZXZpY2U7
DQorCWlmIChkZXZpY2UpDQorCQlyb19mbGFnIHw9IHRlc3RfYml0KERBU0RfRkxBR19ERVZJQ0Vf
Uk8sICZkZXZpY2UtPmZsYWdzKTsNCisJc3Bpbl91bmxvY2soJmRhc2RfZGV2bWFwX2xvY2spOw0K
Kw0KK291dDoNCiAJcmV0dXJuIHNucHJpbnRmKGJ1ZiwgUEFHRV9TSVpFLCByb19mbGFnID8gIjFc
biIgOiAiMFxuIik7DQogfQ0KIA0KLS0gDQoyLjE1LjENCg==
