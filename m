Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B1C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506E920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NextfourGroupOy.onmicrosoft.com header.i=@NextfourGroupOy.onmicrosoft.com header.b="iZlGYNft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfANKVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:37 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:63360
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfANKVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com; s=selector1-nextfour-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAbzE7Hn7eBegj0hG7O8H0i13nfNlDgaIr6lb11udPg=;
 b=iZlGYNftrNbDD5KXnXhBXNyDGznbOlfJ2U/3Roqju1k4DoJhw4tG+ax0JgpkHLm1b/7NGwCKVBsnVxvp+s2P8DWBw4MWflaNHyJ1PHhMJgDEOjbyWTJu/B9PZn9y1maNvlIG7ZvFUtVkhR7WnBEgk7yq94qwjdmnyQXhiNaglL4=
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com (52.134.26.12) by
 VI1PR03MB4223.eurprd03.prod.outlook.com (20.177.48.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 10:21:28 +0000
Received: from VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::60d5:fd33:2de5:e03d]) by VI1PR03MB3775.eurprd03.prod.outlook.com
 ([fe80::60d5:fd33:2de5:e03d%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 10:21:28 +0000
From:   =?utf-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@nextfour.com>
To:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Topic: Regression: i.MX6: pinctrl: fsl: add scu based pinctrl support
Thread-Index: AQHUq/LoUZ45TE6n/EyTL/waEgdjDA==
Date:   Mon, 14 Jan 2019 10:21:27 +0000
Message-ID: <e1b63429-30d6-1f52-ce6a-72b1171286f9@nextfour.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0054.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::43) To VI1PR03MB3775.eurprd03.prod.outlook.com
 (2603:10a6:803:34::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [194.157.170.35]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR03MB4223;6:Ac6UZpU1cSuioGIOZtUZQhVA0QoHfWlJZTtqdH35AINe1ZKeGeYeKnbQMuaqOD6B9iOdHtvle0+rWGn9zjbJMu8MCExrgA08jJHhymqx/xcmgdYD7hqKhzS+ioQv/pXek4cSSMEUhtGVgBPhJ2wIgDawDq+zVInaC3mr0cXa90VnfJXFT4FXrlrOzksAHzMhMXICUM3DIuQ6S4BGUBG5A+eAdy2SSb0CXOG+f56lXvj1ASeXJm5wA1I00TFbjHUejc4EEwRQJG6p8Ivts/2zBKKFt5EmN4qgpLMoycET0KH2lD2/ATPOH6Q9ccobexZ1jiOH7PS8Yx/rQJxPVjboEpfFkUV1GOQLNqYU/xDSQ+Zjtbz1H8b0tAb839p/56ALkCF8SClohWuev5VMEAlRhNgh4qVxo0NvjDpSBRr105Zy1hC3HqmW6rLtuSrzu3ZBT6LU3ppPA9/v10Mc8PAIwg==;5:w9EYhv28kzS0+62cDmPlLp/Q29iEDByRfawHX0WlVPLnPC+/G12UcD/ZhO68HgDRzsN2OR50fW3nf1yeLX/wnV5GQVi6akwQh25wkU/nbwToLKXxUDov1QqqXcwWhEWcTDihvAbWOLgydNSAeg1H8N74o0iHJfVGHNgJgft46z1dz0/8/HlHW1hG9vfQQad8s56hYOzEZHyhNRMzU8iz0Q==;7:Whla0wbZatnQOLWOlvh7VJGW/6tnA+SkVNc9sGskbUTS0YF3b4tUZrXsiS3T2GFTbjERxZHV9mD4ergwRXIu8zmsf1cqEkSuzIBXtITuN1OcCdtxZ0XIfi0O1FRKZo4mbDGdophr4RHHc6A32smGzg==
x-ms-office365-filtering-correlation-id: 651096ba-4388-4206-705a-08d67a0a0b23
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:VI1PR03MB4223;
x-ms-traffictypediagnostic: VI1PR03MB4223:
x-microsoft-antispam-prvs: <VI1PR03MB422380D3D852607F464EE3B383800@VI1PR03MB4223.eurprd03.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39830400003)(189003)(199004)(105586002)(52116002)(6916009)(97736004)(2351001)(106356001)(25786009)(31686004)(8936002)(7736002)(99936001)(53936002)(4326008)(71190400001)(71200400001)(558084003)(3846002)(6116002)(8676002)(305945005)(14454004)(39060400002)(6512007)(81166006)(81156014)(31696002)(36756003)(86362001)(6436002)(6486002)(68736007)(99286004)(5640700003)(66066001)(256004)(6506007)(386003)(2501003)(85182001)(486006)(508600001)(2906002)(102836004)(186003)(476003)(2616005)(54906003)(6346003)(316002)(26005)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR03MB4223;H:VI1PR03MB3775.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nextfour.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BxBm/PYptlrc1EtjusTF0IYHWalRGLc+yL3c6/Jt+Cq0Rz/a2P8jK9hBnnANxKczOb5+ghQIq3ECNjpak1hD5r5GVbsWbR9wWNkLzyL4P8zoFLEMBl0Gkr/oeZM29KjGFVLAvaNe0/DgZHzeqtNRfHl4zz14uKM0aJzV9Va8urVhVufCzdZrmZakwYtNA9jW/b51K63sc2SfwS2ev6uSNp850vvSC+G3WVyK/VJ95zmOYZH3G7TIdYawgKgIwmn4jrKAQk3NKTZFzDQsrOHbm+givHDmqtEBRw5nswhd6ljf6cURXmrR+Bwe2hAf2P8gX8s1MY/YxIt/Rr9zWIAKma23Hil+xnXak0tPp8CRvgmHNc+NQ988IACMlFSECh7jhO2/su8I3JIdFMNnrRz2BKvylUHslU7ELi2O3zrsLxQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
        boundary="_002_e1b6342930d61f52ce6a72b1171286f9nextfourcom_"
MIME-Version: 1.0
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651096ba-4388-4206-705a-08d67a0a0b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 10:21:26.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_e1b6342930d61f52ce6a72b1171286f9nextfourcom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4B1B7B81390594390B8C0E8FE03113A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCg0KVGhlIHBhdGNoIHRpdGxlZCAicGluY3RybDogZnNsOiBhZGQgc2N1IGJhc2Vk
IHBpbmN0cmwgc3VwcG9ydCIgY2F1c2VzDQpyZWdyZXNzaW9uIG9uIGkuTVg2LiBUZXN0ZWQgb24g
YSBjdXN0b20gYm9hcmQgYmFzZWQgb24NCmkuTVg2USBhbmQgc2d0bDUwMDAgY29kZWMsIHRoZXJl
IGlzIG5vIHNvdW5kLMKgIHRlc3RlZCB3aXRoIHNpbXBsZSB3YXYNCnBsYXlpbmcuDQoNClJldmVy
dGluZyB0aGUgcGF0Y2ggbWFrZXMgYXVkaW8gd29yayBhZ2Fpbi4NCg0KLS1NaWthDQoNCg==

--_002_e1b6342930d61f52ce6a72b1171286f9nextfourcom_
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Description: pEpkey.asc
Content-Disposition: attachment; filename="pEpkey.asc"; size=2509;
	creation-date="Mon, 14 Jan 2019 10:21:27 GMT";
	modification-date="Mon, 14 Jan 2019 10:21:27 GMT"
Content-ID: <F8923BDFEEA6F842846CDB4A38D4148E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQoNCm1RR05CRnZYMjBRQkRBREhm
U1VzR2tvY2JsMCt0T1R5TXYyYnQxdVZnWVNDN09QQTE5d3FwWXZhTk9ZdjN1d0UNCnUxRmo0QUl3
Tkp1cjZHZWlETzhheXZ0NHlMSzErUnQraGUxQzNlQmJvbnlPNGVIVml5QmdoYkdoN0JsM0xqemEN
CndONVo2WmR0alBzZFVrUTROWGhoWXJDL041QXAwWi80U1VIOWwwMS9LdkgyTy9ERUZwUWVGekFY
TG9DYVBFTnQNCmJ6bnNmdTlGN2VWV3FUa0ZtdTVLNkR3MFJaMzRHNlJQaGtFUG5Uc0VPWkZLbENT
WkJUNFhXZWQ3dys3Y0d1R2YNCmJSVmNzQ3QwSThXNzlEQU12WTl0Qk4wOGVtUXZUeWsrWnF5SUNN
UVFIR0dyVGhpcWVRbVZhNEcxYzBuaW5YWG0NCkNXaHZ4MUxiYUxlOFhuVG4rODV2SndTb092N2NH
R00yUXJGY2sza1A4cGdsbEd1c0hsU0JNUkVwQWEvZmFKVk4NCmJXL1c1TS8yVGtuS3I0YjZjYWNq
NjduOGVTalIxb0VsOVMxR09CM0xSYWRmYlJ2NDhVNXRsRFhtSlEwMHdURlcNCjZNZE5Oc0Q5dnRP
OXJ6UkEyWlhNUnJxTTkxV0RReHdFYW9mTDc5RjU1a3E2eW5FQmJWNEdKbG11TTdHS1h4RWkNCjZw
ZWIvVGNVeUN0YzBzRUFFUUVBQWJRclRXbHJZU0JRWlc1MGRHbHN3NlFnUEcxcGEyRXVjR1Z1ZEhS
cGJHRkENCmJtVjRkR1p2ZFhJdVkyOXRQb2tCMUFRVEFRZ0FQaFloQkZhdGEya1RJeGVrbE1oT1lN
UUdlY2Z6Mnd6RkJRSmINCjE5dUxBaHNEQlFrQjRUT0FCUXNKQ0FjQ0JoVUtDUWdMQWdRV0FnTUJB
aDRCQWhlQUFBb0pFTVFHZWNmejJ3ekYNClZqd0wvMzVTNTR0SWRXT0xGZXUzcHdUT3ZjKzY1SzR4
V1l4cE5aMVRxWVltWW9pUG9IUERTT1pnUDlQeEV2eFkNCjc4NnU5NXgzR096SU9WbkFWRkxtYTZP
eDdnbEVISThwYkNUZEs0ZTdZb2o0NHdqcWcyeTFoMWl4N2d4Ny94MEoNCnJTZ1p0b2gwQkJ4bTM4
UENTamg1QUtwTGt5ZmlhWktpblJUWE1SejROL0VPSHBKQlJveHN5V2U4aFNsUFdGbXoNClFUTzVI
Ynk3N01nUXAzajRLV1ZNYnUxdWVUQi9HZzgxN2hLTUViWFo5SnlMYVhmdDIxUjFvYU8zUDdwajhP
Wk8NClE3QXk4UHBZOXFtOEVKZHo4R2VIUVZQMEhadHdJMXdZYWFYS1FuMzVWRThVU21MNndUZmVt
RW55bVFEMWUyYU8NCmdUY0hvU05HTTVreHNuQUd4VjcrK0prNjh6K2hBVHpoajJ4SmpKNjRHdGoy
SlJFNU52T011RG4yM2QrcnlHblYNCmNmZDBwd1MxT1RQSmVKV3lZb0xCNm1sRUliT2NoUmhaeVFw
eGNNZktkdkJhTURNK0l2YXo0aWFldDhiWHlVdVgNCmExcHNHSjY0anJxQ3FiUDBzK2xBLzBPVTBi
dHNoTjNNWjZCSGxrR3A0WFBhSFFaVVc2dDlPSitrQnhaaXplWjQNCm85N1FZTGtCalFSYjE5dEpB
UXdBcmJUTW8wbGFTaG1WODJXV1lBM1NjRmYzT3NyYmt2aTVNVGxyTkpTUTRjZGgNCk1WZkd5VTZy
aU4zYjU0OTVFQm1BQ21FRTduWjduQVJyYllUN0E1UENKUFpzYUU0Mnp3cTNBWjg5MEFvRWpqTEYN
CitTbHVVQkdaa1p6K2xMQnhwTHh5aGxxQ2gwaUkyR3JnRVZGaGtlRExNSkZRT2ZUdm1HeVFRWXUz
RllJMlpvNG8NCkJwcW1pd3laVk5pOFlKbUNZSksrMTFZT1I4U21SVC9nN3c1cG95Mldla3RIZmhJ
bUdwZE1FUmtUTnp6U3g5cmUNCitrU2ZFSUtFbGVDYVhDZjNKVW4wWU1ZYlY3Z2lnV2RqR0tFYmZI
ODJYbm1qejFkd2pjcVBoRitUbHhsaHNvTDENCndkaHV5QkJMamZITzEzLzh3YUQwRGxtdFpibmdC
SW5kVkJDQmV0Qzl3cDk3MkdQamN5VkFQTHlHUWE5cGs1SkkNCk9nSVVFZE1yNXRUb1kyZ0hqS2pK
MzFrUk9FbDhWRnppdGt1K2ZzSXNaYmRQZnFwMmdPVW9xZ1ZFRGt5M0hZRmkNCmFadWx6TlBVbVlS
WUovR0hvOEFMVThoNE5TdkNkazk3Q3pIdmRrQjEvRThIMTlLdmswYVpIekZRY0JuaGt6cSsNCm4w
WmJTYVRKUzdNNGFxUmFJOGY3QUJFQkFBR0pBYndFR0FFSUFDWVdJUVJXcld0cEV5TVhwSlRJVG1E
RUJubkgNCjg5c014UVVDVzlmYlNRSWJEQVVKQWVFemdBQUtDUkRFQm5uSDg5c014YVppQy93UDdj
N2wrL0IySGNlczRoY04NCnJrbGhHNi9Lc1JUVk83NDhwT1dod2E1dnlCckMwbU1Db0JHWkRmcDQz
ekZPem56NjNDTVlOUzVsSXZEMmthSVENClErRXFaWUpXeHJKU3FjanFwcmRocTlTM1E1U3NkTFpJ
OVBOZVNxdm1FcDN1MUlBeDhraFdKbGEydGErTGwwcFANCkZhdktuNzFFcXlZMzAyc1NRSm5Ob3Z3
b1phNng0Mmo4bXNZY093enBzSExNZGloYWhMbGMvRW1aYXRMR1hpR0MNCm1RbnVmemsrUFBrdWRz
R3p2RWJxTFJ4MWx6MUpTdDM0OU1mVmpYZVUyRnlmZ1NROHNhWXFnRXhEemNMQ0lXSUYNCk82d1d3
em9nUklVN2tHcXRBaWVjc0lzZlUwRE95ZGRqN25aVTFrd1dnK2kwcXUzUjBuQUxXcVQ4eHF4QjRw
dm4NCmNFME52d1FzaXU5MTBBRFlna3VvYThHOHdLWWFuTTZxOVplZWJITWVFSFl5VGJ3bXFaMXls
S1VDd1pXdTBJQkwNCkQ5dUNvN1MrNHM4QTZwZng5SFB4SUY0eFNCNDN2aXV4YURQWkJ4Rm80U04r
bTJGbWlBWDY5UmNTUyt1T3BYYW8NCkxMTHFCVmR5bmRwOE5EWnRPMU9DSzh3bG1VNVI3UmNtWnM2
TG5SMjRCcmNLc0RJPQ0KPUc2US8NCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0N
Cg==

--_002_e1b6342930d61f52ce6a72b1171286f9nextfourcom_--
