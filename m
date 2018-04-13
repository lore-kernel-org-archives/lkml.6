Return-Path: <vadimp@mellanox.com>
X-Google-Smtp-Source: AIpwx4+01isXQ5b4++stFM6hc4oo9t/5EBY1l947TwrkukrhzjzNIa9eg94WCiCkcwNZE0d2g2xd
ARC-Seal: i=1; a=rsa-sha256; t=1523649215; cv=none;
        d=google.com; s=arc-20160816;
        b=jdf1tZFDot+Mu8UK5Y80v/WWmNFlxdm6cvvEJKEIIkP5bv+NOr4K9zhUn+Cv2vXCfd
         rVRS0yoIoLCHgHEyb5iqf4elXwHt8cS0K83+6kd+iJBBqo34APwOa+I1FcwEStOWA5yN
         VqmYNMsvCATTmAIhf/1nM4cIDcDT4PM9ZP9tuGtKZ58huFZmTa3xs5yfkvZDJKViuZZY
         8EWmEp3AFWxoly1dTdDCff6aBlL6tgy390RZNRy3uNB9KYXY45/0Ban93GinM8tibXoV
         8u4qFZBb5/uh/sgi2HHX7EJHXMcJ/K7k8hUwD27WCxhIqmIduX3A4aGUL71XkMGYoPe4
         X1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=eSBGgPbQRa9hm7ew9kUrCyj5dfMOCLcsfenQnRpEWM0=;
        b=qvVLPhSCZETBjjaKJ6h2/9P32QeLn1JarlNFRUbf6EExBkKeqc3vUFEFgMOPdV7vBJ
         ADy9Magv1z0H46hWi0E+0W8JVMuUOmN237NwACpM36dIZPBc4RZjJLTnfC1ALeWqsz+q
         CJDoqvOWF+upeXkmRnuO6Q3hFrzGqVXYiihuguWVJ6j/hgW9i3f+2p12N0QSFqyYud1E
         WguI7M4b04y2fqW0mROB0TgdNXU19uf2hUuHRsfIqKn5jf9O/YVOC+Q9K7ik6vP7QOSs
         qLw0hATbZ6lQrYATDPeqCqC4g/3kgag86BsYZjozg1RuPh6eIh2pKN4DenxiEFgBF2XM
         uD0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=MRoL2Y/O;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 40.107.1.65 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=MRoL2Y/O;
       spf=pass (google.com: domain of vadimp@mellanox.com designates 40.107.1.65 as permitted sender) smtp.mailfrom=vadimp@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych
	<michaelsh@mellanox.com>, "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v1 4/7] platform: mellanox: add new ODM system types to
 mlx-platform
Thread-Topic: [PATCH v1 4/7] platform: mellanox: add new ODM system types to
 mlx-platform
Thread-Index: AQHTxaKXdm5H7y7paUaSj+YDqBC63aP/BOyAgAAvghA=
Date: Fri, 13 Apr 2018 19:53:31 +0000
Message-ID: <AM6PR0502MB3752A6F66062DF33C4319BABA2B30@AM6PR0502MB3752.eurprd05.prod.outlook.com>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-5-git-send-email-vadimp@mellanox.com>
 <20180413165433.GF27560@fury>
In-Reply-To: <20180413165433.GF27560@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0502MB3685;7:RcqFCx37fRPCQ2fXE/fMbwgt8X6k1o2C28t5q1sbQ6zV9f+Bs0CorgL9BAgqtszJr6fHxnHV+ADVG38RmVea9YwQkmzKReC/PHWtLxHLfySgI30vEplwsn8sWX6vQtLezk796sBIXG3dPIAjBLnvRdkAKuCIIO9y52jYGLRU4kpWgRHOr+p/P6gVS+dCElOF8PBS8XZuDnb3NDf3tM2jbZZNiHb1hvYrJU2iaaZTBqCOn9vj+MEA4LzP93UENoDL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR0502MB3685;
x-ms-traffictypediagnostic: AM6PR0502MB3685:
x-microsoft-antispam-prvs: <AM6PR0502MB3685DB2682000C6264E5AC24A2B30@AM6PR0502MB3685.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM6PR0502MB3685;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0502MB3685;
x-forefront-prvs: 0641678E68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(13464003)(189003)(446003)(316002)(33656002)(3846002)(66066001)(2900100001)(478600001)(7696005)(74316002)(6116002)(26005)(39060400002)(99286004)(76176011)(11346002)(6436002)(14454004)(68736007)(53936002)(6246003)(476003)(81166006)(105586002)(8676002)(81156014)(55016002)(54906003)(9686003)(229853002)(5660300001)(3280700002)(102836004)(3660700001)(86362001)(97736004)(486006)(4326008)(25786009)(6506007)(305945005)(6916009)(5250100002)(186003)(53546011)(2906002)(106356001)(8936002)(7736002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3685;H:AM6PR0502MB3752.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zu+sfs7pAP2BF2+XD6VCWaR/rJGtUdLuyhYfbi52TxEcZ9LhruJsWebgQV7SuRpDMXNyTZcCXoZ77g6UEGtRfgNdNy/rEuBjJx9vB32RS5lAn0/uZ7FNvMfw8xVGx4jt9VP6IyueI2Z7qv2AQPnN8Iq74Rn7uadBYKFOWg12P4MXnQaoIlt+Ft1YkakBRz4Z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c5572108-9150-4cc5-52bc-08d5a1783bed
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5572108-9150-4cc5-52bc-08d5a1783bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2018 19:53:31.5412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3685
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077330575695647?=
X-GMAIL-MSGID: =?utf-8?q?1597661999825309862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, April 13, 2018 7:55 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v1 4/7] platform: mellanox: add new ODM system types =
to
> mlx-platform
>=20
> On Tue, Mar 27, 2018 at 10:02:04AM +0000, Vadim Pasternak wrote:
> > Patch adds new ODM systems, matched according to DMI_BOARD_NAME.
>=20
> General nit. When writing your messages, please use the imperative (comma=
nd)
> form. Rather than:
>=20
> "Patch adds" or "It changes" use the same form you use in the subject lin=
es:
>=20
> "Add new ODM systems", "Fix struct field documentation", etc.
>=20
> Again, I've been rewriting these, but as a regular contributor, this will=
 help
> reduce the overhead of reviewing your patches - good for you, good for me=
 :-)
>=20
> > The supported ODM Ids are: VMOD0001, VMOD0002, VMOD0003,
> VMOD0004,
> > VMOD0005. It doesn't introduce new systems, but allows to ODM
> > companies to set DMI_BOARD_VENDOR and DMI_PRODUCT_NAME on their
> own.
> > It assumes that ODM company can't change DMI_BOARD_NAME.
>=20
> You said "it assumes that ODM companies can't change DMI_BOARD_NAME". Is
> that an assumption, or is that how ODMs work with Mellanox?

Till now ODM companies didn't care about SMBIOS content.
But now we have two, which want to overwrite BOARD_VENDOR and=20
PRODUCT_NAME (and some other fields).
System manufacturing for ODM is provided by Mellanox, so Mellanox
production team is responsible for setting all these fields.

Both don't care about BOARD_NAME and it has been closed with them,
that content of this filed will be defined by Mellanox.

> --
> Darren Hart
> VMware Open Source Technology Center
