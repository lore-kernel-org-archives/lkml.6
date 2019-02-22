Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6134206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="B+puQfUC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfBVUQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:16:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41746 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBVUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vfUAdq3n+24IBbWbbV7yVJ7inWfx1u6txOvOb1GCeyY=; b=B+puQfUCvg40EQ21San94VWkv
        zHo7E1aFNeJiXloTQfzZwitzVbsoKjatMHKlzBe25AySySUlCvjoon47oVZ7G8ssYEc+iEm+7HnBD
        T6f8cKTf8JdLUV7kHcUZrjDI675mEwXUjtozX4AX8ZERxd9rxORu143ShLEg8vRJUJN+V+rxxwHu2
        WZksOY8ezUymamybYh+2O7IMdoJvtTJvJloZ1gJVhTRdUcFUT1PBfdFHByZijk8yNzqA+zE9khHmt
        v2ijpUz5A3iHP0+AsDf1ACuhS9FSlCY8ndJjbPbn1ka0P5nWernKlpIhkrfQj/S68KgxPa48neP0i
        TGJqttNYg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51358)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gxHFW-0004Bc-LV; Fri, 22 Feb 2019 20:16:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gxHFR-0002UG-Vb; Fri, 22 Feb 2019 20:16:41 +0000
Date:   Fri, 22 Feb 2019 20:16:41 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] drm/i2c: tda998x: adjust CTS_N audio pre-divider
 calculation
Message-ID: <20190222201641.yryc5pg6i4jkdj7d@shell.armlinux.org.uk>
References: <20190221181814.24829-1-TheSven73@gmail.com>
 <20190222132051.voznrjt3sctdkpkf@shell.armlinux.org.uk>
 <CAGngYiVU0wLVOm=tY+TZ9h1P+qNnDdv_3PybfhRreuBpCZ6D1g@mail.gmail.com>
 <20190222162735.t2t57wvawpseax3k@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222162735.t2t57wvawpseax3k@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 04:27:35PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Feb 22, 2019 at 10:47:35AM -0500, Sven Van Asbroeck wrote:
> > The config structure which you need to fill in to init the audio has a
> > "i2s qualifier" field, where you have the choice between 16 and 32 bits.
> > This then maps to a "Clock Time Stamp factor x" called CTSX, which maps to
> > the following CTS_N register settings:
> > 
> > CTSX -> CTS_N (m,k)
> > -----------------------------------
> > 16 -> (3,0)
> > 32 -> (3,1) (i2s qualifier = 16 bits)
> > 48 -> (3,2)
> > 64 -> (3,3) (i2s qualifier = 32 bits)
> > 128 -> (0,0)

Okay, this is my hypothesis about how the TDA998x works:

In the HDMI spec, the CTS value is generated using:

128*fS	---- divide ---> CTS counter -----> CTS value
(clock)        ^             ^
               |             |
fTMDS_clock -----------------+------------> TMDS clock
               |
N value -------+--------------------------> N value

What this does is count the number of TMDS clocks for every output of
the divider to produce a value for CTS, effectively implementing

	CTS = fTMDS_clock·N / 128·fS_source

The sink regenerates the 128·fS clock at the sink by reversing the
process - this is the equation given in the HDMI spec:

	128·fS_sink = fTMDS_clock·N / CTS

Using the "actual" values for 'm' and 'k' rather than the register
values, if we subsitute BCLK for the 128·fS input, assume that instead
of a CTS counter it is the mts counter which has to be divided by 'm'
to get the CTS value, and take account of 'k' as an extra prescaler,
what we end up with is:

	mts = fTMDS_clock·N·k / BCLK
	CTS = fTMDS_clock·N·k / (BCLK·m)

Throw this into the reverse process, and we end up with:

	128·fS_sink = BCLK·m / k

From the table of values you've given above, the CTSX value looks very
much like the BCLK fS ratio.  For the 64·fS ratio, we have m=8 (reg
value 3) k=4 (reg value 3):

BCLK ratio	m	k	128·fS_sink is	in terms of fS_source
16		8	1	BCLK·8		128·fS_source
32		8	2	BCLK·4		128·fS_source
48		8	3	BCLK·8/3	128·fS_source
64		8	4	BCLK·2		128·fS_source
128		1	1	BCLK		128·fS_source

What this shows is that we end up with the same sample rate on the sink
as the source despite the different BCLK ratios with this assumption.

What we also know is that SPDIF uses a 64·fS clock, and is programmed
with m=8 k=4, which corresponds nicely with the above.

In light of that, what about this, which rejigs the driver to use a
bclk_ratio rather than the sample width.  We then just need to work out
what to do about getting the bclk_ratio value into the driver in a way
that we don't end up breaking existing users.

A possible solution to that would be for hdmi-codec to default that to
zero unless it's been definitively provided by the ASoC "card", which
would allow the old behaviour of selecting the CTS_N M/K values
depending on the sample width, which we know works for some people.

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9300469dbec0..3d5eb5024b2c 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -930,21 +930,26 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP_I2S;
 		clksel_fs = AIP_CLKSEL_FS_ACLK;
-		switch (params->sample_width) {
+		switch (params->bclk_ratio) {
 		case 16:
+			cts_n = CTS_N_M(3) | CTS_N_K(0);
+			break;
+		case 32:
 			cts_n = CTS_N_M(3) | CTS_N_K(1);
 			break;
-		case 18:
-		case 20:
-		case 24:
+		case 48:
 			cts_n = CTS_N_M(3) | CTS_N_K(2);
 			break;
-		default:
-		case 32:
+		case 64:
 			cts_n = CTS_N_M(3) | CTS_N_K(3);
 			break;
+		case 128:
+			cts_n = CTS_N_M(0) | CTS_N_K(0);
+			break;
+		default:
+			dev_err(&priv->hdmi->dev, "unsupported I2S bclk ratio\n");
+			return -EINVAL;
 		}
-
 		switch (params->format & AFMT_I2S_MASK) {
 		case AFMT_I2S_LEFT_J:
 			i2s_fmt = I2S_FORMAT_LEFT_J;
@@ -1040,6 +1045,22 @@ static int tda998x_audio_hw_params(struct device *dev, void *data,
 	memcpy(audio.status, params->iec.status,
 	       min(sizeof(audio.status), sizeof(params->iec.status)));
 
+	/* Compatibility */
+	switch (params->sample_width) {
+	case 16:
+		audio.bclk_ratio = 32;
+		break;
+	case 18:
+	case 20:
+	case 24:
+		audio.bclk_ratio = 48;
+		break;
+	default:
+	case 32:
+		audio.bclk_ratio = 64;
+		break;
+	}
+
 	switch (daifmt->fmt) {
 	case HDMI_I2S:
 		audio.format = AFMT_I2S | AFMT_I2S_PHILIPS;
diff --git a/include/drm/i2c/tda998x.h b/include/drm/i2c/tda998x.h
index b0864f0be017..4e0f0cd2d428 100644
--- a/include/drm/i2c/tda998x.h
+++ b/include/drm/i2c/tda998x.h
@@ -19,6 +19,7 @@ enum {
 struct tda998x_audio_params {
 	u8 config;
 	u8 format;
+	u8 bclk_ratio;
 	unsigned sample_width;
 	unsigned sample_rate;
 	struct hdmi_audio_infoframe cea;

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
