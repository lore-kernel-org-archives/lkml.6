Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0067C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D7721473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D7721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeJRWcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:32:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43373 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeJRWcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:32:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so24135792oie.10;
        Thu, 18 Oct 2018 07:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WToMcRIJo0HbSfNiEvs6I++vBp30P3845+eD/glxfos=;
        b=K/z5T1Nk6kyLAMzS+iU8vpF+aKchlbQdDUs3H5Vu1UJ8gVQwyzuhHJ4OROjHKn85US
         /0ynjnj1EiGZG5/BBWu5KSZDUzM55Ij9KvyFPrc6wIaBfrJxm1Liv050ut7ej0yXIiT+
         ZVPTksfrkol9eOESLRXjkUoFPF60pG/5cfrYp2fzz9w5SUQySaG3w4P2Lv9vcLiB0k4d
         YGcW1LBRfCiHaYn0fpoIH7EzoAGD2+x9mFc6KzNq1sOJc/U+fJJuYQlifA9CqBfqewse
         jSiAdc47bSQnyxg5kncOs8vuJutI4AHfg7xmAH8FEXB0kui3mY7Qhg9pq0DjvRQnmQUk
         s+Fw==
X-Gm-Message-State: ABuFfohsg51DGuU16siHd57Par4muX3B4yajR0N2E78hIfLJS1pm4xUq
        8xwgpfyYfRAV3EQYDNwSBw==
X-Google-Smtp-Source: ACcGV61vXusy3/GBZDj5D4Z2dKco09jfed+YQ6geCAFy7b9y/RRhOK8X3i9coISoeAnq7csioEGiPg==
X-Received: by 2002:aca:5748:: with SMTP id l69-v6mr17060631oib.100.1539873096851;
        Thu, 18 Oct 2018 07:31:36 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y135-v6sm5774149oie.25.2018.10.18.07.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 07:31:36 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:31:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org,
        robh@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 18/21] dt-bindings: csky CPU Bindings
Message-ID: <20181018143135.GA22243@bogus>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867b2328e3dbaef58d0b5e7fc58e8545d1510951.1539655732.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 10:58:37 +0800, Guo Ren wrote:
> This patch adds the documentation to describe that how to add cpu nodes in
> dts for SMP.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> ---
> Changelog:
>  - Add compatible.
>  - Remove status part.
> ---
> ---
>  Documentation/devicetree/bindings/csky/cpus.txt | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/csky/cpus.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
