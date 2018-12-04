Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7AF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbSZFz5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7AF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeLDQnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:43:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42355 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbeLDQnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:43:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so7617631pga.9;
        Tue, 04 Dec 2018 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QdeSoYpb9hxllSt0+nwb/LOe3PlAFmE0/ta+dumOWag=;
        b=tbSZFz5BgXhFPiaF/yqvZ3D5PBpaC8HznQqmqBejvgq7e0VVBpxf6PRyKFX56tx81s
         9w0xbhkuznOFCkTy/re73FwjObPmKj21ZfjckGjQjYXcejWoj7m/j5ycKadjcDvBd8AV
         nkAC8ACCr4r/5LJGSpdeNOk+ulgCqVUnpvk9f5xbao8tZTkw9NYTri0tMyFLaBGuV7P/
         TnF721jpBYa/xnTaZ8OJG5KiBK2NvRRsUr1QuKbKJkxwWLYG5PO8KnLRCcqBYbCtP31B
         22Ghntr/EdsiMddqjFCsn7ggPOoG4CFaVqW46wjw0rH/4wx9NpxXe3olb6eSx13rUfAp
         Or4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QdeSoYpb9hxllSt0+nwb/LOe3PlAFmE0/ta+dumOWag=;
        b=kXq4Ocb8x0kjaqtWIXDJzcwHv6zQlhiD/yyYP1i6eyG7oc9nct6qEdHWUcHDwkCnzm
         MMSlaQwg2GGmle5GcOgwyDsF655wGoeBugYVopXtss1o3Ay1jHN1u4DjsgvtQ+3INuMC
         nLh4Tpd/tg6np7Wch8o9lrTNqmaqyyNuXA1D/RI1j7EwprZwPAtCpxgFU2vXeR7M6b9z
         JC3FFk7b4VbT9JHuuTfrCbX1M99M68nqKpLm4MTRYIMqBW4EaPQKSf3NDkvOkdIiVaAN
         ZIhNVG33DAvZgzcQxBuxAJsDwwUiRXy94XUt1tX0Db59aiUCdw+6gMCoFGImGbnM6qar
         aeWg==
X-Gm-Message-State: AA+aEWa2T5q69K4ejQcAqoCUJXBXjPSk6h1XTAutxetO5CaW69J5jN0J
        LhTIGzi6Ei7E39kvXcEB6Ps=
X-Google-Smtp-Source: AFSGD/Vmlfuuqo8/5wcVhvSRyiuDUaJLTDW3rO8795cinKnB5/BcOkpt8MBC/ulOKxyPR+tP14aoOQ==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr9424898pfb.55.1543941824457;
        Tue, 04 Dec 2018 08:43:44 -0800 (PST)
Received: from localhost.localdomain (65-113-243-134.dia.static.qwest.net. [65.113.243.134])
        by smtp.gmail.com with ESMTPSA id d129sm27178143pfc.31.2018.12.04.08.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 08:43:43 -0800 (PST)
Date:   Tue, 4 Dec 2018 08:43:42 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, vkoul@kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 2/4] drivers: thermal: tsens: Add generic support for
 TSENS v1 IP
Message-ID: <20181204164340.GA3146@localhost.localdomain>
References: <cover.1543335819.git.amit.kucheria@linaro.org>
 <578f79ce10c51bbb7bd6f44395e10a3369a050f4.1543335819.git.amit.kucheria@linaro.org>
 <20181129165606.GE2688@localhost.localdomain>
 <CAP245DXT7L_HnfeVNcY0ko3JP-kDnNuhaZPy664Z-sAm4SUVXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DXT7L_HnfeVNcY0ko3JP-kDnNuhaZPy664Z-sAm4SUVXg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:54:21PM +0530, Amit Kucheria wrote:
> On Thu, Nov 29, 2018 at 10:26 PM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > On Tue, Nov 27, 2018 at 09:59:05PM +0530, Amit Kucheria wrote:
> 
> <snip>
> 
> > > +     qfprom_cdata = (u32 *)qfprom_read(tmdev->dev, "calib");
> > > +     if (IS_ERR(qfprom_cdata))
> > > +             return PTR_ERR(qfprom_cdata);
> > > +
> > > +     mode = (qfprom_cdata[4] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
> > > +     dev_dbg(tmdev->dev, "calibration mode is %d\n", mode);
> > > +
> > > +     switch (mode) {
> > > +     case TWO_PT_CALIB:
> > > +             base1 = (qfprom_cdata[4] & BASE1_MASK) >> BASE1_SHIFT;
> > > +             p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
> > > +             p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
> > > +             /* This value is split over two registers, 2 bits and 4 bits */
> > > +             lsb   = (qfprom_cdata[0] & S2_P2_MASK_1_0) >> S2_P2_SHIFT_1_0;
> > > +             msb   = (qfprom_cdata[1] & S2_P2_MASK_5_2) >> S2_P2_SHIFT_5_2;
> > > +             p2[2] = msb << 2 | lsb;
> > > +             p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
> > > +             p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
> > > +             p2[5] = (qfprom_cdata[2] & S5_P2_MASK) >> S5_P2_SHIFT;
> > > +             p2[6] = (qfprom_cdata[2] & S6_P2_MASK) >> S6_P2_SHIFT;
> > > +             /* This value is split over two registers, 2 bits and 4 bits */
> > > +             lsb   = (qfprom_cdata[2] & S7_P2_MASK_1_0) >> S7_P2_SHIFT_1_0;
> > > +             msb   = (qfprom_cdata[3] & S7_P2_MASK_5_2) >> S7_P2_SHIFT_5_2;
> > > +             p2[7] = msb << 2 | lsb;
> > > +             p2[8] = (qfprom_cdata[3] & S8_P2_MASK) >> S8_P2_SHIFT;
> > > +             p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
> > > +             for (i = 0; i < tmdev->num_sensors; i++)
> > > +                     p2[i] = ((base1 + p2[i]) << 2);
> > > +             /* Fall through */
> > > +     case ONE_PT_CALIB2:
> > > +             base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
> > > +             p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
> > > +             p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
> > > +             p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
> > > +             p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
> > > +             p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
> > > +             p1[5] = (qfprom_cdata[2] & S5_P1_MASK) >> S5_P1_SHIFT;
> > > +             p1[6] = (qfprom_cdata[2] & S6_P1_MASK) >> S6_P1_SHIFT;
> > > +             p1[7] = (qfprom_cdata[2] & S7_P1_MASK) >> S7_P1_SHIFT;
> > > +             p1[8] = (qfprom_cdata[3] & S8_P1_MASK) >> S8_P1_SHIFT;
> > > +             p1[9] = (qfprom_cdata[3] & S9_P1_MASK) >> S9_P1_SHIFT;
> > > +             for (i = 0; i < tmdev->num_sensors; i++)
> > > +                     p1[i] = (((base0) + p1[i]) << 2);
> > > +             break;
> > > +     default:
> > > +             for (i = 0; i < tmdev->num_sensors; i++) {
> > > +                     p1[i] = 500;
> > > +                     p2[i] = 780;
> > ... Wouldn't be nice to know what 500 or 780 stands for here?
> 
> Indeed, however I haven't found a suitable explanations in the
> downstream trees or documentation yet. tsens-8974.c and tsens-8916.c
> seem to have similar magic numbers.
> 

Well, it does not need to be exactly like it is in downstream, does it?
:-)

> > Why these defaults? Do we expect to have further patches to keep
> > updating these?
> 
> No we don't expect them to change. I wish I had a better answer, but
> honestly I don't. I'll keep looking for a explanation to replace these
> magic numbers.
> 

Yeah, I see, the problem that I have is that these are slope and
offsets, and these constants change from chip version/rev, essentially
due to sensor location, process, etc, so hardcoding in the probe seams
to be asking for future patching.

> > > +             }
> > > +             break;
> > > +     }
> > > +
> > > +     compute_intercept_slope(tmdev, p1, p2, mode);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +#define STATUS_OFFSET                0x44
> > > +#define LAST_TEMP_MASK               0x3ff
> > > +#define STATUS_VALID_BIT     BIT(14)
> > > +
> > > +static int get_temp_tsens_v1(struct tsens_device *tmdev, int id, int *temp)
> > > +{
> > > +     struct tsens_sensor *s = &tmdev->sensor[id];
> > > +     u32 code;
> > > +     unsigned int status_reg;
> > > +     u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
> > > +     int ret;
> > > +
> > > +     status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
> > > +     ret = regmap_read(tmdev->tm_map, status_reg, &code);
> > > +     if (ret)
> > > +             return ret;
> > > +     last_temp = code & LAST_TEMP_MASK;
> > > +     if (code & STATUS_VALID_BIT)
> > > +             goto done;
> > > +
> > > +     /* Try a second time */
> > > +     ret = regmap_read(tmdev->tm_map, status_reg, &code);
> > > +     if (ret)
> > > +             return ret;
> > > +     if (code & STATUS_VALID_BIT) {
> > > +             last_temp = code & LAST_TEMP_MASK;
> > > +             goto done;
> > > +     } else {
> > > +             last_temp2 = code & LAST_TEMP_MASK;
> > > +     }
> > > +
> > > +     /* Try a third/last time */
> > > +     ret = regmap_read(tmdev->tm_map, status_reg, &code);
> > > +     if (ret)
> > > +             return ret;
> > > +     if (code & STATUS_VALID_BIT) {
> > > +             last_temp = code & LAST_TEMP_MASK;
> > > +             goto done;
> > > +     } else {
> > > +             last_temp3 = code & LAST_TEMP_MASK;
> > > +     }
> > > +
> > > +     if (last_temp == last_temp2)
> > > +             last_temp = last_temp2;
> > > +     else if (last_temp2 == last_temp3)
> > > +             last_temp = last_temp3;
> > > +done:
> > > +     /* Convert temperature from ADC code to milliCelsius */
> > > +     *temp = code_to_degc(last_temp, s) * 1000;
> >
> > This three strikes/read approach seams awkward. Is this a broken
> > sensor or are you missing the programming steps? Maybe you need to
> > either wait for a IRQ on temp ready, or maybe you need simply wait
> > some amount of cycles before the sensor is ready with new temp/ADC
> > conversion, no?
> 
> This "algorithm" for reading data is specified in the Tsens IP HW
> documentation almost word for word. The status_reg contains both the
> VALID_BIT and the temperature, so we don't know if this is valid data
> until we read the register. I'll be posting IRQ support soon.
> 
> Again, this algorithm is used for tsens-v2.c and tsens-8916.c so I
> haven't tried to clean this up, yet. I have an experimental branch to
> hide IP-specific register changes behind the regmap interface. This
> should get rid of copies of these functions across the various files
> but that isn't yet ready to post yet.
> 
> > Also, the goto's dont really help, as we dont really have any
> > resource to rollback here..
> 
> Agreed. :-) This function could be made much clearer.
> 
> If I fix this, should I fix it in the other files right away, or can
> we wait a bit more to clean this up as part of the move to regmap? I
> think it'd be logically simpier to clean this up in a separate series
> than introducing changes to the known working function as part of new
> machine enablement.
> 
> Thanks for the review.
> 
> Regards,
> Amit
> 
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct tsens_ops ops_generic_v1 = {
> > > +     .init           = init_common,
> > > +     .calibrate      = calibrate_v1,
> > > +     .get_temp       = get_temp_tsens_v1,
> > > +};
> > > +
> > > +const struct tsens_data data_tsens_v1 = {
> > > +     .ops            = &ops_generic_v1,
> > > +     .reg_offsets    = { [SROT_CTRL_OFFSET] = 0x4 },
> > > +};
> > > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > > index f1ec9bbe4717..d0cc0c09894a 100644
> > > --- a/drivers/thermal/qcom/tsens.c
> > > +++ b/drivers/thermal/qcom/tsens.c
> > > @@ -63,6 +63,9 @@ static const struct of_device_id tsens_table[] = {
> > >       }, {
> > >               .compatible = "qcom,msm8996-tsens",
> > >               .data = &data_8996,
> > > +     }, {
> > > +             .compatible = "qcom,tsens-v1",
> > > +             .data = &data_tsens_v1,
> > >       }, {
> > >               .compatible = "qcom,tsens-v2",
> > >               .data = &data_tsens_v2,
> > > diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> > > index 7b7feee5dc46..f8dc96c42b94 100644
> > > --- a/drivers/thermal/qcom/tsens.h
> > > +++ b/drivers/thermal/qcom/tsens.h
> > > @@ -90,9 +90,10 @@ char *qfprom_read(struct device *, const char *);
> > >  void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
> > >  int init_common(struct tsens_device *);
> > >  int get_temp_common(struct tsens_device *, int, int *);
> > > +int code_to_degc(u32 adc_code, const struct tsens_sensor *s);
> > >
> > >  /* TSENS v1 targets */
> > > -extern const struct tsens_data data_8916, data_8974, data_8960;
> > > +extern const struct tsens_data data_8916, data_8974, data_8960, data_tsens_v1;
> > >  /* TSENS v2 targets */
> > >  extern const struct tsens_data data_8996, data_tsens_v2;
> > >
> > > --
> > > 2.17.1
> > >
