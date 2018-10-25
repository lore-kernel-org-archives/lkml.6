Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB43C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09F120834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZnvUwMan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09F120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJYQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:28:49 -0400
Received: from mail-dm3nam03on0077.outbound.protection.outlook.com ([104.47.41.77]:31376
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeJYQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DloaB6UQmGLPAgRL6lmK4OFMjM3AkBavSA+6Irn+/3I=;
 b=ZnvUwMan2mlZsf8dH+vxGmoQiDFkB3jvtHVVA7DgOWCde59MAswNhFz+LloinSdA1EysOnIZdf427wAlArT3eKMN238MujIAZ5K5WkHsZQ0LExsGhxJfvzxfEs2gVVL19MflWoWyFzZbEcrtwzu0R0SZhV70EEKWa9rxvWvPeaE=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1937.namprd12.prod.outlook.com (10.175.102.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 07:57:08 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1273.021; Thu, 25 Oct 2018
 07:57:08 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Julia Lawall <julia.lawall@lip6.fr>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: fix call_kern.cocci warnings (fwd)
Thread-Topic: [PATCH] drm: fix call_kern.cocci warnings (fwd)
Thread-Index: AQHUbDhTO4PSQTgdRUK8ZmIOpshiGQ==
Date:   Thu, 25 Oct 2018 07:57:07 +0000
Message-ID: <1b153270-c73f-ea6f-6573-b742b81d6c42@amd.com>
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
 <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
 <823eb7cc-ba7e-b816-1821-c73dfd4c70bf@googlemail.com>
 <8c956766-57ba-c6f7-405c-04a41ae926be@linux.intel.com>
In-Reply-To: <8c956766-57ba-c6f7-405c-04a41ae926be@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM6PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::48) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1937;20:pmrnN90iihNNorA404iegjbSxhxl1DZufLEn32ZuA2pQbkiAemwuqkNMxEMYbB504kxxc6iru4TKUo/euzZwbEztcGlyrQGJbrNNDoDgS8Se5JyDDyuu5XO9TYldrKCh3R79oOPt8UDUYsi6lxiPuV6EdP4aqIQmjv/DXrabZ5U65LuD1l+8SGcnX6hwHx4PFXvUGv+DAfFnnSy20IdhfbpcQIeyAk92HTxIxSkZ97EVIdkZcdrcTZS4am+vjohI
x-ms-office365-filtering-correlation-id: c1f0473f-c2ab-4600-09ec-08d63a4f75cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1937;
x-ms-traffictypediagnostic: BN6PR12MB1937:
x-microsoft-antispam-prvs: <BN6PR12MB193793113CFB85F129B48DC083F70@BN6PR12MB1937.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1937;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1937;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(189003)(199004)(86362001)(4326008)(5660300001)(25786009)(305945005)(52116002)(186003)(6512007)(31686004)(105586002)(106356001)(76176011)(6486002)(11346002)(5250100002)(229853002)(476003)(93886005)(102836004)(6436002)(7736002)(446003)(2616005)(386003)(71200400001)(54906003)(486006)(97736004)(71190400001)(65806001)(110136005)(58126008)(6506007)(36756003)(6116002)(99286004)(478600001)(64126003)(46003)(65826007)(256004)(65956001)(53936002)(14444005)(68736007)(8936002)(31696002)(316002)(66574009)(8676002)(81166006)(14454004)(6246003)(72206003)(2900100001)(2906002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1937;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0x693Q2MyFHNeOF0javktBMkZeAi6jGbuUfJ0WHWpcpQn8W+DInls+gujxcpu9NsEbQIht82pN8Rgoi6f5B2c1bj8F6hyYApEEN9p7evL3D1oe0uAgTAmaQcB1L4p0/vkjjSx4vKY+xC9jiavvgr+pObMKUa95a6yxxTYzcRTg3Xq6i0vjYE2KJ82DZ8aj1NJ72CUedZqrFtd8VhmuPqkAK5S0XF5ukcCxRKAyhllLcBuDrwM00GpgMHCO+vYyjQ3lIEq0UcbjXQKGX1pE7/4LxqoREw7wBtMuqwFOQNrqoF0fUs+TVLVdwEtLRftbZdlt0syTUxgdqRgIo5hzThqyuPwFifeiQTz9r2ACVSQPw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA2E9B91AC3F464991C7E0A9A54692B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f0473f-c2ab-4600-09ec-08d63a4f75cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 07:57:08.3176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjUuMTAuMTggdW0gMDk6NTEgc2NocmllYiBNYWFydGVuIExhbmtob3JzdDoNCj4gT3AgMjUt
MTAtMTggb20gMDg6NTMgc2NocmVlZiBDaHJpc3RpYW4gS8O2bmlnOg0KPj4gQW0gMjUuMTAuMTgg
dW0gMDM6Mjggc2NocmllYiBaaG91LCBEYXZpZChDaHVuTWluZyk6DQo+Pj4gUmV2aWV3ZWQtYnk6
IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91QGFtZC5jb20+DQo+PiBOQUssIEdGUF9BVE9NSUMg
c2hvdWxkIGJlIGF2b2lkZWQuDQo+Pg0KPj4gVGhlIGNvcnJlY3Qgc29sdXRpb24gaXMgdG8gbW92
ZSB0aGUgYWxsb2NhdGlvbiBvdXQgb2YgdGhlIHNwaW5sb2NrIG9yIGRyb3AgdGhlIGxvY2sgYW5k
IHJlYWNxdWlyZS4NCj4gWWVhaCArMS4gRXNwZWNpYWxseSBpbiBhIGNhc2UgbGlrZSB0aGlzIHdo
ZXJlIGl0J3Mgb2J2aW91cyB0byBwcmV2ZW50LiA6KQ0KDQpBbm90aGVyIHBvc3NpYmlsaXR5IHdv
dWxkIHRvIG5vdCBhbGxvY2F0ZSB0aGUgZHVtbXkgZmVuY2UgYXQgYWxsLg0KDQpFLmcuIHdlIGp1
c3QgbmVlZCBhIGdsb2JhbCBpbnN0YW5jZSBvZiB0aGF0IHdoaWNoIGlzIGFsd2F5cyBzaWduYWxl
ZCBhbmQgDQpoYXMgYSByZWZlcmVuY2UgY291bnQgb2YgKzEuDQoNCkNocmlzdGlhbi4NCg==
