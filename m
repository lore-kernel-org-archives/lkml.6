Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AIpwx49Rs/Z1J5R0c7IbgspxaFpyHu/oS4qIsFjq2JZNuPivsrJJfbUpqnk1G6ziQp6wn0BYu+to
ARC-Seal: i=1; a=rsa-sha256; t=1522219535; cv=none;
        d=google.com; s=arc-20160816;
        b=BYJRcjCe6rxivky3jdNOkzu5lxEzCkVJ0K/JdnhcbYvkBUOQiGq8BtmM4RlwWqBSKI
         TupkjobJFL8ITmUBu6QNHYaIPmuS5sn19vH30hxXxcrxweMfZ7CYcuB/Svyjpy4GyfH3
         tk/XRCFCwEEGsMUkmD8lIsHOOw8Xl+MrISZ+ieHNKB//azozlfmqUvAIZKerjzdTaM1e
         muzfRcsH0JxNF151e3yVnv6mvtSJ3zGS049oMkeumrMN+RvarnYzzzMT/9HdW0JjdD8y
         oFvY64p8XKBdyGK2puOfIYqJTrjez5ZSEk/r68g/+v0ZDGDHEdz2NlW5Q29WUiv4jghV
         cCwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=pauOIkYRQ48e4ZlyOjr8r9kxoswYoz048grTlnj+m1M=;
        b=pZ73uuSiXwdsgsaPWDcMAOwYuqlQe6nOhSclhKpsxYu6lsPJ4cQhzIZkjliYI1BsqJ
         F5Dk6+KvH76pBAaeUVguDtpO+HBDEhVaYZfIVhkA5DHKRAjz7oknK6mxjYQKZFcR0ZOM
         oW86lS1sI1YoPg0zcQvKpnHuM8EGJdHvQGfGOCE0QFnHd1E5MmEJU0pqL3jyh6T2DOMd
         YLpqbxHL7P5r97MAG9kXDbhgnfRYo8ewlLfky5sPRmajJVsxGiUvsE9Ob6EMjx4eJNF1
         gjUBBLY5i8TxVq8Z1OjGKSPv9REQIbb/MgnQrnZY+lLI9k7KydNTluCHFBGoWB+J2D5P
         73ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bHss8bYk;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.0.48 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=bHss8bYk;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.0.48 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Alexandru Marginean
	<alexandru.marginean@nxp.com>, Ruxandra Ioana Ciocoi Radulescu
	<ruxandra.radulescu@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH] staging: fsl-dpaa2/ethsw: Fix TCI values overwrite
Thread-Topic: [PATCH] staging: fsl-dpaa2/ethsw: Fix TCI values overwrite
Thread-Index: AQHTxc0XrZLTXiFkIU2GUSVuupTjyKPkFfMAgAEe6lA=
Date: Wed, 28 Mar 2018 06:45:31 +0000
Message-ID: <AM3PR04MB0743BA40A26E4BA605C974D8E6A30@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180327131050.30581-1-razvan.stefanescu@nxp.com>
 <20180327133740.GI5862@lunn.ch>
In-Reply-To: <20180327133740.GI5862@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB401;7:QoDrucztonmKkmR++Fp4UbQnyfHxYpnJZHe7KJaA2inuRryTTR/TEGBqtfhmK9EMWhI4oCCRwofTdohd12nxXeFocTytz8ayvfyOu4FcW1zehAstyYC+Y9MKBAOGMiz9glzlxUjQYXIn/mAQDFSXLZ2kalSKN0pX8HwMX6b7fo6+979qBOG0ZuMvNNPgRPfu2htT1CoIVvqKowMtfbvrpvjCM6iSOfN8zJL1q+i/1xocRWSINd8FUzStnFm8Vge6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d79f253f-4367-461e-ecad-08d59477804a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB401;
x-ms-traffictypediagnostic: AM3PR04MB401:
x-microsoft-antispam-prvs: <AM3PR04MB40168FC1435A7F2FEA2475CE6A30@AM3PR04MB401.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB401;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB401;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(366004)(39380400002)(346002)(39860400002)(189003)(199004)(13464003)(54534003)(99286004)(3280700002)(6916009)(68736007)(25786009)(76176011)(5250100002)(476003)(66066001)(6116002)(486005)(11346002)(305945005)(446003)(7696005)(2906002)(86362001)(105586002)(3846002)(486005)(59450400001)(74316002)(26005)(186003)(6506007)(3660700001)(7736002)(478600001)(53546011)(4326008)(229853002)(6436002)(5660300001)(55016002)(102836004)(6246003)(9686003)(54906003)(316002)(97736004)(53936002)(8936002)(2900100001)(33656002)(81166006)(8676002)(14454004)(81156014)(106356001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB401;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Qt9zdioUtSniXMagrJ/FgQisNGb1EGArIV6XQGtQIqVz/NVZw/AG3CZ7YE5yHxjysq1jtyXdgxmlpG+nZeR0huL0qUrgZxO8PmQy1mECDoMCfYZ0BNiCs9kHIVF2iBs5T9SscWTGyP7cLtF47ZHFiIVyfQ6Ds/nUktn915vkoTsFwvwCX2IO6+hqr3ojJGgqyVI8sr3B30djmplv0TU4OHEYdUNZBJiFSqUTEBD8Enyj86TxKxPhaqQkT+VtNpXwDoJqX6bLcSXkjlAhhjBslA5RW2cXI780SSRS7VsmTw8Ov3xCgyMZuqhzieA5WYmuMVqER9ILZhuADWebbmal3A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79f253f-4367-461e-ecad-08d59477804a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 06:45:31.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB401
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596096527090785384?=
X-GMAIL-MSGID: =?utf-8?q?1596162871481081019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Andrew Lunn
> Sent: Tuesday, March 27, 2018 4:38 PM
> To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Alexandru Marginean
> <alexandru.marginean@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; stuyoder@gmail.com
> Subject: Re: [PATCH] staging: fsl-dpaa2/ethsw: Fix TCI values overwrite
>=20
> On Tue, Mar 27, 2018 at 08:10:50AM -0500, Razvan Stefanescu wrote:
> > Previous implementation overwrites PCP value, assuming the default valu=
e
> is
> > 0, instead of 7.
> >
> > Avoid this by modifying helper function ethsw_port_set_tci() to
> > ethsw_port_set_pvid() and make it update only the vlan_id of the tci_cf=
g
> > struct.
>=20
> Hi Razvan
>=20
> It is a good idea to explain acronyms, especially for staging, since
> there are patches for all sorts of devices, can you cannot expect
> everybody to know network specific acronyms.
>=20
> By PCP you mean Priority Code Point. TCI i have no idea about.
>=20
> Looking at the code, i think you are changing the flow to become
> read/modify/write, instead of just write, which is overwriting the
> previously configured Priority Code Point?
>=20
> Please try to add more details to your change logs, to help us
> understand the change.
>=20

Thank you Andrew.  I'll address this in v2.

Best regards,
Razvan Stefanescu
