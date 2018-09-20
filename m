Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0A2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZDa90Cy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E0A2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeITQQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:16:25 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:44480
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbeITQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZrfwDFSAngM+I/DTLWz1wAbD25ZQ82m0mHH5+g8ZI0=;
 b=ZDa90Cy5SzXFcMvCbr4yWY+P9M0UG3FhTWouFmePcWKRhZINUXdzNbp0+GDfLxTzj396pWwd1ITyMEoTIf53zjYlBLfq/t5V8xxn0GTYeQePyZvDGN0m9v/D32f/WYf07nrZ1cZw55zQP145qmuULEYBgNRog3hMXfsSF25GAyM=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3952.eurprd04.prod.outlook.com (52.134.17.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 10:33:31 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849%6]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 10:33:30 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Robin Gong <yibin.gong@nxp.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "jslaby@suse.com" <jslaby@suse.com>
Subject: RE: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail
 data
Thread-Topic: [PATCH v1] tty: serial: imx: enable IDDMAEN for the last tail
 data
Thread-Index: AQHUULMF78kWbcOONUStgPVYZUwGR6T4zR+AgAAMbgCAABC8AIAAC4SQ
Date:   Thu, 20 Sep 2018 10:33:30 +0000
Message-ID: <VI1PR0402MB36009F89D7E629CE99A7C592FF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
         <20180920075513.6jqfbrrjax3sp4cn@pengutronix.de>
         <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <1537436376.3362.159.camel@pengutronix.de>
In-Reply-To: <1537436376.3362.159.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3952;6:OpS1YetlrP+RGzgdlqnxu610HyqTp+noHGC1nL+ow/QVQQ5ypKoFrwT0gj2zOXEwiqaBJfR/vINuU99B9f154L6Mw0DD6Am+kx8dBKNkcHeZVzRGCQSpsG8hnmqeD+a0GBbhtDCSPoZOBdEw5j/0UnIgGYOFpcHh5ILQzh7vnlFCwUiMN/CJMyNi02wFNcXYJdPqiB0Bnx6zPQKnwZsWG6JO3zVfEx+tqAI1uhlnkUTYOEI6jR7VL5khskLoV9fWnkjTreBko1PBi3QNBBIyUMqSnmtfVu7Golf2TLckg+tUDFBWoIVochgsIzbKfKNaGmznu0/wlNnw7lmYAwF/nEij0X8CFoE0/7Ajw4jNONXkQjdL9HYyOv76Zau58Pk0boUzNnSpRN2UVoPPYt0UNeHX+hJYEDXc15TzaVCQncxU5KQVCtyMMTVaAMA5ZdFtkEgS8NEwBPsjVx1KNSiMwQ==;5:NJnG0jDZ/W0bc1SDNMZyFFn2bRQXBR0axoWZ3se2JgpxhwVcSz7KuitHZI5aqYPUAJn1KywlHRtRj/Xr2FCJfkRCdo3dJXMbmFdYYrP1ArBnnzV5UJjeYlpMkajVayo4JD2NjAR6yC9T1LFtOhH2ESUiz9p1EhBOINWaraP318E=;7:pmhesOnkgaQ6ZMeWdnPF+ttLv9Ce8do9nxpZxAhrFHNR/OP7H3wreWgVq497ULWlTP8m6relKl9WfkImnfs16sPol/qbi243Dp+dd7fwlBd4u8bexnmzViYxKdUsOCWkDn0SXS7IUn0CMd0hTid0dy+JSo8ug0NxRhvluffoLO651mx/CtweN+sfm6La6qPTNIK77VibLoC/avgoVwtGVgbMbunKTfM+1zhIbUQ+DO1Cgs5tkeC1KttAF3UxdJg3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 63e16b80-d615-4cca-cbd9-08d61ee48274
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3952;
x-ms-traffictypediagnostic: VI1PR0402MB3952:
x-microsoft-antispam-prvs: <VI1PR0402MB3952F5711DB65B1F5F0B2932FF130@VI1PR0402MB3952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(189930954265078)(185117386973197)(45079756050767);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR0402MB3952;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3952;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(13464003)(3846002)(81166006)(2906002)(9686003)(575784001)(2900100001)(86362001)(26005)(7696005)(186003)(74316002)(6306002)(5660300001)(6246003)(966005)(478600001)(8936002)(7736002)(45080400002)(55016002)(5024004)(14454004)(102836004)(53936002)(99286004)(14444005)(305945005)(53546011)(76176011)(256004)(8676002)(25786009)(229853002)(446003)(316002)(106356001)(110136005)(5250100002)(486006)(11346002)(4326008)(66066001)(6506007)(33656002)(6116002)(105586002)(97736004)(93886005)(81156014)(54906003)(6436002)(476003)(68736007)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3952;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hLohH2845UqdA1YXEbqHwd1gzWf1iFZKW8lECbiNJfuNCUAZF7IJpSCG8tEUdyCMT8uS7fCV2DojXtKWrKlzaEcc8bSJyRW1/7GwrdzHSWL96uHhXs03WHU0V6eMV10/Sgsv9f59CoGjRf+NnqJFMDLVZuFmsbWXo5uJg8f8SevotcG+ICCc42n8bV+PFavAwmamK5hgXTulm7qhvoT0BzHUwZx3nVmkWusyGWWAa92N3wdKg5DGrZ9eaUSO0bxGo95Mv3UkVxT5ojc7fISHzz8OXY+6Sv/BEKtzq7SF8PiRHOix9Kx9NY7DJ7OzxddvFnym9wOaJe4HgAHVBLlLsl7ag/SFKCAOVIp71LaHaZE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e16b80-d615-4cca-cbd9-08d61ee48274
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 10:33:30.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+IFNlbnQ6IDIwMTjlubQ5
5pyIMjDml6UgMTc6NDANCj4gQW0gRG9ubmVyc3RhZywgZGVuIDIwLjA5LjIwMTgsIDA4OjM5ICsw
MDAwIHNjaHJpZWIgUm9iaW4gR29uZzoNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJv
bml4LmRlPg0KPiA+ID4gU2VudDogMjAxOOW5tDnmnIgyMOaXpSAxNTo1NQ0KPiA+ID4gVG86IFJv
YmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiA+IENjOiBqc2xhYnlAc3VzZS5jb207
IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT47DQo+ID4gPiBsaW51eC1zZXJpYWxAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC0NCj4gPiA+IGxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIHR0eTogc2VyaWFsOiBpbXg6IGVuYWJsZSBJRERNQUVO
IGZvciB0aGUNCj4gPiA+IGxhc3QgdGFpbCBkYXRhDQo+ID4gPg0KPiA+ID4gSGVsbG8sDQo+ID4g
Pg0KPiA+ID4gT24gVGh1LCBTZXAgMjAsIDIwMTggYXQgMTE6MjY6MDBQTSArMDgwMCwgUm9iaW4g
R29uZyB3cm90ZToNCj4gPiA+ID4gZW5hYmxlIElERE1BRU4gaW4gVUNSNCB0byBsZXQgc2RtYSBz
Y3JpcHQgaGFzIHRoZSBjaGFuY2UgdG8gZGV0ZWN0DQo+ID4gPiA+IHRoZSBpZGxlIHN0YXR1cyBh
bmQgdHJhbnNmZXIgdGhlIGxhc3QgdGFpbCBkYXRhIHdpdGggdGhlIGludGVycnVwdA0KPiA+ID4g
PiBub3RpZnlpbmcgdWFydCBkcml2ZXIuT3RoZXJ3aXNlLCB0aGUgbGFzdCBkbWEgZG9uZSBpbnRl
cnJ1cHQgb2YNCj4gPiA+ID4gdGhlIHRhaWwgZGF0YSBpbiByeGZpZm8gd2hvc2Ugc2l6ZSBpcyBs
ZXNzIHRoYW4gd2F0ZXJtYXJrIG1heQ0KPiA+ID4gPiBuZXZlciBiZSByZWNlaXZlZCBieSB1YXJ0
IGRyaXZlci4NCj4gPiA+DQo+ID4gPiBJcyB0aGlzIGEgdGhlb3JldGljIGlzc3VlPyBPciBkb2Vz
IGl0IGZpeCBhIHJlYWwgcHJvYmxlbT8NCj4gPiA+DQo+ID4gPiBJZiB0aGUgZm9ybWVyIEknZCBz
YXkgVUNSMV9BVERNQUVOIGJlaW5nIHNldCBzaG91bGQgcHJldmVudCB0aGlzDQo+ID4gPiBzdGFs
bC4NCj4gPg0KPiA+IEl0J3MgYSByZWFsIGZpeCwgeW91IHdpbGwgc2VlICd0aW1lb3V0IFdlIHJl
YWQgMCBieXRlJyB3aXRoIHRoZQ0KPiA+IGF0dGFjaGVkIHN0cmVzcyB0ZXN0IHJ1bm5pbmcgb24g
aS5teDdkIG9yIGkubXg2IGlmIG5vIHRoaXMgcGF0Y2gNCj4gPiBhcHBsaWVkLg0KPiA+ICcgd2hp
bGUgWyAxIF07IGRvIC91bml0X3Rlc3RzL1VBUlQvbXhjX3VhcnRfc3RyZXNzX3Rlc3Qub3V0DQo+
ID4gL2Rldi90dHlteGM1IDIwMDAwMDAgRCBMIDEwMCAxMDAgTDsgZG9uZSAmJw0KPiA+IFBsZWFz
ZSBtYWtlIHN1cmUgZG1hIGVuYWJsZWQgb24gdHR5bXhjWCBmb3IgeW91ciB0ZXN0LCBhbmQgc2Rt
YQ0KPiA+IGZpcm13YXJlIHNldHVwIGluIHlvdXIgcm9vdGZzIC9saWIvZmlybXdhcmUvaW14L3Nk
bWEvc2RtYS1pbXg2cS5iaW4NCj4gb3INCj4gPiAvbGliL2Zpcm13YXJlL2lteC9zZG1hL3NkbWEt
IGlteDdkLmJpbi4NCj4gPiBZb3UgY2FuIGdldCBzZG1hIGZpcm13YXJlIGZyb20gYmVsb3c6DQo+
ID4NCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRmdpDQo+IHQNCj4gPiAua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxp
bnV4JTJGa2VybmVsJTJGZ2l0JTJGZmlybXdhcmUlMkZsaW4NCj4gdXgtJmFtcA0KPiA+IDtkYXRh
PTAyJTdDMDElN0NmdWdhbmcuZHVhbiU0MG54cC5jb20lN0MyMTMwNzZmNmQxMTE0MTQ4YjUNCj4g
Y2UwOGQ2MWVkY2ZiDQo+ID4NCj4gODglN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYz
NSU3QzAlN0MwJTdDNjM2NzMwMzMxDQo+IDgxNDgwNDU0NSZhbXANCj4gPiA7c2RhdGE9ZDB1Wk1q
TGMlMkZySWFlM1dkNlBXdFgyZ0VHbHZaY1VqUEJWcUtLOTU1MGpnJTNEJmFtcA0KPiA7cmVzZXJ2
ZWQ9MA0KPiA+IGZpcm13YXJlLmdpdC90cmVlL2lteC9zZG1hDQo+IA0KPiBQbGVhc2Ugc2VlIGNv
bW1pdCA5MDVjMGRlY2FkMjg0MDJhYTE2Njk3NTAyM2ZiODhjOGY2MmY5M2M4IG9uDQo+IHdoeSB1
c2luZyB0aGUgaWRsZSBkZXRlY3QgdG9nZXRoZXIgd2l0aCB3aXRoIFNETUEgaXMgd3JvbmcuIFdl
IGRvbid0DQo+IHdhbnQgdG8gcmUtIGludHJvZHVjZSB0aGUgYnJva2VuIGJlaGF2aW9yLg0KPiAN
ClRoZSBwYXRjaCBqdXN0IHdhbnQgdG8gdXNlIGlkbGUgdGltZXIgdG8gc3RvcCBTRE1BIHRyYW5z
ZmVyIHVzaW5nIHRoZSBuZXcgcmFtIHNjcmlwdCwgd2hvc2UgYWN0aW9uIGlzIG5vdCB0aGUgc2Ft
ZSBhcyByb20gc2NyaXB0Lg0KU2RtYSByb20gc2NyaXB0IGhvdyB0byBzdG9wIHNkbWEgdHJhbnNm
ZXIgaWYgb25seSBvbmUgYnl0ZSBpbiByeCBGSUZPIHRoYXQgdHJpZ2dlciBTRE1BIHJlcXVlc3Qg
Pw0K
