Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A735BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBEB224E3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iQECyNd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBEB224E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeKLXWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:22:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53512 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbeKLXWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:22:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so8485557wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 05:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RBPHPXb454UUTJuCc1TKAGTTONF0rMgxWkUYmEh7WeU=;
        b=iQECyNd2WjVP+1kw0EIslUjK0G1YIfiOOzSznWoaD7DUutgYGdzhWFHipdr/6+dKH0
         skI4rbjHubzlTysumo839djMlsy+KsuqhoY21IjinQ0DiXVyXQm8igiU6TzZ56UuvyB3
         XKot9oJID5H5M7j9JgTvYGqCCEooEbCoKVGRITH6jbGJwsaSlZ8+XXN0LTBbsHd6Hv2j
         cBCfyuYxm4uS2/Lnw/mIhmBTP5s6RMzbRigip51xoczG5RbLFnCt53onIYc5zfXumKfy
         u7Zo3ZkpH/vF794aoqCQpRf7uhlYR0X6HUiGmj7cgwe+j4QF1eNHYA3ES879ok7m9gJN
         vBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RBPHPXb454UUTJuCc1TKAGTTONF0rMgxWkUYmEh7WeU=;
        b=KY41+1r0QsZ7d2HEhWfju2CdNNk70WOsy7h++Quu6K6TSxGC2/NJO6wucE1COn04rT
         63lqJ2fUF1u/TJOyZOLfEJ9TYKha7d+TGkpeTCFlur+eDp9ZvGM0jH/Kqqr60OOKkR9S
         bXSMmGrf6DtO7N5gRe6nVT2/l47kgajuUJmhwUuo6NZLrDwFPA3vAvK32SlnQ5+4j1Rz
         CQf6OBmg/+12Pu5YGbOTsOmkLetc2IOimRZPD9FgKIgG15JIrG2+VFZU3Hg0kqandhS0
         kankOnrYUEPWbbARTNfxouUReYgD3e7PMdnMQnShLCYOutNKW+RivTqEp4zckLZ5x34V
         vVRA==
X-Gm-Message-State: AGRZ1gKqiOkJsOYwO5nwp6A+8uYwMCrqxjNMtjOQD7fU6IbiJqZfWqe/
        spj3IOD9Y8GrEBnB3S+oShexBQ==
X-Google-Smtp-Source: AJdET5dFL+uN6IiEW+9h1qLzUpdh3ZQ72FBlzOfvXr7mzxP7pvCvZTbEqHxXZfZHn7pBm+F4dJL6oA==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr8028607wma.121.1542029332235;
        Mon, 12 Nov 2018 05:28:52 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id q12sm1638148wmf.2.2018.11.12.05.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 05:28:51 -0800 (PST)
Message-ID: <e2bda62e2d402d94762d47c6f775d06c3dfabfee.camel@baylibre.com>
Subject: Re: [PATCH 0/4] nvmem: meson: efuse updates
From:   jbrunet@baylibre.com
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Nov 2018 14:28:49 +0100
In-Reply-To: <fe93e6da-e55f-f127-32c2-5f0e46421b7b@linaro.org>
References: <20181030102231.4851-1-jbrunet@baylibre.com>
         <fe93e6da-e55f-f127-32c2-5f0e46421b7b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 13:08 +0000, Srinivas Kandagatla wrote:
> 
> On 30/10/18 10:22, Jerome Brunet wrote:
> > The first change of this patchset just adds add error message in case
> > of failure. If there is problem with the secure monitor, the
> > SM_EFUSE_USER_MAX call will be first one to fail so it is better if it
> > give us a clue to help debugging, instead af silently failing.
> > 
> > Next this series adds the peripheral clock missing in this driver.
> > Like many other device in amlogic's SoC, the efuse requires a
> > peripheral clock to operate. ATM, the clock controller has
> > CLK_IGNORE_UNUSED on this clock and we have been lucky enough that the
> > bootloader left the clock enabled
> > 
> > At some point, we would like to remove those CLK_IGNORE_UNUSED, so if a
> > driver needs a clock, it needs to properly claim it.
> > 
> > Srinivas, Kevin,
> > The dts change needs to land before the actual driver change, to avoid
> > breaking the efuse on our users. If there an agreement on this series,
> > Kevin could you provide a tag to Srinivas ?
> 
> These are not fixes to any bugs/regressions, so its new material which 
> can only go in next dev cycle!
> 

It is not fixing a regression, indeed. It fixing a problem in the driver
itself, I think I described this above.

I don't expect this to go a fixes for 4.20. I was targeting next.

> I guess that should also address the patch sequencing issue!

Same issue still applies. If there is an agreement on this series, Patch 3
must land before patch 4 to avoid any problems for our users. I mentionning it
because patch 3 is supposed to go through Kevin's tree, while the rest go
through yours

> 
> Also I need ack from dt-maintaners on clk bindings to pick patch 2 and 4.

I understand for patch 2, but don't really get it for patch 4 ?

> 
> thanks,
> srini
> 
> > Cheers
> > Jerome


