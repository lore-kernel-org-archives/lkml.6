Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753719AbeDAQwB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:52:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2931 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753628AbeDAQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:51:58 -0400
X-IronPort-AV: E=Sophos;i="5.48,391,1517846400";
   d="scan'208";a="75598812"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "cleech@redhat.com" <cleech@redhat.com>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAOXMAgAAWvgCAAAewgA==
Date: Sun, 1 Apr 2018 16:51:54 +0000
Message-ID: <321881c736938279fbd3787b9dd4f8b87188bda9.camel@wdc.com>
References: <20180331015903.GA29398@animx.eu.org>
         <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org>
         <44e142c66ee48606a877af37077f9a6dd8a522dc.camel@wdc.com>
         <20180401162421.GA25011@animx.eu.org>
In-Reply-To: <20180401162421.GA25011@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0528;7:4bgs0VBuV4Q6AIhV4OvN4nLF1nHF20GcDWTpTJbV17T4ZMiyKEkvVe9uQY4tsA1bovOscb5A0kAHmfh40zvCU6rKJU2LbtOh+RLcGubs9VCgCh+uUDG2V+hJvZ+RYslYhwt10TSMm5G5w0Mo/86I/unHeZjvToUWbvodujcSc+NAnIciqjbbo3nAOZYZJuqJ8vzKtweiavqvgyo1zrsg6KrrsWyvjVY7x5WbaUXvkRWQEZz7UsqFKCiE2Lj3rW9v;20:EAn7AeUMXfE+aQUBqa9x5n+SjmXV4nqv9M3MhEjIZeUDUJ5LzE4v3maU9QWXZ162VV125qy5v/g3VqBhPVIyzqCZcFoUIy9N/3sY8QDj9Or+4zd3NWNY524tzud1tOBSQfd6SDqVtpquqBUUMPMCnusZPW/LDZKocjDksX+JKOY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 733fbecc-8874-49b4-bd3a-08d597f0dff7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:MWHPR04MB0528;
x-ms-traffictypediagnostic: MWHPR04MB0528:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05280C1A8D036342B481CFD798A70@MWHPR04MB0528.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0528;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0528;
x-forefront-prvs: 06290ECA9D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39380400002)(396003)(39860400002)(199004)(189003)(377424004)(81166006)(11346002)(81156014)(8936002)(68736007)(2501003)(478600001)(6246003)(66066001)(5890100001)(14454004)(5250100002)(6512007)(53936002)(8676002)(72206003)(486005)(316002)(6506007)(102836004)(26005)(486005)(476003)(6486002)(93886005)(3280700002)(2616005)(446003)(5660300001)(3660700001)(186003)(1730700003)(59450400001)(6436002)(4326008)(39060400002)(2906002)(6916009)(25786009)(54906003)(99286004)(86362001)(305945005)(105586002)(118296001)(229853002)(97736004)(76176011)(3846002)(2900100001)(7736002)(5640700003)(2351001)(6116002)(99936001)(36756003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0528;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0kXvwkq0RORgdRCZvPeSzFZwpHgX2Juj0V+l8kj3CrTFsTEd8eyxvwLZG1Q4zuHVoO5JDPr09hka3ZzQ6l0HG4IgE4PVQQvGHIV4N9vHZPYQaHlUg0C57TEJrn9q+AupDvwqaSZBqMgwXo02MH1FUeJSMnnc96gRorh0JFNdQ/j3s+mWON9lgE9nCDxpCxQ4JLGN4Vd5QzL1n+wVMrc2sW4aWssY3uUZSRPQPvqDT9eL6tziGy2nHLcUnYPEul3qegS0is7FWAHFrPeI0v8q1+KXQbu6h0eTuQyP80owDs4xW5f1GIP3m+AnTedBLpj5dbmWppscBu5Hs+RFhBIN51Qfw9P3myICB8ZtB3h9Pa2pNpiKj/K8RBHNEgJ5+n1AA3hOs5cDBqRzkwFAQugsCOd5nd1oDWFQtRUAPnIAjmU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
        boundary="_002_321881c736938279fbd3787b9dd4f8b87188bda9camelwdccom_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733fbecc-8874-49b4-bd3a-08d597f0dff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2018 16:51:54.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0528
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_321881c736938279fbd3787b9dd4f8b87188bda9camelwdccom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <FACCB28BC8496948BDBBB2BDD5D36DE7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDE4LTA0LTAxIGF0IDEyOjI0IC0wNDAwLCBXYWtrbyBXYXJuZXIgd3JvdGU6DQo+
IFdoYXQgZG8geW91IGVuYWJsZSBpbiB0aGUga2VybmVsIHRvIGdldCB0aG9zZSBsb2NraW5nIG1l
c3NhZ2VzPw0KDQpIZWxsbyBXYWtrbywNCg0KSSBoYXZlIGF0dGFjaGVkIHRoZSBzY3JpcHQgdG8g
dGhpcyBlLW1haWwgdGhhdCBJIHVzZSB0byBlbmFibGUgYSBidW5jaCBvZg0Ka2VybmVsIGRlYnVn
Z2luZyBvcHRpb25zLiBQbGVhc2Ugbm90ZSB0aGF0IGVuYWJsaW5nIHRoZXNlIG9wdGlvbnMsDQpl
c3BlY2lhbGx5IGxvY2tkZXAgYW5kIGthc2FuLCB3aWxsIHNsb3cgZG93biB0aGUga2VybmVsLg0K
DQpCYXJ0Lg0KDQoNCg0K

--_002_321881c736938279fbd3787b9dd4f8b87188bda9camelwdccom_
Content-Type: application/x-shellscript;
	name="enable-kernel-debugging-options"
Content-Description: enable-kernel-debugging-options
Content-Disposition: attachment; filename="enable-kernel-debugging-options";
	size=1593; creation-date="Sun, 01 Apr 2018 16:51:54 GMT";
	modification-date="Sun, 01 Apr 2018 16:51:54 GMT"
Content-ID: <5B0863FBC4753A40A3539AD58C064DFE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCm9wdGlvbnM9KAogICAgQ09ORklHX0JMS19ERUJVR19GUwogICAgQ09ORklH
X0RFQlVHX0FUT01JQ19TTEVFUAogICAgQ09ORklHX0RFQlVHX0JPT1RfUEFSQU1TCiAgICBDT05G
SUdfREVCVUdfQlVHVkVSQk9TRQogICAgQ09ORklHX0RFQlVHX0ZTCiAgICBDT05GSUdfREVCVUdf
SU5GTwogICAgQ09ORklHX0RFQlVHX0lORk9fRFdBUkY0CiAgICBDT05GSUdfREVCVUdfSU5GT19S
RURVQ0VECiAgICBDT05GSUdfREVCVUdfS0VSTkVMCiAgICBDT05GSUdfREVCVUdfS01FTUxFQUsK
ICAgIENPTkZJR19ERUJVR19MSVNUCiAgICBDT05GSUdfREVCVUdfTE9DS19BTExPQwogICAgQ09O
RklHX0RFQlVHX01VVEVYRVMKICAgIENPTkZJR19ERUJVR19PQkpFQ1RTCiAgICBDT05GSUdfREVC
VUdfT0JKRUNUU19SQ1VfSEVBRAogICAgQ09ORklHX0RFQlVHX1BBR0VBTExPQwogICAgQ09ORklH
X0RFQlVHX1BFUl9DUFVfTUFQUwogICAgQ09ORklHX0RFQlVHX1BJX0xJU1QKICAgIENPTkZJR19E
RUJVR19QUkVFTVBUCiAgICBDT05GSUdfREVCVUdfUFJFRU1QVF9WT0xVTlRBUlkKICAgIENPTkZJ
R19ERUJVR19TRwogICAgQ09ORklHX0RFQlVHX1NQSU5MT0NLCiAgICBDT05GSUdfREVCVUdfU1RB
Q0tPVkVSRkxPVwogICAgQ09ORklHX0RFQlVHX1NUQUNLX1VTQUdFCiAgICBDT05GSUdfREVURUNU
X0hVTkdfVEFTSwogICAgQ09ORklHX0RZTkFNSUNfREVCVUcKICAgIENPTkZJR19IQVJETE9DS1VQ
X0RFVEVDVE9SCiAgICBDT05GSUdfS0FTQU4KICAgIENPTkZJR19NQUdJQ19TWVNSUQogICAgQ09O
RklHX1BSRUVNUFQKICAgIENPTkZJR19QUk9WRV9MT0NLSU5HCiAgICBDT05GSUdfUFJPVkVfUkNV
CiAgICBDT05GSUdfU0NIRURfREVCVUcKICAgIENPTkZJR19TTFVCCiAgICBDT05GSUdfU0xVQl9E
RUJVR19PTgogICAgQ09ORklHX1dRX1dBVENIRE9HCikKCnVzYWdlKCkgewogICAgZWNobyAiVXNh
Z2U6ICQoYmFzZW5hbWUgIiQwIikgWy10XSIKICAgIGV4aXQgMQp9Cgp0ZXN0X29wdGlvbnMoKSB7
CiAgICBmb3IgbyBpbiAiJHtvcHRpb25zW0BdfSI7IGRvCglncmVwIC13ICIkbyIgLmNvbmZpZyB8
fCBlY2hvICI/Pz8gJG8iCiAgICBkb25lCn0KCnNldF92YXIoKSB7CiAgICBpZiBncmVwIC1xdyAi
JDEiIC5jb25maWc7IHRoZW4KICAgICAgICBzZWQgLWkgInMvXlwoXHwjIFwpJDFcKCBcfD1cKS4q
LyQxPSQyLyIgLmNvbmZpZwogICAgZWxzZQogICAgICAgIGVjaG8gIiQxPSQyIiA+PiAuY29uZmln
CiAgICBmaQp9CgplbmFibGUoKSB7CiAgICBzZXRfdmFyICIkMSIgeQp9CgpzZXRfb3B0aW9ucygp
IHsKICAgIGZvciBvIGluICIke29wdGlvbnNbQF19IjsgZG8KCWVuYWJsZSAiJG8iCiAgICBkb25l
CiAgICBzZXRfdmFyIENPTkZJR19MT0NBTFZFUlNJT04gJyItZGJnIicKfQoKd2hpbGUgWyAkIyAt
Z3QgMCBdICYmIFsgIiQxIiAhPSAiLS0iIF07IGRvCiAgICBjYXNlICIkMSIgaW4KCS10KSB0ZXN0
PTE7IHNoaWZ0OyBicmVhazs7CgkqKSB1c2FnZTs7CiAgICBlc2FjCmRvbmUKCmlmIFsgLW4gIiR0
ZXN0IiBdOyB0aGVuCiAgICB0ZXN0X29wdGlvbnMKZWxzZQogICAgc2V0X29wdGlvbnMKZmkK

--_002_321881c736938279fbd3787b9dd4f8b87188bda9camelwdccom_--
