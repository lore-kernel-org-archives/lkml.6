Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519913352; cv=none;
        d=google.com; s=arc-20160816;
        b=rW1VUOrxSsRN7XsGVZEDa+5/qP20I3jPQGOD0+/IyCKkKLw8HBMkRHtQWrARDobT8u
         Ddq1Ezf4mcxmG2kIcquyPMfSdY2YBwyJW/KnVhp5mcKg4aP8vLxhv21UlAaq7uzrjBve
         lc7nI4s506tByZRaeaTqaEY8iNdleHsMiawMfnkp9Tce5EfU312iI9b7AnGHEBLAMaS8
         FhKxZyn3j7DN1LMsg3fyBbwoW5cbaXpHmahyOJ3BQiO3ZB15y8V5VyCUUcHEzwevu/T1
         x2AUjv1SITvVL1Ga72X/8cQASOju6/CCR0qJmzKaTSF7oj5MRredTSehP/BsFN0oXhxZ
         xsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=QGV2G70jIcnbqdL7c6iVjthWYS2gKsjvDRl5ydpxGbY=;
        b=JIsA0pSKQ7eXYGigdLnGfrnyH6ocyucLa/K8RLrYb39CYPU5fEkrI5Hmyiso42hJP/
         CEUsr9tUy9mVGKsOOtBPcjUp2cmlEKowl4lmG/0ubHJTsxLAw1xym6ruKHlJeprGOMy8
         9brjn59AxwqSh9XZCtDOhbta2e73h2y2aeuKDxLVk9Fe/8YJH5k6ghEVifbiI4Ty5vvc
         pLBsOSKGBU4w/jepUoqtg3RHDlAuL3lIslgFcummmmD/NwA5T3Lxks/1KSBQNS37Eprc
         Q1SQT2i+f02uW7RL8y1KYYd3HRtx7exU6vCIa2hBnHCEWD1FXIycsj46g0qtct6Z8WYt
         wVzA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=okMAAuiM;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=okMAAuiM;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsatQ9cLgtKNALChy1qukCIxzCd6a2DvN8joydf2RLjrIbDtBnYOUt9/rUaSPOoaXTmCIh+SanefgKb4j3XADI=
MIME-Version: 1.0
In-Reply-To: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com> <1519154467-2896-4-git-send-email-jollys@xilinx.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 16:09:11 +0200
Message-ID: <CAHp75VdqDupw3E6qVj6awHJf0JrT3f7UGbO3YAeWM9Yzg-HE=w@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
To: Jolly Shah <jolly.shah@xilinx.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matt Fleming <matt@codeblueprint.co.uk>,
	Sudeep Holla <sudeep.holla@arm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, rajanv@xilinx.com,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>,
	Jolly Shah <jollys@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948932748631222?=
X-GMAIL-MSGID: =?utf-8?q?1593744663303173323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 9:21 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> Add Firmware-ggs sysfs interface which provides read/write
> interface to global storage registers.

> +#include <linux/compiler.h>
> +#include <linux/of.h>

> +#include <linux/init.h>
> +#include <linux/module.h>

You need to leave one of them.

> +#include <linux/uaccess.h>
> +#include <linux/slab.h>

> +#include <linux/firmware/xilinx/zynqmp/firmware.h>

Keep it in order? Or add an empty line before?

> +       return sprintf(buf, "0x%x\n", ret_payload[1]);

Hmm... No leading zeroes?

> +static ssize_t write_register(const char *buf, size_t count, u32 read_ioctl,
> +                             u32 write_ioctl, u32 reg)
> +{
> +       char *kern_buff, *inbuf, *tok;
> +       long mask, value;
> +       int ret;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return -EFAULT;

> +       kern_buff = kzalloc(count, GFP_KERNEL);
> +       if (!kern_buff)
> +               return -ENOMEM;
> +
> +       ret = strlcpy(kern_buff, buf, count);
> +       if (ret < 0) {
> +               ret = -EFAULT;
> +               goto err;
> +       }

kstrndup()

> +
> +       inbuf = kern_buff;
> +
> +       /* Read the write mask */
> +       tok = strsep(&inbuf, " ");
> +       if (!tok) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       ret = kstrtol(tok, 16, &mask);
> +       if (ret) {

> +               ret = -EFAULT;

Why to shadow an error?

> +               goto err;
> +       }
> +
> +       /* Read the write value */
> +       tok = strsep(&inbuf, " ");
> +       if (!tok) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       ret = kstrtol(tok, 16, &value);
> +       if (ret) {

> +               ret = -EFAULT;

Ditto.

> +               goto err;
> +       }
> +
> +       ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
> +       if (ret) {

> +               ret = -EFAULT;

Ditto.

> +               goto err;
> +       }

> +       ret_payload[1] &= ~mask;
> +       value &= mask;
> +       value |= ret_payload[1];

Also canonical one to write in one line:

      value = (value & mask) | (ret_payload[1] & ~mask);

> +
> +       ret = eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
> +       if (ret)

> +               ret = -EFAULT;

Why to shadow an error?

> +
> +err:
> +       kfree(kern_buff);


> +       if (ret)
> +               return ret;
> +
> +       return count;

return ret ? ret : count;

> +}

-- 
With Best Regards,
Andy Shevchenko
