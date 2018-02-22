Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeBVBxb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 20:53:31 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33300 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeBVBx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 20:53:29 -0500
X-Google-Smtp-Source: AH8x227ggWyqAfavzY6n1DVAnEvd1CXyrZsX6aGzFD6z7kMR2qbTuQZ+4zuZyufbdGgy5PJSFq6d3dt2ZVnmQfGqds4=
MIME-Version: 1.0
In-Reply-To: <20180221205635.31314-67-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com> <20180221205635.31314-67-alexandre.belloni@bootlin.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 22 Feb 2018 09:53:29 +0800
Message-ID: <CAMz4kuL755sihR_GcNOYBweogXxFAFkNHDmuk6UBV4_5K-cFqA@mail.gmail.com>
Subject: Re: [PATCH 066/100] rtc: sc27xx: stop validating rtc_time in .read_time
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On 22 February 2018 at 04:56, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> rtc_time64_to_tm never generates an invalid tm. It is not necessary to
> validate it. Also, the RTC core is always calling rtc_valid_tm after the
> read_time callback.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks for fixing this, and please add my tag if it helps.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/rtc/rtc-sc27xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
> index d544d5268757..00d87d138984 100644
> --- a/drivers/rtc/rtc-sc27xx.c
> +++ b/drivers/rtc/rtc-sc27xx.c
> @@ -376,7 +376,7 @@ static int sprd_rtc_read_time(struct device *dev, struct rtc_time *tm)
>                 return ret;
>
>         rtc_time64_to_tm(secs, tm);
> -       return rtc_valid_tm(tm);
> +       return 0;
>  }
>
>  static int sprd_rtc_set_time(struct device *dev, struct rtc_time *tm)
> --
> 2.16.1
>



-- 
Baolin.wang
Best Regards
