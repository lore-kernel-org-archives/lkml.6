Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E5C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B5B217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdOtrgUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfBFAtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:49:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44017 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFAtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:49:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so2164674pgk.10;
        Tue, 05 Feb 2019 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fygf7zWkpHlUBvY4zArgNZspQNtVM7b7j+lUpAebLec=;
        b=hdOtrgUc1ADXkYukL13QGUfJ7CwesoZ7E0n4bgeu5erX7Gn44rpWwpINfAat/4tUGD
         fUQH98Ykl7AGGNgHMMKhgOltgsCUMTvVJHAFMd7pZRBHRnFnLZmmBT/lL3N4zyXXek/a
         fGhG1BptWMCDJyvihwNYcddyEi1/VJlzv9RwkpS4f8V45+gS/XjbWxTcF/SJNeGonzNx
         BSeWoPJNxnegoxGkYrsnNCt/lg/AQa4bFMUw9WN/720K7v4FbuWXZZ2uDRIJw7SzbcEH
         hZITZ68bezkJ+1NQP8b4ZT5nqISifouRybaiuSJZenWoBXxBVU5hoXyj4ZKF7ViMGZJx
         ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fygf7zWkpHlUBvY4zArgNZspQNtVM7b7j+lUpAebLec=;
        b=eTEwy9bYg7L4VAsD7ismRVONZX4zrNsPletKhxnTNI4It+FTl+pk76iZMTrhaHxBli
         3HvrMdt2tDk++m95Guk8HDhAKkdJScE4lhdcnoqCnzICuMjGxqYel4JE+1YQYSJTsusL
         kg+BG69P26yXTjkmPnk8ok4e9fPBPf2XApeYoO99f+sBOLnZFU/b9KEnWw+P9h7Vwt7I
         zFIdOPaw8HaJkrHFzFwducIljAzHjGf2WYEB3kudxuhX5SfrXDLumbvV80UTvAKXXaqK
         yqIYWul/XlCfvC/ADUJdEqWLgH7dE8miQ2ZVY/fQhVnsoje90OeU1eq6EoKRd1y1oTJC
         Kmvw==
X-Gm-Message-State: AHQUAuY1onlThiW9Oj1lqbcVqZAXweoKng3K/Ai5+PuY+GVdxzYicVNE
        ZO9cCP9G/dQOwg2Q6CarBfk=
X-Google-Smtp-Source: AHgI3IYDogd3BK/tFiyIGNgJ7rE1G+A1DKOBywq2yU4HzXfPZB8t8oNMN1rFLBk8JYJ4W+YGgoB/XA==
X-Received: by 2002:a63:be0a:: with SMTP id l10mr2349341pgf.292.1549414141257;
        Tue, 05 Feb 2019 16:49:01 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id g6sm6990242pgq.18.2019.02.05.16.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 16:48:59 -0800 (PST)
Date:   Tue, 5 Feb 2019 16:48:51 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     michael.kao@mediatek.com, =Zhang Rui <rui.zhang@intel.com>,
        =Daniel Lezcano <daniel.lezcano@linaro.org>,
        =Rob Herring <robh+dt@kernel.org>,
        =Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH 3/7] thermal: mediatek: add calibration item
Message-ID: <20190206004837.GC19687@localhost.localdomain>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
 <1549006693-11659-4-git-send-email-michael.kao@mediatek.com>
 <dcc04c1e-eb7d-024e-abc8-7b75504947c2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc04c1e-eb7d-024e-abc8-7b75504947c2@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 06:31:41PM +0100, Matthias Brugger wrote:
> 
> 
> On 01/02/2019 08:38, michael.kao@mediatek.com wrote:
> > From: Michael Kao <michael.kao@mediatek.com>
> > 
> > Add calibration item in thermal_data to support
> > the project with different calibration coefficient.
> > 
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 07f8ad7..45c6587 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -105,6 +105,9 @@
> >  /* The number of sensing points per bank */
> >  #define MT8173_NUM_SENSORS_PER_ZONE	4
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT8173_CALIBRATION	165
> > +
> 
> Calibration value is the same for all SoCs (including mt8183), we can define it
> once and use it in all mtk_thermal structs.

Well, on patch 7 we have:

+#define MT8183_CALIBRATION	153

> 
> Regards,
> Matthias
> 
> 
> >  /*
> >   * Layout of the fuses providing the calibration data
> >   * These macros could be used for MT8173, MT2701, and MT2712.
> > @@ -147,6 +150,9 @@ enum {
> >  /* The number of sensing points per bank */
> >  #define MT2701_NUM_SENSORS_PER_ZONE	3
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT2701_CALIBRATION	165
> > +
> >  /* MT2712 thermal sensors */
> >  #define MT2712_TS1	0
> >  #define MT2712_TS2	1
> > @@ -162,12 +168,18 @@ enum {
> >  /* The number of sensing points per bank */
> >  #define MT2712_NUM_SENSORS_PER_ZONE	4
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT2712_CALIBRATION	165
> > +
> >  #define MT7622_TEMP_AUXADC_CHANNEL	11
> >  #define MT7622_NUM_SENSORS		1
> >  #define MT7622_NUM_ZONES		1
> >  #define MT7622_NUM_SENSORS_PER_ZONE	1
> >  #define MT7622_TS1	0
> >  
> > +/* The calibration coefficient of sensor  */
> > +#define MT7622_CALIBRATION	165
> > +
> >  struct mtk_thermal;
> >  
> >  struct thermal_bank_cfg {
> > @@ -188,6 +200,7 @@ struct mtk_thermal_data {
> >  	const int *sensor_mux_values;
> >  	const int *msr;
> >  	const int *adcpnp;
> > +	const int cali_val;
> >  	struct thermal_bank_cfg bank_data[];
> >  };
> >  
> > @@ -295,6 +308,7 @@ struct mtk_thermal {
> >  	.num_banks = MT8173_NUM_ZONES,
> >  	.num_sensors = MT8173_NUM_SENSORS,
> >  	.vts_index = mt8173_vts_index,
> > +	.cali_val = MT8173_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 2,
> > @@ -330,6 +344,7 @@ struct mtk_thermal {
> >  	.num_banks = 1,
> >  	.num_sensors = MT2701_NUM_SENSORS,
> >  	.vts_index = mt2701_vts_index,
> > +	.cali_val = MT2701_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 3,
> > @@ -356,6 +371,7 @@ struct mtk_thermal {
> >  	.num_banks = 1,
> >  	.num_sensors = MT2712_NUM_SENSORS,
> >  	.vts_index = mt2712_vts_index,
> > +	.cali_val = MT2712_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 4,
> > @@ -376,6 +392,7 @@ struct mtk_thermal {
> >  	.num_banks = MT7622_NUM_ZONES,
> >  	.num_sensors = MT7622_NUM_SENSORS,
> >  	.vts_index = mt7622_vts_index,
> > +	.cali_val = MT7622_CALIBRATION,
> >  	.bank_data = {
> >  		{
> >  			.num_sensors = 1,
> > @@ -402,7 +419,7 @@ static int raw_to_mcelsius(struct mtk_thermal *mt, int sensno, s32 raw)
> >  	raw &= 0xfff;
> >  
> >  	tmp = 203450520 << 3;
> > -	tmp /= 165 + mt->o_slope;
> > +	tmp /= mt->conf->cali_val + mt->o_slope;
> >  	tmp /= 10000 + mt->adc_ge;
> >  	tmp *= raw - mt->vts[sensno] - 3350;
> >  	tmp >>= 3;
> > 
