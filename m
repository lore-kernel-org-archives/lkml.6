Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeB1PTB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:19:01 -0500
Received: from mail-he1eur02hn0207.outbound.protection.outlook.com ([104.47.5.207]:23548
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752465AbeB1PS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:18:59 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Wed, 28 Feb 2018 18:18:44 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 3/3] x86/kvm/hyper-v: inject #GP only when invalid SINTx
 vector is unmasked
Message-ID: <20180228151843.GB2376@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
References: <20180228134401.6544-1-vkuznets@redhat.com>
 <20180228134401.6544-4-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228134401.6544-4-vkuznets@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0051.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::40) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abe30ac4-19ff-4883-af98-08d57ebe9149
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:Xc7jVHB7Nzj7XvlD5fSixaOfXxaNDBH+adlY2TrEIumNI8tZg1EJ1iRcOmEfozaAsZuFuLkyQ8YHengV6Uu6TIKMXqkYXX2Cpv6Xx4jIjHdSdHEaYyCv6NQ3Q+Qlzv4a9OFFM3FwZeCWHFTgnRix8kVj0161jkSj03u5tRo8sHJahaVWzerhH4Loat0KsfQWV1GJie+W2RC9o3BxzP/nXerc6AfHOH/rcei+9hPouTiSqBP2p/tu5nK9dg8zqGR2;25:NpkQa/QxHr/HKwFW0QrHCBN/LPo7gf2C69L2HFsAlOM+2rayVdNKDGiEjA47TbS+HL5RIdSXqVcw/FZC0XMRRyLJ9BhDU/VlHYaMfhK/5ZjtRbtV5Lb+y5yoluWJL2MGAN9rNgqR029cy6hn3gbI12V/DfRW+JrRVnLjYljbyN5zqYIt1defriXA/UnVOB5JrZv3hlY8M8EKvDgbHBspLzhcmMaubXfoAznwi40lPqdYcpyZDcfXQoY4ilBvfNNznSBmqDxSSKqBAS0J3WFEf1a3XtOQNVGtdsCK/ZpvBo3cl1DWxTXKciT+urwMx/qb7l/RQexYDGgqTIvCSpqtYQ==;31:VFUQ4OZX8mwfcIUB7xQePjMa2EkQFyVWAKYF3lkTst+LsnxRVv3ipYpcnnXMLzBMNVxetZbyE+QnFqfWqZqpVClk4yYyKMn3PsSvICRjhNLaJjAVf131F4yWtyprKXnITCzCWjsjvo3wEXyO6jX9mlL7YsoZFU7ZcE2zMyvWocu6KdPqUaqjQVVGHkIcXhWY1KD86wAZOycZ3VnWN1exQiCrzuKW/nU78lbjoVcFQn4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:sfhVvayyAjdd/FNxKfSEEgFlw7WnRzvryCqxltL/5HkkGW1E9a/YxCGgKnSS5wR28R3OpmPkMVWgKih83i8arNeK8vWxfzjJTmm7Ce9AJBwUa8YEq7aW3PqbYGx/TxDuYrDwytSXZ2BGON0zZfrBOczn0bZlaJsRF6rRSd4ONuVaBS8rrQBe5nsgMkacMK88gPU+4HXu3mjJTfuNLSz68W0FHDwHMEN9k07y3F7Fi1G8abZJceDvVG0RzcYkMxNgR6XEzOEVM1waigbecdOSJdYlJa961PO82vwY2GPDbmxHmO8pTQesxgngKulRTu2NN3FjfO2XKePpIkhtxUa1NFWi12mk9EuHYsRxJk0jVpGEA2Lx6GkC6FWy3Sx0wtmNn6bZMB2tpQ9LHwOpzxHN+UOX+xYLc3xDuYrAKcC02wcwsDcIDQ0d211oFcy4dD+NamVz+aMgszW4i6/CGCRSYEA6t9ixc7Cus06bqJm3AA5TNpLGeCufA0gPtBW9bxEP;4:HZSYClZN/ew7vkRSReL43LeS6wYEWCgZv4qPSGMzkWHJSBLxn+M2dnl3G1U8w9XpcMSgQbtAFoyCiEgccbP0gzV1JpKdMTUAMzngIv92tPG3T9vgkJWkAgIolsLIEUzigz36DrAD2kxn9k0uLudGFjd2h7vWl3zisvGfpGw1HJ5hjWwxHpx1yXQ4qyzyuDc21jhswPqLImNcuRQFG3IPV7PFwHlvGqoPyjKLgfdlmTgnnAZ6stEWiNfgxMz8jqAZekNEjWYMJ0Lcdjuu5a7MTg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1980846676DE6C909BD7B7F8C9C70@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501217)(52105095)(6041288)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(39850400004)(396003)(39380400002)(366004)(376002)(346002)(189003)(199004)(54094003)(81166006)(8676002)(45080400002)(81156014)(8666007)(478600001)(25786009)(106356001)(69596002)(4326008)(6506007)(107886003)(316002)(7696005)(52116002)(386003)(26005)(55236004)(59450400001)(76176011)(53936002)(5660300001)(186003)(16526019)(6246003)(16586007)(55016002)(86362001)(54906003)(229853002)(2906002)(68736007)(33656002)(6916009)(2950100002)(6666003)(23726003)(58126008)(9686003)(3846002)(53416004)(105586002)(1076002)(6116002)(50466002)(36756003)(97736004)(305945005)(8936002)(7736002)(66066001)(47776003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:33GDNPzCmu4hQ6BFSYRE6/9zueHNbTgphKrG2uh?=
 =?us-ascii?Q?b8jIdLM+j9bDrzRsfBfWzMJDDywLEg8IH0j5bB7uN8UQUnewLPewCgIRZAIp?=
 =?us-ascii?Q?1XImUXq74XxtMJMa/RNv7BjoohRgZkVhSaxYkC0R/1igyA0WPqBb/bGofhhh?=
 =?us-ascii?Q?3bOpQSUo6KsPkww9dX7vgdjYGW1NPQP+oUw+i1Mfeyk6/o0ZT/JnnhaeB56l?=
 =?us-ascii?Q?Gooy95m1qykpswm460JODhMwGteJPNX1CL31zk5FAzK6AXV9AHQ4tdmzq9EY?=
 =?us-ascii?Q?cFYCWsnT0VwJa8+FBpeYlpvW+HJL/EW8bLC9sq52NeKyPoDCcNkooRTH6RcV?=
 =?us-ascii?Q?VC3EPsxmoZFixy9dt89XjCkEva5hXHi3LkMf86cwucIB49tkBPTuQSCK7LwF?=
 =?us-ascii?Q?UJaEIjmgk/GkqZYpTYFNY3u+vUhDZ+aqbooD0nBtWMAYVutsojYLkHAnswC5?=
 =?us-ascii?Q?uCIzli0IHu7YVf+3GpXbyzZp/q5cl1UzOFRyfJXGki7DBAzqv1F1Y4qiIy4Q?=
 =?us-ascii?Q?kRg1s4yQBfI0GLJfwEWerOl5goHoTXs+EKDSPD4k7eNjRfwxn9zz+J9vPFG6?=
 =?us-ascii?Q?Dzev1RrEWG38W+044xYgtCm4ckQV/VXQ1tkkFb5Hys/xj45/MXK5srhpkWpH?=
 =?us-ascii?Q?zZfePlrvnhtOvgFYSbYKtCR10C6pV/C4tZl1wTCFpGc9B20Ka7JHe4AT79lX?=
 =?us-ascii?Q?iTNBhj4rWKg2be07csr9KAL/NJjlGg5Cm56XDFO6/0WeWc5FfzoDtvvkOwMJ?=
 =?us-ascii?Q?YHBkMNVLyWwPOE1Xr385vaop8nl26zNbX4VDQfBqjZEcwPAG3PL+1FlS3Tt9?=
 =?us-ascii?Q?u4cJcqYm5CByvu/MXFD+Xdcj2cGACWwbg+tp6pAvjFvXRofuTxXKCbBmrNUN?=
 =?us-ascii?Q?3dkGcYgLRxU17fjx6ZUgFjSQ7VWXaWk6Rvtp1Od1rWCWzgm7zR/IUhHso7Lk?=
 =?us-ascii?Q?vJkBXj86YE+nEyYDbG7uADRuLaBBtl1AQGdqPnyIC/JJxO31t4MW1/eXTstW?=
 =?us-ascii?Q?Wx2cceXAwPvj2pINondG8QNVVQvwnmqEe9ieXuusiqXEVoKELzbjB6gLltoA?=
 =?us-ascii?Q?m1wOU/q8et1heuxaZsxbeWB+UxWzdsXK52clGnLzWYiQgXbFknvoPNDz9gch?=
 =?us-ascii?Q?A1NqdPPFuHjw7vCGLTIehiIiryELqn9i7rZ+TrTnx7YVXEf3bF+s7mrWBU9Z?=
 =?us-ascii?Q?WjNd+PGtEqs52tqCeoJ7rzp3WCxbKjj1GTSNCADuQFhyE4mBG7PKlgI0lHcB?=
 =?us-ascii?Q?FGNlFDB62M3dFPrQ6kivLNfFMzD+eSLKQqfeSjwUlQ0p2A6lJDxNmTUNr1mb?=
 =?us-ascii?Q?NnFcKHa0tida2hDKPe+h2U3V4Srbi7/ODiYJUBNap3WDCfXJ3qgudE4CCbjq?=
 =?us-ascii?Q?l9bRy+d/z0ruL+9RHuu46rYuMJtvj7o2Sfv9W8EhUbpBh8XKeIfBNtp3Ae9y?=
 =?us-ascii?Q?YOxoz6zOoJ8xFk3OrGQquZSjbfjKl5/U=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:qy1MpR8XDIIFfw0eZZiIYiR20cJsmn1GGN7keAYHXCKh7+wnPoSlQEm8GooKQbihpy7iNDwiN1Vtl22bNCFqluSzfwQiwPG24ma6MMnu7FC+OB867VCRKFvKuvcVXgDRfaGKpmRLJfVwzF5+3r02MQ==;6:EuUTDwLOclTYK8O8XGyK2rcn9Kh8Pw+L/eLfX+GJYtTDoVUyKJgkasqRv4RfsaCobjdVEHQWarTGKPic6jmAGkloqB/hHepNR0BFdL77mWU8Ru9KBKZhHJQwMGvDPJHLuekKw2EAXGAOdNF4RLF7s56egvjhqmL8Isy9YylpnXAbD8AsCbEoH07TEHYL1DE+7xkvR2YnrUZ9XKTkKk7GN3/vp7tRnS5Vr6mjyy2CIV7lW81ZwydZVSmYqa2peFm8koKR6XUJ0w6Ws03v3p8rmjenZu7uYwBAk1/MJJiFB1pxwVIFBxy94ZwMuCcIItxPCpzFfTHH5dNLAWFJdyHWG7kRmZuiHsmYu2NHH9kflIY=;5:Ima7kwAQ67B1QEKCSdXBP6p4M4utH0rm59yQZlTC9OJV0aWmi150SOMO48MzCxOxMLlwiAgUD+szW7ZovvJ3yCzi0Jtz7AE6Qm4Ygy7Wa8RsvsrGfihEYnlTvS9S2t6Y+dtVlPZM0m0uaJ+wNnjQHIPSbiFRYJBWUGkwUWF3s2I=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:XOdv2kbp2Sn3W1ONnuOv+TZuMFRoiYGQfRqMnR3lnmH/1EkjP0mhpppj87PyLJWqklH5kcLNy13Bc+QGeY0sGEZhmn02h3LMF8fgp8gio7xc1ACZdlInn3UN/xJOBnm2kye55pK6JSNkeHlWMO0NwuV0K6qbJQDnHxk1334/3raiWEymDWdJIrBBnMiVANZrgcvywcJYsd/wtHf47ub//AV35c61z6MS6HvGp03F/Y+MFPi12XP8XTZDJzlTxQTI;20:tNIJrQrzqU8xiQO8/nUehL2BE58utaQlkuBoD/Ua4aBVAPodAFQFAdWTsfG3RBoK4CiErE4zRVv+9cr+0+9zOKwbL+jkPJds/yu/e5xCTwWtog4GfDQRgf/JTdalytP/9ahgj5ZZI9emHMcLQyXIyVf6TUyQ2mr4rcLYCg+ZmEA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 15:18:48.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abe30ac4-19ff-4883-af98-08d57ebe9149
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:44:01PM +0100, Vitaly Kuznetsov wrote:
> Hyper-V 2016 on KVM with SynIC enabled doesn't boot with the following
> trace:
> 
>     kvm_entry:            vcpu 0
>     kvm_exit:             reason MSR_WRITE rip 0xfffff8000131c1e5 info 0 0
>     kvm_hv_synic_set_msr: vcpu_id 0 msr 0x40000090 data 0x10000 host 0
>     kvm_msr:              msr_write 40000090 = 0x10000 (#GP)
>     kvm_inj_exception:    #GP (0x0)

I don't remember having seen this...  Does this happen with the mainline
QEMU, which doesn't set the SintPollingModeAvailable (17) bit in cpuid
0x40000003:edx?

> 
> KVM acts according to the following statement from TLFS:
> 
> "
> 11.8.4 SINTx Registers
> ...
> Valid values for vector are 16-255 inclusive. Specifying an invalid
> vector number results in #GP.
> "
> 
> However, I checked and genuine Hyper-V doesn't #GP when we write 0x10000
> to SINTx. I checked with Microsoft and they confirmed that if either the
> Masked bit (bit 16) or the Polling bit (bit 18) is set to 1, then they
> ignore the value of Vector. Make KVM act accordingly.

I wonder if that cpuid setting affects this behavior?  Also curious what
exactly the guest is trying to achieve writing this bogus value?

> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h | 1 +
>  arch/x86/kvm/hyperv.c              | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
> index 62c778a303a1..a492dc357bd7 100644
> --- a/arch/x86/include/uapi/asm/hyperv.h
> +++ b/arch/x86/include/uapi/asm/hyperv.h
> @@ -326,6 +326,7 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
>  #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
>  #define HV_SYNIC_SINT_MASKED		(1ULL << 16)
>  #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
> +#define HV_SYNIC_SINT_POLLING		(1ULL << 18)
>  #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
>  
>  #define HV_SYNIC_STIMER_COUNT		(4)
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 6d14f808145d..d3d866c32976 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -95,9 +95,14 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
>  			  u64 data, bool host)
>  {
>  	int vector, old_vector;
> +	bool masked, polling;
>  
>  	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
> +	masked = data & HV_SYNIC_SINT_MASKED;
> +	polling = data & HV_SYNIC_SINT_POLLING;
> +
> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR &&
> +	    !host && !masked && !polling)
>  		return 1;
>  	/*
>  	 * Guest may configure multiple SINTs to use the same vector, so

I'm not sure this is enough to implement the polling mode: per spec,

> Setting the polling bit will have the effect of unmasking an interrupt
> source, except that an actual interrupt is not generated.

However, if the guest sets a valid vector and the masked bit cleared,
we'll consider it a usual SINT and add to masks and inject interrupts,
etc, regardless of the polling bit.

I must admit I'm confused by the above quote from the spec: is the
polling bit supposed to come together with the masked bit?  If so, then
we probably should validate it here (but your logs indicate otherwise).
In general I'm missing the utility of this mode: why should an interrupt
controller be involved in polling at all?

Roman.
