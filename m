Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbeA3FNi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:13:38 -0500
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:1248
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752385AbeA3FNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:13:36 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: "He, Roger" <Hongbo.He@amd.com>, Michal Hocko <mhocko@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Topic: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaOLC3EAgAClcwCAAClJEA==
Date: Tue, 30 Jan 2018 05:13:32 +0000
Message-ID: <MWHPR1201MB0127401481BC5F7424B41B6BFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
 <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0207;7:dP0SIPPiA3dC99Ylkyb/k4OghObpEa4K4HqVfxpj2KmRO6Nbx86BWMBFn7ymd2zuie6SkvAX1j8ElFyGysxCkxDKLQcQTOSf80mbbC3YM+uXGs5jL/isFZgDUkNyYmoSf7kX/BC8mJcQ68AXEjjWdQWiu60g+TanMCNeDL9yMR4xk5ehlVTcS8wV55MPJ06r8aiZQLo3XLAceHSnLHlXW1yd169kknuXyb3PUm6KcWkJZ2Qrw7ZlQ0J8HLfNZhC8;20:u6ooYzXiT62M+m0bN3jhj6tTcuKUd9OGjOocuvf8ZcssZEkFMnRjpOT5bXXPtHhvXu//RF+Nr+pbYZhqcpQACXZR58jZoUtvdONl7mcWhp127xF9cthR+HpkGYclCGfuxN6MU9BqbtjAaXl6ZmkPPKN8U808uNUAx8W2LXZAkB2Y3sVcVrm+nGi1e5iM+bdKvhhyqzsSMPU9o865KtQLaSaegsuD958Q4QG3ChuPaNaswF7tpqq0U6crVCWTzDf0
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(346002)(366004)(377424004)(13464003)(199004)(189003)(478600001)(2906002)(81166006)(7736002)(8676002)(8936002)(97736004)(53936002)(9686003)(6506007)(6246003)(4326008)(53546011)(76176011)(3846002)(7696005)(59450400001)(2950100002)(102836004)(305945005)(33656002)(81156014)(26005)(6306002)(25786009)(6116002)(77096007)(6436002)(3280700002)(316002)(74316002)(3660700001)(68736007)(54906003)(5660300001)(229853002)(55016002)(2940100002)(110136005)(66066001)(2900100001)(86362001)(966005)(72206003)(14454004)(105586002)(106356001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0207;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a2da653-3bb7-4973-39f2-08d567a0353d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0207;
x-ms-traffictypediagnostic: MWHPR1201MB0207:
x-microsoft-antispam-prvs: <MWHPR1201MB02079898F6EED9A252BBC6DEFDE40@MWHPR1201MB0207.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR1201MB0207;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0207;
x-forefront-prvs: 0568F32D91
x-microsoft-antispam-message-info: UcU580Bup1lEdpvE4XP/zea/xIx7zXK33FZqY5hp2PpY+fruiQ3TAudTMGNWLT4V/mLQaYNHrAM2eW7CRSnJjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2da653-3bb7-4973-39f2-08d567a0353d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2018 05:13:32.7020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0U5DhET001970

	get_nr_swap_pages is the only API we can accessed from other module now.
	It can't cover the case of the dynamic swap size increment.
	I mean: user can use "swapon" to enable new swap file or swap disk dynamically or "swapoff" to disable swap space.

Above is why we always to get swap cache size rather than getting it once at module initialization time.
That is internal in TTM. Please ignore that.

And why TTM needs get_total_swap_pages instead of using get_nr_swap_pages directly. That because
even though the TTM buffer has been swapped out, at the start they also stay in system memory by shmem. Later at some point when
Under high memory pressure, Those buffers all are flushed into swap disk and used more swap disk size or even use up all swap size. That is not what we want and still has random OOM. So we need a API to get total swap size and control the swap size used by TTM very accurately.

Thanks
Roger(Hongbo.He)
-----Original Message-----
From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of He, Roger
Sent: Tuesday, January 30, 2018 10:57 AM
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

Hi Michal:

We need a API to tell TTM module the system totally has how many swap cache.
Then TTM module can use it to restrict how many the swap cache it can use to prevent triggering OOM.
For Now we set the threshold of swap size TTM used as 1/2 * total size and leave the rest for others use.


get_nr_swap_pages is the only API we can accessed from other module now.
	It can't cover the case of the dynamic swap size increment.
	I mean: user can use "swapon" to enable new swap file or swap disk dynamically or "swapoff" to disable swap space.

Thanks
Roger(Hongbo.He)

-----Original Message-----
From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Michal Hocko
Sent: Tuesday, January 30, 2018 12:31 AM
To: He, Roger <Hongbo.He@amd.com>
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

On Mon 29-01-18 16:29:42, Roger He wrote:
> ttm module needs it to determine its internal parameter setting.

Could you be more specific why?

> Signed-off-by: Roger He <Hongbo.He@amd.com>
> ---
>  include/linux/swap.h |  6 ++++++
>  mm/swapfile.c        | 15 +++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h index 
> c2b8128..708d66f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *); struct 
> backing_dev_info;  extern int init_swap_address_space(unsigned int 
> type, unsigned long nr_pages);  extern void 
> exit_swap_address_space(unsigned int type);
> +extern long get_total_swap_pages(void);
>  
>  #else /* CONFIG_SWAP */
>  
> @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)  { 
> }
>  
> +long get_total_swap_pages(void)
> +{
> +	return 0;
> +}
> +
>  #define free_swap_and_cache(e) ({(is_migration_entry(e) ||
> is_device_private_entry(e));})  #define swapcache_prepare(e)
> ({(is_migration_entry(e) || is_device_private_entry(e));})
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c index 3074b02..a0062eb
> 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>  
>  atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>  
> +/*
> + * expose this value for others use
> + */
> +long get_total_swap_pages(void)
> +{
> +	long ret;
> +
> +	spin_lock(&swap_lock);
> +	ret = total_swap_pages;
> +	spin_unlock(&swap_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(get_total_swap_pages);
> +
>  static inline unsigned char swap_count(unsigned char ent)  {
>  	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */
> --
> 2.7.4

--
Michal Hocko
SUSE Labs
_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
