Return-Path: <JOLLYS@xilinx.com>
X-Google-Smtp-Source: AH8x226RCH3ua2vAuVtvWiKSWG1j+tZBVQpUG0eKEksm4v6gKePoTlehYLjaHATOP2sYEkm3RvTB
ARC-Seal: i=1; a=rsa-sha256; t=1517448235; cv=none;
        d=google.com; s=arc-20160816;
        b=Tpbc7MT+KwmsISK9xaWsNseyXvEv97Td7qagV0LcCLdE0+v6JfRtXWJyi/DxzkYIe7
         OdhWMJ5ZkrpsZjLaFwl8JjcEM+e7V4VxU5vxjk7GkR0uEkFBvdfFGH25ehUqhNH/5mpl
         oBZzRVYYmqF1HzsnqJl+G9EtMgoHiHV7ksoG4frkAzUVegmW3MNn2tbfm9c7EgAipDLk
         HRp13YTUeSZ+DgUGTxp1s+oUI7RnXR2zeu8Q78zXJabNu/t9AVCgUBpon9SAvtDMz4Xc
         EjBUTnYYCaeQDQ7s7TW04mKpxYol7k8/L1yzJ+k/d3qJbhH65NUpJjS+gnaORhWNccSj
         /bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=S1IRutNWNblGwewKhTS09YpUiBXZtB/hZUrxC79kpkM=;
        b=n3rJKh+XnRXYOsAITQRx9XlHUglrrJValZmrbgyZlay55jvlsPGubr7Iisbh8yJjtV
         Kz+9Y/fe8JXgQgTw32GMyHmXwxOqlpsSy14qKLibOMMz40tPS8V04P6HBrFlT9MIDCqL
         OxJwcu0QvUYC6DSLZIB8lxRPcX8TuEqqoVnK5rUHHECEjWrxK0xXaC/9oiUUHkhRUa5m
         I6i/R1lUOiSaiJY2su5SQFEQBwHgrcjBhVfTPyA3hrkWRvYFuaiQimW1BBfwUeyoSAfb
         DnkyUb3VRl9C1NnXqvP7ZcIJR8v24vOU880qzJRN0bq8RR7K2+5M9tLvEktWep3I2MG6
         /wzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=nBF8cDOE;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.66 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=nBF8cDOE;
       spf=pass (google.com: domain of jollys@xilinx.com designates 104.47.42.66 as permitted sender) smtp.mailfrom=JOLLYS@xilinx.com
From: Jolly Shah <JOLLYS@xilinx.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "matt@codeblueprint.co.uk"
	<matt@codeblueprint.co.uk>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "michal.simek@xilinx.com"
	<michal.simek@xilinx.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Rajan Vaja <RAJANV@xilinx.com>
Subject: RE: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Topic: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Thread-Index: AQHTlWou2XFDSgiaBEabjrwcvuQZWKOOVW8AgABxHPA=
Date: Thu, 1 Feb 2018 01:23:48 +0000
Message-ID: <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
In-Reply-To: <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com;
x-originating-ip: [149.199.62.254]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0201MB1034;7:TJyQCiM7ZDs6YhpW9+NRnKNo83HYE4zPPJRswbAjXkqghcCkwxZPeCuAhdE+7explFJ4j9AWiCyndlosM6exO67ad3wWmruVPq7zImDIRj+bsMuMbLUCiQJ3TnnH8hI+1uxkrgOXY32Ye9/wM1SCiQ22pWL7J1QltWf7Pqqtfkj59OlJLwaeO1BJAQYoVrMSzBnadj8kXItE6p4DJxPcqBJHiMJ351FrSDCqXkT1kzqAH6ISTKA4o6gf3eMALH/p
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(366004)(346002)(39380400002)(189003)(199004)(51914003)(37524003)(13464003)(59450400001)(6506007)(97736004)(39060400002)(14454004)(86362001)(105586002)(4326008)(2906002)(6116002)(53546011)(3846002)(102836004)(229853002)(106356001)(25786009)(107886003)(66066001)(5660300001)(81166006)(76176011)(6246003)(2900100001)(33656002)(55016002)(9686003)(8936002)(2950100002)(7696005)(68736007)(8676002)(53936002)(72206003)(54906003)(3280700002)(7416002)(316002)(3660700001)(99286004)(6916009)(478600001)(77096007)(81156014)(6436002)(186003)(74316002)(7736002)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1034;H:CY1PR0201MB0764.namprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 861960a0-f121-48e0-476d-08d569127247
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0201MB1034;
x-ms-traffictypediagnostic: CY1PR0201MB1034:
x-microsoft-antispam-prvs: <CY1PR0201MB1034EE596F3EA729559AEDD8B8FA0@CY1PR0201MB1034.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0201MB1034;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1034;
x-forefront-prvs: 0570F1F193
x-microsoft-antispam-message-info: DmdR1DhNTw8FqJt7zzMVCXGot6T/zWHKLPJXJpHu+TyQ6ZQcPLcssbaXWCbcjVvJb8zzDGn+fOzNavjWtC+gUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861960a0-f121-48e0-476d-08d569127247
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2018 01:23:48.8520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517939735530008?=
X-GMAIL-MSGID: =?utf-8?q?1591159800676594603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,
Thanks for the review,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland@arm.com]
> Sent: Wednesday, January 31, 2018 10:20 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; michal.simek@xilinx.com; robh+dt@kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmwar=
e
> driver
>=20
> On Wed, Jan 24, 2018 at 03:21:12PM -0800, Jolly Shah wrote:
> > This patch is adding communication layer with firmware.
> > Firmware driver provides an interface to firmware APIs.
> > Interface APIs can be used by any driver to communicate to
> > PMUFW(Platform Management Unit). All requests go through ATF.
>=20
> > +/**
> > + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
> > + *					while suspended
> > + * @target:	Node ID of the targeted PU or subsystem
> > + * @wakeup_node:Node ID of the wakeup peripheral
> > + * @enable:	Enable or disable the specified peripheral as wake source
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_set_wakeup_source(const u32 target,
> > +				       const u32 wakeup_node,
> > +				       const u32 enable)
> > +{
> > +	return invoke_pm_fn(PM_SET_WAKEUP_SOURCE, target,
> > +			    wakeup_node, enable, 0, NULL); }
>=20
> I see many functions take a "Node ID" parameter, but these don't appear t=
o be
> in any DT binding, and drivers (other than the debugfs driver) aren't usi=
ng them.
>=20
> What's the plan for making use of these? Where are the node IDs going to =
come
> from in practice?
>=20
Node ids are defined in firmware.h. Node id refers to targeted PU/subsystem=
/peripheral for required action.

> > +/**
> > + * zynqmp_pm_system_shutdown - PM call to request a system shutdown or
> restart
> > + * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> > + * @subtype:	Specifies which system should be restarted or shut down
> > + *
> > + * Return:	Returns status, either success or error+reason
> > + */
> > +static int zynqmp_pm_system_shutdown(const u32 type, const u32
> > +subtype) {
> > +	return invoke_pm_fn(PM_SYSTEM_SHUTDOWN, type, subtype, 0, 0,
> NULL);
> > +}
>=20
> PSCI already has this functionality, so I'm a little confused by the dupl=
ication.
>=20
PSCI doesn't distinguish between shutdown scope. It can be APU/PS/System in=
 this case.

> [...]
>=20
> > +/**
> > + * zynqmp_pm_get_node_status - PM call to request a node's current pow=
er
> state
> > + * @node:		ID of the component or sub-system in question
> > + * @status:		Current operating state of the requested node
> > + * @requirements:	Current requirements asserted on the node,
> > + *			used for slave nodes only.
> > + * @usage:		Usage information, used for slave nodes only:
> > + *			0 - No master is currently using the node
> > + *			1 - Only requesting master is currently using the node
> > + *			2 - Only other masters are currently using the node
> > + *			3 - Both the current and at least one other master
> > + *			is currently using the node
>=20
> These should probably have corresponding macros or enum values.
Will add macros in next version patch.

>=20
> [...]
>=20
> > +/**
> > + * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
> > + * @address:	Address of the data/ Address of output buffer where
> > + *		hash should be stored.
> > + * @size:	Size of the data.
> > + * @flags:
> > + *	BIT(0) - Sha3 init (Here address and size inputs can be NULL)
> > + *	BIT(1) - Sha3 update (address should holds the )
>=20
> Missing "data", I guess?
Yes will update in next version patch.

>=20
> > + *	BIT(2) - Sha3 final (address should hold the address of
> > + *		 buffer to store hash)
>=20
> Is the SHA engine coherent? Or is cache maintenance necessary?
>=20
> [...]
It is coherent. Update/Final has below significance here:
BIT(1) - To call Sha3_Update API which can be called multiple times when da=
ta is not contiguous.
BIT(2) - to get final hash of the whole updated data. Hash will be overwrit=
ten at provided address with 48 bytes.

>=20
> > +/**
> > + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> > + * @pin:	Pin number to request
> > + *
>=20
> No DT binding for the pinctrl bits?
>=20
> [...]
It doesn't require any bindings. Calling drivers will have DT binding for p=
ins they use.=20


>=20
> > +/**
> > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > + * @clock_id:	ID of the clock to be enabled
> > + *
>=20
> Likewise for the clocks?
>
It doesn't require bindings too.=20
=20
> > +/**
> > + * get_eemi_ops	- Get eemi ops functions
> > + *
> > + * Return:	- pointer of eemi_ops structure
> > + */
> > +const struct zynqmp_eemi_ops *get_eemi_ops(void) {
> > +	return &eemi_ops;
> > +}
> > +EXPORT_SYMBOL_GPL(get_eemi_ops);
> > +
> > +static int __init zynqmp_plat_init(void) {
> > +	struct device_node *np;
> > +	int ret =3D 0;
> > +
> > +	np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> > +	if (!np)
> > +		return 0;
> > +	of_node_put(np);
> > +
> > +	/* We're running on a ZynqMP machine, the PM node is mandatory. */
> > +	np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-firmware");
> > +	if (!np) {
> > +		pr_warn("%s: pm node not found\n", __func__);
> > +		return -ENXIO;
> > +	}
> > +
> > +	ret =3D get_set_conduit_method(np);
> > +	if (ret) {
> > +		of_node_put(np);
> > +		return ret;
> > +	}
> > +
> > +	/* Check PM API version number */
> > +	zynqmp_pm_get_api_version(&pm_api_version);
> > +	if (pm_api_version !=3D ZYNQMP_PM_VERSION) {
> > +		panic("%s power management API version error. Expected:
> v%d.%d - Found: v%d.%d\n",
> > +		      __func__,
> > +		      ZYNQMP_PM_VERSION_MAJOR,
> ZYNQMP_PM_VERSION_MINOR,
> > +		      pm_api_version >> 16, pm_api_version & 0xffff);
> > +	}
> > +
> > +	pr_info("%s Power management API v%d.%d\n", __func__,
> > +		ZYNQMP_PM_VERSION_MAJOR,
> ZYNQMP_PM_VERSION_MINOR);
> > +
> > +	of_node_put(np);
> > +
> > +	return ret;
> > +}
> > +
> > +early_initcall(zynqmp_plat_init);
>=20
> Why does this need to be an early initcall? Can't we probe this as a plat=
form
> device?
>=20
> Thanks,
> Mark.
