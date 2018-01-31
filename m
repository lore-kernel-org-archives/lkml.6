Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeAaIIU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:08:20 -0500
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:16288
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751678AbeAaIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:08:18 -0500
From: "He, Roger" <Hongbo.He@amd.com>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Topic: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
Thread-Index: AQHTmNtYoBUw/9kRPkGbswRNbnupYaONlMmAgAANf7A=
Date: Wed, 31 Jan 2018 08:08:15 +0000
Message-ID: <MWHPR1201MB0127760D359772D5565BA3EBFDFB0@MWHPR1201MB0127.namprd12.prod.outlook.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
 <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
In-Reply-To: <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hongbo.He@amd.com;
x-originating-ip: [116.228.147.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR1201MB0111;7:SpCROZkyEuUrClByRVLRC2VtrFiGzaMluroMGcoJQkfcytL/kOg9ArkmJR81HsFOnWVAzDyzfsyw0lg0QZ7L/zDzMn+NjmdxDrXfoAugCehLwv7LtYotY1yBzMgEbb4NFLX5sWny9mmA28xvvG2WR52tkjH3PSBfe4HZEZwafaleEd8iLWQpjNqjWQ6o911/w8VUGf8bULhSlCx1wHRZTVPVj42r8YcMwbGKdpXpNwbXP5Je58WUVbwhl3h7BSjY;20:n6nwY2/RA7Ns7aT8vMwLesOYuoP/juKKCng6pPaZ/jz65OrPrHhKdu+cVnMA5uCIk/uUaePohHSjvpl0+D0/OKLBWDamc9lKEo5yn2pq+BIzOYO1+ea7rbki5tCRIMX8NSyJG/Cvbg5FZ8OIQn1hG52GoZanCwtwy2ptm6/oNQ9ELIW/iqoX2RDtMQd/3OFo47brxEo/S2L/9AViAQEfNYUXYi9+ytlFA7jaEonDUzegIMH4CUnjQTx9SvsMBCmv
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(13464003)(199004)(189003)(66066001)(26005)(77096007)(9686003)(59450400001)(53546011)(2501003)(97736004)(6506007)(99286004)(25786009)(76176011)(7696005)(81166006)(5660300001)(2900100001)(81156014)(33656002)(6116002)(3846002)(102836004)(8936002)(8676002)(4326008)(316002)(110136005)(68736007)(478600001)(229853002)(6246003)(53936002)(2950100002)(14454004)(966005)(72206003)(7736002)(6436002)(3280700002)(55016002)(74316002)(2906002)(3660700001)(86362001)(105586002)(305945005)(106356001)(6306002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0111;H:MWHPR1201MB0127.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1af1fb6-7820-4647-68c1-08d56881c7ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR1201MB0111;
x-ms-traffictypediagnostic: MWHPR1201MB0111:
x-microsoft-antispam-prvs: <MWHPR1201MB011181E54DE250ADDDB8240AFDFB0@MWHPR1201MB0111.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR1201MB0111;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0111;
x-forefront-prvs: 056929CBB8
x-microsoft-antispam-message-info: AuIV96YpjquXnBFhJbrDz9JXih/LALWJaC4P0f2LNwc2ig7QmYWiva3zGFpYdvLsIGtho9b9K/RzaruT3bWNgQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1af1fb6-7820-4647-68c1-08d56881c7ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2018 08:08:15.5903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0V88PMJ025366

	I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM.

Because the variable is not exported by EXPORT_SYMBOL_GPL. So direct using will result in:
"WARNING: "total_swap_pages" [drivers/gpu/drm/ttm/ttm.ko] undefined!".

Thanks
Roger(Hongbo.He)
-----Original Message-----
From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On Behalf Of Chunming Zhou
Sent: Wednesday, January 31, 2018 3:15 PM
To: He, Roger <Hongbo.He@amd.com>; dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose total_swap_pages

Hi Roger,

I think this patch isn't need at all. You can directly read total_swap_pages variable in TTM. See the comment:

/* protected with swap_lock. reading in vm_swap_full() doesn't need lock */ long total_swap_pages;

there are many places using it directly, you just couldn't change its value. Reading it doesn't need lock.


Regards,

David Zhou


On 2018年01月29日 16:29, Roger He wrote:
> ttm module needs it to determine its internal parameter setting.
>
> Signed-off-by: Roger He <Hongbo.He@amd.com>
> ---
>   include/linux/swap.h |  6 ++++++
>   mm/swapfile.c        | 15 +++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index c2b8128..708d66f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);
>   struct backing_dev_info;
>   extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>   extern void exit_swap_address_space(unsigned int type);
> +extern long get_total_swap_pages(void);
>   
>   #else /* CONFIG_SWAP */
>   
> @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)
>   {
>   }
>   
> +long get_total_swap_pages(void)
> +{
> +	return 0;
> +}
> +
>   #define free_swap_and_cache(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>   #define swapcache_prepare(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>   
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3074b02..a0062eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>   
>   atomic_t nr_rotate_swap = ATOMIC_INIT(0);
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
>   static inline unsigned char swap_count(unsigned char ent)
>   {
>   	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel
