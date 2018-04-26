Return-Path: <linus.walleij@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524742442; cv=none;
        d=google.com; s=arc-20160816;
        b=rYfbBolUotP8fUKvUyP1SNqasWX1vXtjCm/nhq2FbYOVPsgxP3nGhqBn1ljw6eJ4jg
         yqUR1tK/JvzVUUZO3ZCoRkPFqnbwkzQEU+hgD+t6gnm9JnEVfv2WIPQLQ+HAOanadv9X
         cBO3MaBiQAl40zMjPrA93tiHvRHge8X3tzPuEUYhkwzDxrbjLcRQsJYuk2JhOh6tmW3T
         qyCEb+VdfJ5TKyrzNK8mGRmEuJxzSlSfdXFDsk2R/+g9xN8KMK78s+Rd3hcRNMaIHuTl
         yYID05y2vdix4+xAy8g0IyeSwXRTJNYpQpUTEIbAGZKlb+KGV+KO8v5HB0LqusLdVg3F
         RTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/qLxIa2sqlph3qKRu2+kYBcOlb+i8VerU29oCIHtZVw=;
        b=nGWm+uKc7NCDQJjzEADHVoPIIharqqmHhogUUyqPkKS7v5cw7+rzMOi/o+NfANZGqA
         4qvAHCx5iTXHYWyiA1q14YvDrWe9EAWyj+5xAzSDjxuzimzV7piO9BjgxqTY8sVnpNML
         n8B/Ga6DVAkhfSOc7H3BsYphBRkof+KA34RqD/Av8Kg2FJrlTQXSYQs2A/ZzQfSi1dMw
         +ffGdzpPfNNeJj+EGLWcizjdf2mU4SyRpKoVCi0BMBcxzqJ5NJk41bsi5rlVOCN9xoAx
         sLOWnQXtbMWfzkKFkZZnSk99bH+VjW4/zsDV/p1Hw1PYLDsFjytVPAkOQHW/Z/69+Kjp
         wA7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kywneH3g;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kywneH3g;
       spf=pass (google.com: domain of linus.walleij@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus.walleij@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpolF9eALcMfyaRkCBpi7hLAlaoeUmqqW8bF51fxEH4/R5LtIZMBbSK0uagh9w3lNgoeFWlXr+ZoYUMrT4jDYA=
MIME-Version: 1.0
In-Reply-To: <20180407175802.29444-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180407175802.29444-1-ctatlor97@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 13:34:00 +0200
Message-ID: <CACRpkdZGtD4dP9UzVsb_peRGjdB6nfzUy79Ep-Su6ZEeWKw=ig@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
To: Craig Tatlor <ctatlor97@gmail.com>, Antonio Ospite <ospite@studenti.unina.it>,
	Hans Verkuil <hans.verkuil@cisco.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1598808331152090613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 7, 2018 at 7:57 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

Hi Craig! Thanks for your patch!

> This patch adds a driver for the BMS (Battery Monitoring System)
> block of the PM8941 PMIC, it uses a lookup table defined in the
> device tree to generate a capacity from the BMS supplied OCV, it
> then ammends the coulomb counter to that to increase the accuracy
> of the estimated capacity.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Just some minor remarks.

NB: I see that you are writing from a private email address
so if you're working as a hobbyist on your precious sparetime
I have lower expectation on how much work you will put into
this, so see it more as suggestions than demands.

My overall feedback is that for algorithmic charger what
we need is infrastructure. What is currently piling up in
drivers/power/supply scares me a bit in it's lack of
framework and code reuse.

It also scares me because this is vital technology dealing
with physical devices and as such really need to have
modularized reusable reviewed code with several users
and deployments.

Code reuse would include:

- Mathematical helpers such as interpolation of
  values from absolute values or tables
  Suggestions below!
- State machines and transitions
- CC/CV alorithms (using the above)
- Many other things

Not that *I* can make the situation much better, I'm just
sharing my fears,

> +static s64 sign_extend_s36(uint64_t raw)
> +{
> +       raw = raw & CC_36_BIT_MASK;
> +
> +       return (raw >> 35) == 0LL ?
> +               raw : (SIGN_EXTEND_36_TO_64_MASK | raw);
> +}

#include <linux/bitops.h>

Use sign_extend32()

> +static unsigned int interpolate(int y0, int x0, int y1, int x1, int x)
> +{
> +       if (y0 == y1 || x == x0)
> +               return y0;
> +       if (x1 == x0 || x == x1)
> +               return y1;
> +
> +       return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
> +}
> +
> +static unsigned int between(int left, int right, int val)
> +{
> +       if (left <= val && val <= right)
> +               return 1;
> +
> +       return 0;
> +}

How are these things not library functions?

Every cell of my brain says this code should be reusable.

Can you put this in <linux/fixp-arith.h>?

I bet a million to one that the video people will sooner or later
need linear interpolation and there are more users in the kernel
than drivers/power/, certainly drivers/iio as well.

If noone else says anything I vote to put at least the linear
interpolation into <linux/fixp-arith.h> with a bonus if you
move some of the current users in drivers/power over
while you're at it.

> +static unsigned int interpolate_capacity(int temp, u16 ocv,
> +                               struct bms_ocv_lut ocv_lut)
> +{
> +       unsigned int pcj_minus_one = 0, pcj = 0;
> +       int i, j;
> +
> +       for (j = 0; j < TEMPERATURE_COLS; j++)
> +               if (temp <= ocv_lut.temp_legend[j])
> +                       break;
> +
> +       if (ocv >= ocv_lut.lut[0][j])
> +               return ocv_lut.capacity_legend[0];
> +
> +       if (ocv <= ocv_lut.lut[ocv_lut.rows - 1][j - 1])
> +               return ocv_lut.capacity_legend[ocv_lut.rows - 1];
> +
> +       for (i = 0; i < ocv_lut.rows - 1; i++) {
> +               if (pcj == 0 && between(ocv_lut.lut[i][j],
> +                                       ocv_lut.lut[i+1][j], ocv))
> +                       pcj = interpolate(ocv_lut.capacity_legend[i],
> +                                         ocv_lut.lut[i][j],
> +                                         ocv_lut.capacity_legend[i + 1],
> +                                         ocv_lut.lut[i+1][j],
> +                                         ocv);
> +
> +               if (pcj_minus_one == 0 && between(ocv_lut.lut[i][j-1],
> +                                                 ocv_lut.lut[i+1][j-1], ocv))
> +                       pcj_minus_one = interpolate(ocv_lut.capacity_legend[i],
> +                                                   ocv_lut.lut[i][j-1],
> +                                                   ocv_lut.capacity_legend[i + 1],
> +                                                   ocv_lut.lut[i+1][j-1],
> +                                                   ocv);
> +
> +               if (pcj && pcj_minus_one)
> +                       return interpolate(pcj_minus_one,
> +                                          ocv_lut.temp_legend[j-1],
> +                                          pcj,
> +                                          ocv_lut.temp_legend[j],
> +                                          temp);
> +       }

This code really needs some comments to tell what is going on
here. Also I sense that you can break out a smaller function
for interpolation based on table values, such as a function
that would take a standard format of tables, look up where we
are in that table and interpolate from the neighboring values.

People can then later go in and refine the algorithms if they
e.g. want to introduce spline or RMS interpolation instead
and we can get better interpolation for everybody.

> +static unsigned long interpolate_fcc(int temp, struct bms_fcc_lut fcc_lut)
> +{
> +       int i, fcc_mv;
> +
> +       for (i = 0; i < TEMPERATURE_COLS; i++)
> +               if (temp <= fcc_lut.temp_legend[i])
> +                       break;
> +
> +       fcc_mv = interpolate(fcc_lut.lut[i - 1],
> +                            fcc_lut.temp_legend[i - 1],
> +                            fcc_lut.lut[i],
> +                            fcc_lut.temp_legend[i],
> +                            temp);
> +
> +       return fcc_mv * 10000;
> +}

So then only this would really remain: pass a table and interpolate.

> +static int bms_lock_output_data(struct bms_device_info *di)
> +{
> +       int ret;
> +
> +       ret = regmap_update_bits(di->regmap, di->base_addr +
> +                                REG_BMS_CC_DATA_CTL,
> +                                BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
> +       if (ret < 0) {
> +               dev_err(di->dev, "failed to lock bms output: %d", ret);
> +               return ret;
> +       }

Reuse of regmap is very nice, thanks for doing it this way.

> +static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
> +static void bms_reset_cc(struct bms_device_info *di)

These indeed need to be mostly hardware-specific so they
are fine.

> +static int bms_calculate_capacity(struct bms_device_info *di, int *capacity)
> +{
> +       unsigned long ocv_capacity, fcc;
> +       int ret, temp, temp_degc;
> +       s64 cc, capacity_nodiv;
> +
> +       ret = iio_read_channel_raw(di->adc, &temp);
> +       if (ret < 0) {
> +               dev_err(di->dev, "failed to read temperature: %d", ret);
> +               return ret;
> +       }

Very nice that you use IIO ADC as a back-end.

> +       temp_degc = (temp + 500) / 1000;

That deserves a comment I think. Like what the manual
says about this and why the raw temperature is given
like this.

Maybe you want to use DIV_ROUND_CLOSEST()
or DIV_ROUND_UP() from <linux/kernel.h> instead
of just "/"?

Maybe you want to use that in other places too like
the below divisions.

> +       ret = bms_read_cc(di, &cc);
> +       if (ret < 0) {
> +               dev_err(di->dev, "failed to read coulomb counter: %d", ret);
> +               return ret;
> +       }
> +
> +       ocv_capacity = interpolate_capacity(temp_degc, (di->ocv + 5) / 10,
> +                                           di->ocv_lut);
> +       fcc = interpolate_fcc(temp_degc, di->fcc_lut);
> +
> +       capacity_nodiv = ((fcc * ocv_capacity) / 100 - cc) * 100;
> +       *capacity = div64_ul(capacity_nodiv, fcc);

So I guess you fit the capacity between 0..100, please
add some comment on what's going on here.

> +static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
> +{
> +       struct bms_device_info *di = dev_id;
> +
> +       if (bms_read_ocv(di, &di->ocv) < 0)
> +               return IRQ_HANDLED;
> +
> +       bms_reset_cc(di);
> +       return IRQ_HANDLED;
> +}

So that is a coloumb counter interrupt? Please add some
comment on when this gets called. Is it called whenever
a coloumb is added/removed from the battery?

> +       ret = of_property_read_u8_array(di->dev->of_node,
> +                                                "qcom,ocv-temp-legend",
> +                                                (u8 *)di->ocv_lut.temp_legend,
> +                                                TEMPERATURE_COLS);
> +       if (ret < 0) {
> +               dev_err(di->dev, "no ocv temperature legend found");
> +               return ret;
> +       }
> +
> +       di->ocv_lut.rows = of_property_read_variable_u8_array(di->dev->of_node,
> +                                                "qcom,ocv-capacity-legend",
> +                                                di->ocv_lut.capacity_legend, 0,
> +                                                MAX_CAPACITY_ROWS);
> +       if (di->ocv_lut.rows < 0) {
> +               dev_err(di->dev, "no ocv capacity legend found");
> +               return ret;
> +       }
> +
> +       ret = of_property_read_variable_u16_array(di->dev->of_node,
> +                                                 "qcom,ocv-lut",
> +                                                 (u16 *)di->ocv_lut.lut,
> +                                                 TEMPERATURE_COLS,
> +                                                 TEMPERATURE_COLS *
> +                                                 MAX_CAPACITY_ROWS);
> +       if (ret < 0) {
> +               dev_err(di->dev, "no ocv lut array found");
> +               return ret;
> +       }
> +
> +       ret = of_property_read_u8_array(di->dev->of_node,
> +                                                "qcom,fcc-temp-legend",
> +                                                (u8 *)di->fcc_lut.temp_legend,
> +                                                TEMPERATURE_COLS);
> +       if (ret < 0) {
> +               dev_err(di->dev, "no fcc temperature legend found");
> +               return ret;
> +       }
> +
> +       ret = of_property_read_u16_array(di->dev->of_node,
> +                                                 "qcom,fcc-lut",
> +                                                 di->fcc_lut.lut,
> +                                                 TEMPERATURE_COLS);
> +       if (ret < 0) {
> +               dev_err(di->dev, "no fcc lut array found");
> +               return ret;
> +       }

These tables (that I also suggest to use libraries to parse)
should probably have standardized DT names so other
battery drivers can use the same properties and we can
use the same DT parsing code for all.

> +       ret = bms_read_ocv(di, &di->ocv);
> +       if (ret < 0) {
> +               dev_err(di->dev, "failed to read initial ocv: %d", ret);
> +               return ret;
> +       }

OCV = original coloumb counter value?

Please expand the acronym somewhere because I get
a bit lost.

Overall it is a very nicely coded driver. My worries are
all about code reuse, not code quality per se.

Yours,
Linus Walleij
