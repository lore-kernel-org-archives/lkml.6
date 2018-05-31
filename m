Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932690AbeEaDPS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:15:18 -0400
Received: from [180.169.226.26] ([180.169.226.26]:60616 "EHLO mail.iauto.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932527AbeEaDPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:15:15 -0400
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Thu May 31 11:15:13 2018
X-DSPAM-Confidence: 0.8525
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 1,5b0f68c112001188614662
X-Spam-Flag: NO
X-Spam-Score: -2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ANDROID: binder: rename parameter to resolve name
 collision.
From: kuangrufan@iauto.com
In-Reply-To: <CAHRSSEySzqTb-m5Rjv23PuUHi2q4OY485JJjFi1AeLiKL1KJQQ@mail.gmail.com>
Date: Thu, 31 May 2018 11:15:12 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <67F0DCCC-BBC5-4B7B-9FC4-1BD83D247DAA@iauto.com>
References: <20180530045814.49504-1-kuangrufan@iauto.com>
 <CAHRSSEySzqTb-m5Rjv23PuUHi2q4OY485JJjFi1AeLiKL1KJQQ@mail.gmail.com>
To: Todd Kjos <tkjos@google.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is this needed? These don't collide in the namespace:
Sorry, I check it again, you’re right. my bad.

PS:
I need to change the binder API between 32bit & 64bit dynamically.
So I was trying to compile binder as a “.ko”. I compiled the 2
files into the same kernel module, which causes problem.

Best Regards,

> 在 2018年5月30日，下午11:54，Todd Kjos <tkjos@google.com> 写道：
> 
> Why is this needed? These don't collide in the namespace:
> 
> /sys/module/binder/parameters/debug_mask
> 
> and
> 
> /sys/module/binder_alloc/parameters/debug_mask.
> 
> On Tue, May 29, 2018 at 9:58 PM <kuangrufan@iauto.com> wrote:
> From: Kuang Rufan <kuangrufan@iauto.com>
> 
> both bind.c & binder_alloc.c define the same kernel parameter 'debug_mask',
> rename the one in binder_alloc.c to 'alloc_debug_mask'.
> 
> Signed-off-by: Kuang Rufan <kuangrufan@iauto.com>
> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5a426c877dfb..3850dab493d4 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -42,7 +42,7 @@ enum {
>  };
>  static uint32_t binder_alloc_debug_mask;
> 
> -module_param_named(debug_mask, binder_alloc_debug_mask,
> +module_param_named(alloc_debug_mask, binder_alloc_debug_mask,
>                    uint, 0644);
> 
>  #define binder_alloc_debug(mask, x...) \
> -- 
> 2.15.1 (Apple Git-101)
> 
