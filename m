Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AIpwx48G43rS2rJXrCY0HQxofU6IDMioR0O6MKFiAvHWCQMeyh1tO2/kGb7EnHHtzDC4eT2/Y2xf
ARC-Seal: i=1; a=rsa-sha256; t=1522675502; cv=none;
        d=google.com; s=arc-20160816;
        b=PUOtCB5yas6wjGb7B3UTIVIEHI/VLECe4FqsPdWqzACRkEJ+uN/R6DWeJ6qK85NqLq
         sisV7nT1/NvJZzJm9v1xMnm31ZWzR0Y/Qeur2spJzkC7n+tBzpxnT9xbq7920RgeEIsw
         ilUG5JlHdcN7ggpvJ+V/e+3pBLzYyzqF4cwxVKZoVDnCOUaigVuQxU/+i6/Gr344iqkx
         e3JPl3xAp3vu4ojsBn00ZPycYSQRrkSuhgrNnuOcWeFTBk0LwZXJ//IJIPfEVW0/vsME
         nWlu3YbbltuDSlwFiMFzOCFDrPZzHuajUt9uP4ALpmVw9d/cRDN7vFAG1EbquBa+PUNo
         GKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=pG3eMTrMJVgfYjR9bgyRlVHIxOVqtM7h2iS1I6h8xC0=;
        b=ZH5hi0Z0r+/7XbQo66o5Uv/oFmI6wrYNM/7CExvdvvfoqvmclKRzahmC5bIGs2xrHH
         wTVhYEf2WmdVRNgstf+M+Vg8yVHXqwdnQJ6uTLGKV47GLsGclqArJ4n/d1OIC+ZS4/gb
         2N1H8qOiOxL24L3h2Y4jnCUiYsIT/sIAmXzPPwyL8BM3UhjsWI8iVigI1Xf4pINyklGg
         Yt6Mm6apqjHHqU13aXlq07EHTH56JJ3J3AHFA/+NPnIOcttXISlzf9bnqQG5Ga02niJD
         D5C18vW2CIal3v0L6rWakZAEaFJ8OTkPL6s/fM4oUy4HiQVM2YAKpR+6KkuKC5ZL3dAC
         b7EA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=KGKuOG2U;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.4.69 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=KGKuOG2U;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 40.107.4.69 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>
CC: gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor
	<laurentiu.tudor@nxp.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Stuart Yoder <stuyoder@gmail.com>, Ruxandra
 Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu
	<razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0rRbeSymdCeEiXdPiYqeyzd6PfBFwAgAPKwGCAAwJ/AIAADHGAgAenJTA=
Date: Mon, 2 Apr 2018 13:24:58 +0000
Message-ID: <HE1PR04MB32127E14E0953910746A6363E0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <20180328162811.GB15827@lunn.ch>
In-Reply-To: <20180328162811.GB15827@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR04MB1129;7:/7RvhK5A3WVcU4cOYhfH1JBv3tOvinvj5y8vBMp5LLJgKsOEeyqkDEZvIBc/evae4GWPb0nBO64de8woi9fTXUb3moJiVPQBxQIMEjOUdnNu0kTxNstocwG113WL0xeEBnCmecFrBe2hsPsIe4wioofxwr4/liOgozohkIlWL0EXIIj3OopbV0HKZ7Lydmc/Mc9lDyCcYJbP26s5KKmBrVcCfdq0TnNe6++rVSEpofN23Re0kf/Ip4zOb0YV1IhT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e72bd5ba-0f13-47e4-0b86-08d5989d21a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1129;
x-ms-traffictypediagnostic: HE1PR04MB1129:
x-microsoft-antispam-prvs: <HE1PR04MB11294F359D62A40812BEDEB2E0A60@HE1PR04MB1129.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR04MB1129;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1129;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(189003)(199004)(7736002)(8676002)(39060400002)(486005)(486005)(11346002)(476003)(14454004)(2906002)(2900100001)(446003)(4326008)(7696005)(8936002)(5250100002)(93886005)(76176011)(97736004)(99286004)(305945005)(81156014)(81166006)(74316002)(86362001)(6246003)(54906003)(68736007)(6116002)(66066001)(316002)(3846002)(5660300001)(53936002)(106356001)(186003)(9686003)(55016002)(110136005)(6306002)(3660700001)(25786009)(26005)(105586002)(102836004)(3280700002)(229853002)(478600001)(6436002)(6506007)(33656002)(6346003)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1129;H:HE1PR04MB3212.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
x-microsoft-antispam-message-info: 0BBBoIMqX6ppqOfj3ZxgqW+/QGt9F9yJ2CJiB0KDXBdBeKmTuS4bBEmTz/PcnbU6bXfxPXGiyqgvbLe4UXgiCwH/jBQmkKIi04CkR9ArhYI80/aX4+2BoWwsXZCkMEYTjtNZzv6Vs9a3lQI7fgnha09jJy3mHENmqb0sfLdNBHi0+IyRs2yLRXyb8ZV6ktQjZMWy1bF6bFfXP0KaBhxcBj7bG3VKwsn4wVTomtEkwqioU2gH0LVVQG8B9e0W+3dlPO30V5HUdSEt3ShUK9+hrEXBG5Qt58FJ9M9mMYBO+Kc6Evra6fk3DpjliSt2kwcIyPw+kNJjOFVp9Qm1kxPIVGToaHfzF8Z3rYJbS+5dx6pAckkGrjgWV6xpAuqFARxfM0e4S6FQAfdNFsefVncJaqo2eOtWuC7V/RzRfPHNLXQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72bd5ba-0f13-47e4-0b86-08d5989d21a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 13:24:58.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1129
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596640987129261886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


>=20
> > I'm still not convinced either way (high-level or low-level
> > interface), but I think this needs to be discussed with the networking
> > maintainers. Given the examples on the github page you linked to, the
> > high-level user space commands based on these ioctls
> >
> >    ls-addni   # adds a network interface
> >    ls-addmux  # adds a dpdmux
> >    ls-addsw   # adds an l2switch
> >    ls-listmac # lists MACs and their connections
> >    ls-listni  # lists network interfaces and their connections
> >
> > and I see that you also support the switchdev interface in
> > drivers/staging/fsl-dpaa2, which I think does some of the same things,
> > presumably by implementing the switchdev API using fsl_mc_command
> > low-level interfaces in the kernel.
>=20
> Hi Arnd
>=20
> I agree that switchdev and devlink should be the correct way to handle th=
is. The
> low level plumbing of the hardware should all be hidden. There should not=
 be
> any user space commands needed other than the usual network configuration
> tools and devlink.
>=20

Hi,

The commands listed above are for creating/destroying DPAA2 objects in Mana=
gement Complex and not for runtime configuration where standard userspace t=
ools are used.
Restool is responsible for creating objects in Management complex and this =
process can be seen as the equivalent of hotplugging a peripheral rather th=
an configuring it, thus there is no standard userspace tool to handle that.

* The Management Complex is configured to create a specific set of DPAA2 ob=
jects dynamically through Restool (by sending create commands) or staticall=
y, at boot time, through a configuration file (Data Path Layout file)
* The objects are then probed and configured by the corresponding drivers
* The objects are controlled at runtime by the user via standard tools (e.g=
. ethtool for network interfaces).
 =20
I hope this gives a better understanding on the DPAA2 hardware and software=
 architecture. The fsl-mc bus documentation gives more details on this: htt=
ps://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/tree/Docume=
ntation/networking/dpaa2/overview.rst?h=3Dstaging-next

Ioana
