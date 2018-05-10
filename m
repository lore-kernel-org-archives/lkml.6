Return-Path: <oleksandrs@mellanox.com>
X-Google-Smtp-Source: AB8JxZqdCfmt5SS54lq6uqztyGgivrp5FF5tAfODhqRX2fsp6zazIAWTl+wRnJDhsIcaRPwf1y6J
ARC-Seal: i=1; a=rsa-sha256; t=1525965211; cv=none;
        d=google.com; s=arc-20160816;
        b=Ho0uMS2xliHX73c+foB9ipMJ2H1brWQ8Eby7ut35Y0X9oSeUn1Oq7dwmvbvofjK+uu
         m6JMstou46oNsGNPXOFU07KxfZP5kpY3UL3hI2oVMRJcqvhGvnIGfmEMIIVkE62CEGBC
         b4fBDnbmR+R8rPPSWbpBSgctto777tUjuyzOWUjvgBFQhChtN6VQWttyAuOLypfL6vUd
         iRR6oYTI2ArmbF+BfFqJdvHKdq2MOju/c7NFjBaU7BbhqcgbDxWO+Udnz4wlP/rhVO4J
         Z4GsecVPkTBkOXWGtITqp2uDnW/Z6XpQI6EzHzJ8skUfElFjdvplJvSgAGMV/N/hRTTn
         FaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=wZ2Xji7lx/czSxvf+11tYYrOgCEn5rsRPSaCgsdDXKI=;
        b=rJR+vP/fl47qqbp7ynkoGxVfG6XQ5SGbdpSFF0YdECNpUByI7am+1aDzZPAAV3c0/u
         /TGzRgJp4T5iayDqGKnxi7KDu14ncFRBHJBz4eWXep+YMLqBgh5JkYy8i0LbKOrdn6Qc
         FMqsU9lxIi17/rS2hssK9Af0aGieQ35touFBBONLIEc+2pHbKD3lhHLHeQbzMiRPMAKM
         PQSl77l4TPuwXq+GPsc5c+IrVGwyYlYHfogUd0IAGUAd2qHanYdsKx75A1uYGrpgBnNt
         Dz0SFak7Y9CdvAyIvgbLsI11KyyeE8mNQRDU2dFdZBkunSApQdBvWXKqdoaHHzEvo+GN
         9Clg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=dv3NcOj0;
       spf=pass (google.com: domain of oleksandrs@mellanox.com designates 104.47.2.80 as permitted sender) smtp.mailfrom=oleksandrs@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Mellanox.com header.s=selector1 header.b=dv3NcOj0;
       spf=pass (google.com: domain of oleksandrs@mellanox.com designates 104.47.2.80 as permitted sender) smtp.mailfrom=oleksandrs@mellanox.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=mellanox.com
From: Oleksandr Shamray <oleksandrs@mellanox.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"jiri@resnulli.us" <jiri@resnulli.us>, "tklauser@distanz.ch"
	<tklauser@distanz.ch>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, Vadim Pasternak <vadimp@mellanox.com>,
	system-sw-low-level <system-sw-low-level@mellanox.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "openocd-devel-owner@lists.sourceforge.net"
	<openocd-devel-owner@lists.sourceforge.net>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"mchehab@kernel.org" <mchehab@kernel.org>
Subject: RE: [patch v18 0/4] JTAG driver introduction
Thread-Topic: [patch v18 0/4] JTAG driver introduction
Thread-Index: AQHTmQ3800fthZTMJk+uk3ntR7rluaONTgeAgJxUsJA=
Date: Thu, 10 May 2018 15:13:26 +0000
Message-ID: <HE1PR0502MB2972F340728121766CEEC593B1980@HE1PR0502MB2972.eurprd05.prod.outlook.com>
References: <1517236305-4880-1-git-send-email-oleksandrs@mellanox.com>
 <ff739c26-d3b2-3df7-e751-fbf037ae96d1@gmail.com>
In-Reply-To: <ff739c26-d3b2-3df7-e751-fbf037ae96d1@gmail.com>
Accept-Language: en-US, uk-UA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandrs@mellanox.com;
x-originating-ip: [79.135.198.29]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3818;7:jMW1X96hxVWU6PyKn0M+m16etunb3c9RCz5NEKoC3q4xwOqYB8M09bav/L7Z120dVTDvo3GtnjRNGLGuQJYLVMxiWDnBwrp3qVWlJyCJ9AT0nnJ0L8Sye/ljvsNtcbh44kiG1KWKWT5lRiD5OXVBGnx1I7mWzYGaIvFp/sXovuionh0SB5S+We35eEbacFutvJnDmgGwUWwLe86lyDjRGsHc3pzfj7gTzHxhcr+0nmfJMbBjMcdxhERjoh/4ITto
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3818;
x-ms-traffictypediagnostic: HE1PR0502MB3818:
x-microsoft-antispam-prvs: <HE1PR0502MB38185C38FBC63B9A20D0F3E9B1980@HE1PR0502MB3818.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(143289334528602)(166708455590820)(9452136761055)(65623756079841)(85827821059158)(788757137089)(258649278758335)(42262312472803)(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0502MB3818;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB3818;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(366004)(13464003)(189003)(199004)(11346002)(446003)(486006)(476003)(229853002)(26005)(6116002)(102836004)(53546011)(6506007)(5250100002)(186003)(14454004)(2501003)(86362001)(7696005)(110136005)(54906003)(99286004)(316002)(305945005)(3846002)(6436002)(76176011)(59450400001)(2201001)(66066001)(97736004)(7736002)(74316002)(8936002)(9686003)(478600001)(81166006)(33656002)(6306002)(966005)(81156014)(2906002)(551934003)(55016002)(25786009)(53936002)(5660300001)(4326008)(39060400002)(2900100001)(106356001)(3280700002)(7416002)(6246003)(3660700001)(68736007)(105586002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB3818;H:HE1PR0502MB2972.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C1zhRa5mR8GG8hKsbUgi11+X56njru6uBUehjeeW1gO4wU80wQSoIocOEuKFKeXWQpwDYSdjz8PmfSu0BHNY0K1OFsZEnos8lIR3SCUwZOb2TF5rahmW2DhYdmQED5smh9sqmDeiAA90xBPy8Y+FFrtP8rPyvOlgt2vmi0jMylBfn08woVF7gVyQFYQ5Q4TP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3c573abd-aca0-4d95-7bc8-08d5b6889468
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c573abd-aca0-4d95-7bc8-08d5b6889468
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 15:13:26.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3818
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590937581304379012?=
X-GMAIL-MSGID: =?utf-8?q?1600090498197424374?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Florian.

>> We propose to implement general JTAG interface and infrastructure=20
>> to communicate with user layer application. In such way, we can=20
>> have the standard JTAG interface core part and separation from=20
>> specific HW implementation.
>
>Well, the framework in its current shape is still extremely=20
>simplistic, therefore leaving a lot of room (read: bugs,=20
>inconsistencies) within the hands of the driver, so while the=20
>user-space interface is standard through the proposed character=20
>device, the user experience, likely might not.

Well, the framework is intentionally simply and provide the very basic
interface. It supposed that interface can be extended in the future, if=20
necessary. Current kernel does not provide a framework for JTAG interface,
and we believe this is good starting point to allow such framework. This
provide minimal, but sufficient interface and any future extension will be
of course welcomed.

At the moment we have one controller driver, which works well with this
infrastructure. And we have very reasonable use case - this driver allows
flashing for all the programmable devices, connected to JTAG interface,
where the image for these device is provided with the standard SVF format.


>> This allow new capability to debug the CPU or program system's=20
>> device via BMC without additional devices nor cost.

>If that is the case, should not we leverage the kernel's device=20
>driver model and expect the JTAG framework to create specific devices=20
>for the different pieces of HW discovered on the scan chain? That=20
>would also
>presumably allow the core JTAG framework to retain the necessary=20
>state
>changes in order to address one particular device within the scan chain.

For the device programming use case, the flashing image will contain
jtag chain topology. If for example, jtag domain contains x devices, but
image contains less, the only relevant devices will be flashed and there is
no need to distinct between them.
In case there are several domains, jtag interface is  configured to be
connected to the relevant one.

For the CPU debug use case, jtag interface is configured to be connected
to CPU only.

System should be able to provide jtag selection according to the needs
and this kind of operations should be out of the JTAG driver scope.


>> This patch purpose is to add JTAG master core infrastructure by=20
>> defining new JTAG class and provide generic JTAG interface to allow=20
>> hardware specific drivers to connect this interface.
>> This will enable all JTAG drivers to use the common interface part=20
>> and will have separate for hardware implementation.

>Let's consider I want to get rid of OpenOCD, or rather, move its=20
>driver interface within the kernel and replace it on the OpenOCD side=20
>with a generic character device interface. I could presumably=20
>amortize the costly operations which are currently I/O and/or system=20
>call limiting when running in user-space, what would it look like=20
>with your proposed framework, have you given some thoughts about that?


The JTAG driver using SDR/SIR transactions to send/receive data.
It can send/receive multiple data bits by a single transaction.

For the bit-banging style drivers it gives you an advantage of sending
Bits stream by one system call vs per-bit system call.
So, instead of updating GPIO pins a few time through user space interface
(sysfs) for sending single bit, an application can send multiple bits in a
stream by one call. And all GPIO operations will be performed than in a
kernel space.
It'll be necessary to have bit-banging driver, using the JTAG infrastructur=
e,
which should be configured according to the particular system during
initialization. And we are planning to develop such kind of driver.
It definitely reduces system calls and saves time for JTAG operations.

For the system equipped with the JTAG master there the same advantages
plus hardware acceleration for pin access (all pins can be accessed by
one shot).

Driver supports universal transactions (include/uapi/linux/jtag.h),
which are sent through  IOCTL interface JTAG_IOCRUNTEST, JTAG_IOCXFER
struct struct jtag_xfer {
              __u8      type;
              __u8      direction;
              __u8      endstate;
              __u8      padding;
              __u32    length;
               __u64    tdio;
};

jtag_run_test_idle {
              __u8      reset;
              __u8      endstate;
              __u8      tck;
};

You can see usage example on https://github.com/mellanoxbmc/mellanox-bmc-to=
ols/tree/master/mlnx_cpldprog

Best Regards,
Oleksandr Shamray

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli@gmail.com]
> Sent: 31 =D1=CE=D7=C1=D2=D1 2018 =C7. 5:03
> To: Oleksandr Shamray <oleksandrs@mellanox.com>;
> gregkh@linuxfoundation.org; arnd@arndb.de
> Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; openbmc@lists.ozlabs.org; joel@jms.id.au;
> jiri@resnulli.us; tklauser@distanz.ch; linux-serial@vger.kernel.org; Vadi=
m
> Pasternak <vadimp@mellanox.com>; system-sw-low-level <system-sw-low-
> level@mellanox.com>; robh+dt@kernel.org; openocd-devel-
> owner@lists.sourceforge.net; linux-api@vger.kernel.org;
> davem@davemloft.net; mchehab@kernel.org
> Subject: Re: [patch v18 0/4] JTAG driver introduction
>=20
> On 01/29/2018 06:31 AM, Oleksandr Shamray wrote:
> > When a need raise up to use JTAG interface for system's devices
> > programming or CPU debugging, usually the user layer application
> > implements jtag protocol by bit-bang or using a proprietary connection
> > to vendor hardware.
> > This method can be slow and not generic.
> >
> > We propose to implement general JTAG interface and infrastructure to
> > communicate with user layer application. In such way, we can have the
> > standard JTAG interface core part and separation from specific HW
> > implementation.
> > This allow new capability to debug the CPU or program system's device
> > via BMC without additional devices nor cost.
>=20
> Oleksandr, you have completed dodged my questions here:
>=20
> https://lkml.org/lkml/2017/12/25/163
>=20
> can you try to respond to some of these questions please?
> --
> Florian
