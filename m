Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CC7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87637216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87637216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeI0V3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:29:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33101 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0V3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:29:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id m23-v6so2929296otf.0;
        Thu, 27 Sep 2018 08:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4rmAT+TBK8rmuU32ECuj5amVvTUzzKquEU5ecs/Pib0=;
        b=F70Wm1HHK+A7FL3xhp/+F0XAKumiFO709QJwUDN3KWc0nieZo2EhwV9wqJ9ggWIMCS
         jkS/Al/FgDdfrnoqBI3tmgOU9A6ViLUbQrveKxpS2eXNEKIxf5eDwuDUx+8rFUNVNi/t
         BpvTYEAUezmdfjTkb8gPxZXEJeO4g9y6PgUqlupKyr+GOhORVzaVct2b5BIntjHrce59
         8jb8uQHXhsW214Ogeh/8qT/akKuI13U6ETjSrViAISwFOEavSdj428eg3s5oZgqh9YUd
         IMJ4YPjtGufK5oz1yQR9bz25Kh1RQgF30fnWM/valBH9tx1cBADoWGamV3uRT4RgJaIO
         TjPA==
X-Gm-Message-State: ABuFfogX3W5BuhSX0dVkGgMaoPuvEtGNVJnbFl2T8s7yiIvlHbqTTDmq
        PQ6nYSvqmMZpfP3Zv8+xCg==
X-Google-Smtp-Source: ACcGV61g76UxA65ZDbzxsgKp4CtbiNcESZY+BgcpUeDL4lkLRoNHByZYugZEh+F0OIMO8rcioEsKNg==
X-Received: by 2002:a9d:2154:: with SMTP id l20-v6mr1603341otd.370.1538061056516;
        Thu, 27 Sep 2018 08:10:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z33-v6sm832474otz.71.2018.09.27.08.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 08:10:55 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:10:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: Re: [PATCH v8 01/12] dt-bindings: Add a document of PECI subsystem
Message-ID: <20180927151055.GA11054@bogus>
References: <20180918215124.14003-1-jae.hyun.yoo@linux.intel.com>
 <20180918215124.14003-2-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918215124.14003-2-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2018 14:51:13 -0700, Jae Hyun Yoo wrote:
> This commit adds a document of generic PECI bus, adapter and client
> driver.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
> Reviewed-by: James Feist <james.feist@linux.intel.com>
> Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> ---
>  .../devicetree/bindings/peci/peci.txt         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
