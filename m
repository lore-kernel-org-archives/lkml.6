Return-Path: <laurentiu.tudor@nxp.com>
X-Google-Smtp-Source: AIpwx4+KKqHdpjAp5tr0NLnYSLXmqDSREy3EWT1hlxQloYS1C42JfXmqI1FK9tDTSDYmIICgKrHz
ARC-Seal: i=1; a=rsa-sha256; t=1522930584; cv=none;
        d=google.com; s=arc-20160816;
        b=dxgPkZJk64AXi8zUnzL917avJkCdGJ682UPV3MiUhuCurRWrVVRxOjtoPxEWbieY+B
         jyaDksMjZdEhegJgLA9BHhSYwNpkJ0wKP2IlQNjsf8Gl9TVF9UVpsFGKpcTrEAR4Hh7+
         VewDcrldD0vPz1AruXSYikjZ5VdAdkYQdDaD7pgBh9/sVjHaN+SsG2iZD1AX0KUxw/zK
         JbJVVFrTG96xlODtlv2n+/GQC9HrZ1HTpG1WmWQaR3fdt4/sh9RrVfwmGVPTD9eJYlM2
         VN6d4+fSOizDX9yX00U3sGzfBhWruT+Qx0iOLHJMPqvnGO8Ta5Bbw7xXJ10UcxMGLI9D
         R9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=hcOei011qWtpafx8NXLVg/CQSPds/0R4tbStsazcIMM=;
        b=nIZNLSbhO3mHHqJNf5ngU8dKRSjKpCjSoOzBNio5moWbThVN2Dkp/iCS1xn9B9fF66
         ZEOoNzTCygqhulvnR4jTe8HnT46vsYSdMWQEm/dIXwfx8zJgKOEWkMqlWbaERaT7Q96V
         cPJ5HmrHMAYz/nh8mavJhN8O2eiik1WRqzonoO45dFBG6y38sIexEl7abTdrwD7uxd3o
         ZSRsEWetOBmnAx2PPJEPSz8YWpv76lGWZrg0uH/HFM4GtQ0Fxmtq/P4XQHgnLRI8snGe
         2QpXhZtGQ+TbxCBtt3ee5B4SvfS0lG+AvTrpu5Cet+pFB/yqbWe+PKgui1+S2Vxjm2Xw
         0jgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NV937Rl5;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.3.66 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=NV937Rl5;
       spf=pass (google.com: domain of laurentiu.tudor@nxp.com designates 40.107.3.66 as permitted sender) smtp.mailfrom=laurentiu.tudor@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Stuart Yoder <stuyoder@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, gregkh <gregkh@linuxfoundation.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Ruxandra Ioana Ciocoi
 Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu
	<razvan.stefanescu@nxp.com>, Roy Pledge <roy.pledge@nxp.com>, Networking
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Topic: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Thread-Index: AQHTwr0s//RURDTyGEKsLhU+ZuPm16PfBFwAgAa39ICAABVLAIAJ+AgAgAATBYCAACYwgIAAnIoAgAFtPQCAABWuAIAACAaA
Date: Thu, 5 Apr 2018 12:16:20 +0000
Message-ID: <5AC61393.7090509@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
 <20180404124246.GA20869@lunn.ch> <5AC5FAA8.80409@nxp.com>
 <20180405114736.GA12178@lunn.ch>
In-Reply-To: <20180405114736.GA12178@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0401MB2606;7:+4faxFlpjZry02GHVJL6aWk7WPNfTUSNNyqlmBtUkDJyOlCtqPYZU7CmESkxzpsR5N4Y2RbdiNNRhPn8HIy3ZfC8bY5/xRa4UNWCU8qmEAoxmKDiL89dT3gP8oIAj/LTE4UqlQgoHgHjJ5E+UDBWhyWzJcQIuHnfuNzeic1MbzWUH1M2eBItoN9If6Va2xflans5JMAzXE/pXEZ3SjUl0B9+SLXxbpHuvHSccfHQU/CEQi8xS/4fobWQ6GjPPrl5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee7c4d20-7ac3-4a05-bb18-08d59aef0a9b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB2606;
x-ms-traffictypediagnostic: VI1PR0401MB2606:
x-microsoft-antispam-prvs: <VI1PR0401MB2606220E0782D4F2BC121752ECBB0@VI1PR0401MB2606.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0401MB2606;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0401MB2606;
x-forefront-prvs: 06339BAE63
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39380400002)(376002)(39860400002)(51444003)(189003)(199004)(229853002)(2900100001)(68736007)(106356001)(8676002)(5250100002)(446003)(14454004)(97736004)(81156014)(105586002)(36756003)(6486002)(81166006)(93886005)(6916009)(6506007)(476003)(76176011)(53546011)(8936002)(54906003)(102836004)(87266011)(59450400001)(65816011)(2616005)(486006)(86362001)(316002)(99286004)(25786009)(6436002)(80316001)(2906002)(305945005)(478600001)(6246003)(39060400002)(6116002)(26005)(59896002)(66066001)(186003)(7736002)(3846002)(33656002)(3660700001)(4326008)(3280700002)(6512007)(5660300001)(11346002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2606;H:VI1PR0401MB1856.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Z4RzWdrW1Tdkt3qIx1yO1bsPhkIWS5GJfzzWe+b0AikTdJ/94ivGl40hFatX+SpPKugyiyaREmaIQ5t0XMi0txLAXje9G9ROxDykKahI0977PnI/DoiEclV3FASc7VXOG/sYl/WFAz/lVE+7nzeHHUxTqsY6X1tM/Z9DsX8RxRdYP6q2Xvoe9voUq3IFERMwnVVtJCDcurITCY2D11YoN2DV1OkjOM6+Io04IBxO3hBB/cnVSC62gJnmLqEbinpzP/E8HK/vOuhdOu7ztAbFIjeZCYDOrcMWgJiO8/zpMMfHJ+d9X2vZrQ/oQ/9tChJCFZF3lILXXS72JmbE5K0JVOmeAyRaArX6e6V05mMOgm6iSLv41KB5nSRmpEyItRhg7aXmXF3nGC6deEsXD/NmcI5AObto/thGag3QXc5D4hk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F32F3013581F104B9AF8DD273AD00B29@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c4d20-7ac3-4a05-bb18-08d59aef0a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2018 12:16:20.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2606
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596908460470826999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/05/2018 02:47 PM, Andrew Lunn wrote:
> On Thu, Apr 05, 2018 at 10:30:01AM +0000, Laurentiu Tudor wrote:
>> Hello,
>>
>> My 2c below.
>>
>> On 04/04/2018 03:42 PM, Andrew Lunn wrote:
>>>> I hear you.  It is more complicated this way...having all these indivi=
dual
>>>> objects vs just a single "bundle" of them that represents a NIC.  But,=
 that's
>>>> the way the DPAA2 hardware is, and we're implementing kernel support f=
or
>>>> the hardware as it is.
>>>
>>> Hi Stuart
>>>
>>> I see we are not making any progress here.
>>>
>>> So what i suggest is you post the kernel code and configuration tool
>>> concept to netdev for a full review. You want reviews from David
>>> Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.
>>>
>>
>> I think that the discussion steered too much towards networking related
>> topics, while this ioctl doesn't have much to do with networking.
>
> Hi Laurentiu
>
> So i can use switchdev without it? I can modprobe the switchdev
> driver, all the physical interfaces will appear, and i can use ip addr
> add etc. I do not need to use a user space tool at all in order to use
> the network functionality?

Absolutely!
In normal use cases the system designer, depending on the requirements,=20
configures the various devices that it desires through a firmware=20
configuration (think something like a device tree). The devices=20
configured are presented on the mc-bus and probed normally by the=20
kernel. The standard networking linux tools can be used as expected.

The ioctl is necessary only for more advanced use cases that are=20
supported by this bus. Think "more dynamic" scenarios that involve=20
linking & unlinking various devices at runtime, maybe some=20
virtualization scenarios. Unfortunately I'm not the architect type of=20
guy so I don't have more specific examples to better illustrate ...

---
Best Regards, Laurentiu=
