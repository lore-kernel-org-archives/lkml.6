Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932330AbeB1Qsh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:48:37 -0500
Received: from mail-am5eur02hn0234.outbound.protection.outlook.com ([104.47.4.234]:45133
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752998AbeB1Qse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:48:34 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Wed, 28 Feb 2018 19:48:22 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 1/3] x86/kvm/hyper-v: add reenlightenment MSRs support
Message-ID: <20180228164822.GA12531@rkaganb.sw.ru>
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
 <20180228134401.6544-2-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228134401.6544-2-vkuznets@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0701CA0060.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::28) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bfd4d8a-b4b4-4ea8-7204-08d57ecb1683
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:8UHWP81Xk6A5/PL09FpLFZ7iCT0ZxZ2lKHdrVHihWzhT2dXcaRs6dxDXIkJ6nmrEpDKr12Q1FqQJx53q8QNJiOj836837+UGGsRu3q/kBZhyCFnt0mPjxQu8CwWtzlAfKzNdHNHC6wWEdtvvcQY3wAuDflBw0VXneUA3pNUGSBDfSIJZZuRDLVT2bjI799lpjrwGn3HEv3ZfTU1LwyxE0mPuh4MqhVBMIkYdMnBS9th4WKYiltJzf3R0npEfrSNM;25:9dR27lnP/SrkppkSBpJN7tGyOS2SHQP6qGfqVMo4nZJnWAe7FLfv+BgEPbOGVdhPYdEzAKahJi2g/c1kGSHNQUdRWTeozmH2TBcGgt/1cm0Ruq/HGrQlaOm4pK3JyzrG/H0LKgGSlEVWRkSIAI2dJa46TZbcjjv78gnmoi2tpMsFeAUECgu6hQXumrQ1/9QZhsswT6q6zBUh+4RdxRfBrBKDHR0FywYWmV+3YQ+Wh0C8IVZlUvQtHq8SXM0yVvL5l+s2jEBj2ZecZtryuOHvxriTwv2jVVkqs4b8s3R5URFKN/q/kP3nIhV9698SgiNuEl+VHoSn1M8La0+Ge3MhKg==;31:PunSkYIQhiJqW+a8y7qdlO4OhggkF/M2AcmyzeGMSzgD29ptQrMpncwfuYq81nj9rLxoxw4MOjHZIOJI6KqVk95Zcwgk2IhIGi1aK3fiCn+TLPueNU8hqQ0kRgNlI1v34O4f4C4+kfxC8NisBaKy7V4wr+wgRfBFg957LZFYdZd3Afk6HyHWmJWDWjdPFNzDNsiFjBfBrz8p1MaPZSyyBDd1citbjDNCBmZW2Ig27gc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:1qXtI8gN/mXa7WKWo7lux67LyxJYXOiWOtHNBUme6CNGRT/rdxLDWw9frVYXqGzNJguQQeKA6zeDtOlHCVhmV3uCZAHdwSGRxmI3BDAVidowgfJ5DQ9RrGF/d6gunpp9Ea8Gox6pwVJhNJiN25QQqjxMC4cT/ZVxrttrJ27wABqxElr0qIeR8bN8A101K3vYxR5RzZXqE2limgOpYxtEiERrdVjIfycJlGVerT5sWVi6IT5GwdsPbEv2nX6OvqWHj1h0HtMCQa8WQeS3kdSZsW0aWI+zSIJMgmk2oYANvBHpYHGnYKcR5kGs74Hp4GR+EUS8SbQHGSg7kL/TvOTgT0aJrc+CKSQFrxhtxwN7/vO3mG+EZZRSYftWOZRGMJuOQw6yS/eTeIIWfXDySGbiZ/W3HVV59GWS0g2w1aT3sIdBeVWzT1F9OUievEC1QaTxIZnioC/9o9fYxHE35is4izJBTVbRnC7EBVoL1xJrnoa5zzYQwMfxmA39g1XUjmBI;4:rAgMO7HA1xdRg1rGDDvU6oSKPSoIhvaep4Ry9Vh2S2vhFzCgUdIOL72yKlbFZvrRSjW1rcY6PIqlyz7m+RjYaD7veFh2h7SQNfbaPNdrOi3hXFbsY/k0ZoAU2nzIPyyEAmemH3jlhb+abszN3TfwkUMsPFWA5fg4AEdU8GKVDUp/WhMHSWHQ0LPD+kzk+iOe8A9ArNN7YJLTyXbHQZRUbEXL/4yUAna8KlP+p8+AFRVix2ur9ovsaIdFv4b6+l3gcSXWp0JwB0AIreim3vAuFg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1980D6A8D733DA605D529843C9C70@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501217)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(376002)(39850400004)(189003)(199004)(54094003)(81166006)(8676002)(81156014)(8666007)(478600001)(25786009)(106356001)(69596002)(4326008)(6506007)(107886003)(7696005)(52116002)(316002)(386003)(55236004)(59450400001)(76176011)(53936002)(26005)(5660300001)(186003)(16526019)(6246003)(16586007)(55016002)(86362001)(54906003)(229853002)(2906002)(68736007)(33656002)(6916009)(2950100002)(6666003)(23726003)(58126008)(3846002)(9686003)(105586002)(53416004)(1076002)(6116002)(50466002)(305945005)(36756003)(97736004)(66066001)(8936002)(7736002)(47776003)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:B59BpjhQAy1NQf3h3rnMlS2tnQOKyVQMbRjeg0B?=
 =?us-ascii?Q?/3hOZx4IRrwekndRfOCLd2tXqEASZc5t6+UOxSG7YyRnpxPDeAZuDl4/xLHH?=
 =?us-ascii?Q?fUPz3h1o4AYfFmFs8yo2RofrvZ3lS/b6fQSNRZqtBkHIu6uudnxOgZkNCd4+?=
 =?us-ascii?Q?co635EV9Xdrg84dz6NwHvg7kmz1Msu9yvNZfuK4Y32mzVtI0f+j/2oI43FbH?=
 =?us-ascii?Q?8AHzVyCglp8ZWHbsbWGKZlVoxY4mnwvtZkd7pzaHnPQ7DKImswi+25PFsEFj?=
 =?us-ascii?Q?iqP+TfX7J7Ah9+sGgw/ZQPErSM0BAaVGLxus3APjtYpL5rd/f/BMxplZYXkm?=
 =?us-ascii?Q?DSLFj+wjgZvrQWyYO6X42r11xRKreD45+NhhQqIBEUFBjvKDotNE5WeNZmr6?=
 =?us-ascii?Q?MK4CmkhK5qV2PoKLMFyCzwTvcPo8xnSiaL6ItdKe49V0hywZyU4BbO0gx7Kc?=
 =?us-ascii?Q?f2q+4bis3oZGJ7c/X2d92f6H8XrtOwmaU6GRpHuL5hmxj1AwBtTAUTcrq+Yh?=
 =?us-ascii?Q?CO7PtWlzfls3cEE1OZ0jN36tdTpGIoIPJHV/Wa4qw7d6JSqhwCcvcU/SnwE2?=
 =?us-ascii?Q?HQuq4cwC7zTzLTfB0VerfqCk4oHXehus26lpp3fn8nOaU225HaTN3jOLZF3/?=
 =?us-ascii?Q?L7vQkZZ1ysJn5toKT2xf0FzunCdw59EWad0iYqrk00XwxIoncbeO5n+RC/WZ?=
 =?us-ascii?Q?cjA9jIExO/iBhf+TEK5JVMz+Dcrjf3ECneMysnF81XD3RwGgRQNChSQNDJMz?=
 =?us-ascii?Q?xgKIUMNiySUBJ16y0VBcyKmwHl4MHtR8mNn4VOvrjQd3xE7+p8thKFDrQNAp?=
 =?us-ascii?Q?AIIL3rb+TtOIe5HE4Ylq3NP2FvK452GPJN1wOqFT124LCWvxEtvF7pgk83j0?=
 =?us-ascii?Q?Vxer5uPLsF+YfyI4MLFbMrZacvuDstAoZlPsNXU/6/52f44MuaL0rAGNY8tJ?=
 =?us-ascii?Q?3Ky/2tYdmd2NoaQGHwdX/jLgjk0GGSw9QT1EwGxm/UQ7DP8sQ4IcP4xQz6of?=
 =?us-ascii?Q?Zzg82+cJtZSBOqjeBe+CiPz6PS5oDo5KvjRZvBtt0eB6dV7WxgJi8SDpDjiy?=
 =?us-ascii?Q?D9kJ0cbOEtZCMKvFy10SGmm8CBO3380LPTjVa1z8slQj8zZqcPZma+GULNDE?=
 =?us-ascii?Q?eAoXWFCo3fVKhhZwgEoZtPkE23m/Kd+6yfOoEsPGOD/JnCU6OEZ/efg3F1jp?=
 =?us-ascii?Q?BE4vEMT63T8sZa5/bg/azjw2eEs51EZkhVzsL6PrS2Y3KZ1WWZGtHsMlcU2G?=
 =?us-ascii?Q?CW5fkQIaQq/bpxx7uTfGkaTF2CxsmdRF3VkIXQWKDGu50NY7fK/Nn1knUZ2U?=
 =?us-ascii?Q?9t8LEirmzu7WHSAxErbOhA2bLtBCUFsG/wCPPhnSUjm4mgJUa+CuZuMsLiJ1?=
 =?us-ascii?Q?sO6AZPMprKEcU2v8S2UxF9hnRLQrrD2GcQbJqBo0pMfjfQLIMBOGhid8MCXS?=
 =?us-ascii?Q?pjuA0ERbalA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:pZZ0JLO4r3Z28wpQoGBARdNqNnrPLIyEXycVX/wM20qSSoBYSYK7C0/OFAP5u3BGeapomWe8reAcYKdKkIA18X4gzYWU0ho0WYOsw0Z42yZ9e96uBIVXL3OW4hP1adz5+OGGMuhCLKn7+MxcKc9wSA==;6:8eUkiFvmOns0np6hkah5/1agDUaBhIkOGGcb4KUt5rQofZEfVcXk5slrszfkV4cq2GJszA9oEFPtIuwHhkqK2X4vEqsD7uQL9ei9t8o6mJI/BV0WNZF54cc94GoZqhL0We5hxRYVtJgo8E7h80DV+SvSEQHllbb5AshTfYR1oTKqopJv4hKbKC3cir8eSc/cxhZAhc2v9eCJsO/dcm+2iUdydLhx1puRqtwLRM7/1dnn3VwLdN+EFyamRB7Baph99T7e/udqTsbFSo73Ooxa48/RVqERWAOiQOdwyd5qfifRpB1/3AnutIC3xa6zDcr5xr5aIW7sGwhaRcE8gMnpFgsyrhQBhcc6OMnSLR9Ds9I=;5:NMYu6QFxr2Qj0yrLc96Isq0od2UOTLomPlcxUpcc0fwnFbGi9s8vheUPM7I0+heZtSYvA1TBRUcemBe67eXLUtebASYQOSMl4XSTasCpiR/DfXSikIrLGMJs1D4i5CZoOrluIuulvLJwzrfDz2GcpX2t9VqAA+pgR83jhB/HY5Q=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:nVMF1tkRJblsH9olPyCDjZAuuOdIDFgNeKcoex5q5MpEHJ1dUPvmgLndYFSVqaBpMiKlsQ3XmnkhrqW/7A6pOGwiTHoDBziuU/wG7pjgT91CWqOfqmKvXW2zMG92EgeSa/sxC7NHyVKmgDfnpMlyL8sW1PHVuk2xSzqEriu0kA0dO8GVnnr7zDDoU/MbfFVr3igRJ5OsBBJeo4yRA7q8yUoF8FcxMBmUmJT3QfvvRQHw3Qucfth5sekOsOTPnWbr;20:gpr7ixWdWvTlPSnHo9is4ctRauDHRv/kfY/WmbMQIkTeYwqcl/E2yRI4UGyq2ykhQwvdPZA2ieKqG7H5jDyPyAHTMuikuGGNGhtMSAIlk51UwQk2kfRKl8L4sBCzJCo3Q0sd4sCY0Y3fSuDWHQmL36UACBSmY5/+RIFYgaLA6MM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 16:48:26.0217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfd4d8a-b4b4-4ea8-7204-08d57ecb1683
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:43:59PM +0100, Vitaly Kuznetsov wrote:
> Nested Hyper-V/Windows guest running on top of KVM will use TSC page
> clocksource in two cases:
> - L0 exposes invariant TSC (CPUID.80000007H:EDX[8]).
> - L0 provides Hyper-V Reenlightenment support (CPUID.40000003H:EAX[13]).
> 
> Exposing invariant TSC effectively blocks migration to hosts with different
> TSC frequencies,

I wonder if TSC scaling on the destination host doesn't allow to relax
this requirement?

> providing reenlightenment support will be needed when we
> start migrating nested workloads.
> 
> Implement rudimentary support for reenlightenment MSRs. For now, these are
> just read/write MSRs with no effect.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  4 ++++
>  arch/x86/kvm/hyperv.c           | 21 +++++++++++++++++++++
>  arch/x86/kvm/x86.c              | 12 +++++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
