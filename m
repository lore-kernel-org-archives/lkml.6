Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B49C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9261723BDF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rlMCp0vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9261723BDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934153AbeFVBM4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:12:56 -0400
Received: from mail-eopbgr60082.outbound.protection.outlook.com ([40.107.6.82]:49292
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933129AbeFVBMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+o54IJd/bdBjDHLEqK6ossCfkZ8MOTu5nQR4iNfmW4=;
 b=rlMCp0vg/UM1nuy/dAdeA4AWi7/PC43k3oVo5KmoiEGBFl1Cn+bC9O+gSsSZhuZ4tV7RE0d2aAAL8Y/y6dM0uouKi+G//dK7tVA82Ych7wvMeHwMkLUgbawXMndgpSgKYge4YgW+s9xmgVtdUBpNwMUXzMjWxJXdE4sKNcS/FyY=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB2983.eurprd04.prod.outlook.com (10.170.213.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Fri, 22 Jun 2018 01:12:49 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::982d:7c4d:d525:42f9%4]) with mapi id 15.20.0863.016; Fri, 22 Jun 2018
 01:12:49 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Topic: [PATCH v5 0/7] add virt-dma support for imx-sdma
Thread-Index: AQHUB6ubqqf+VcikvUmzLvpSTD8gdKRre59g
Date:   Fri, 22 Jun 2018 01:12:48 +0000
Message-ID: <DB6PR04MB32237203C350E5853C8870DB89750@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB2983;7:U4jyp3s+XGfmumzivPmKklKMQyEy1UI1357lM1muFAYaWQtLH8YuifX7rUKkYWPRa3o/rDfqMMwJjFKm+NFG1au61UyAVMprIOHrt/eSyOfO87jLs1IDGKMVMdO4DzUauzvNQHgrsQQKEZ2v9/mN76jj+bDkVX7RiOJDfFXxfqGe/OzJpqN+oQ20t1EJUmmeU6P4DcT3aXERCd7dlF733hKLGgCDn+dPE9tZ+9qaz9FXVrgW2KzBZIgs0CL3oEeB
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f85c09e7-ee09-4cd7-0475-08d5d7dd4528
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB2983;
x-ms-traffictypediagnostic: DB6PR04MB2983:
x-microsoft-antispam-prvs: <DB6PR04MB29835EAE9EE66F314827CD1789750@DB6PR04MB2983.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB2983;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB2983;
x-forefront-prvs: 071156160B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(366004)(346002)(13464003)(199004)(189003)(186003)(7416002)(66066001)(2501003)(14454004)(446003)(5250100002)(68736007)(476003)(486006)(26005)(53546011)(86362001)(8936002)(7696005)(97736004)(102836004)(76176011)(2201001)(5660300001)(6506007)(59450400001)(81166006)(55016002)(25786009)(2906002)(6116002)(53936002)(74316002)(106356001)(316002)(305945005)(9686003)(229853002)(8676002)(105586002)(81156014)(6246003)(3660700001)(7736002)(478600001)(11346002)(99286004)(6436002)(54906003)(33656002)(110136005)(2900100001)(3846002)(3280700002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB2983;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dfRHihB8KhGAx1fnLNIycgjuhgeXN2VmMxiLj9gdrC5xDNI6KJiA6GOSjOGAZcXLL3Kmrx+gFEfHzZiwauCTrOj/lCMEOh0aF6FxWdVpBRXqTSCr25k1vv+8ILwh1J3iDV6nFYS8rojcDJzSbvA9ZlqpCDhnKla51T1gSH/Y2r3rLudMpkp4NGDEPd477Do67fqkF3pn6dKaEMwlYbEmCSXNQpy4Xvw+0v3XZb3cdetEZcGqkYOgRXLxMXyafzcnJKin+T6FHGzgQcfoSomfQ3EmHGLBnLFj272fdn2l1uyhUnFcPihaDlbQ29LqxFKMldiNyq7NlEnWnGWVyBt+DA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85c09e7-ee09-4cd7-0475-08d5d7dd4528
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2018 01:12:48.9850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2983
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gTHVjYXMsDQoJV291bGQgeW91IGxpa2UgdG8gdHJ5IHdpdGggdGhlIHY1IGZvciB5b3Vy
IEF1ZGlvL1VBUlQgY2FzZT8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJv
YmluIEdvbmcgDQpTZW50OiAyMDE4xOo21MIyMMjVIDA6NTcNClRvOiB2a291bEBrZXJuZWwub3Jn
OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBkYW4uai53
aWxsaWFtc0BpbnRlbC5jb207IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBqc2xhYnlAc3Vz
ZS5jb20NCkNjOiBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQpT
dWJqZWN0OiBbUEFUQ0ggdjUgMC83XSBhZGQgdmlydC1kbWEgc3VwcG9ydCBmb3IgaW14LXNkbWEN
Cg0KVGhlIGxlZ2FjeSBzZG1hIGRyaXZlciBoYXMgYmVsb3cgbGltaXRhdGlvbnMgb3IgZHJhd2Jh
Y2tzOg0KICAxLiBIYXJkY29kZSB0aGUgbWF4IEJEcyBudW1iZXIgYXMgIlBBR0VfU0laRSAvIHNp
emVvZigqKSIsIGFuZCBhbGxvYw0KICAgICBvbmUgcGFnZSBzaXplIGZvciBvbmUgY2hhbm5lbCBy
ZWdhcmRsZXNzIG9mIG9ubHkgZmV3IEJEcyBuZWVkZWQNCiAgICAgbW9zdCB0aW1lLiBCdXQgaW4g
ZmV3IGNhc2VzLCB0aGUgbWF4IFBBR0VfU0laRSBtYXliZSBub3QgZW5vdWdoLg0KICAyLiBPbmUg
U0RNQSBjaGFubmVsIGNhbid0IHN0b3AgaW1tZWRpYXRsZXkgb25jZSBjaGFubmVsIGRpc2FibGVk
IHdoaWNoDQogICAgIG1lYW5zIFNETUEgaW50ZXJydXB0IG1heSBjb21lIGluIGFmdGVyIHRoaXMg
Y2hhbm5lbCB0ZXJtaW5hdGVkLlRoZXJlDQogICAgIGFyZSBzb21lIHBhdGNoZXMgZm9yIHRoaXMg
Y29ybmVyIGNhc2Ugc3VjaCBhcyBjb21taXQgIjI3NDZlMmMzODlmOSIsDQogICAgIGJ1dCBub3Qg
Y292ZXIgbm9uLWN5Y2xpYy4NCg0KVGhlIGNvbW1vbiB2aXJ0LWRtYSBvdmVyY29tZXMgdGhlIGFi
b3ZlIGxpbWl0YXRpb25zLiBJdCBjYW4gYWxsb2MgYmQgZHluYW1pY2FsbHkgYW5kIGZyZWUgYmQg
b25jZSB0aGlzIHR4IHRyYW5zZmVyIGRvbmUuIE5vIG1lbW9yeSB3YXN0ZWQgb3IgbWF4aW11bSBs
aW1pdGl0YXRpb24gaGVyZSwgb25seSBkZXBlbmRzIG9uIGhvdyBtYW55IG1lbW9yeSBjYW4gYmUg
cmVxdWVzdGVkIGZyb20ga2VybmVsLiBGb3IgTm8uMiwgc3VjaCBpc3N1ZSBjYW4gYmUgd29ya2Fy
b3VuZCBieSBjaGVja2luZyBpZiB0aGVyZSBpcyBhdmFpbGFibGUgZGVzY3JpcHQoInNkbWFjLT5k
ZXNjIikgbm93IG9uY2UgdGhlIHVud2FudGVkIGludGVycnVwdCBjb21pbmcuIEF0IGxhc3QgdGhl
IGNvbW1vbiB2aXJ0LWRtYSBpcyBlYXNpZXIgZm9yIHNkbWEgZHJpdmVyIG1haW50YWluLg0KDQpD
aGFuZ2UgZnJvbSB2NDoNCiAgMS4gaWRlbnRpZnkgbG9ja2RlcCBpc3N1ZSB3aGljaCBjYXVzZWQg
YnkgYWxsb2NhdGUgbWVtb3J5IHdpdGgNCiAgICAgJ0dGUF9LRVJORUwnLCBjaGFuZ2UgdG8gJ0dG
UF9OT1dBSVQnIGluc3RlYWQgc28gdGhhdCBsb2NrZGVwDQogICAgIGlnbm9yZSBjaGVjay4gVGhh
dCBhbHNvIG1ha2Ugc2Vuc2Ugc2luY2UgQXVkaW8vdWFydCBkcml2ZXIgbWF5DQogICAgIGNhbGwg
ZG1hIGZ1bmN0aW9uIGFmdGVyIHNwaW5fbG9ja19pcnFzYXZlKCkuLi4NCiAgMi4gdXNlIGRtYSBw
b29sIGluc3RlYWQgZm9yIGJkIGRlc2NyaXB0aW9uIGFsbG9jYXRlZCxzaW5jZSBhdWRpbw0KICAg
ICBkcml2ZXIgbWF5IGNhbGwgZG1hX3Rlcm1pbmF0ZV9hbGwgaW4gaXJxLiBQbGVhc2UgcmVmZXIg
dG8gNy83Lg0KICAzLiByZW1vdmUgNy83IHNlcmlhbCBwYXRjaCBpbiB2NCwgc2luY2UgbG9ja2Rl
cCBpc3N1ZWQgZml4ZWQgYnkgTm8uMSANCg0KQ2hhbmdlIGZyb20gdjM6DQogIDEuIGFkZCB0d28g
dWFydCBwYXRjaGVzIHdoaWNoIGltcGFjdGVkIGJ5IHRoaXMgcGF0Y2hzZXQuDQogIDIuIHVubG9j
ayAndmMubG9jaycgYmVmb3JlIGN5Y2xpYyBkbWEgY2FsbGJhY2sgYW5kIGxvY2sgYWdhaW4gYWZ0
ZXINCiAgICAgaXQgYmVjYXVzZSBzb21lIGRyaXZlciBzdWNoIGFzIHVhcnQgd2lsbCBjYWxsIGRt
YWVuZ2luZV90eF9zdGF0dXMNCiAgICAgd2hpY2ggd2lsbCBhY3F1aXJlICd2Yy5sb2NrJyBhZ2Fp
biBhbmQgZGVhZCBsb2NrIGNvbWVzIG91dC4NCiAgMy4gcmVtb3ZlICdSZXZlcnQgY29tbWl0JyBz
dHVmZiBzaW5jZSB0aGF0IHBhdGNoIGlzIG5vdCB3cm9uZyBhbmQNCiAgICAgY29tYmluZSB0d28g
cGF0Y2ggaW50byBvbmUgcGF0Y2ggYXMgU2FzY2hhJ3MgY29tbWVudC4NCg0KQ2hhbmdlIGZyb20g
djI6DQogIDEuIGluY2x1ZGUgU2FzY2hhJ3MgcGF0Y2ggdG8gbWFrZSB0aGUgbWFpbiBwYXRjaCBl
YXNpZXIgdG8gcmV2aWV3Lg0KICAgICBUaGFua3MgU2FjaGEuDQogIDIuIHJlbW92ZSB1c2VsZXNz
ICdkZXNjJy8nY2hhbicgaW4gc3RydWN0IHNkbWFfY2hhbm5lLg0KDQpDaGFuZ2UgZnJvbSB2MToN
CiAgMS4gc3BsaXQgdjEgcGF0Y2ggaW50byA1IHBhdGNoZXMuDQogIDIuIHJlbW92ZSBzb21lIHVu
bmVjZXNzYXJ5IGNvbmRpdGlvbiBjaGVjay4NCiAgMy4gcmVtb3ZlIHVubmVjZXNzYXJ5ICdwZW5k
aW5nJyBsaXN0Lg0KDQpSb2JpbiBHb25nICg2KToNCiAgdHR5OiBzZXJpYWw6IGlteDogY29ycmVj
dCBkbWEgY29va2llIHN0YXR1cw0KICBkbWFlbmdpbmU6IGlteC1zZG1hOiBhZGQgdmlydC1kbWEg
c3VwcG9ydA0KICBkbWFlbmdpbmU6IGlteC1zZG1hOiByZW1vdmUgdXNlbGVzcyAnbG9jaycgYW5k
ICdlbmFibGVkJyBpbiAnc3RydWN0DQogICAgc2RtYV9jaGFubmVsJw0KICBkbWFlbmdpbmU6IGlt
eC1zZG1hOiByZW1vdmUgdGhlIG1heGltdW0gbGltaXRhdGlvbiBmb3IgYmQgbnVtYmVycw0KICBk
bWFlbmdpbmU6IGlteC1zZG1hOiBhZGQgc2RtYV90cmFuc2Zlcl9pbml0IHRvIGRlY3JlYXNlIGNv
ZGUgb3ZlcmxhcA0KICBkbWFlbmdpbmU6IGlteC1zZG1hOiBhbGxvY2xhdGUgYmQgbWVtb3J5IGZy
b20gZG1hIHBvb2wNCg0KU2FzY2hhIEhhdWVyICgxKToNCiAgZG1hZW5naW5lOiBpbXgtc2RtYTog
ZmFjdG9yIG91dCBhIHN0cnVjdCBzZG1hX2Rlc2MgZnJvbSBzdHJ1Y3QNCiAgICBzZG1hX2NoYW5u
ZWwNCg0KIGRyaXZlcnMvZG1hL0tjb25maWcgICAgICB8ICAgMSArDQogZHJpdmVycy9kbWEvaW14
LXNkbWEuYyAgIHwgNDAwICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tDQogZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgICAyICstDQogMyBmaWxlcyBjaGFu
Z2VkLCAyMzUgaW5zZXJ0aW9ucygrKSwgMTY4IGRlbGV0aW9ucygtKQ0KDQotLQ0KMi43LjQNCg0K
