Return-Path: <prvs=564c18bbf=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AH8x225tCYQe05uCQ8PqRmG5vbf7Wt5+iCDW2gAqhTx/VGbq6lMJAlhCxyvKnuWS+bR/mbb+7ndO
ARC-Seal: i=1; a=rsa-sha256; t=1517531907; cv=none;
        d=google.com; s=arc-20160816;
        b=pnzImcQWVd1j8B8QfUsjX8VksqTSLqAdm47lHjtQEyAd0vQjdjW+FFQm+xdrEgWcsU
         oOj0Hd7le/WnaOUGlmBSjz4teqDcaaoQZEZuIpstvYpHRUy4O+yJrdAy/RUY31p0SZ/4
         cmYWr6mGwiER+bI2134vZrAo/7B46LMCo1Vo7rq759kKDyDfuzXZxCt502IsIaBCakyt
         wgwPc31Wab8iKH3AFGRruRdpDB67hKyrD51lqoEQOBMLAhVBTxk8SGW3rxC1NOG7tQIT
         +YpLTi8xoKFF3fcSHrbhoFKN4DQb014bs3kBqlCumG7su0lEYvW3GyrN2Xu2gFnYW0M1
         uQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=Lt0/KN/7qF/Ys61H7Kmn4KPLwkOD6IK20Tnsc55tktQ=;
        b=DVgghcDmRPQ+nkWFzpTiB6Fb5UPzbgBAwymdyuDv7+fsQ8pekIS8IlaS5bVH4kMf6d
         NG0FrzRyI73Pxfghzm8aRrkUMSCV+cu8t67XybtV1sxrku/K5nUVv7GyrhpyDdORHKZB
         2tnlDdqf3Xtx77juYeE8wT2KYpptb/lyg6U7WeorCYjZGr4jhaUJPhKKZzBoTOMBQuTJ
         WLPM+gvFDsxBkxpgAG4CHR/Lyw6OkKIQNAF6OidJDTAqlmTN/4FTVgff4eN1PPcpYn1c
         twnbNcATA2L9ES5pl5HFoyUb9Ov8reUW1TitTpDdCojd5VoCpCKdAgTn+48PGLeIhDtr
         h+YA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=HakGF2ZP;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=Kn68eW/A;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=HakGF2ZP;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=Kn68eW/A;
       spf=pass (google.com: domain of prvs=564c18bbf=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=564c18bbf=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,445,1511798400";
   d="scan'208";a="70508656"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
CC: Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v4 08/10] ufs: sysfs: unit descriptor
Thread-Topic: [PATCH v4 08/10] ufs: sysfs: unit descriptor
Thread-Index: AQHTm3gORSuoW1sppE+tpd0nPEIDTqOQRVKA
Date: Fri, 2 Feb 2018 00:38:25 +0000
Message-ID: <1517531903.2746.33.camel@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
	 <1517501746-19075-9-git-send-email-stanislav.nijnikov@wdc.com>
In-Reply-To: <1517501746-19075-9-git-send-email-stanislav.nijnikov@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1502;7:2oH4ZGWQFc8/UI/jPaD8vuzFF3VZQTtQrjAxeAWMZ5SGBmtsz/Bto9uIVpMA9hLx+xDM05hTmcvggi3bgRC34gtwiIHrB4B09vVP/6PhhBPqNydTBCfyplf4pbwn0bsAxU+Ukg+br1421vqwi5xwEWIs7ZAXJJlPWYzqBpjuGXeGSa08uJxc13Ov9afOKHRxThqb5HmHm1Gfsz0tR6XMzYnd7EbJMA+vss16zvmgSd8DbFh+GaerZZpAdRTmzSZv;20:XzoQ9qC0TDss9sOYr9hnsF4KkzNpxyKNhiQA74trOFaSP36u67ytSqPCLZylmuk3wV1HGUiTes+wxtFGX8Jl9nhB8PSAW1NKIqTOFcpA8oC75+/sw6N0ypn6lL6q15ugDzooOArLhGbzFxMJnvMyXR1TtoxB+0Fe/F6mNC4KFO8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 689ac0ea-c0db-41f0-d82e-08d569d54579
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1502;
x-ms-traffictypediagnostic: CY1PR0401MB1502:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1502709F63E23FAE2BF186C498F90@CY1PR0401MB1502.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0401MB1502;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1502;
x-forefront-prvs: 05715BE7FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(39860400002)(39380400002)(376002)(199004)(189003)(377424004)(36756003)(6116002)(66066001)(72206003)(2906002)(99286004)(97736004)(68736007)(76176011)(2950100002)(14454004)(305945005)(5660300001)(2900100001)(7736002)(229853002)(8936002)(478600001)(102836004)(3846002)(316002)(6486002)(110136005)(2201001)(106356001)(3660700001)(2501003)(4326008)(575784001)(86362001)(81156014)(8676002)(53936002)(105586002)(77096007)(26005)(6506007)(81166006)(103116003)(6436002)(6512007)(6636002)(25786009)(186003)(3280700002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1502;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: dB0Xaq6dFF/Fn5nvSAboT/PyUEG2Elgsp4cN4Dt1RsL7Xa9ap8Ff8VCpDv/bQuRUE9fliVAoOjA6oEFbA8Qbsw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D35FB941F90F194780601E34F8982D41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689ac0ea-c0db-41f0-d82e-08d569d54579
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 00:38:25.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1502
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215933151078273?=
X-GMAIL-MSGID: =?utf-8?q?1591247537562492791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gVGh1LCAyMDE4LTAyLTAxIGF0IDE4OjE1ICswMjAwLCBTdGFuaXNsYXYgTmlqbmlrb3Ygd3Jv
dGU6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2NzaV9zeXNmcy5jIGIvZHJpdmVycy9z
Y3NpL3Njc2lfc3lzZnMuYw0KPiBpbmRleCBjYmMwZmUyLi42OWE2YTFmIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Njc2kvc2NzaV9zeXNmcy5jDQo+ICsrKyBiL2RyaXZlcnMvc2NzaS9zY3NpX3N5
c2ZzLmMNCj4gQEAgLTEzMDksNiArMTMwOSwxNCBAQCBpbnQgc2NzaV9zeXNmc19hZGRfc2Rldihz
dHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYpDQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gKwlpZiAoc2Rl
di0+aG9zdC0+aG9zdHQtPnNkZXZfZ3JvdXBzKSB7DQo+ICsJCWVycm9yID0gc3lzZnNfY3JlYXRl
X2dyb3Vwcygmc2Rldi0+c2Rldl9nZW5kZXYua29iaiwNCj4gKwkJCShjb25zdCBzdHJ1Y3QgYXR0
cmlidXRlX2dyb3VwICoqKQ0KPiArCQkJc2Rldi0+aG9zdC0+aG9zdHQtPnNkZXZfZ3JvdXBzKTsN
Cj4gKwkJCWlmIChlcnJvcikNCj4gKwkJCQlyZXR1cm4gZXJyb3I7DQo+ICsJfQ0KPiArDQo+ICAJ
c2NzaV9hdXRvcG1fcHV0X2RldmljZShzZGV2KTsNCj4gIAlyZXR1cm4gZXJyb3I7DQo+ICB9DQo+
IEBAIC0xMzI2LDYgKzEzMzQsMTIgQEAgdm9pZCBfX3Njc2lfcmVtb3ZlX2RldmljZShzdHJ1Y3Qg
c2NzaV9kZXZpY2UgKnNkZXYpDQo+ICAJaWYgKHNkZXYtPnNkZXZfc3RhdGUgPT0gU0RFVl9ERUwp
DQo+ICAJCXJldHVybjsNCj4gIA0KPiArCWlmIChzZGV2LT5ob3N0LT5ob3N0dC0+c2Rldl9ncm91
cHMpIHsNCj4gKwkJc3lzZnNfcmVtb3ZlX2dyb3Vwcygmc2Rldi0+c2Rldl9nZW5kZXYua29iaiwN
Cj4gKwkJCShjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwICoqKQ0KPiArCQkJc2Rldi0+aG9z
dC0+aG9zdHQtPnNkZXZfZ3JvdXBzKTsNCj4gKwl9DQo+ICsNCj4gIAlpZiAoc2Rldi0+aXNfdmlz
aWJsZSkgew0KPiAgCQkvKg0KPiAgCQkgKiBJZiBzY3NpX2ludGVybmFsX3RhcmdldF9ibG9jaygp
IGlzIHJ1bm5pbmcgY29uY3VycmVudGx5LA0KDQpQbGVhc2Ugc3BsaXQgdGhpcyBwYXRjaCBpbnRv
IHR3byBwYXRjaGVzLCBuYW1lbHkgb25lIHBhdGNoIHRoYXQgaW50cm9kdWNlcw0KdGhlIHNkZXZf
Z3JvdXBzIGF0dHJpYnV0ZSBpbiB0aGUgU0NTSSBjb3JlIGFuZCBhIHNlY29uZCBwYXRjaCB0aGF0
IGRvZXMgbm90DQptb2RpZnkgdGhlIFNDU0kgY29yZSBidXQgb25seSB0aGUgVUZTIGRyaXZlci4g
VGhhdCB3aWxsIG1ha2UgdGhlc2UgY2hhbmdlcw0KZWFzaWVyIHRvIHJldmlldy4NCg0KQWRkaXRp
b25hbGx5LCBpdCBzZWVtcyB3cm9uZyB0byBtZSB0byBjYXN0IHRoZSB0aGlyZCBhcmd1bWVudCBv
Zg0Kc3lzZnNfY3JlYXRlX2dyb3VwcygpIGFuZCBzeXNmc19yZW1vdmVfZ3JvdXBzKCkgZnJvbSBh
IG5vbi1jb25zdCB0byBhIGNvbnN0DQpwb2ludGVyLiBQbGVhc2UgY29uc2lkZXIgdG8gZGVjbGFy
ZSB0aGUgc2Rldl9ncm91cHMgbWVtYmVyIGNvbnN0IGFuZCBhbHNvDQp0aGUgY29ycmVzcG9uZGlu
ZyBkYXRhIHN0cnVjdHVyZXMgaW4gdGhlIFVGUyBkcml2ZXIuDQoNClRoYW5rcywNCg0KQmFydC4=
