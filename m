Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240939-2-10589691930794136393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240938; b=oOnuUJKDrm5ocfUu3m6iRT3VwTg3MXBI1iyLmMRX9gGMTpQweX
    PQdEMVNVl7VhRAKOV6mXjOAe/6bV7YUe+8TwXszlJyPK3DfHvIJESuS2zeOcrSwY
    +WKAKjBi++Bj0aJxugilCM5TCM28Xhc3KukyGJzOO9SqFT4uW2T6AvQdFK78Up1L
    BaguuELKqqNnyXMHJTZVPIN6Rgniz4wzf5LLGtEUM8B7Jpf5a6NObHxMlaTcHdxb
    KQJoIQ/KfiDqWIuGKx0k9K92Up3Pul1Q4D1A+/hzrgIfeBLuPZCjlUf3BJe1guMJ
    g+hrCrgHvcrmTzPmPXH1p7ZRcP+1SHrz1Hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523240938; bh=/26qTwynvExjHeZLGeJXADJ779n+/BxqpAW3xeP2Y5c=; b=
    j/HDVlJ3I2TTgb9yLFz6VfdQlhahOkrnUzofLYrBT8Vrd/VMxcfLxuGFj+asw51R
    /W3p2qo3pMUe24mTJ55ZZ0qmUshMufXSJ0PtBnuCB5GQa+NGnZXRDp3V3GYrRv+N
    JPojGE+3J5KWBExiiwGMs4ZeFrwSFsA/nENGX6XEFTxsmcWNAL84ogaGz90oDY8B
    DxdV+3in6YKYX8oJQPjyEvpTNZ4JlemAH3Q81mW2un6ImjsIAGEySVx+4j7wenXk
    3iA5qAOeFs1t1ikWILKm5jsxojd5yeEVrNeE89y8qKzV1EdqRiV88aFF+BZehKA6
    yNPi9p+N+1PLtHTVNnmfmA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kcjeB+45 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kcjeB+45 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN0lZ9ojDMvyMsPaE5pPwMdisMv6pUwEaizy6TycUnyZeVUgFSR9HP2m594FD/QZK7JC6aE2F/ZFE6e7N0OTjIBSFh3QO0LcY1hvQMDEJHM59uBXS+mG
    BctLJMrUETo7Q1cfJC/M9D802nH1DHA6PA3LrU9MFGQnSNsVjPPuFGpi4FXMaKW6d2il8wNr67Mk2bRKLJtIwvxruP5EoclgBPkwGuVY8WjX5VJyPX+vVzTV
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=LDBv8-xUAAAA:8 a=yMhMjlubAAAA:8 a=BzHf38hvvPQYTYxzxdEA:9
    a=hiyUikULbgfsvQVf:21 a=ZNSoMEXyhTeSgbNt:21 a=QEXdDO2ut3YA:10
    a=DZeXCJrVpAJBw65Qk4Ds:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbeDIC23 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:28:29 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:12595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755881AbeDIA2i (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 082/293] i2c: rcar: use correct length when
 unmapping DMA
Thread-Topic: [PATCH AUTOSEL for 4.9 082/293] i2c: rcar: use correct length
 when unmapping DMA
Thread-Index: AQHTz5kN1GQSPjTQq0urLKrzMNx5lQ==
Date: Mon, 9 Apr 2018 00:23:58 +0000
Message-ID: <20180409002239.163177-82-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:JXsFw3EMQuUBUsHpBCdDnxzaMFcuI/X5iuh8nAzrHN5x0mALprGFCRjYd64PnLXa4ymI5nAJaNV0qwqwwYDp+tbG0AN12YmGMLy9wLN6wdpQ7XI7Jzbld5iY80RL73MsfHITAyB/fKm3fv5XiVmsCdGtqrFm3KYQbES33Wr+Z5DTQdQsffHzKfsJGayKpqDebHVJllohKNAtL40S9XstEGo12eXBbSLOEFAVmXD9j9p6lB1h/44N5mnX9PO3e2an;20:rMOCHX/PJqTGaPrDt7bDT8aokzxxVQtc5Mhjm40cY8VwIikK+4wbJGCC6dHlEQtefohY9k8FxIqkVj7jV3bWJpg0l5H4EHyGcgNDKbbQ4jKZlu2BH+NElwmovK9GMogGahY/dAoJO7ZJIny8irMz2Ah6z2hL9IgvB8EBoIayYPs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a60dcbd-4fd4-4b27-77ff-08d59db0d331
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807E9C7A78FCAB976898DF0FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ZYN8R+D0cs3ORqyTDRK+Pi3JUMtL5qmt1REBK1DPgsVcALgNUErd3ToZtj4tfp2Rh/ORviE8nuYVttFDwwgdeonBbp0hP/le8t/wWdT5sYQOonEtmxC4FHkIt1bUfvOuL89trI+wm6xVqiLs2BBK2DivdVPWGwHaQleTqupSUwV0eGvy+dffj+njQotipcoz9EO0aD2pixuD9JXzGOUjX+Tc7QmtWztPXvRmdBtRzq39jypZXxaUbaymvxivEb8PlU6AuhXvveIr8DBFE+NAmAwB7dwIZSO0GuqsrRC2rWD2wggKNJMVLSoegmKTNNRsgRKRafhski0cOAASbVUqgCTqEHTk3p0d23JE/GnRxUM34Kh55LXPKJyLcFUpPAy7KlS0QTnVedpTip3Oq7gtAsIquqZZahDL9pN2yj29JzU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <05D2A98B965BF1419464DC1036E155BB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a60dcbd-4fd4-4b27-77ff-08d59db0d331
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:58.1124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RnJvbTogV29sZnJhbSBTYW5nIDx3c2ErcmVuZXNhc0BzYW5nLWVuZ2luZWVyaW5nLmNvbT4NCg0K
WyBVcHN0cmVhbSBjb21taXQgOTE2MzM1MDM2ZDRmZTMzZjk4MDYyNDBjYjBkMTkwMGY0OTc1Yjk1
OSBdDQoNCkJlY2F1c2Ugd2UgbmVlZCB0byB0cmFuc2ZlciBzb21lIGJ5dGVzIHdpdGggUElPLCB0
aGUgbXNnIGxlbmd0aCBpcyBub3QNCnRoZSBsZW5ndGggb2YgdGhlIERNQSBidWZmZXIuIFVzZSB0
aGUgY29ycmVjdCB2YWx1ZSB3aGljaCB3ZSB1c2VkIHdoZW4NCmRvaW5nIHRoZSBtYXBwaW5nLg0K
DQpGaXhlczogNzNlOGIwNTI4MzQ2ZTggKCJpMmM6IHJjYXI6IGFkZCBETUEgc3VwcG9ydCIpDQpT
aWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcu
Y29tPg0KUmV2aWV3ZWQtYnk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlk
ZXIuYmU+DQpSZXZpZXdlZC1ieTogTmlrbGFzIFPDtmRlcmx1bmQgPG5pa2xhcy5zb2Rlcmx1bmQr
cmVuZXNhc0ByYWduYXRlY2guc2U+DQpTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYUB0
aGUtZHJlYW1zLmRlPg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZp
bkBtaWNyb3NvZnQuY29tPg0KLS0tDQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1yY2FyLmMgfCAy
ICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXJjYXIuYyBiL2RyaXZlcnMvaTJjL2J1
c3Nlcy9pMmMtcmNhci5jDQppbmRleCA3MjY2MTVlNTRmMmEuLjRjZjIwNGQwNzY3OSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcmNhci5jDQorKysgYi9kcml2ZXJzL2kyYy9i
dXNzZXMvaTJjLXJjYXIuYw0KQEAgLTMxOSw3ICszMTksNyBAQCBzdGF0aWMgdm9pZCByY2FyX2ky
Y19kbWFfdW5tYXAoc3RydWN0IHJjYXJfaTJjX3ByaXYgKnByaXYpDQogCXJjYXJfaTJjX3dyaXRl
KHByaXYsIElDRkJTQ1IsIFRDWUMwNik7DQogDQogCWRtYV91bm1hcF9zaW5nbGUoY2hhbi0+ZGV2
aWNlLT5kZXYsIHNnX2RtYV9hZGRyZXNzKCZwcml2LT5zZyksDQotCQkJIHByaXYtPm1zZy0+bGVu
LCBwcml2LT5kbWFfZGlyZWN0aW9uKTsNCisJCQkgc2dfZG1hX2xlbigmcHJpdi0+c2cpLCBwcml2
LT5kbWFfZGlyZWN0aW9uKTsNCiANCiAJcHJpdi0+ZG1hX2RpcmVjdGlvbiA9IERNQV9OT05FOw0K
IH0NCi0tIA0KMi4xNS4xDQo=
