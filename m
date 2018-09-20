Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135682152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r+Xp2lsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135682152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeITQhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:37:04 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:8646
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITQhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT+cFL6TMnM1brsy8an0T9OojLtnUI+79MGzDRbFyoo=;
 b=r+Xp2lsW7bQgt/SANZq8tImhoqISLEPmTmScs0TByqLzMFMLQ0qLB9c5Zx2BQPL403BVegwCo5DKWS2wA2d7+3zkHM8xDCCJ28v0rf7+kZfd00l/5FXe67sAnVhQ8nfuLUZwFAilQoLxyv10+lbKyMKWhYvKUeeq76veWkyXNOI=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2719.eurprd04.prod.outlook.com (10.175.22.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Thu, 20 Sep 2018 10:54:04 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::2d86:d831:13dd:3849%6]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 10:54:04 +0000
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
Thread-Index: AQHUULMF78kWbcOONUStgPVYZUwGR6T4zR+AgAAMbgCAABC8AIAAC4SQgAAF8YCAAAG6YA==
Date:   Thu, 20 Sep 2018 10:54:04 +0000
Message-ID: <VI1PR0402MB36002FFAFC4904D8D5A890DAFF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1537457160-10792-1-git-send-email-yibin.gong@nxp.com>
         <20180920075513.6jqfbrrjax3sp4cn@pengutronix.de>
         <VI1PR04MB45432291716B64380C1B90DD89130@VI1PR04MB4543.eurprd04.prod.outlook.com>
         <1537436376.3362.159.camel@pengutronix.de>
         <VI1PR0402MB36009F89D7E629CE99A7C592FF130@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <1537440125.3362.161.camel@pengutronix.de>
In-Reply-To: <1537440125.3362.161.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2719;6:0BXXzr5259+kh+qySyYdXvPIUQ7jQKqEztZabcvsDiMEP4U6W1BFwo6nHWrrZG1OdGpNCUMP9Fnl8IEcxsfBkoH3mRPIQZ5kbngxVIZU0YzOhTEIHitmhuT/RM5F4M/xM6283guVxXigI2pzC1DT6v8PRUrEQ9CJjAMLcDvBTi1YBikqY9Wp3T4/VspjgzK5ldAL0+H0ux8I2B2hzWrr+nNbl9pa7bAZmjwCoqSWAiSn9cnx2kZaLIOr2EZOJdcL7AddVQMYAapKkr8xA1+2IQPEnUMzh9kwt/k7HOs+pJl4n3dZT2hdLTH+jeAb9kM4TlbJwSSxXBh6ZLMT7nfDYgoS4FmOSkGV/cjGvwzV+ixu4GtPifhPhAXsXEHKh9DwvERJlPSeQMuuM7DgYKDlbmJtTEoRjoRL34/HrtNzHaFirwNowpvjp/VTcgKeIJyyRaEi9iLu/TD37cxatA6MJw==;5:AS8Gz1dc3GHVz5huLMz5WaIMqfFRbTHZV4DloreCqfonksvcr4oeb3r/qGzjSeam8o1uCQzg2jthQZe1eHkrgdvXbElxow6wHckMayRB1ZWxrOWR+S/wposKqUo8KbkoIb4BGEYrWFfke8oSYiK54cU8AOFanbl24FrDWooiuN0=;7:qBwjn78IdSGV2lSm3iaNCDSEriHnMOtqDiIJgJwTZ0f72l91SQK+J06x5eWw/XrtZWwmfAGKlpaKJ7+X/iw0BHPcpg+tcPLshq/AEXNf8QJyTkV11HK+hdpS7WHJTsALrTrT8mLg+YWhiYg2836l9KyfhttKcvTl8pVbjdAo28RLb5TZ7TkC7g3b3AIx79z9iVtByt/uIG50t1dIfc9XCApXidZXAzsPAsp9Mw7/J9sSyB0+pEIipSc24OURrrKr
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 91e7ce67-0946-42d9-f0e5-08d61ee761c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2719;
x-ms-traffictypediagnostic: VI1PR0402MB2719:
x-microsoft-antispam-prvs: <VI1PR0402MB27198226122BF6F3F74BC811FF130@VI1PR0402MB2719.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR0402MB2719;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2719;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(13464003)(81166006)(81156014)(5660300001)(76176011)(6436002)(106356001)(478600001)(966005)(5250100002)(105586002)(45080400002)(97736004)(14454004)(93886005)(99286004)(26005)(7696005)(71190400001)(71200400001)(186003)(53546011)(6246003)(229853002)(4326008)(446003)(25786009)(53936002)(486006)(9686003)(11346002)(476003)(6506007)(316002)(102836004)(86362001)(68736007)(8936002)(256004)(8676002)(66066001)(55016002)(6306002)(575784001)(14444005)(3846002)(6116002)(305945005)(7736002)(74316002)(2906002)(33656002)(5024004)(2900100001)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2719;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lKlrHwz8L/EKP7sUuva+Z1NzcDeZx2rvzhRu6eqdKRqqdTTOrfdG7xt7z8AZ/sI/RS+O25YtWwQ7GjRgvNCUOejh4lTGf3/8KImOvWufOCNbzX7Yz2HbNizke7LEeKuBz+QTGQn+w0ku3V/dmLoPl44uMR59wDpwZSNJfEys5W7qjDfDbAm11lcIJrADNrtEAO4lC559fmPEJfiQbSfiqTtxcYQPRwLalfrhAcns2SF+cjKgsJAgS0IS9WnO96bEwqGJtKrcpnWt7U2L2qQgF6MiLLU1uDmnNtz+uXQu5gYXicKX2uADqWxM8g3p7pmCpAFwjVTj6oQDUhhlQDLjsIHmlHFT0CeqgFi49w0kNOA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e7ce67-0946-42d9-f0e5-08d61ee761c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 10:54:04.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+IFNlbnQ6IDIwMTjlubQ5
5pyIMjDml6UgMTg6NDINCj4gQW0gRG9ubmVyc3RhZywgZGVuIDIwLjA5LjIwMTgsIDEwOjMzICsw
MDAwIHNjaHJpZWIgQW5keSBEdWFuOg0KPiA+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPiBTZW50OiAyMDE45bm0OeaciDIw5pelDQo+IDE3OjQwDQo+ID4gPiBBbSBE
b25uZXJzdGFnLCBkZW4gMjAuMDkuMjAxOCwgMDg6MzkgKzAwMDAgc2NocmllYiBSb2JpbiBHb25n
Og0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gPiA+
ID4gPiBTZW50OiAyMDE45bm0OeaciDIw5pelIDE1OjU1DQo+ID4gPiA+ID4gVG86IFJvYmluIEdv
bmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gPiA+ID4gPiBDYzoganNsYWJ5QHN1c2UuY29tOyBB
bmR5IER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+Ow0KPiA+ID4gPiA+IGxpbnV4LXNlcmlhbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLQ0KPiA+ID4g
PiA+IGxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUN
Cj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxXSB0dHk6IHNlcmlhbDogaW14OiBlbmFi
bGUgSURETUFFTiBmb3IgdGhlDQo+ID4gPiA+ID4gbGFzdCB0YWlsIGRhdGENCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IEhlbGxvLA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVGh1LCBTZXAgMjAsIDIw
MTggYXQgMTE6MjY6MDBQTSArMDgwMCwgUm9iaW4gR29uZyB3cm90ZToNCj4gPiA+ID4gPiA+IGVu
YWJsZSBJRERNQUVOIGluIFVDUjQgdG8gbGV0IHNkbWEgc2NyaXB0IGhhcyB0aGUgY2hhbmNlIHRv
DQo+ID4gPiA+ID4gPiBkZXRlY3QgdGhlIGlkbGUgc3RhdHVzIGFuZCB0cmFuc2ZlciB0aGUgbGFz
dCB0YWlsIGRhdGEgd2l0aA0KPiA+ID4gPiA+ID4gdGhlIGludGVycnVwdCBub3RpZnlpbmcgdWFy
dCBkcml2ZXIuT3RoZXJ3aXNlLCB0aGUgbGFzdCBkbWENCj4gPiA+ID4gPiA+IGRvbmUgaW50ZXJy
dXB0IG9mIHRoZSB0YWlsIGRhdGEgaW4gcnhmaWZvIHdob3NlIHNpemUgaXMgbGVzcw0KPiA+ID4g
PiA+ID4gdGhhbiB3YXRlcm1hcmsgbWF5IG5ldmVyIGJlIHJlY2VpdmVkIGJ5IHVhcnQgZHJpdmVy
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSXMgdGhpcyBhIHRoZW9yZXRpYyBpc3N1ZT8gT3IgZG9l
cyBpdCBmaXggYSByZWFsIHByb2JsZW0/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJZiB0aGUgZm9y
bWVyIEknZCBzYXkgVUNSMV9BVERNQUVOIGJlaW5nIHNldCBzaG91bGQgcHJldmVudCB0aGlzDQo+
ID4gPiA+ID4gc3RhbGwuDQo+ID4gPiA+DQo+ID4gPiA+IEl0J3MgYSByZWFsIGZpeCwgeW91IHdp
bGwgc2VlICd0aW1lb3V0IFdlIHJlYWQgMCBieXRlJyB3aXRoIHRoZQ0KPiA+ID4gPiBhdHRhY2hl
ZCBzdHJlc3MgdGVzdCBydW5uaW5nIG9uIGkubXg3ZCBvciBpLm14NiBpZiBubyB0aGlzIHBhdGNo
DQo+ID4gPiA+IGFwcGxpZWQuDQo+ID4gPiA+ICcgd2hpbGUgWyAxIF07IGRvIC91bml0X3Rlc3Rz
L1VBUlQvbXhjX3VhcnRfc3RyZXNzX3Rlc3Qub3V0DQo+ID4gPiA+IC9kZXYvdHR5bXhjNSAyMDAw
MDAwIEQgTCAxMDAgMTAwIEw7IGRvbmUgJicNCj4gPiA+ID4gUGxlYXNlIG1ha2Ugc3VyZSBkbWEg
ZW5hYmxlZCBvbiB0dHlteGNYIGZvciB5b3VyIHRlc3QsIGFuZCBzZG1hDQo+ID4gPiA+IGZpcm13
YXJlIHNldHVwIGluIHlvdXIgcm9vdGZzIC9saWIvZmlybXdhcmUvaW14L3NkbWEvc2RtYS0NCj4g
PiA+ID4gaW14NnEuYmluDQo+ID4gPg0KPiA+ID4gb3INCj4gPiA+ID4gL2xpYi9maXJtd2FyZS9p
bXgvc2RtYS9zZG1hLSBpbXg3ZC5iaW4uDQo+ID4gPiA+IFlvdSBjYW4gZ2V0IHNkbWEgZmlybXdh
cmUgZnJvbSBiZWxvdzoNCj4gPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiBodHRwczovL2VtZWEwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+ID4g
PiBnaQ0KPiA+ID4gdA0KPiA+ID4gPiAua2VybmVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJG
a2VybmVsJTJGZ2l0JTJGZmlybXdhcmUlMg0KPiBGbGluDQo+ID4gPg0KPiA+ID4gdXgtJmFtcA0K
PiA+ID4gPiA7ZGF0YT0wMiU3QzAxJTdDZnVnYW5nLmR1YW4lNDBueHAuY29tJTdDMjEzMDc2ZjZk
MTExNDE0DQo+IDhiNQ0KPiA+ID4NCj4gPiA+IGNlMDhkNjFlZGNmYg0KPiA+ID4gPg0KPiA+ID4N
Cj4gPiA+DQo+IDg4JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3
QzYzNjczMDMzMQ0KPiA+ID4gODE0ODA0NTQ1JmFtcA0KPiA+ID4gPiA7c2RhdGE9ZDB1Wk1qTGMl
MkZySWFlM1dkNlBXdFgyZ0VHbHZaY1VqUEJWcUtLOTU1MGpnJTNEJg0KPiBhbXANCj4gPiA+DQo+
ID4gPiA7cmVzZXJ2ZWQ9MA0KPiA+ID4gPiBmaXJtd2FyZS5naXQvdHJlZS9pbXgvc2RtYQ0KPiA+
ID4NCj4gPiA+IFBsZWFzZSBzZWUgY29tbWl0IDkwNWMwZGVjYWQyODQwMmFhMTY2OTc1MDIzZmI4
OGM4ZjYyZjkzYzgNCj4gb24gd2h5DQo+ID4gPiB1c2luZyB0aGUgaWRsZSBkZXRlY3QgdG9nZXRo
ZXIgd2l0aCB3aXRoIFNETUEgaXMgd3JvbmcuIFdlIGRvbid0DQo+ID4gPiB3YW50IHRvIHJlLSBp
bnRyb2R1Y2UgdGhlIGJyb2tlbiBiZWhhdmlvci4NCj4gPiA+DQo+ID4NCj4gPiBUaGUgcGF0Y2gg
anVzdCB3YW50IHRvIHVzZSBpZGxlIHRpbWVyIHRvIHN0b3AgU0RNQSB0cmFuc2ZlciB1c2luZyB0
aGUNCj4gPiBuZXcgcmFtIHNjcmlwdCwgd2hvc2UgYWN0aW9uIGlzIG5vdCB0aGUgc2FtZSBhcyBy
b20gc2NyaXB0Lg0KPiA+IFNkbWEgcm9tIHNjcmlwdCBob3cgdG8gc3RvcCBzZG1hIHRyYW5zZmVy
IGlmIG9ubHkgb25lIGJ5dGUgaW4gcnggRklGTw0KPiA+IHRoYXQgdHJpZ2dlciBTRE1BIHJlcXVl
c3QgPw0KPiANCj4gUmlnaHQsIGFuZCB1c2luZyB0aGUgaWRsZSBkZXRlY3QgZG9lc24ndCB3b3Jr
IHdpdGggdGhlIFJPTSBzY3JpcHQgYXMgdGhpcw0KPiBkb2Vzbid0IHJlYWQgdGhlIHJlbWFpbmlu
ZyBieXRlcyBpbiB0aGUgRklGTyB3aGVuIHRoZSBpZGxlIGRldGVjdA0KPiBjb25kaXRpb24gaXMg
aGl0Lg0KPiANCj4gSW5zdGVhZCB3aXRoIHRoZSBST00gc2NyaXB0IHRoZSBhZ2luZyB0aW1lciBp
cyB1c2VkIHRvIHRlcm1pbmF0ZSB0aGUgRE1BDQo+IHRyYW5zZmVyLiBTbyBpZiAxIGJ5dGUgaXMg
c2l0dGluZyBpbiB0aGUgRklGTyBiZWxvdyB0aGUgd2F0ZXJtYXJrIGxldmVsLCB0aGUNCj4gc2Vy
aWFsIGNvcmUgd2lsbCB0cmlnZ2VyIGEgRE1BIHJlcXVlc3Qgd2hlbiB0aGUgYWdpbmcgdGltZSBp
cyBoaXQuIFRoZSBST00NCj4gc2NyaXB0IGNoZWNrcyB0aGUgYWdpbmcgc3RhdHVzIGFuZCByZWFk
cyB0aGUgcmVtYWluaW5nIGJ5dGVzIGZyb20gdGhlIEZJRk8sDQo+IHRoZW4gdGVybWluYXRlcyB0
aGUgdHJhbnNmZXIuIFRoaXMgaXMgYWxsIGRvY3VtZW50ZWQgaW4gdGhlIHJlZmVyZW5jZQ0KPiBt
YW51YWwuDQo+IA0KPiBJIGZhaWwgdG8gc2VlIHdoeSB0aGlzIHNob3VsZG4ndCB3b3JrIHdpdGgg
dGhlIFJBTSBzY3JpcHQuIElmIGl0IGRvZXNuJ3Qgd29yaw0KPiB3aXRoIHRoZSBSQU0gZmlybXdh
cmUsIHRoaXMgc2NyaXB0IGlzIHZpb2xhdGluZyB0aGUgaW50ZXJmYWNlIGJldHdlZW4gdGhlDQo+
IHNlcmlhbCBjb3JlIGFuZCB0aGUgc2NyaXB0IGluIGFuIGluY29tcGF0aWJsZSB3YXkgYW5kIG5l
ZWRzIGZpeGluZy4NCj4gDQpJZiByb20gc2NyaXB0IHN0b3AgRE1BIHRyYW5zZmVyIHdoZW4gU0RN
QSBpcyB0cmlnZ2VyZWQgYnkgYWdpbmcgdGltZXIsICB0aGVuIGlkbGVyIHRpbWVyIGlzIG5vdCBu
ZWVkZWQuIEFuZCB0aGUgZGF0YSBjb3B5IGFjdGlvbiBzaG91bGQgaGF2ZSBubyBwcm9ibGVtLiBJ
IHdpbGwgZG8gc3RyZXNzIHRlc3Qgd2l0aCBTRE1BIHJvbSBzY3JpcHQuDQpGb3IgcmFtIHNjcmlw
dCwgdGhlcmUgaGF2ZSBtYW55IGNoYW5nZXMgYW5kIGRpZmZlcmVudCBhY3Rpb24gd2l0aCByb20g
c2NyaXB0LiBBZ2luZyB0aW1lciB0cmlnZ2VyIGNhbm5vdCBzdG9wIGN1cnJlbnQgU0RNQSB0cmFu
c2Zlciwgc28gdXNlIGlkbGVyIHRpbWVyIGFzIHRoZSBzdG9wIGNvbmRpdGlvbiB0cmlnZ2VyIHNv
dXJjZS4gDQpXZSB3aWxsIGRvIG1vcmUgdGVzdCBvbiByb20gc2NyaXB0LCBpZiBwYXNzIG91ciBh
bGwgdGVzdCBjYXNlcywgd2UgY2FuIGFsaWduIHJhbSBzY3JpcHQgd2l0aCByb20gc2NyaXB0Lg0K
VGhhbmtzLg0KDQpBbmR5DQo=
