Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dQMeACB7HluDQwAAmS7hNA
	; Mon, 11 Jun 2018 13:39:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85A1F607E7; Mon, 11 Jun 2018 13:39:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q//KOPOK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DD61860791;
	Mon, 11 Jun 2018 13:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DD61860791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933369AbeFKNjF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 09:39:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52628 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932917AbeFKNjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:39:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so14781437wmb.2;
        Mon, 11 Jun 2018 06:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDaNw6ymM7t/oY+Us1HVnl14viFZBnctTSAi1qIGX7k=;
        b=Q//KOPOKI+GdnfC93+K6e/pgfA+IDtGrYItMHrWIRsaouI3bV5mbcfNW+wcIaxOKPG
         DmZVOoc3J3UNdv8+BaFzHpJlrRbnCR/3ppzfTqKk5XvPQSHf2Y+z+/xTnal61egTCqqB
         Saqlsc/c5v/eQC/l/BfFwMxI3v7IzF3thid7/gnWjDAlboFR3SYG2wKhPvUxpFuOT9Th
         ic2iaJ2ABErhskAY6gcgFJ2hOoaPf5Vmuk9K9Kk6lO4zbNR+lTM1d5NUZhxI+D4X2LHj
         KKUPOHAy/ponzfuAAqvWJx7Q4xgMDFhZuUAI7NpnC/y3dVR5tXHzLJexrgZviW/DN25p
         F1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDaNw6ymM7t/oY+Us1HVnl14viFZBnctTSAi1qIGX7k=;
        b=DySqfU97xRK5c/bNlUrVdwkj/7U8WP6rA5fADLF0zxy1PPtmFLkaGG97h3k+eMnTyN
         aJMk+j4aZtxSXz4rltle4FqSTQx1DFYMoDTcWHW55m46N8rPivBKAEUYPnDpo8ocJtdv
         f8YtYHPCDzMBd5YnRfUW7ZE3sY6rVq/u9daB2i1K/KTntR2RGwjKHGKLCo0PZlCE5VF+
         NuTVagcSmj8mZyFzFvmwLF0fU1tI83O4BwZCBPcnBhcR/IZBNkcn4j5ScgsE4Sw4LH4g
         dw8fS5dWMXcXD1AIgIIboP1C/390SNOBbrgt4Gg0Kxp55rPrgCOP7lRlRZkPIVerCHOt
         0pHw==
X-Gm-Message-State: APt69E2X62NflCEKO0tBsXsGfsFsIERBR0qgFg9ztppa/jKzA7TmsaBB
        Wv+P4UWyrbGanI+ZtAwOsO8=
X-Google-Smtp-Source: ADUXVKKwNh9bwm9scW2B8ltmXo2vKhdbok6h7pIiWbApVxMdScJ3tDZnMzKquCCR8tz70Jiyjn3OYQ==
X-Received: by 2002:a1c:4203:: with SMTP id p3-v6mr9127557wma.111.1528724341412;
        Mon, 11 Jun 2018 06:39:01 -0700 (PDT)
Received: from dimapc.localnet (109-252-55-168.nat.spd-mgts.ru. [109.252.55.168])
        by smtp.gmail.com with ESMTPSA id 84-v6sm8897764wme.16.2018.06.11.06.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 06:39:00 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] memory: tegra: Introduce Tegra20 EMC driver
Date: Mon, 11 Jun 2018 16:38:52 +0300
Message-ID: <2038303.qe2mJgr7in@dimapc>
In-Reply-To: <20180611114133.GD31977@ulmo>
References: <20180603223654.23324-1-digetx@gmail.com> <20180611113503.GC31977@ulmo> <20180611114133.GD31977@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 11 June 2018 14:41:33 MSK Thierry Reding wrote:
> On Mon, Jun 11, 2018 at 01:35:03PM +0200, Thierry Reding wrote:
> > On Wed, Jun 06, 2018 at 04:42:01PM +0300, Dmitry Osipenko wrote:
> > > On 06.06.2018 14:02, Thierry Reding wrote:
> > > > On Mon, Jun 04, 2018 at 01:36:54AM +0300, Dmitry Osipenko wrote:
> [...]
> 
> > > >> +	if (!child_count) {
> > > >> +		dev_err(emc->dev, "no memory timings in DT node\n");
> > > >> +		return -ENOENT;
> > > >> +	}
> > > >> +
> > > >> +	emc->timings = devm_kcalloc(emc->dev, child_count, 
sizeof(*timing),
> > > >> +				    GFP_KERNEL);
> > > >> +	if (!emc->timings)
> > > >> +		return -ENOMEM;
> > > >> +
> > > >> +	emc->num_timings = child_count;
> > > >> +	timing = emc->timings;
> > > >> +
> > > >> +	for_each_child_of_node(node, child) {
> > > >> +		err = load_one_timing_from_dt(emc, timing++, child);
> > > >> +		if (err) {
> > > >> +			of_node_put(child);
> > > >> +			return err;
> > > >> +		}
> > > >> +	}
> > > >> +
> > > >> +	sort(emc->timings, emc->num_timings, sizeof(*timing), 
cmp_timings,
> > > >> +	     NULL);
> > > >> +
> > > >> +	return 0;
> > > >> +}
> > > >> +
> > > >> +static struct device_node *
> > > >> +tegra_emc_find_node_by_ram_code(struct tegra_emc *emc, u32 ram_code)
> > > >> +{
> > > >> +	struct device_node *np;
> > > >> +	int err;
> > > >> +
> > > >> +	for_each_child_of_node(emc->dev->of_node, np) {
> > > >> +		u32 value;
> > > >> +
> > > >> +		err = of_property_read_u32(np, "nvidia,ram-code", &value);
> > > >> +		if (err || value != ram_code)
> > > >> +			continue;
> > > >> +
> > > >> +		return np;
> > > >> +	}
> > > >> +
> > > >> +	dev_info(emc->dev, "no memory timings for RAM code %u found in
> > > >> DT\n",
> > > >> +		 ram_code);
> > > > 
> > > > This seems like it should be dev_warn() or perhaps even dev_err()
> > > > given
> > > > that the result of it is the driver failing to probe. dev_info() may
> > > > go
> > > > unnoticed.
> > > 
> > > Absence of memory timings is a valid case, hence dev_info() suit well
> > > here.
> > > 
> > > I can't see anything wrong with returning a errno if driver has nothing
> > > to do and prefer to keep it because in that case managed resources
> > > would be free'd by the driver core, though returning '0' also would
> > > work.
> > 
> > I disagree. A driver failing to probe will show up as a kernel log entry
> > and is something that people will have to whitelist if they're filtering
> > for error messages in the boot log.
> > 
> > I think it's more user-friendly to just let the driver succeed the probe
> > in an expected case, even if that means there's really nothing to do. If
> > you're really concerned about the managed resources staying around, I
> > think you could probably get rid of them explicitly. By the looks of it
> > devres_release_all() isn't an exported symbol, so it can't be called
> > from driver code, but perhaps that's something that we can change.
> 
> Maybe an easier way to avoid keeping the managed resources around would
> be to move the check a little further up. That way, we can abort earlier
> if no EMC timings are available, before any resources are even
> allocated.
> 
> The tegra_emc_find_node_by_ram_code() function would need to take a
> struct device * instead of struct tegra_emc *, but otherwise it should
> work fine.

Good point, thank you!
