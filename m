Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935630AbeEJAdS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:33:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34028 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934395AbeEJAdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:33:16 -0400
X-Google-Smtp-Source: AB8JxZpu7C0h4VqjMg6e6QssAjD7sGKFtwjBJC8m9HNKDY4nh9mWJgu4RmtGSl8MccsRoePeeJG8iw==
Date: Wed, 9 May 2018 17:33:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Simonov <nicksimonovv@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: fix coding style issues in input.c
Message-ID: <20180510003313.GD91762@dtor-ws>
References: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525874834-20432-1-git-send-email-nicksimonovv@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi NIck,

On Wed, May 09, 2018 at 05:07:14PM +0300, Nick Simonov wrote:
> This is a patch to the input.c file that fixes
> up warning found by checkpatch.pl tool
> 
> Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> ---
>  drivers/input/input.c | 52 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 9785546..e18fdae 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * The input core
>   *
> @@ -252,7 +253,8 @@ static int input_handle_abs_event(struct input_dev *dev,
>  	}
>  
>  	/* Flush pending "slot" event */
> -	if (is_mt_event && mt && mt->slot != input_abs_get_val(dev, ABS_MT_SLOT)) {
> +	if (is_mt_event && mt && mt->slot !=
> +		input_abs_get_val(dev, ABS_MT_SLOT)) {
>  		input_abs_set_val(dev, ABS_MT_SLOT, mt->slot);

So now it is not immediately clear what is part of condition and what is
part of body.

I am sorry to say, but with most of these changes the cure is worse than
the disease. If you were fixing the code and adjusted the affected lines
so they are under 80 columns limit that would be one thing, but just
reformatting for the sake of it is not really helpful.

Thanks.

-- 
Dmitry
