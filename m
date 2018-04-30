Return-Path: <ctatlor97@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525111597; cv=none;
        d=google.com; s=arc-20160816;
        b=L3PkOeKWcYGcw3jI360SqdUDb5HY2MW/X5u+d31ixnjsANoaTjG/0YKj3kU9OqsQyX
         w12NyvBeBg/3VEU/1BkEx+nkc1fhbI7qrb9+yDQvB6cwIDeySFnW5HUwI2vy/d57g/x6
         Z5/i861/srqYT4bxs1SQDp6OAo2QoNVpDe14xyrV5g/TQrm+9OO1Nc4axqZFp6tFL61S
         z5HAhj8MYjdSTHaS6TmflvWHtA+XL+Lyb1W+2VDLCxy/G1RHf2auy/2P7+iyfIwTJEyB
         hfPGGQEgv8cBhC/54pVOuFzQg8JZyshGucvUQxFrCvBqnQ6mTpU/MXGJ99aYsHkFfkt1
         qbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=BkU+4XMk3JF1FsAAJuLXzgNfAJlQoT3MtUk8B+Eth+A=;
        b=q1lJh85dyP3F9H8C+WVIbd2g4+VI3bBqK1QiII6g7lbwsF8AA5SIPvNG1jjKphfNTP
         CnV7hQ7MYZQ5SuyBncosAHtKbVto1napvHk2QiPf9rkqe9MbAMs5Qwcpr0WAKG8lxgSI
         l8cclq4jynmBvoCVtCOTUi7J+hADhWvqmabuIphOUra+O5W9O/KEazdKsy3r9v/KdmUI
         MJiglWAMU27vxNcHS7tLTf61a6461h501FOGNSFw1ZbFwc3OlQ3kGtir/QyJpCDpclkn
         5MI9PvgCTVFrVB9XHfuCgYVGHKwH5cRJNKVlbrE/LrPo94uRXe0LhF8uHP36fpBPq4DP
         P75A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K5+720CL;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K5+720CL;
       spf=pass (google.com: domain of ctatlor97@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ctatlor97@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqGe7b0kYIoVzyRVdRuskLU6SZZnEMxfpG5iSZ3KYQYjEiZRHf0G8GMjE6afYIOjd/eXnj93A==
Date: Mon, 30 Apr 2018 19:06:20 +0100
From: Craig Tatlor <ctatlor97@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-arm-msm@vger.kernel.org,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] power: supply: Add support for the Qualcomm
 Battery Monitoring System
Message-ID: <20180430180620.GA4411@arch>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180407175802.29444-1-ctatlor97@gmail.com>
 <CACRpkdZGtD4dP9UzVsb_peRGjdB6nfzUy79Ep-Su6ZEeWKw=ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZGtD4dP9UzVsb_peRGjdB6nfzUy79Ep-Su6ZEeWKw=ig@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597095374964030475?=
X-GMAIL-MSGID: =?utf-8?q?1599195418043261880?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thanks for review, replies inline.

On Thu, Apr 26, 2018 at 01:34:00PM +0200, Linus Walleij wrote:
> On Sat, Apr 7, 2018 at 7:57 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:
> 
> Hi Craig! Thanks for your patch!
> 
> > This patch adds a driver for the BMS (Battery Monitoring System)
> > block of the PM8941 PMIC, it uses a lookup table defined in the
> > device tree to generate a capacity from the BMS supplied OCV, it
> > then ammends the coulomb counter to that to increase the accuracy
> > of the estimated capacity.
> >
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> 
> Just some minor remarks.
> 
> NB: I see that you are writing from a private email address
> so if you're working as a hobbyist on your precious sparetime
> I have lower expectation on how much work you will put into
> this, so see it more as suggestions than demands.
Yeah, I am a just hobbyist :)
> 
> My overall feedback is that for algorithmic charger what
> we need is infrastructure. What is currently piling up in
> drivers/power/supply scares me a bit in it's lack of
> framework and code reuse.
> 
> It also scares me because this is vital technology dealing
> with physical devices and as such really need to have
> modularized reusable reviewed code with several users
> and deployments.
> 
> Code reuse would include:
> 
> - Mathematical helpers such as interpolation of
>   values from absolute values or tables
>   Suggestions below!
> - State machines and transitions
> - CC/CV alorithms (using the above)
> - Many other things
> 
> Not that *I* can make the situation much better, I'm just
> sharing my fears,
> 
> > +static s64 sign_extend_s36(uint64_t raw)
> > +{
> > +       raw = raw & CC_36_BIT_MASK;
> > +
> > +       return (raw >> 35) == 0LL ?
> > +               raw : (SIGN_EXTEND_36_TO_64_MASK | raw);
> > +}
> 
> #include <linux/bitops.h>
> 
> Use sign_extend32()
Right.
> 
> > +static unsigned int interpolate(int y0, int x0, int y1, int x1, int x)
> > +{
> > +       if (y0 == y1 || x == x0)
> > +               return y0;
> > +       if (x1 == x0 || x == x1)
> > +               return y1;
> > +
> > +       return y0 + ((y1 - y0) * (x - x0) / (x1 - x0));
> > +}
> > +
> > +static unsigned int between(int left, int right, int val)
> > +{
> > +       if (left <= val && val <= right)
> > +               return 1;
> > +
> > +       return 0;
> > +}
> 
> How are these things not library functions?
> 
> Every cell of my brain says this code should be reusable.
> 
> Can you put this in <linux/fixp-arith.h>?
> 
> I bet a million to one that the video people will sooner or later
> need linear interpolation and there are more users in the kernel
> than drivers/power/, certainly drivers/iio as well.
> 
> If noone else says anything I vote to put at least the linear
> interpolation into <linux/fixp-arith.h> with a bonus if you
> move some of the current users in drivers/power over
> while you're at it.
I was pretty surprised there wasn't a library function for it
aswell, i will add it there. 
> 
> > +static unsigned int interpolate_capacity(int temp, u16 ocv,
> > +                               struct bms_ocv_lut ocv_lut)
> > +{
> > +       unsigned int pcj_minus_one = 0, pcj = 0;
> > +       int i, j;
> > +
> > +       for (j = 0; j < TEMPERATURE_COLS; j++)
> > +               if (temp <= ocv_lut.temp_legend[j])
> > +                       break;
> > +
> > +       if (ocv >= ocv_lut.lut[0][j])
> > +               return ocv_lut.capacity_legend[0];
> > +
> > +       if (ocv <= ocv_lut.lut[ocv_lut.rows - 1][j - 1])
> > +               return ocv_lut.capacity_legend[ocv_lut.rows - 1];
> > +
> > +       for (i = 0; i < ocv_lut.rows - 1; i++) {
> > +               if (pcj == 0 && between(ocv_lut.lut[i][j],
> > +                                       ocv_lut.lut[i+1][j], ocv))
> > +                       pcj = interpolate(ocv_lut.capacity_legend[i],
> > +                                         ocv_lut.lut[i][j],
> > +                                         ocv_lut.capacity_legend[i + 1],
> > +                                         ocv_lut.lut[i+1][j],
> > +                                         ocv);
> > +
> > +               if (pcj_minus_one == 0 && between(ocv_lut.lut[i][j-1],
> > +                                                 ocv_lut.lut[i+1][j-1], ocv))
> > +                       pcj_minus_one = interpolate(ocv_lut.capacity_legend[i],
> > +                                                   ocv_lut.lut[i][j-1],
> > +                                                   ocv_lut.capacity_legend[i + 1],
> > +                                                   ocv_lut.lut[i+1][j-1],
> > +                                                   ocv);
> > +
> > +               if (pcj && pcj_minus_one)
> > +                       return interpolate(pcj_minus_one,
> > +                                          ocv_lut.temp_legend[j-1],
> > +                                          pcj,
> > +                                          ocv_lut.temp_legend[j],
> > +                                          temp);
> > +       }
> 
> This code really needs some comments to tell what is going on
> here. Also I sense that you can break out a smaller function
> for interpolation based on table values, such as a function
> that would take a standard format of tables, look up where we
> are in that table and interpolate from the neighboring values.
Yeah, ill add some comments.
Tbh i'm not really sure how that would work as I interpolate from
values at several different indecies, can you expand ont this?
> 
> People can then later go in and refine the algorithms if they
> e.g. want to introduce spline or RMS interpolation instead
> and we can get better interpolation for everybody.
> 
> > +static unsigned long interpolate_fcc(int temp, struct bms_fcc_lut fcc_lut)
> > +{
> > +       int i, fcc_mv;
> > +
> > +       for (i = 0; i < TEMPERATURE_COLS; i++)
> > +               if (temp <= fcc_lut.temp_legend[i])
> > +                       break;
> > +
> > +       fcc_mv = interpolate(fcc_lut.lut[i - 1],
> > +                            fcc_lut.temp_legend[i - 1],
> > +                            fcc_lut.lut[i],
> > +                            fcc_lut.temp_legend[i],
> > +                            temp);
> > +
> > +       return fcc_mv * 10000;
> > +}
> 
> So then only this would really remain: pass a table and interpolate.
> 
> > +static int bms_lock_output_data(struct bms_device_info *di)
> > +{
> > +       int ret;
> > +
> > +       ret = regmap_update_bits(di->regmap, di->base_addr +
> > +                                REG_BMS_CC_DATA_CTL,
> > +                                BMS_HOLD_OREG_DATA, BMS_HOLD_OREG_DATA);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "failed to lock bms output: %d", ret);
> > +               return ret;
> > +       }
> 
> Reuse of regmap is very nice, thanks for doing it this way.
> 
> > +static int bms_read_cc(struct bms_device_info *di, s64 *cc_uah)
> > +static void bms_reset_cc(struct bms_device_info *di)
> 
> These indeed need to be mostly hardware-specific so they
> are fine.
> 
Thanks :)
> > +static int bms_calculate_capacity(struct bms_device_info *di, int *capacity)
> > +{
> > +       unsigned long ocv_capacity, fcc;
> > +       int ret, temp, temp_degc;
> > +       s64 cc, capacity_nodiv;
> > +
> > +       ret = iio_read_channel_raw(di->adc, &temp);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "failed to read temperature: %d", ret);
> > +               return ret;
> > +       }
> 
> Very nice that you use IIO ADC as a back-end.
> 
> > +       temp_degc = (temp + 500) / 1000;
> 
> That deserves a comment I think. Like what the manual
> says about this and why the raw temperature is given
> like this.
> 
> Maybe you want to use DIV_ROUND_CLOSEST()
> or DIV_ROUND_UP() from <linux/kernel.h> instead
> of just "/"?
> 
> Maybe you want to use that in other places too like
> the below divisions.
That was just converting it to celcius, adding 500 to round it. 
I'll skip that and make bindings use millicelcius.
> 
> > +       ret = bms_read_cc(di, &cc);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "failed to read coulomb counter: %d", ret);
> > +               return ret;
> > +       }
> > +
> > +       ocv_capacity = interpolate_capacity(temp_degc, (di->ocv + 5) / 10,
> > +                                           di->ocv_lut);
> > +       fcc = interpolate_fcc(temp_degc, di->fcc_lut);
> > +
> > +       capacity_nodiv = ((fcc * ocv_capacity) / 100 - cc) * 100;
> > +       *capacity = div64_ul(capacity_nodiv, fcc);
> 
> So I guess you fit the capacity between 0..100, please
> add some comment on what's going on here.
Basically,
1. Read coulomb counter delta since last ocv update
2. Interpolate open circuit voltage (ocv) and full charge capacity (fcc)
3. Math just ammends the coulomb counter delta to the last taken ocv
reading, Used the nodiv variable to make it a bit more but i could
probably just take that out.

Will add something like this in code.
> 
> > +static irqreturn_t bms_ocv_thr_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct bms_device_info *di = dev_id;
> > +
> > +       if (bms_read_ocv(di, &di->ocv) < 0)
> > +               return IRQ_HANDLED;
> > +
> > +       bms_reset_cc(di);
> > +       return IRQ_HANDLED;
> > +}
> 
> So that is a coloumb counter interrupt? Please add some
> comment on when this gets called. Is it called whenever
> a coloumb is added/removed from the battery?
Its called whenever a new open circuit voltage reading happens, which
only occurs when device us using very little power (probably below 10mA).
The coulomb counter is reset because its kept as a delta.
> 
> > +       ret = of_property_read_u8_array(di->dev->of_node,
> > +                                                "qcom,ocv-temp-legend",
> > +                                                (u8 *)di->ocv_lut.temp_legend,
> > +                                                TEMPERATURE_COLS);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "no ocv temperature legend found");
> > +               return ret;
> > +       }
> > +
> > +       di->ocv_lut.rows = of_property_read_variable_u8_array(di->dev->of_node,
> > +                                                "qcom,ocv-capacity-legend",
> > +                                                di->ocv_lut.capacity_legend, 0,
> > +                                                MAX_CAPACITY_ROWS);
> > +       if (di->ocv_lut.rows < 0) {
> > +               dev_err(di->dev, "no ocv capacity legend found");
> > +               return ret;
> > +       }
> > +
> > +       ret = of_property_read_variable_u16_array(di->dev->of_node,
> > +                                                 "qcom,ocv-lut",
> > +                                                 (u16 *)di->ocv_lut.lut,
> > +                                                 TEMPERATURE_COLS,
> > +                                                 TEMPERATURE_COLS *
> > +                                                 MAX_CAPACITY_ROWS);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "no ocv lut array found");
> > +               return ret;
> > +       }
> > +
> > +       ret = of_property_read_u8_array(di->dev->of_node,
> > +                                                "qcom,fcc-temp-legend",
> > +                                                (u8 *)di->fcc_lut.temp_legend,
> > +                                                TEMPERATURE_COLS);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "no fcc temperature legend found");
> > +               return ret;
> > +       }
> > +
> > +       ret = of_property_read_u16_array(di->dev->of_node,
> > +                                                 "qcom,fcc-lut",
> > +                                                 di->fcc_lut.lut,
> > +                                                 TEMPERATURE_COLS);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "no fcc lut array found");
> > +               return ret;
> > +       }
> 
> These tables (that I also suggest to use libraries to parse)
> should probably have standardized DT names so other
> battery drivers can use the same properties and we can
> use the same DT parsing code for all.
Okay, any recommendations on names?
> 
> > +       ret = bms_read_ocv(di, &di->ocv);
> > +       if (ret < 0) {
> > +               dev_err(di->dev, "failed to read initial ocv: %d", ret);
> > +               return ret;
> > +       }
> 
> OCV = original coloumb counter value?
Nope, open circuit voltage.
> 
> Please expand the acronym somewhere because I get
> a bit lost.
Will do.
> 
> Overall it is a very nicely coded driver. My worries are
> all about code reuse, not code quality per se.
Thanks!
> 
> Yours,
> Linus Walleij
