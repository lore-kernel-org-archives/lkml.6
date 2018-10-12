Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A1C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C421477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0C421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJMAUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:20:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39740 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeJMAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:20:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so10353509oia.6;
        Fri, 12 Oct 2018 09:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbPlsqaJbcyTz2rdNCXqXZgxWZeAO6pjjOsEkrcduNQ=;
        b=Mckq412ctXHPAwv96rzmyYtPyHk8UiD0rxLrwAFusAzCH5hXpw92T/kz//j6QumGPq
         k32yDVYAfhg/S1WTQ1BDPAFqrkjH5QXhNVKO/YVi2C6KkJN9OvWRuP55H8Bj/EY+k1b8
         aOU9XDW97xnKCHR1OUgXOkUvka2Khs37NEk9CrSbuh0jQww3oryMAQDa2TXZfw+k9Oov
         BUEjgbjxQpRunofPDrV0tlsm67XIWM324pROk6+Knrdkhxh/kBfnitTfKfJdW1XFJ3RC
         vsixhFCw5Ya9GaSOREn8TYN3Fh/Z4qeidnNalQioJOCsEyZ3qraAGS76XipC4VpwrK+Y
         KE7Q==
X-Gm-Message-State: ABuFfoieL8aTeIW6i82z4b87xS9+xsDpUT3PGCLrN5ZxMPsWprMbLTKv
        7od0IlOb18XW4BkQXStPkw==
X-Google-Smtp-Source: ACcGV60A9C7X9eOPADr8muymSOewYM39npHOcuS16HJgBduDd+auF0pVOa8eAqZsaXKwICuCtNDtyA==
X-Received: by 2002:aca:3f87:: with SMTP id m129-v6mr3470300oia.228.1539362810808;
        Fri, 12 Oct 2018 09:46:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p129-v6sm435314oia.21.2018.10.12.09.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:46:50 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:46:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joao.Pinto@synopsys.com, festevam@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [V2, 2/5] Documentation: dt-bindings: Document the Synopsys MIPI
 DPHY Rx bindings
Message-ID: <20181012164649.GA31690@bogus>
References: <20180920111648.27000-1-lolivei@synopsys.com>
 <20180920111648.27000-3-lolivei@synopsys.com>
 <20181012164548.GA11873@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012164548.GA11873@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:45:48AM -0500, Rob Herring wrote:
> On Thu, Sep 20, 2018 at 01:16:40PM +0200, Luis Oliveira wrote:
> > Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> > RX mode.
> 
> "dt-bindings: phy: ..." for the subject.
> 
> > 
> > Signed-off-by: Luis Oliveira <lolivei@synopsys.com>

Also, checkpatch.pl complains the author and S-o-b emails don't match.

Rob
