Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A46C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A13F21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 16:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A13F21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeI0XEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:04:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44805 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0XED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:04:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id u74-v6so2733134oia.11;
        Thu, 27 Sep 2018 09:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEU1hd1glilu8/DgbWS4TC+ByJX1Y2X30TUeoXWHyog=;
        b=Dsyoy0vlU8Ay6SJxGia4f1eTRlJmdB5uIP/1YAfWbOsZDjCfQs1h+a8jmkPu82ML5G
         MVGXkEuLnDl0cdTGCLqkv6ojRScJcme3qmHG5WW9FZFe0oRd0ulPE7l/1MQslaqEwtCG
         UCj3sFuJaeUrU72lbepx96+K3Lnb4Wl57lmxsPodWBPyACQD4KhnHLwu6Hja0mLQ0pBE
         HehxYy5JwulnsV0PCrXPMusSmUAY22HMOBFRsuosJTi46/Wf5lKrZ1lhDqbUmi0IRAQU
         ZVRd1BYEUJtmNONApfrvy+P44StNMFxftmzIupD7qlI42iIwSkfiY+K/6hQ9BNvI3/bk
         gSkQ==
X-Gm-Message-State: ABuFfoi9BatEpVGCIifpCj1EumVQHIh0KU1Vos5EyLsQ7LeNWHjA0+9c
        i1BccUnGurEqEVwzJgSJQQ==
X-Google-Smtp-Source: ACcGV61fvfRwhV/94iB6iFR3jkaHc5VxpbpIOYLqN2coMpKmsjn0/1TyRAdy7X4lFj7P4vcluhWgPg==
X-Received: by 2002:aca:690c:: with SMTP id e12-v6mr3747111oic.323.1538066696146;
        Thu, 27 Sep 2018 09:44:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q204-v6sm815086oih.49.2018.09.27.09.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:44:55 -0700 (PDT)
Date:   Thu, 27 Sep 2018 11:44:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V5 19/30] dt-bindings: Add vendor prefix for csky
Message-ID: <20180927164454.GA30070@bogus>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <da5734d918db4e9159d07bda477f502d1243df10.1537789737.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5734d918db4e9159d07bda477f502d1243df10.1537789737.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 07:39:22 +0800, Guo Ren wrote:
> Add csky vendor definition.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
