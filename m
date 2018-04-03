Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AIpwx4/qmy2nKhyXobLiYIkYUbd1Azbjss8eyzsOy3JK6jsIoLw6Sl0fPCseJqJm9f03eF0pADNc
ARC-Seal: i=1; a=rsa-sha256; t=1522753975; cv=none;
        d=google.com; s=arc-20160816;
        b=RP6Tiq3eVdp5Dca1l/+M+G8r/+wAaP4LvxFq9SedOB9A9BU1kDIfVkNTTz0o+vmENp
         SUQEZBH83cgLGj46vPLuuQgnRGfd1HemLAIWAySWrtUVYFL5cknYDhy3HZY2t3rPDcdL
         CK0i7w8zIpKjZFAUASKf+lrkO9Jopp+ps25LcwokonXTi5AQuSSCc+TZ9AGJ2AJt0Vvt
         5oc+8SiqGFGLS/LIcqbiidq14pgQedhDJEqCtb3gswkrMubTOowAU/V+47CcIKDRK0zs
         /pgKhB7eYu1BbCsnj25kkxlGuLeCWRizaLIZ7dxyKoOSVdfZe4by1FnFRThTU1Ru7yyZ
         ZUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=CunsYfswwtddMwzMfFY7aLGJIl3vUj0t1r6cekaDqsk=;
        b=qjjLfD6/5cODKq5D9hFTYAwtwGpMlwbsG4rF8hrk0pNHiT3IvVcJkxwaNo4zFOzg62
         tqmFxKl3OYKbQhsHaJww8uanW8hjxb2cX+pk5TDMb8Ie2SqLhYZTmCK4ekQUuVcTE+xg
         W25M0w14j5qlmm7QVqJZxn62T9KWhGU3HInyWhdJfb3NMXzhduny2M6HyfTL1OXjxdJ5
         HUDmeSxkIDNAxF3uyKt7eTSNFwxrg3dObSxC3nqxMFS3SaSpCwJj0GOXvqgSgAY4Qmqs
         b753W7w100ySB7s0dDoRgwhj8fzHkS5h4ILusXLC0pPxQhZirkMPc9EGDUBmuNLmDCKM
         v7xA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=jhVioMX6;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.3.81 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=jhVioMX6;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 40.107.3.81 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Stuart Yoder <stuyoder@gmail.com>, Ruxandra
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Roy Pledge
	<roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>, Ioana Ciornei
	<ioana.ciornei@nxp.com>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0rwCuWpkuBfUu2ocXSZgQVIaPfBFwAgAa39ICAABVLAIAADHGAgAeodwCAAAWCgIABZnWg
Date: Tue, 3 Apr 2018 11:12:52 +0000
Message-ID: <AM3PR04MB07439B79DD857CD2F8033623E6A50@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <20180328162811.GB15827@lunn.ch>
 <HE1PR04MB32127E14E0953910746A6363E0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <20180402134441.GB10520@lunn.ch>
In-Reply-To: <20180402134441.GB10520@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1444;7:x6sVYj3NF04nKNIFK8rblTR3BdiONBmZDs6Ni/PveT1vmALO5V04v2+13XuiaBJoz4SbWUoB1i0WTVtVwl95j32A9xfWE/htUqbcxmOxbeBfPmX/86TKtaEDTsegBtHopMXBaeahJeaQCezODRqYRh1S8yXCBhDK0vAFbG8DByEM6pLmi6aIb4hJUT1G7EECeufZl8821KX7UKZEuWcMlAaNZQMK/8zl9r84+R/Kzf3ouGvz2oYsAqyRzHiABMqK
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95cf9577-86ba-45fc-397a-08d59953d7ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1444;
x-ms-traffictypediagnostic: AM3PR04MB1444:
x-microsoft-antispam-prvs: <AM3PR04MB14449BB02F452655F7A582A1E6A50@AM3PR04MB1444.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(21532816269658)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1444;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1444;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(13464003)(68736007)(3660700001)(76176011)(8676002)(2906002)(33656002)(5250100002)(14454004)(7696005)(2900100001)(81156014)(86362001)(25786009)(81166006)(229853002)(105586002)(4326008)(8936002)(66066001)(186003)(316002)(99286004)(3280700002)(6916009)(5660300001)(11346002)(97736004)(6246003)(486005)(486005)(106356001)(476003)(3846002)(74316002)(478600001)(7736002)(9686003)(55016002)(93886005)(446003)(6116002)(53936002)(26005)(39060400002)(54906003)(59450400001)(6506007)(102836004)(53546011)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1444;H:AM3PR04MB0743.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TgFVct1hIQwYfuByz/Dd7OfPMXdx1Znk9fhdojHc/VbfTlEz8vHAHqAhOEft4BzvW2uSnadUeO6yEKDzUUgWZDz4DBjVWE4yl3WLM/XAVJTmP+6ULC5flEFk9N+G4Ui4IOwMlQB/Hrvlz4Nl9RD1aFVVG4stwbIbYcWxJRB/rS3NtQiJg/kSwV2qfdxENXQfpWrTqACav0D55/29r3J+xgvdy5nrgGg7xJPDCIaOWp0/q3pzF1O191wIqk4tMSd9TQEXXUGJWovc+8ktYeLBQB41J2Of8cvWW0hKNPL5+PFk/5tAgRKXpYF/PkCFjZOIyu0jgc9spUn+1bJ43wpuaR+7ujRKSG36jRO04lMZhrNdBOnzBRXYcncfesBUcV0473QRpa81ivlJpk4g6zR0ayzLQLxs+9S9sZGXgE0wUcs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cf9577-86ba-45fc-397a-08d59953d7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 11:12:52.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1444
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596723272220818161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Andrew,

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Monday, April 2, 2018 4:45 PM
> To: Ioana Ciornei <ioana.ciornei@nxp.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; gregkh
> <gregkh@linuxfoundation.org>; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Stuart Yoder <stuyoder@gmail.com>; Ruxandra
> Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>; Razvan Stefanescu
> <razvan.stefanescu@nxp.com>; Roy Pledge <roy.pledge@nxp.com>;
> Networking <netdev@vger.kernel.org>
> Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
>=20
> Hi Ioana
>=20
> > The commands listed above are for creating/destroying DPAA2 objects
> > in Management Complex and not for runtime configuration where
> > standard userspace tools are used.
>=20
> Please can you explain why this is not just plumbing inside a
> switchdev driver?
>=20
> The hardware has a number of physical ports. So on probe, i would
> expect it to create a DPMAC, DPNI, and DPIO for each port, and a linux
> netdev. From then on, standard tools are all that are needed. The
> switchdev driver can create a l2 switch object when the user uses the
> ip link add name br0 type bridge. It can then connect the switch
> object to the DPNI when the user adds an interface to the switch, etc.
>=20

I'll chime in as you mentioned switchdev driver.=20

DPAA2 offers several object-based abstractions for modeling network
related devices (interfaces, L2 Ethernet switch) or accelerators
(DPSECI - crypto and DPDCEI - compression), the latter not up-streamed yet.
They are modeled using various low-level resources (e.g. queues,
classification tables, physical ports) and have multiple configuration and
interconnectivity options, managed by the Management Complex.=20
Resources are limited and they are only used when needed by the objects,
to accommodate more configurations and usage scenarios.
=20
Some of the objects have a 1-to-1 correspondence to physical resources
(e.g. DPMACs to physical ports), while others (like DPNIs and DPSW)
can be seen as a collection of the mentioned resources. The types and=20
number of such objects are not predetermined.

When the board boots up, none of them exist yet. Restool allows a user to
define the system topology, by providing a way to dynamically create, destr=
oy
and interconnect these objects.

After an object is created, it will be presented on the fsl-mc bus. A drive=
r
is loaded to implement the required kernel interfaces specific to that obje=
ct
type. Kernel can boot and afterwards the DPAA2 objects are added, as the us=
er
requires.

As you mentioned DPMACs: objects of this type can be connected only to a DP=
NI
(a network interface like object) or to a DPSW (L2 ethernet switch) port.
Likewise, a DPNI can have only one connection (to a DPMAC, a DPSW port or
another DPNI object).

Here's several examples of valid connection types:
  * DPMAC <----> DPNI (standard network i/f corresponding to a physical por=
t)
  * DPMAC <----> DPSW (physical port in a switch)
  * DPNI <----> DPSW (virtual network interface connected to a switch port)
  * DPNI <----> DPNI

In the latter case, the two DPNIs will not be connected to any physical
port, but can be used as a point-to-point connection between two virtual
machines for instance.

So, it is not possible to connect a DPNI to a DPSW after it was connected
to a DPMAC. The DPNI-DPMAC pair would have to be disconnected and
DPMAC will be reconnected to the switch. DPNI interface that is no longer
connected to a DPMAC will be destroyed and any new addition/deletion of
a DPNI/DPMAC interface to the switch port will trigger the entire switch
re-configuration.

Best regards,
Razvan Stefanescu
