Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946233AbeCBRzG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:55:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51612 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946022AbeCBRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:55:04 -0500
Date: Fri, 2 Mar 2018 17:54:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
Message-ID: <20180302175451.GB3482@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
 <20180301205940.GR12864@sirena.org.uk>
 <66d37327-b8ea-0da5-3e05-435cec5d84ab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <66d37327-b8ea-0da5-3e05-435cec5d84ab@linaro.org>
X-Cookie: Limited delivery area.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 02, 2018 at 01:13:17PM +0000, Srinivas Kandagatla wrote:
> On 01/03/18 20:59, Mark Brown wrote:
> > On Tue, Feb 13, 2018 at 04:58:17PM +0000, srinivas.kandagatla@linaro.org wrote:

> > > +static struct afe_port_map port_maps[AFE_PORT_MAX] = {
> > > +	[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
> > > +				AFE_PORT_HDMI_RX, 1, 1},
> > > +};

> > Is this not device specific in any way?  It looks likely to be.

> It is specific to Audio firmware build.
> AFAIK, DSP port IDs are consistent across a given range of AVS firmware
> builds. So far I have seen them not change in any of the B family SoCs.
> However on older A family SOCs these are very different numbers. Which is
> where ADSP version info would help select correct map.

Can we have some documentation of this in the code please?

> > > +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> > > +{
> > > +	struct q6afe_port *p = NULL;
> > > +
> > > +	spin_lock(&afe->port_list_lock);
> > > +	list_for_each_entry(p, &afe->port_list, node)
> > > +		if (p->token == token)
> > > +			break;
> > > +
> > > +	spin_unlock(&afe->port_list_lock);

> > Why do we need to lock the port list, what are we protecting it against?

> This is just to protect the list from anyone deleting this.

> Its very rare but the use case could be somelike the adsp is up and we are
> in the middle of finding a port and then adsp went down or crashed we would
> delete an entry in the list.

If that's what we're protecting against then this also needs to do
something to ensure that the port we looked up doesn't get deallocated
before or while we look at it.

> > > +int q6afe_port_start(struct q6afe_port *port)
> > > +{
> > > +	return afe_port_start(port, &port->port_cfg);
> > > +}
> > > +EXPORT_SYMBOL_GPL(q6afe_port_start);

> > This is the third level of wrapper for the port start command in this
> > file.  Do we *really* need all these wrappers?

> Intention here is that we have plans to support different version of ADSP,
> on A family this command is different, so having this wrapper would help
> tackle this use-case.

Why not just take out the level of wrapper for now then add it in when
there's actually an abstraction in there?  The code might end up looking
different anyway.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqZj+oACgkQJNaLcl1U
h9BglQf/Yr/VUWgW/Yt5oZyuay/zHxMAuWyObW6ZelbFKsU/PSD/bYjyUuLOABst
B30f7OSttx/uCFmHUC8i0AOvOCyfjXW0oJxCIesxsAQxDnJzM+fBldKJMbDfAajT
uT/z2EbENWf/ZjyydM20gJZ9lVGNBQU5Ck7MwOidmCftgBUcIaQGWzLc6JCfBZV6
Qb9PrKF/XroZbVthZ7H0JLmFR94v5CjFzyvgwfol37tP75eu+t4xXBVET8ac+4Ea
yVe2ZsuDof5y0agHQczSZkXbQCA5LOkoE5QgPL9xNRuFBwF6gHIoHAUVXHaEV5S7
HAmRwKobzqt6l1vtSZk5AU+oxH+ftA==
=Ioiu
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
