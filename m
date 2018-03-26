Return-Path: <prvs=6169d87a0=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx4+rotMX80QOGZjaXhiqqE96Ypfc4mIiCwD2w/HxPO3a/bZY0Npkcpa/Ae7rgy9sZ++zlK4Z
ARC-Seal: i=1; a=rsa-sha256; t=1522104546; cv=none;
        d=google.com; s=arc-20160816;
        b=Gaz2PohliqUJaxrIqU1WBQy3rHTazF2AbWmVNKN2miTocgIteM5E1HssHOOj5DmXA7
         sTn22KbeercRX9WR89WUcFmlRVG4Z+FN8n1hvJAGjCFQjp7eBksbn/T2HPRhwVam/1v6
         jXBFC0C6ygf/NZOR/a22Ds4xU592oHqT6Uyc+DPIeDftsNHghcc6zcvmlE3FQIjYJOO/
         v3CNRr0RjtBi124RbdgfmU77lBVrP790KCRa3AGi+ylma/p0OI1DBTm6cB6gtOyrkAz0
         Ua1pbSUGQOI8nhGYSt4Lwa8CgYTT+dqTZyRrSNqJjQL67NeUJ+tKizttkmY/kN1BbcsY
         DQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-language:accept-language:in-reply-to:references:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=ZhjoDpn0e7K5JzGsr0yNG/aocFyHPR8/7D38XAozZ6M=;
        b=orsm80AKWKsYRO/T9ZMoCg0KB71f+wNwN8jkT6drlLyDNCoi9ObbMW8lCNmtl6HEeE
         8DFmNcpFvSFyj9u+DEBsjFkbIbAOdTcmiaDt0swtdLDKItO9hS6j5bUlQUWRMBBBKvdW
         i+Y9BafjOb8NqgIzUlM4D0Ttn5rSvObgtEyPbBhoTl1BKe2jhFRvFheYCZvoU48MQspi
         eYclv5V6318eljIzccX55+/Z8Gmi9OBTDqfcZlKrk/c1BYykw+ILIdvM5+02KjykTiTt
         IPavYGD8htiZgvtCW5MYuXzbFvnzm1XF5XG+SSiU35HvwQwHQ8uzjM5y4+uifsU64/Vy
         vM9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=aceRWSZu;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=hhccUsMd;
       spf=pass (google.com: domain of prvs=6169d87a0=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=6169d87a0=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=aceRWSZu;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=hhccUsMd;
       spf=pass (google.com: domain of prvs=6169d87a0=bart.vanassche@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=6169d87a0=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,365,1517846400";
   d="scan'208";a="171107972"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: Ohad Sharabi <Ohad.Sharabi@wdc.com>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, Stanislav Nijnikov
	<Stanislav.Nijnikov@wdc.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: Re: [PATCH v3] scsi: ufs: add trace event for ufs upiu
Thread-Topic: [PATCH v3] scsi: ufs: add trace event for ufs upiu
Thread-Index: AQHTxAgdzQUwmgl5yUC2AkxigzyoJaPjISkA
Date: Mon, 26 Mar 2018 22:48:53 +0000
Message-ID: <1522104532.3102.24.camel@wdc.com>
References: <1521961684-13588-1-git-send-email-ohad.sharabi@sandisk.com>
In-Reply-To: <1521961684-13588-1-git-send-email-ohad.sharabi@sandisk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1214;7:eaahuHLivgVuzJCinhNNPWF5QA9gww/Vz9RsV3WlrKGcEnpfJvxYhXJuj5b5eOOqk5k6fusccZi7TS2cDve6Z/dLd+tZbjGbgLHvsSwCTt2eWGeD7jZkCggMTYlD7qh7MHvdcu26Xe/thfrgodSb1Jt+Qo99KGitEWbEiLZlkp6OPoUUaNHwj4aWi+2Hoeb0MeUuvRI2HKbSOknhkbPmaIdHcB7SDwLzJr5afxCQSQu/JaAC95NAg8oCxkbgLn55;20:bgWx6eZrVNehdl1XEPRMabt12emeESEmp6BlvH6PVtosZ1U8+TX5samoPxEbkp7TilHrilmoy3O8v4SdQ1dT53ik7ujWYA9WBn2/XNfvRVRx2o24TdLxXEHnivSMcJcoZfIJDAn3Wekfpc2sbNRRn6xmzLt17sgftq6nA+UqK0U=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fbf8328-b987-4713-20af-08d5936bbff1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1214;
x-ms-traffictypediagnostic: MWHPR04MB1214:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1214B732F11AECA47FDCEBAE98AD0@MWHPR04MB1214.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB1214;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1214;
x-forefront-prvs: 06237E4555
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(39380400002)(346002)(377424004)(189003)(199004)(54534003)(105586002)(25786009)(72206003)(229853002)(76176011)(97736004)(66066001)(3660700001)(2501003)(2900100001)(6506007)(476003)(5250100002)(2906002)(36756003)(99286004)(3280700002)(14454004)(4326008)(6486002)(551934003)(103116003)(7736002)(6512007)(8936002)(305945005)(53936002)(8676002)(81166006)(81156014)(5660300001)(6436002)(106356001)(26005)(6116002)(478600001)(446003)(316002)(2616005)(102836004)(54906003)(11346002)(110136005)(2201001)(6246003)(68736007)(86362001)(3846002)(486005)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1214;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: myeCn/YDeXzE0zAFR1XwnXKdFQ39SBOzhtKNPvA/VlKwd8jJ8SYQpvUt/vY7aVtspqTlbJ8ZRb5Rv6O8jwyaWWxRz5CTJXbH81rsfIj2G5IwOgcBgj9ZVgn4Epze1mgwGVNoR5oGG3zQ0Ftt7Y/XQ8E3SqfF8G+9/N5a7m8EVblQdC6i3b+LOYNcY4OrbNWqihTSL/SEHdbX6T2QjXM8ZSxqso6o6CXepPkALqx9sLMcExtCAXxzseRcFtJUSPpRk7QebslmGYLY1goNlaOzxTDjipcePI3w4W5PhPgN1RfeRpnGGesFbKj5hnRWvLZOxpeiw90sxr6YlUw2JDfE0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3087C897FB9304282B568755AC539C0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbf8328-b987-4713-20af-08d5936bbff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2018 22:48:53.2890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1214
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595892513876179134?=
X-GMAIL-MSGID: =?utf-8?q?1596042297002482913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T24gU3VuLCAyMDE4LTAzLTI1IGF0IDEwOjA4ICswMzAwLCBPaGFkIFNoYXJhYmkgd3JvdGU6DQo+
IEFkZCBVRlMgUHJvdG9jb2wgSW5mb3JtYXRpb24gVW5pdHModXBpdSkgdHJhY2UgZXZlbnRzIGZv
ciB1ZnMgZHJpdmVyLA0KPiB1c2VkIHRvIHRyYWNlIHZhcmlvdXMgdWZzIHRyYW5zYWN0aW9uIHR5
cGVzLSBjb21tYW5kLCB0YXNrLW1hbmFnZW1lbnQNCj4gYW5kIGRldmljZSBtYW5hZ2VtZW50Lg0K
PiBUaGUgdHJhY2UtcG9pbnQgZm9ybWF0IGlzIGdlbmVyaWMgYW5kIGNhbiBiZSBlYXNpbHkgYWRh
cHRlZCB0byB0cmFjZQ0KPiBvdGhlciB1cGl1cyBpZiBuZWVkZWQuDQo+IEN1cnJlbnRseSB0cmFj
aW5nIHVmcyB0cmFuc2FjdGlvbiBvZiB0eXBlICdkZXZpY2UgbWFuYWdlbWVudCcsIHdoaWNoDQo+
IHRoaXMgcGF0Y2ggaW50cm9kdWNlLCBjYW5ub3QgYmUgb2J0YWluZWQgZnJvbSBhbnkgb3RoZXIg
dHJhY2UuDQo+IERldmljZSBtYW5hZ2VtZW50IHRyYW5zYWN0aW9ucyBhcmUgdXNlZCBmb3IgY29t
bXVuaWNhdGlvbiB3aXRoIHRoZQ0KPiBkZXZpY2Ugc3VjaCBhcyByZWFkaW5nIGFuZCB3cml0aW5n
IGRlc2NyaXB0b3Igb3IgYXR0cmlidXRlcyBldGMuDQo+IA0KPiB2Mi0+djM6DQo+ICAgICAtIG1v
ZGlmeSBhcmdzIDMsNCBvZiB0cmFjZV91ZnNoY2RfdXBpdSB0byBiZSB2b2lkICoNCj4gDQo+IHYx
LT52MjoNCj4gICAgIC0gc3BsaXQgdG8gdHJhbnNhY3Rpb24gc3BlY2lmaWMgZnVuY3Rpb25zIChm
aXggd2FybmluZ3MgYW5kIHNpbXBsaWZpZXMNCj4gICAgICAgY29kZSkNCj4gICAgIC0gYWRkaW5n
IHRyYWNlcyB3aGVuIHNlbmRpbmcgcXVlcnkgY29tbWFuZA0KDQpUaGUgY2hhbmdlbG9nIGZvciBh
IHBhdGNoIHNob3VsZCBhcHBlYXIgdW5kZXIgdGhlIHRocmVlIGh5cGhlbnMgc3VjaCB0aGF0IGl0
DQpnZXRzIGRpc2NhcmRlZCBhdXRvbWF0aWNhbGx5IGJ5IHRvb2xzIGxpa2UgImdpdCBhbSIuIE1h
cnRpbiB3aWxsIGhhdmUgdG8NCnJlbW92ZSB0aGUgYWJvdmUgY2hhbmdlbG9nIG1hbnVhbGx5LiBB
bnl3YXk6DQoNClJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJhcnQudmFuYXNzY2hlQHdk
Yy5jb20+DQoNCg0KDQoNCg==
