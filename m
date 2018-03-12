Return-Path: <kernel-hardening-return-12466-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELunSHJ5HQwZuPatiRKMrYYxDtt6bLz2W38PPv4o1akaZAcbb0AjDyI9/mgw9eKmtHlyrbsh
ARC-Seal: i=1; a=rsa-sha256; t=1520871144; cv=none;
        d=google.com; s=arc-20160816;
        b=M+Q8mgFcMJexV/Lnm8nl/20BXAK4rklNdorJGIxl3w72vgUQZEF1pk1/0bNxSm3NQF
         0P16W47MjGAN1p8XQbEKIEDU3qapUSs8rNp4KkJS1raUhMz17hCriMfOSgZC+as3k9MG
         5Vf4H33rJG1UjWvUrxxC9o+riaBJES+Swj+48r0LbyVVtFIGxooWk/57rAD5r5VFh6y+
         zhUlS0DlKNiuJ6Pu+V/PoBelhaeQcIa3ZkCNu6ky8zan/gGBua8SsNX7X2UGTYPkZ57E
         ssOi3MyYddWPzhN/rdW/TJCH7l8zoa8dhzvMLcsBx1v+tTjkvlzINPj0IdwaerlsLeDG
         GsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=MXiRWFNnNDyDEGy1sVQnDvx+vYVrzOhx9jVC9zEvNCI=;
        b=UPY6fchtpxrfCDnpSh28xKG8KIXf5X4fhsdwQR0+AkamtEo4TB8UW7RzUdhfwq9dvT
         R+4HqOWu5G3HiN6qRJ+MTngNBcy54vDZE408UVMHiP6Xk5Cx5KPT5/8kdX/C8BwQ9dgV
         K/857wEnTO07EhT60Bl0Fr9wpIRj1yfSe6gILZqBhBGLmk0ymbHhdW2Sin0BxiOTYMMs
         Bv/7gU9X68UBqetF9THu6VPkJlrJaeRndQp0fgBadyfGaoWUyP9c22tSBkVYen9fxYwd
         noQV45GZkRMoDbRJKUfrBvD7bnPDzRqNLU42f8bi9idzn+SmXhHmHfNX1hhPIsd8059C
         qGaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=fyHNdHLq;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=SiVHMN+E;
       spf=pass (google.com: domain of kernel-hardening-return-12466-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12466-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=fyHNdHLq;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=SiVHMN+E;
       spf=pass (google.com: domain of kernel-hardening-return-12466-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12466-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-IronPort-AV: E=Sophos;i="5.47,461,1515427200";
   d="scan'208";a="73458665"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "steve@sk2.org" <steve@sk2.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"hare@suse.com" <hare@suse.com>, "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>
Subject: Re: [PATCH] device_handler: remove VLAs
Thread-Topic: [PATCH] device_handler: remove VLAs
Thread-Index: AQHTt/aUex+QuA3suUC1+a/4cQR5DqPIgXUAgADyBgCAA02/gA==
Date: Mon, 12 Mar 2018 15:41:26 +0000
Message-ID: <1520869285.3469.13.camel@wdc.com>
References: <20180309232933.14e39858@heffalump.sk2.org>
	 <20180309223211.20473-1-steve@sk2.org> <1520635688.2907.17.camel@wdc.com>
	 <20180310141422.3a8c451f@heffalump.sk2.org>
In-Reply-To: <20180310141422.3a8c451f@heffalump.sk2.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0928;7:QyBXvX5xqSE/6wbU02r5fwS11DPOV/VbcsF+8h+xY13OjYpjQu2DKQWiX9ejDKM2xcSxsyBK43CMmYQ8A7ajkuuNWbJ8k3LRUPAKdZgO4tZOD9jE4XOyWzysoyydxv3O4xOs16byXoP1EW8KDsBFj7plQY5SivxlNAWGVG722Afd9eLHZUpe5ikd/RAMVHsorlx5+GZYXEI2WzomutHM9C9B+rCvQtUmmEEZXMmO9xlpyFCEGoihZrWKZY3F0pov;20:vr+9P1NP4VJnd8Is4ML9cwFvOjFuiksnVPF7CryDj9SAqyvSOlxnMzwuEhpy+09yFULWZXQVeRCDTAMWtdCarTKSx/OTQz8hantlop6iX+h6fgb8Z2RSOxYCqRcrEz6TQFN7vuYXjAJx0Ioq9wiI1oJgpNjLQqiRRe9DJywBN+8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da4e998d-310b-4dcf-308a-08d5882fb74b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0928;
x-ms-traffictypediagnostic: MWHPR04MB0928:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB092816BD3D2CC3457A59B7E598D30@MWHPR04MB0928.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0928;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0928;
x-forefront-prvs: 06098A2863
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(199004)(189003)(377424004)(72206003)(54906003)(99286004)(25786009)(81166006)(305945005)(93886005)(103116003)(4326008)(6246003)(36756003)(81156014)(2351001)(1730700003)(106356001)(8676002)(5660300001)(7736002)(3660700001)(68736007)(6116002)(478600001)(3846002)(14454004)(229853002)(2501003)(966005)(5250100002)(5640700003)(6436002)(53936002)(6306002)(6512007)(66066001)(3280700002)(105586002)(8936002)(26005)(59450400001)(186003)(102836004)(97736004)(6486002)(2900100001)(6916009)(2906002)(76176011)(2950100002)(86362001)(316002)(6506007)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0928;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 9sQNfCfYq8UTHCyy7thbvl1YrEHRms7Y3PM4fJIkBziC8lNWhlBEmK5x2hGtzAOBxpG3h3JV1kiSEcVJm+ejyj3ACWi6aIQLGqZPM8U1wyJHqj0wY71mY77Hu4ILrTpZjZs/cBr4vyC/KlxAPcRf3WTMTHkHmEWFMNnB6GkVMuoYBf0Nqa+QNVQRAX+DCOv/Z/BxP0HuUuFe2jLcpqv1Zq4FXH4QkvhN4GlUlMrCgm/UXILvx+3t6cW3+XG9+uFNHXQOxb8zL36MRic1HC+gByQGkioFOwxPyxSHHi+bMhlyiKIntH6JNYJBNnJKmGBKQnPr/E7tFFItbmiwfsp6lw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0DD18BB1A20EC49A68831DE9DF44737@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e998d-310b-4dcf-308a-08d5882fb74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2018 15:41:26.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0928
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594501121445271854?=
X-GMAIL-MSGID: =?utf-8?q?1594748980641942971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU2F0LCAyMDE4LTAzLTEwIGF0IDE0OjE0ICswMTAwLCBTdGVwaGVuIEtpdHQgd3JvdGU6DQo+
IFRoZSB0d28gcGF0Y2hlcyBJIHNlbnQgd2VyZSBzdXBwb3NlZCB0byBiZSBhbHRlcm5hdGl2ZSBz
b2x1dGlvbnM7IHNlZQ0KPiBodHRwczovL21hcmMuaW5mby8/bD1saW51eC1zY3NpJm09MTUyMDYz
NjcxMDA1Mjk1Jnc9MiBmb3IgdGhlIGludHJvZHVjdGlvbiAoSQ0KPiBzZWVtIHRvIGhhdmUgbWVz
c2VkIHVwIHRoZSBoZWFkZXJzLCBzbyB0aGUgbWFpbHMgZGlkbuKAmXQgZW5kIHVwIHRocmVhZGVk
DQo+IHByb3Blcmx5KS4NCg0KVGhlIHR3byBwYXRjaGVzIGFycml2ZWQgaW4gbXkgaW5ib3ggc2V2
ZXJhbCBtaW51dGVzIGJlZm9yZSB0aGUgY292ZXIgbGV0dGVyLiBJbg0KdGhlIGUtbWFpbCBoZWFk
ZXIgb2YgdGhlIGNvdmVyIGxldHRlciBJIGZvdW5kIHRoZSBmb2xsb3dpbmc6DQoNClgtR3JleWxp
c3Q6IGRlbGF5ZWQgMTgxMCBzZWNvbmRzIGJ5IHBvc3RncmV5LTEuMjcgYXQgdmdlci5rZXJuZWwu
b3JnOyBGcmksIDA5IE1hciAyMDE4IDE4OjA1OjA4IEVTVA0KDQpEb2VzIHRoaXMgbWVhbiB0aGF0
IHRoZSBkZWxheSBoYXBwZW5lZCBkdWUgdG8gdmdlciBzZXJ2ZXIncyBhbnRpLXNwYW0gYWxnb3Jp
dGhtPw0KDQpCYXJ0Lg0KDQoNCg0K
