Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BA621723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BA621723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeHCKEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:04:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40657 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeHCKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:04:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so3436823lfd.7;
        Fri, 03 Aug 2018 01:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=URDSvYW7O879FCFJt2S98ICv/g3Ln7D2xy2aUNCSlWs=;
        b=bQpoFN6aG9NtGONrhdoEqbyCRNUnG8L1UP20m52snwFmx84N6RSgjetybeSgziv4Mq
         rKuV/atSYOkyPMGrVg1blhCXDZGw5CBCZxXh4HGhwgNd6uo+yi/+JQ7C5GPV3JTrXTE1
         HmJKIw1Nh+CNIXeeFzFClY6cI93dxL7fZt7UCDZrA0yVA7Eeu+0fiy730ifspGipYIXy
         ZXFBwgsz8KTCjDWf685OacKr36kkkeUNXba9+h5Yq5gKytPORhmKh6X6AFfj5gwlAINW
         eKYir2B1ZQb6kljeLd5TnChNqW/IiKOcItb20O/9bPOTIpGEE8aWdBn4Tcg4tWTOhVcM
         yjkw==
X-Gm-Message-State: AOUpUlFFY3f+ex0jXcWQA//FtimOCR0vVul3UOMtwuhb4VKPzi/JVeB0
        tnoXBCj8D6fxfiQg8V2UqWdxAN2DbIw=
X-Google-Smtp-Source: AAOMgpfki2lu+AqVoicg0GnUJq31q8LVJxhJApz7RTyjJovMjIXRgVR7dpbbWoP25GFF8BweMqy+Ow==
X-Received: by 2002:a19:aac8:: with SMTP id t191-v6mr4174825lfe.68.1533283763023;
        Fri, 03 Aug 2018 01:09:23 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y68-v6sm625744lfd.66.2018.08.03.01.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 01:09:21 -0700 (PDT)
Date:   Fri, 3 Aug 2018 11:09:14 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>, robh+dt@kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, broonie@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180803080914.GA20907@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com>
 <20180626081319.GA2118@localhost.localdomain>
 <20180731073023.GA2956@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731073023.GA2956@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:28:58AM +0300, Matti Vaittinen wrote:
> On Tue, Jun 26, 2018 at 11:13:19AM +0300, Matti Vaittinen wrote:
> > On Mon, Jun 25, 2018 at 04:44:57PM -0700, Stephen Boyd wrote:
> > > Quoting Matti Vaittinen (2018-06-12 01:23:54)
> > > > On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> > > > > Quoting Matti Vaittinen (2018-06-04 06:19:13)

[snip]

> 
> > 3. Create devm_of_clk_add_hw_provider_w_node() which does something
> 

After giving this second thought - I think there is limited amount of
use cases where other than own or parent nodes should be used. Actually,
the MFD node being parent is pretty much only use case I can think of
where something else but own node should be used. Hence function like
suggested devm_of_clk_add_hw_provider_w_node might invite thinking of
clever hacks... So, perhaps introducing
devm_of_clk_add_hw_provider_parent() (see idea below) would be option to
consider? I feel the bd71837 driver is not only case where MFD is being
parent which has the clock stuff in DT.

static int __devm_of_clk_add_hw_provider(struct device *dev,
	struct clk_hw *(*get)(struct of_phandle_args *clkspec, void *data),
	struct device_node *of_node, void *data)
{
	struct device_node **ptr;
	int ret;
	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
			   GFP_KERNEL);
	if (!ptr)
		return -ENOMEM;

	*ptr = of_node;
	ret = of_clk_add_hw_provider(of_node, get, data);
	if (!ret)
		devres_add(dev, ptr);
	else
		devres_free(ptr);
	return ret;
}

int devm_of_clk_add_hw_provider(struct device *dev,
	struct clk_hw *(*get)(struct of_phandle_args *clkspec, void *data),
	void *data)
{
	return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
}
EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);

int devm_of_clk_add_hw_provider_parent(struct device *dev,
	struct clk_hw *(*get)(struct of_phandle_args *clkspec, void *data),
	void *data)
{
	return __devm_of_clk_add_hw_provider(*dev, get, dev->parent->of_node,
					     data);
}
EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider_parent);

> just a friendly reminder, what's your opinion on adding this kind of
> function (devm_of_clk_add_hw_provider_w_node)? or solutions 1/2? And are
> these options safe what comes to reference counting of of_nodes?

I thik the reference counting should not be a problem when use is
limited to (MFD) parent device nodes, right?

Best regards
    Matti Vaittinen
