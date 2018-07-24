Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C8C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FEF204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="vsZ9o8qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FEF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbeGXNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:05:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48664 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388264AbeGXNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mDzzkvKQoaaTt6vLFnw79M3ujNaGhQmzsu/1j7sLTRk=; b=vsZ9o8qZ1+avcvMkmX+W6/4T/
        FcbTtwv19L0IONcxCYVtJLuGKvtwyzlDeU6GHIx2YBVzJIaxYvREUSRHW7jxo6Sf8bu+J1Iqle3JA
        B1ObhBxIzFeWGC4oqf02oc44mjp+szC2AJuetamqJV3usISJp3OIa+BWEc0v8WtyohNCk=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhvy9-0005Np-IJ; Tue, 24 Jul 2018 11:59:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D08C4440078; Tue, 24 Jul 2018 12:59:08 +0100 (BST)
Date:   Tue, 24 Jul 2018 12:59:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 07/12] ASoC: wcd9335: add CLASS-H Controller support
Message-ID: <20180724115908.GC2414@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20180723155410.9494-8-srinivas.kandagatla@linaro.org>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:05PM +0100, Srinivas Kandagatla wrote:

> +static inline int wcd_clsh_get_int_mode(struct wcd_clsh_ctrl *ctrl,
> +					int clsh_state)
> +{
> +	int mode;
> +
> +	if ((clsh_state != WCD_CLSH_STATE_EAR) &&
> +	    (clsh_state != WCD_CLSH_STATE_HPHL) &&
> +	    (clsh_state != WCD_CLSH_STATE_HPHR) &&
> +	    (clsh_state != WCD_CLSH_STATE_LO))
> +		mode = CLS_NONE;
> +	else
> +		mode = ctrl->interpolator_modes[ffs(clsh_state)];
> +
> +	return mode;

This looks like it wants to be a switch statement.

> +static void wcd_clsh_state_hph_lo(struct wcd_clsh_ctrl *ctrl, int req_state,
> +				  bool is_enable, int mode)
> +{
> +	struct snd_soc_component *comp = ctrl->comp;
> +	int hph_mode = 0;
> +
> +	if (is_enable) {
> +		/*
> +		 * If requested state is LO, put regulator
> +		 * in class-AB or if requested state is HPH,
> +		 * which means LO is already enabled, keep
> +		 * the regulator config the same at class-AB
> +		 * and just set the power modes for flyback
> +		 * and buck.
> +		 */
> +		if (req_state == WCD_CLSH_STATE_LO)
> +			wcd_clsh_set_buck_regulator_mode(comp, CLS_AB);

This seems like there's a pretty confusing state machine, or possibly
that we might end up in different states depending on how we transition.
Whatever is going on it really feels like this code is more complex than
it needs to be.  Some of this is the use of lots of nested if statements,
some of it is the lack of any clear description of what we're trying to
achieve.  It's hard to tell if the code is doing what's expected because
it's hard to tell what it is expected to do.

> +		else {

If there's braces on one side of an if/else there should be braces on
both sides.

> +			if (req_state == WCD_CLSH_STATE_HPHL)
> +				snd_soc_component_update_bits(comp,
> +					WCD9XXX_A_CDC_RX1_RX_PATH_CFG0,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
> +			if (req_state == WCD_CLSH_STATE_HPHR)
> +				snd_soc_component_update_bits(comp,
> +					WCD9XXX_A_CDC_RX2_RX_PATH_CFG0,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_EN_MASK,
> +					WCD9XXX_A_CDC_RX_PATH_CLSH_ENABLE);
> +		}

Switch statement?

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXFIwACgkQJNaLcl1U
h9AlGQf9Hntz7b0NDrasFJ50EvVDGuiZu8yWDMlZgGZY5deKA3MUubcQmCzDqL5C
s54SdXf9usQEcMFlsngWgJZful87H7a0rvhq8JMBsRnCBXDMj14L+nkDVGVfslOQ
bVeSAefLXB2RqVZdqS6VWCp1FjZ+8SFWyGgeEbF0IgWu2DlY/FsufZqJgQUIphfj
BLjdiTJCN16tE65aVfcMHH5LUao8rizBaiSmCipiJKdYrLlC6ebVUyYNHFByT2Hr
s1AgdhjZjodUP72kkbPOmoCup5/MX0doutsW/o2DEaLYLSeSXuxnORAoadSco/du
HzxbV2+1/RFzkFvKMQ5hONi2ZL6BaA==
=RLr1
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
