Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AIpwx49sA0DfxEstLcEHJc3imXfCHgwm7kvaGxAJH4Avf+BXFnBauPbUgTwEBFMlcRwGhv7HSwYz
ARC-Seal: i=1; a=rsa-sha256; t=1522394235; cv=none;
        d=google.com; s=arc-20160816;
        b=MqOt3VOY7aj019IFkGHJoeCKR33ySkXVT5nl+/F3L/Jh7bPzXP+B69ZFq1uHm9qSHV
         OGFt1eb2EgRdWRc0VpwJMdYWO6ffAGeSk0VeJjRa4IQy0zM2CaLvfIf2uNWt+wMrD+iv
         fSafbuzKyTdTEuKX09RbMjqI5kzwZF0XEWb0Qt+VehX8lKGoAkq7jSEJSh9vyq8Cc222
         bTYIKkfSP+8QKfsmEyWSYCSVeHQOop9VuNUPFUvlbk5uRkgpSmRnr7w8ZAhWfs+BR96t
         Huz9hZx6hwydn2oJgsTD8/SNQSf4d6hDTtTGd5cO126DqdBxgZRnSRRRFQtmZRT5FDtf
         LJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=drasYtib71Y7i2edSJgEavWm2ucYu/ts8RTrq9i97BY=;
        b=q0+rZ0SPfxyrbFPu+qw7MvLYCvnQ+ikXihLRihH+W9VpQcy0uKAXWxyf1sTauy/rGh
         4825hL21G2jIDB5hL7xE13Fk+HBGIyHwk9W4huuhfWOmD+PYI9ZF2gvZOlGKXjRsCiic
         UvD3srQmFo5ePkpMvLEU8M6IauMK8da1bY5N02iZZmnF2kaNH5mH1Q6w3gw3mafACfXy
         6xmVT9hYZ5NT3cCvWP0vGa8lNl9xmuaGXkEcZEkBdmcla6LH80ThX12cCbfeYyvWgOat
         EQHJpWnU/TgcrVuHO+MBPOFw8qaAMVM7ZoJh70SmPJgQPbgo13yChGx1NfBJf9T9biQc
         rH4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NUYiQH7G;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.3.86 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NUYiQH7G;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.3.86 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "johan@kernel.org"
	<johan@kernel.org>, "msuchanek@suse.de" <msuchanek@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus	infrastructure
Thread-Topic: [PATCH] dma-mapping: move dma configuration to bus
	infrastructure
Thread-Index: AQHTx/bkCxQ+GwywEEynjMRFLoeWUqPoXivA
Date: Fri, 30 Mar 2018 07:17:10 +0000
Message-ID: <HE1PR0401MB24259BC13BCEFEE462910AE1E6A10@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <20180330071530.GA17557@lst.de>
In-Reply-To: <20180330071530.GA17557@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
x-originating-ip: [182.68.102.100]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2362;7:0DQyiC3bj3j26BXODQq1frkZ3ztnjnusJiVO7JJcXZMhqif7qdtwl3CoBTRTpp4r254GPMcy+Y9XtXaLyJdlGnlYlXDcFZLscJndfdjSj5i8o/EicasiA5wGjzF6ueoT5fj6n9DN32RzCb4/R8Pqq8AUSl22G7qaBg+PVazq7JtPvpqTgxzu4KlWLe53XfgqiYJ8WFw/zk2ynP4RhBy08ob2idH6f7KVIjmMyv0zKiPXGxptl9c4HJyL3gfJG5AO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3d17781-61fc-428c-2042-08d5960e4165
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2362;
x-ms-traffictypediagnostic: HE1PR0401MB2362:
x-microsoft-antispam-prvs: <HE1PR0401MB2362BBE2E4FE6585ADD3E9B6E6A10@HE1PR0401MB2362.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(211936372134217)(7411616537696)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0401MB2362;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2362;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(39850400004)(396003)(376002)(199004)(189003)(13464003)(486005)(53546011)(39060400002)(476003)(6916009)(2900100001)(97736004)(3280700002)(5250100002)(7696005)(6436002)(76176011)(6506007)(6246003)(99286004)(3660700001)(102836004)(11346002)(33656002)(316002)(486005)(54906003)(53936002)(229853002)(105586002)(9686003)(7416002)(26005)(106356001)(55016002)(25786009)(446003)(8936002)(86362001)(7736002)(305945005)(74316002)(2906002)(68736007)(66066001)(81156014)(14454004)(3846002)(478600001)(6116002)(4326008)(5660300001)(81166006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2362;H:HE1PR0401MB2425.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: h7K5Y5ANLtS5ySkl8QCBqNdHXf9XAhf3ALl6sHC/x0Ypba87MRBysPwZdPXYbOiSCpETnLvf60Gw6gJVAzV+WcoX6EVF5FMblflyd0Z5rEDW9asK30JWLFWGPN1C8waRO4PmUc/AGEJELfgmS+wk2V6fAPa37EpqG1jSOdJUmIDy5LaKzroeUedJx/vfRz0AnCAOqxyxgVjbTPqSjntfQyYGmWaDeCx0yyYZjxLF4+MaI0FN4sTe3p61hxghOAcUwrt9cVtV5XygUwEHWvBgSqlVvY8+404GXPgbvGhwNdfI44TA2HyjL1YNIllqlS807d/S32bQrEgS21tpCMfekfpiJBKpOWxfHx3yyetM5tMJv/cjuUki7qxvXkcvyKoK6r5QeHQhyVh5zUul+m06pq3wvzQy6UNWrJPr88s4cTs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d17781-61fc-428c-2042-08d5960e4165
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 07:17:11.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2362
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594746017210545974?=
X-GMAIL-MSGID: =?utf-8?q?1596346058253834511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I am just going to send it within an hour :)

Thanks,
Nipun

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Friday, March 30, 2018 12:46
> To: Nipun Gupta <nipun.gupta@nxp.com>
> Cc: hch@lst.de; robin.murphy@arm.com; linux@armlinux.org.uk;
> gregkh@linuxfoundation.org; m.szyprowski@samsung.com; bhelgaas@google.com=
;
> dmitry.torokhov@gmail.com; rafael.j.wysocki@intel.com;
> jarkko.sakkinen@linux.intel.com; linus.walleij@linaro.org;
> johan@kernel.org; msuchanek@suse.de; linux-kernel@vger.kernel.org;
> iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
> infrastructure
>=20
> Can you resend the current state of affairs so we can get it in for
> 4.17?
