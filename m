Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60147C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E12206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E12206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZA0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:26:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36299 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:26:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id p125-v6so2319326oic.3;
        Tue, 25 Sep 2018 11:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rT4Ogpe2Vc8wcz3DugTJ2sz2iB/NL3rlpQ/Y9/we2aI=;
        b=UhW9HVio3KV3zxrGOYmcQhBPBOD3vjBbBemrzc3HK8VFfWMuKG1V8EAbVXKZJAO4WP
         5+o/+l65l7SbcNuxDGa9la0rHbajCfkR6eqlBjE2dF5qi32Tf0S4eG7AnUPKjhPovVDW
         fl8xXD3Oz10zWSZ0PZ8643RiIxgAewd2qBlXYf2om95taQrmEZ5OATjxyGHY5GT1wMA8
         kqsv0UNPO+rYP+HFaPgIGh99v+01bLSRsJb5gRIHCcoueUhwSIPiSVvq5RsHdZo4tSJf
         leOzP0BdAOfs3EQMzsz+wGsb3EwICQexGBn6bJVk5IQTbzYdy+Mue/FUM9r5qyNJkDkk
         VTcQ==
X-Gm-Message-State: ABuFfoj6HyvfM3oxuKs0mbf5wxjHwRempEXrIs2jMExfnqaMX8x2j6Gc
        A5vF2KyZGkSfxJBbMUZZeg==
X-Google-Smtp-Source: ACcGV637PqikbFnVN/CxQrYHqpLVBizk18Ih9ObbNqBZyUvTmELwWdZ62167XFHyQqun1vxX9W4Faw==
X-Received: by 2002:aca:6206:: with SMTP id w6-v6mr1425953oib.201.1537899457452;
        Tue, 25 Sep 2018 11:17:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v11-v6sm1170478oti.3.2018.09.25.11.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:17:36 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:17:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 5/8] interconnect: qcom: Add RPM communication
Message-ID: <20180925181735.GA28385@bogus>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-6-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831140151.13972-6-georgi.djakov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:01:48PM +0300, Georgi Djakov wrote:
> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.

I don't think you should have a binding nor a separate driver for this. 
It's not actually an interconnect provider, so it doesn't belong in 
bindings/interconnect. And it just looks like abuse of DT to instantiate 
some driver.

All the driver amounts to is a 1 function wrapper for RPM_KEY_BW 
messages. Can't this be part of the parent?

Rob
