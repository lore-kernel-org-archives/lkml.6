Return-Path: <kernel-hardening-return-12244-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsPr5eW/YXOiWG5CpiPcWH95Y3gN/j0RmSTsJifLMUJtYn+elcSpt0VwbfvQKQBAl4MePN/
ARC-Seal: i=1; a=rsa-sha256; t=1520531957; cv=none;
        d=google.com; s=arc-20160816;
        b=btQ+DPmJvo3c/2Bc2xo44OpsXFz9q5YTQ9owpcSjkdHSdwuET8M2JW/MYazNVaMF7q
         mOIhpTTAeaE/BlIgDd7ea3CpW4x9VGCSTca7jiRn9IzlZJs52jjANz+tuSewylesW8KV
         fT6INfOVvNhJ/50SXFAvhdit4pjvtN2SpN2YgIilQtlQsCvOlYhu18uSW3YVwmTxXpwf
         9FLI0RPzjYhrVzDkhcOC2oFIjlqtbG403iDVczl77KVqTLoE6NSn6OaHYSfmm77C6ccM
         qo78U9wV2jdYz7G8UD+zvWQ1A7hSr1ks4gDDAUjmWjjfH/U9MbM/srB4OES8nMO4Crxs
         G4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=pi1cO5ef8UnCpzwfA61Vrnr7U4/0iZKYI9PHgG54FJc=;
        b=FUji06TUAcy9bzhJ3WsD3MCnZhdA98KpvXsU1VJO5N8Via8TA1SGb4mMJYod1Ggerw
         IUHLweJ7l7DcAMn4QmeXu7ZMzWi5sGPXlJgnUvQr0JVavML3OiqNZdXXCaqsd9dh/jr9
         kIOpJJ0S/6ZVA1YhlebQHNoOBqh2/uLauyVZyKFgED4rDgqYHRkFV1ErA2ZLHVixPhoy
         OOWONkUC9dauO3kD1ANARp8lnZAEtHTd17QNG6XrhupkR7is0YyjJqd7qQXZLVMD4nG0
         p15/CDQqAwIftVn+t7Hch4Iy8XF4vS+Q4T3uJWWwJlQcNxW8ER7Si1N0g/ZzQViN2vf8
         6bHg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=O0ZBVJCe;
       dkim=pass header.i=@chromium.org header.s=google header.b=iCj9/bld;
       spf=pass (google.com: domain of kernel-hardening-return-12244-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12244-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=O0ZBVJCe;
       dkim=pass header.i=@chromium.org header.s=google header.b=iCj9/bld;
       spf=pass (google.com: domain of kernel-hardening-return-12244-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12244-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180308172031.GA14541@embeddedgus>
References: <20180308172031.GA14541@embeddedgus>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 09:58:57 -0800
X-Google-Sender-Auth: NlRGX7Sb5KGopYr9Kx4SlaDz8Os
Message-ID: <CAGXu5jLjKcYOPxQOV6GO1oaLj1M_K=cFu-kHLLEzP=ZOXaAtfA@mail.gmail.com>
Subject: Re: [PATCH] rtc: s5m: Remove VLA usage
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594390903982064564?=
X-GMAIL-MSGID: =?utf-8?q?1594393317289449107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 9:20 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them
> with fixed-length arrays instead.
>
> From a security viewpoint, the use of Variable Length Arrays can be
> a vector for stack overflow attacks. Also, in general, as the code
> evolves it is easy to lose track of how big a VLA can get. Thus, we
> can end up having segfaults that are hard to debug.
>
> Also, fixed as part of the directive to remove all VLAs from
> the kernel: https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/rtc/rtc-s5m.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index 6deae10..2b5f4f7 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -38,6 +38,9 @@
>   */
>  #define UDR_READ_RETRY_CNT     5
>
> +/* Maximum number of registers for setting time/alarm0/alarm1 */
> +#define MAX_NUM_TIME_REGS      8

I would adjust the various const struct s5m_rtc_reg_config's
.regs_count to be represented by this new define, so the stack and the
structures stay in sync. Something like:

static const struct s5m_rtc_reg_config s2mps13_rtc_regs = {
        .regs_count             = MAX_NUM_TIME_REGS - 1,

?

-Kees

> +
>  /*
>   * Registers used by the driver which are different between chipsets.
>   *
> @@ -367,7 +370,7 @@ static void s5m8763_tm_to_data(struct rtc_time *tm, u8 *data)
>  static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>         struct s5m_rtc_info *info = dev_get_drvdata(dev);
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         int ret;
>
>         if (info->regs->read_time_udr_mask) {
> @@ -413,7 +416,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>         struct s5m_rtc_info *info = dev_get_drvdata(dev);
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         int ret = 0;
>
>         switch (info->device_type) {
> @@ -450,7 +453,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>         struct s5m_rtc_info *info = dev_get_drvdata(dev);
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         unsigned int val;
>         int ret, i;
>
> @@ -500,7 +503,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>
>  static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>  {
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         int ret, i;
>         struct rtc_time tm;
>
> @@ -545,7 +548,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>  static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>  {
>         int ret;
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         u8 alarm0_conf;
>         struct rtc_time tm;
>
> @@ -598,7 +601,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>  static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
>         struct s5m_rtc_info *info = dev_get_drvdata(dev);
> -       u8 data[info->regs->regs_count];
> +       u8 data[MAX_NUM_TIME_REGS];
>         int ret;
>
>         switch (info->device_type) {
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
