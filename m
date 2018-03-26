Return-Path: <Sridhar.Pitchai@microsoft.com>
X-Google-Smtp-Source: AG47ELsYKZYrD2l7pVh6PbbpQgBjKqwABDYxfYQBRs9oeHJOS5Eq+nH0UwGiQiB74kbmCiJ8RG+U
ARC-Seal: i=1; a=rsa-sha256; t=1522085539; cv=none;
        d=google.com; s=arc-20160816;
        b=pR+h6R4nA8zHgEf209Rak9prQPzvFFlIV2vSpUPoj/KfyYlgDU8IjiwJqhFY+PKElI
         Uhsy5b4u3gqb9mL88V7hyp+osD+PZ64lPevtOe5sd3DewYUuQ1SFC4NNDNQdiGmyN9Vp
         W2c2fuvNhWJeGla82RlgECs1Z/nocaSFgviKMG/g5YXQA8nBxd8CiG8LcPvcT/DqWdoV
         +ne/xylekh9z1O2LKrkVAq5nHkZAOgCufsraGsmfJ9SGOJi+/qffqN+Wgbl0WN1Hte1y
         Q9/hRuGM73YEvdMqD++88Fl/EirhhwJPKP54vyecWyndtheBfwd77YQMCS/wCOX0laka
         nIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=04nG6jbJGlh+iNHOcDUyLFcZeQ8fcHv1r+srvLF1NEs=;
        b=w9gWB/xmYAgq0zxXTxle7ifq7cWhUn9Bsb5ajxaCMDXqV/6dySX1kIMlFJc5jexkZs
         wbjW538EMc4OLN2NHWKHobbnXRQV0hRy4bsOE2WfW8SUb6naMnRb6gnVK7Zyua28rHmY
         jhqaN85IRFnRhygWAE5k1wlH8nYCO6VvGiAg+OkKqhWZPE1ke22rnH6iy7fbHsYWzFys
         XuVSOlGCBdh1vTlmht7rn+ExmVfBdXIMnIYJlRXbCG1vfRodAmFOpIZZAIAre08FZzGH
         jvlpqCvH2VAyDpOYvza9ggukvqq0ldAqHjBsuguqkP58iFwMzDMcE7bS64CGu5Xo+8V2
         ITAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=mHeHYyXc;
       spf=pass (google.com: domain of sridhar.pitchai@microsoft.com designates 104.47.40.139 as permitted sender) smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=mHeHYyXc;
       spf=pass (google.com: domain of sridhar.pitchai@microsoft.com designates 104.47.40.139 as permitted sender) smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Stephen Hemminger
	<sthemmin@microsoft.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael
 Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, Jake Oshins
	<jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Topic: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Thread-Index: AQHTu/D/DaxTLK2/o0CSPNG8bCOBxaPRM+cAgABaE+D//5pngIAH090AgAB/YQD//9WnAIABmXUAgAKzfoCAAHcYAIAETjgA
Date: Mon, 26 Mar 2018 17:32:17 +0000
Message-ID: <387657CF-8AD7-4C62-9E4E-A7B96915A345@microsoft.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
 <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
 <4E6E5EE3-2EFA-4326-BE14-D5465F5F439F@microsoft.com>
 <20180321162555.GA16028@red-moon>
 <55A0639B-3C54-456D-95C1-829332C024EE@microsoft.com>
 <20180323164716.GA7794@kroah.com>
In-Reply-To: <20180323164716.GA7794@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2::57b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0473;7:oJeRMM3nKCbIcvcndVM7VNjk1+xuCzGhE9Qd/YpxQEqxlO1Jj4SqfQfKUFA/9AofpKwa+fBxtETovEIdq1emyvZevK5eNlbuAJbjBN4rELtqZpQdXvJXFsxfWQvWNqEBhwJS4RNh1fdYVOnjmtKNZGuahUnpYsXmEMvW2iV3/3qvbYPSDxQ1+higs9m21UR9u6PRptMLJ0cYNLFjfbB3pspASO4RNmjSMfWj4CH+IMmZqpwPPdgiC1SNav7/+9TP;20:WBS6REKesv4MgyHCSDwhhmI7sX15t3vVg+mvg9ryAjkW86MbaveXsvx9pmwFI81Gf5pD2eRhe5WSnXAf1USPl10E6fb5F7K9RHkz2Kk9WAn7jf6UfZmKVioEz42hOqS8TMOTN+qfEpQHHQ7V3Mk0zdPWfymnjKgzaMfZhJx0kIg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c98dcc2-f027-419b-b3eb-08d5933f85b7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR21MB0473;
x-ms-traffictypediagnostic: DM5PR21MB0473:
x-microsoft-antispam-prvs: <DM5PR21MB0473E5DCB9EB9F43E1806D99F6AD0@DM5PR21MB0473.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR21MB0473;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0473;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(39380400002)(346002)(376002)(189003)(199004)(22452003)(102836004)(4326008)(305945005)(6436002)(36756003)(83716003)(316002)(7736002)(105586002)(186003)(86362001)(2906002)(10290500003)(14454004)(476003)(486005)(486005)(86612001)(6506007)(10090500001)(46003)(6486002)(5250100002)(99286004)(93886005)(6246003)(72206003)(8936002)(6116002)(81166006)(446003)(76176011)(6512007)(3660700001)(82746002)(81156014)(8676002)(5660300001)(97736004)(54906003)(3280700002)(68736007)(106356001)(6346003)(229853002)(478600001)(33656002)(53936002)(25786009)(6916009)(2900100001)(11346002)(2616005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0473;H:DM5PR21MB0826.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sridhar.Pitchai@microsoft.com;
x-microsoft-antispam-message-info: dD3esjPvZ0uM4rivJgNvFlXACDIJ1PkAEg9INud1Rw2wqDWOwMbuRP1f19RkmWdzPLtlKoo0ZPeUCfNJHboLysQ4oif8/OBloSfGTH3p5QRZXxGz8JvaQwOlJvZOfJmUtakVauI6zqdZ/Hz2FtF9ISzYn9Y9a0URYSv5oHMRTzNGtXbaQpi+DAsT26XJZ3xGYMgcRkpLtlNEyO2roYZXOpUvUznsDRzCJf/jPln0AtFQ840qCetdHEefXYpFphP7ow/BOmlA7z6ZucgmEcEZ9klcRgklD1/ggEcBEppfBb4vqpwhcRroaG9/UIkmm2skoxBwipmQZuzilGnUT0OsFw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC015F66DD62EA409CDE54AA8558974F@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c98dcc2-f027-419b-b3eb-08d5933f85b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 17:32:17.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0473
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596022366913722568?=
X-GMAIL-MSGID: =?utf-8?q?1596022366913722568?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ICANCiAgICA+IFRoaXMgaXMgbm90IHRoZSBjb3JyZWN0IHdheSB0byBzdWJtaXQgcGF0Y2hlcyBm
b3IgaW5jbHVzaW9uIGluIHRoZQ0KICAgID4gc3RhYmxlIGtlcm5lbCB0cmVlLiAgUGxlYXNlIHJl
YWQ6DQogICAgPiAgPHVybD4NCiAgICA+IGZvciBob3cgdG8gZG8gdGhpcyBwcm9wZXJseS4NCg0K
TXkgYmFkLiBJIGFtIHNlbmRpbmcgdGhlIHBhdGNoIHRvIHRoZSBtYWlubGluZSBrZXJuZWwgd2l0
aCBhIENjOiB0YWcgZm9yIHN0YWJsZQ0KYW5kIGhvcGluZyB0aGUgcGF0Y2ggd2lsbCBiZSBhdXRv
bWF0aWNhbGx5IG1lcmdlZCB0byB0aGUgc3RhYmxlIGtlcm5lbHMuDQoNClRoYW5rcywNClNyaWRo
YXIgUGl0Y2hhaQ0KDQo=
