Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeA3C44 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 21:56:56 -0500
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:51707
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752378AbeA3C4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 21:56:54 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Topic: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaOLC3EAgAClcwA=
Date: Tue, 30 Jan 2018 02:56:51 +0000
Message-ID: <MWHPR1201MB01278542F6EE848ABD187BDBFDE40@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <20180129163114.GH21609@dhcp22.suse.cz>
In-Reply-To: <20180129163114.GH21609@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB2477;7:/d0e5WBvKfaooULQanouWFg1F+N5On8bWfnpafH3YRVt6zeaLwT6OvwRUrVoMstWghF1T/Zcz7qvOI8Eczu5HWHz4mOemT1cr3tcSnlal8eNG5gbvVUZ+vto7hUZweKwNQLKWMWJd/rEy15pis/MZBDXRch6BqPnUFEQWtGRq35latg/rJqfpVOCs7R/Uuy4Yb68YAULyobhw9t8khKQvWZxvr2QTLVUyNic0Gvmg54PXnnUsPYzNpNd3of0hl7m;20:+pUesfRZyA+gT6bND9Sv5/NjAYt2sVZJwQ99eYzFy4vpq+7QGv7AflRO5Pvn+Jc/C/kj4eD7qpgW82U2S7BwqbTmf5AuGVu3VaH9I+2PvfLAqtIjG4szH/sKvRw7cnEZCgVOOEdt5KX5389+i3QtOP/Jtjj85SbEyj7De19A9ufgSZFYd8quHzS3GBG2J/6n+ZM/jB+SJJosnkL+tLKTwiA3CRoTJhLIq05hnV/AJSedDRTJvUqEQouULdUlF62m
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(13464003)(377424004)(26005)(53936002)(3280700002)(3660700001)(316002)(305945005)(7736002)(2950100002)(186003)(6916009)(6436002)(86362001)(9686003)(55016002)(99286004)(77096007)(105586002)(106356001)(54906003)(2900100001)(6306002)(5660300001)(8676002)(68736007)(478600001)(4326008)(2906002)(33656002)(7696005)(76176011)(6506007)(53546011)(102836004)(966005)(97736004)(72206003)(3846002)(66066001)(8936002)(229853002)(74316002)(81156014)(59450400001)(14454004)(25786009)(6246003)(6116002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB2477;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f612e97-c428-4373-c38b-08d5678d1d31
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB2477;
x-ms-traffictypediagnostic: MWHPR1201MB2477:
x-microsoft-antispam-prvs: <MWHPR1201MB2477F4F1E894C8DA54850582FDE40@MWHPR1201MB2477.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR1201MB2477;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB2477;
x-forefront-prvs: 0568F32D91
x-microsoft-antispam-message-info: xFMSawsZnFMC+39bxCgQ3FdaxpX/JGGcd7RZfBWZhXb6YmhF9KI+5SzQl7SuGXkMH5rISrBRsj4ixTMst8QqQQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f612e97-c428-4373-c38b-08d5678d1d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2018 02:56:51.8924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2477
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0U2v1jX010617

Hi Michal:

We need a API to tell TTM module the system totally has how many swap cache.
Then TTM module can use it to restrict how many the swap cache it can use to prevent triggering OOM.
For Now we set the threshold of swap size TTM used as 1/2 * total size and leave the rest for others use.

But get_nr_swap_pages is the only API we can accessed from other module now.
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
> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);  
> struct backing_dev_info;  extern int init_swap_address_space(unsigned 
> int type, unsigned long nr_pages);  extern void 
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
