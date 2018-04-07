Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752289AbeDGRJJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 13:09:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3110 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeDGRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 13:09:07 -0400
X-IronPort-AV: E=Sophos;i="5.48,419,1517846400";
   d="scan'208";a="76178218"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAU3eAgAAfGYCAAw0ygIADtuOAgAAFnoCAAAO2AIAChmAAgAAEUYA=
Date: Sat, 7 Apr 2018 17:09:04 +0000
Message-ID: <1ff8d234cc565ba9701ce31899fca5faa597e050.camel@wdc.com>
References: <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org> <20180401163604.GB25011@animx.eu.org>
         <20180401182723.GA31755@animx.eu.org>
         <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
         <20180406014644.GA16112@animx.eu.org> <20180406020651.GB16112@animx.eu.org>
         <fb0640c203409a84ab1bfbbc41078a5416138ad2.camel@wdc.com>
         <20180407165335.GA2515@animx.eu.org>
In-Reply-To: <20180407165335.GA2515@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1136;7:QyzGpPWzlRVwTuNxWwx0dc1Brsny6H5dVLo5BA8ONZLgKLtI9pBMZCHMYQRMOb1i5MZ7sH43/nvBXTczLNF3s+N2QhurQrbqz/U7YfYzj3s9spylgBmjlS+/cZDtzoylfsNakFEcO5Uias3qHuJz3dDl9q4RehmQpOmuBgQ8Qiep/fYBOw6HeMrnGNeybSO/vw5NkxU1eVmBmzYyS7sDjBpaqQnLkN3JHc/rzkPZMs1U+pR0XOZ6V3vYUIqLrM+X;20:RYWrXq/9DQtIAGsKs2vBUxXVbLP/h/sWgbbQYaxlbo+AXRwsW1XdHKQIpVdUGaLZUxzedNheNu43/RA4Q5hUF2IGqMTvgyiNsMp7Zw+wJi/DpIUFmVuurAUz052xaPAtOvqK0AWLKHrRj1ib6BHELE/QSrElPCf0OQaVRE/RYAA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce56d60e-efcb-4a8d-95d3-08d59caa4443
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1136;
x-ms-traffictypediagnostic: MWHPR04MB1136:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1136BDE8C6647CB8856D050E98B90@MWHPR04MB1136.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB1136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1136;
x-forefront-prvs: 0635D5275E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(396003)(376002)(346002)(377424004)(189003)(199004)(2906002)(118296001)(102836004)(966005)(76176011)(66066001)(26005)(14454004)(6486002)(6512007)(6436002)(2900100001)(6306002)(2501003)(2351001)(446003)(2616005)(39060400002)(6506007)(486006)(5250100002)(59450400001)(6916009)(72206003)(11346002)(97736004)(5660300001)(478600001)(106356001)(476003)(81166006)(53936002)(81156014)(6246003)(8676002)(1730700003)(93886005)(54906003)(86362001)(25786009)(229853002)(7736002)(36756003)(99286004)(8936002)(4326008)(316002)(305945005)(68736007)(3280700002)(3660700001)(5640700003)(6116002)(105586002)(3846002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1136;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: MfsqZUwRDUXI5Ogi4zvVe7Of4nrXuBhRWwAnCSALi5kSejvMOuIYfpbVddDKuLVnQiQlBdpKt70vcE29P4hSat4laPoxUTsdkuGtFXfCct3dVoREGlu+9Gp3SS2Rl1v4FaJ915A/at6NgxdrMw4vfMVMNNLD3u+EiotdUHaGvDtfcnyUnMaj5x4CpBvKrZ3u/B6vyVxv/i2t2OjkBSapzw3Z73VPzp3q1szCnV2F+0vRewIhbnat7FG7kNvikSZ071IgaReukI2UMavOH8bGWa1HzA+xue9mRaMzez6TI1Q9p25UBcLOGLGxNxQjRU4J1f/9AHBs2vHQR3kkvJ0KEWATH3s1vp28bh0TEfKVt5KqR+NfuUjibly82N1X4U+NRK1+wYqC5GCB3HRJZaKgVyWbW2y4mfs6fuoDM4A4dhE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <58D06DE5D9C8574991134A2D5FBEC75D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce56d60e-efcb-4a8d-95d3-08d59caa4443
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2018 17:09:04.5509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1136
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w37H9EH4002506

On Sat, 2018-04-07 at 12:53 -0400, Wakko Warner wrote:
> Bart Van Assche wrote:
> > On Thu, 2018-04-05 at 22:06 -0400, Wakko Warner wrote:
> > > I know now why scsi_print_command isn't doing anything.  cmd->cmnd is null.
> > > I added a dev_printk in scsi_print_command where the 2 if statements return.
> > > Logs:
> > > [  29.866415] sr 3:0:0:0: cmd->cmnd is NULL
> > 
> > That's something that should never happen. As one can see in
> > scsi_setup_scsi_cmnd() and scsi_setup_fs_cmnd() both functions initialize
> > that pointer. Since I have not yet been able to reproduce myself what you
> > reported, would it be possible for you to bisect this issue? You will need
> > to follow something like the following procedure (see also
> > https://git-scm.com/docs/git-bisect):
> 
> After doing 3 successful compiles with good/bad, I got this error and was
> not able to compile any more kernels:
>   CC      scripts/mod/devicetable-offsets.s
> scripts/mod/empty.c:1:0: error: code model kernel does not support PIC mode
>  /* empty file to figure out endianness / word size */
>  
> scripts/mod/devicetable-offsets.c:1:0: error: code model kernel does not support PIC mode
>  #include <linux/kbuild.h>
>  
> scripts/Makefile.build:153: recipe for target 'scripts/mod/devicetable-offsets.s' failed
> 
> I don't think it found the bad commit.

Have you tried to modify the kernel Makefile as indicated in the following
e-mail? This should make the kernel build:

https://lists.ubuntu.com/archives/kernel-team/2016-May/077178.html

Thanks,

Bart.
