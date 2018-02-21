Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbeBUAeq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:34:46 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:5212 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeBUAep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:34:45 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>
CC: "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Subject: Re: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
Thread-Topic: [RFC patch] ioremap: don't set up huge I/O mappings when
 p4d/pud/pmd is zero
Thread-Index: AQHTf8/DU6Bn0QH47UWdTrAB037o0qOtWaOAgAEK4wA=
Date: Wed, 21 Feb 2018 00:34:40 +0000
Message-ID: <1519175992.16384.121.camel@hpe.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
         <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
In-Reply-To: <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0340;6:5D2A3x7WAQMEQhqD6pimjMt7thUVIIfxVcocVNswmS1DgxcshVeVv9KFKcQ38dmPxRkaBNz9bOt00edkZ9DoBUNUUN/NDBLbHNhP5YYtoiy5cunwIF2m2BZLHMt8t+XtsvoIA8zxPOHR840TbvGyId0OySppHdfpJBiImlMf6ZSbpxZBlPQklijuhru08idNqyuG4zqgColRpjhyDPHuU11oFYbUx6CuROn3F8Ia6TIWkiBYXUenEzlt+csgZnCkOQCFr475DHK7LyZeOInnUCT/CABOd0Lgt08fGTajpBwixGwuNT9h8sFcwo4797BTJUJEJ82bH2RdmCrnan20StWXR91AR2MYDfn8cB02DsEI1DhY1vVx5HlGUPJTELqN;5:upB0+5XwOBlM+T2GXbaHAMr9IHNAotLRAFTHBoc0FdawK0U/p6ANxkHd8Ih+EaJtBkFX7QXf88ckXJ9JDGIqbsvUrs1dz8DioHxrDVmbfOU4L81AyrldT+ypkYibPfgi3PLF2BY6SbVNjrD8GOn/LVA+c/C76AEETqvytLL6v90=;24:0zE63nS3DZskLFJmwRxLKxPyYgrVsuERl01OUjGPAnSffiIfSgxd+mFXvNrDM8vPV6eS/NLLK5X068FLj09yenMcdsSRDlMGmBBxc52L/R0=;7:fVrsKz+IpCZ/HH2FJ2yZW1ZdftGz931fAYKp4s+3tXNWMZAIz1+pjJllPzsYRQeTSNwf9DyNNX7MOS3j5xI/ns/Vif7+NgdcJLuUir6p6nmcVOt3rOYCdy90wD/Qi+iXGLt1eD2qApfCGQh0d5T116aZanwK8zA//7JQX/FlbXLiPkNSF/8+NSp9hpbUrrNHhT5qmhqd9Z5hMy0b1Kg/HYtrif7mmcjj4AatqRxQPZxD/Jn9RCgKwa6kSfkoOHV+
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51205b96-56af-437b-a1fa-08d578c2e4e8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB0340;
x-ms-traffictypediagnostic: AT5PR8401MB0340:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB034060B7A977EB9E0F94FFC782CE0@AT5PR8401MB0340.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001061)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AT5PR8401MB0340;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0340;
x-forefront-prvs: 0590BBCCBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(377424004)(199004)(189003)(7736002)(6486002)(305945005)(102836004)(6246003)(3660700001)(76176011)(66066001)(966005)(53546011)(6506007)(106356001)(14454004)(6436002)(8676002)(5660300001)(7416002)(99286004)(68736007)(81156014)(2201001)(86362001)(8936002)(26005)(81166006)(103116003)(110136005)(97736004)(105586002)(5250100002)(316002)(2501003)(186003)(3280700002)(478600001)(2900100001)(54906003)(3846002)(6116002)(6512007)(229853002)(53936002)(2950100002)(6306002)(2906002)(25786009)(4326008)(36756003)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0340;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: LqlqNPqifCIHb3uGGxGoxnG0Ye9WscJVkD6S8x0yfSb2iSUtYpaCGNV2JlIYTxx+tBXpZ+qPz3/bCJzjWBwfMahfcVlp0fZkzZn7YSeVG+lxvyOcCJ5xfpAMv3WK7EwNKMMJ21V7lDsBleNz6/Yj/vTMUdIi0MqriDbe4B+wmik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A2CE272CB23C041A9BC657DD90D9DD9@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51205b96-56af-437b-a1fa-08d578c2e4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2018 00:34:40.0982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0340
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1L0YoGY005037

On Tue, 2018-02-20 at 14:54 +0530, Chintan Pandya wrote:
> 
> On 12/28/2017 4:54 PM, Hanjun Guo wrote:
> > From: Hanjun Guo <hanjun.guo@linaro.org>
> > 
> > When we using iounmap() to free the 4K mapping, it just clear the PTEs
> > but leave P4D/PUD/PMD unchanged, also will not free the memory of page
> > tables.
> > 
> > This will cause issues on ARM64 platform (not sure if other archs have
> > the same issue) for this case:
> > 
> > 1. ioremap a 4K size, valid page table will build,
> > 2. iounmap it, pte0 will set to 0;
> > 3. ioremap the same address with 2M size, pgd/pmd is unchanged,
> >     then set the a new value for pmd;
> > 4. pte0 is leaked;
> > 5. CPU may meet exception because the old pmd is still in TLB,
> >     which will lead to kernel panic.
> > 
> > Fix it by skip setting up the huge I/O mappings when p4d/pud/pmd is
> > zero.
> > 
> 
> One obvious problem I see here is, once any 2nd level entry has 3rd 
> level mapping, this entry can't map 2M section ever in future. This way, 
> we will fragment entire virtual space over time.
> 
> The code you are changing is common between 32-bit systems as well (I 
> think). And running out of section mapping would be a reality in 
> practical terms.
> 
> So, if we can do the following as a fix up, we would be saved.
> 1) Invalidate 2nd level entry from TLB, and
> 2) Free the page which holds last level page table
> 
> BTW, is there any further discussion going on this topic which I am 
> missing ?

Yes, I suggested to free up a pte table in my last reply.
https://patchwork.kernel.org/patch/10134581/

Thanks,
-Toshi
