Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeCHUgL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:36:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52836 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:36:09 -0500
X-IronPort-AV: E=Sophos;i="5.47,442,1515427200";
   d="scan'208";a="73248022"
From: Alex Lemberg <Alex.Lemberg@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Harish Jenny K N <harish_kandiga@mentor.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Thread-Topic: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Thread-Index: AQHTr77gTAsg8icfe0GBsxZvuBdg+qO861wAgAnvc4A=
Date: Thu, 8 Mar 2018 20:36:01 +0000
Message-ID: <67491d8c-7eb3-e8c5-7eb0-3006ff668a60@wdc.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
In-Reply-To: <CACRpkdYuxoZaF9xyoA9tsyBuXOkrcdZVGWYfcyEMe0psk6UydQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Lemberg@wdc.com;
x-originating-ip: [64.183.48.10]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1558;7:kYgONYzFQP/ZV7LZmnkDBRBZ38qgXuOQc9RGOTyJOM4kTExPHQK+1wqL8/pPC+tiIzeADwuU0MHQeHzc0Xo7alWrH3WBjryqyc/DEH7s/TcGY9i1T0Dq1lFmCkr8zKvWe//yoGEaUlfdeBy+03mGaRDl67daqzwCrY6+oNkmuPtG36R5R563ps6TNaoEXOhsxAHaUvZUX2sAfaYI6BZtQMBqzCsnyOUlVcHvOWxMWalG3+09WeNWyoqUQaLBIYGi;20:onaFqEL/Ba4x/fYrU/q+2tUl1OJy+YRZoosOT+WbscEe9NAEgd6GcM6B+zx5l+Qi/D2Pxfk8Vgzhn1NEFBmPv0Red+dVxYir/zn1asA8sDajKuF6Gma4b6q3t6/f5etGLRy+99xLRAuT/wFaReKpkgaSb0X7Pk/2KtiXcyB/fnQ=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3223894-30c8-414a-bf97-08d585343522
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1558;
x-ms-traffictypediagnostic: BN3PR0401MB1558:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1558DA623154F920B6B0B58F8DDF0@BN3PR0401MB1558.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN3PR0401MB1558;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1558;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(186003)(26005)(7736002)(305945005)(6512007)(3280700002)(6306002)(53936002)(6436002)(5250100002)(2950100002)(110136005)(58126008)(6506007)(102836004)(6246003)(65826007)(86362001)(2900100001)(229853002)(54906003)(68736007)(81156014)(76176011)(97736004)(81166006)(31696002)(478600001)(5660300001)(966005)(8676002)(2906002)(72206003)(64126003)(316002)(6486002)(14454004)(66066001)(3660700001)(8936002)(31686004)(53546011)(6116002)(105586002)(65956001)(99286004)(65806001)(25786009)(106356001)(3846002)(59450400001)(4326008)(36756003)(422495003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1558;H:BN3PR0401MB1235.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: elWPOtNB/DeCS3fNEWwoRE1F5+XzxCEzDY8z5iwUOlPa+6p3R/8qGk9oPYwTMoRhs+7IzFiw2f2zjCzLyUzO7cB5lE1LUJmJWk5yEoFIHv8/aFIYsEbduW1IQX/n9UNoQmeIN6Gg4cnIkphKJWQ8yqRWgiF3Ps2GlbNs2/O+bcXpLz4TcZNNzcFICBaJh0sflUnAd//QsUxzM6CsSM/nvozO1YiCN5B5+HCCdfaaPubiqm2ACtIEYx1kK8ueiHGOBB5GBtrWWnFxSAmlaq/VNGxr2qxKiD4w4Ntn7STtb618GoCkqqw7FZ3wNVdZjXwBJj4lAlNHWYSH+rZlbOPomw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1650BAD238F43F45AC17F877891882A2@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3223894-30c8-414a-bf97-08d585343522
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 20:36:01.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1558
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w28KaK4n032238

Hi Linus,

On 3/2/18 4:53 AM, Linus Walleij wrote:
> On Tue, Feb 27, 2018 at 12:33 PM, Harish Jenny K N
> <harish_kandiga@mentor.com> wrote:
>
>> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>>
>> Since RPMB area is accessible via special ioctl only and boot areas
>> are unlikely to contain any partitions, exclude them all from listing
>> in /proc/partitions. This will hide them from various user-level
>> software (e.g. fdisk), thus avoiding unnecessary access attempts.
>>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> Makes sense to me, at least it makes the problem smaller not bigger.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
>> The main intention of the patch was to not have RPMB device in /proc/partitions.
>> Boot partitions are also unlikely to have any partitioning, so it made sense to
>> treat them the same way as RPMB and not list in /proc/partitions.
>> Now I see that RPMB is converted to a character device and this change
>> may not be required for RPMB.
> It certainly does not hurt, even if this code path is not called
> for the RPMB partition anymore (luckily).
>
> On a general note, I do not feel the work with boot partitions or
> the general purpose partitions is finished.
>
> In a lecture I pointed out that:
>
> dd if=/dev/sda of=sda.img
>
> Gives an image of the whole device, and you can restore the
> device by doing the inverse of that command.
>
> For MMC devices,
>
> dd if=/dev/mmcblk0 of=mmcblk0.img
>
> does NOT have the same nice property. Instead, since the
> special partitions are their own devices and not part of the main
> device, they have to be backed up separately.
>
> IMO this breaks the user contract of how a device vs a partition
> works.
>
> What we need to do is make the "special partitions" part of the
> main block device and stop spawning these special block
> devices for each boot partions or general partitions. In addition,
> each of these boot partitions or general partitions will get their
> own block queue and state container which is not cheap in
> runtime memory footprint terms.
>
> So what I want to do (unless someone beats me to it) it to come
> up with some way making boot and general partitions part
> of the main block device. Possibly the core kernel partitioning
> code needs to be augmented. The tentative idea is to just
> put the sectors representing these partitions after the main
> block device and access them from there, with an offset.
I don't think that hiding the Boot and RPMB will resolve the problem
described above.
Boot partition (same as RPMB) in eMMC device is a separate
"physical" partition.
It has its own logical address range and different from general
partition characteristics.
>From the protocol - the access to this partition it requires switch
partition command. It can be accesses during the boot sequence
before the general/userdata partition is mounted.
>From the device side - it can be managed in totally different manner
(SLC vs. MLC blocks, etc.)
I think it completely makes sense to allow access to Boot partition from the
user space. For example - to allow R/W the boot image.

AFAIK, in case of SCSI/UFS devices - Boot LUN's are represented as
separate block
device partitions (/dev/sdb, dev/sdc...).
Shouldn't we have the same for eMMC?

> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
