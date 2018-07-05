Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C936C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9EE23F27
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9EE23F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeGEXW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:22:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33235 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbeGEXWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:22:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so20113301oiy.0;
        Thu, 05 Jul 2018 16:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0ykZY/s44xs+bExtGI8GQ+d++9yE+LqoXI30pt4tzo=;
        b=fYDvatUzJ6JscHAzWIYA0RMbP8NwIOBNh94hoc9iydR2tRMn5PEowi1rOZu9tGCG0y
         aaw2KQnQjem6QCCHwRzZfr85BelUPErkZ+psynEOixuEt/1I3WDJuV1++CS1vC73GDNn
         Vsj9XG8dIPkMuayn2t4I3qMLPdkHl1YZojIClUDrg25NztJgAf4IT7Ph9i97KSEPtCuV
         KBPkk2utBlU4uW1x/8c3izIEKGsE1+UezEV4nuKJMu7boUCfhs9IXXyUvkSEIyRQWop2
         s4VMSDfdE28zs5L7uzaYdyiQmEL/Xh61b/LdWzxZ7pFFeHYuzA3+qRa80YxJ0s18KXAo
         b5fA==
X-Gm-Message-State: APt69E09y3jhZlsfLJLTAIfobclTVHXqou7rFZnRhVbzYcOssTihirn2
        zvQOG/Tk0xDkNgW9D4HSHA==
X-Google-Smtp-Source: AAOMgpfbnwSCIE4bi4+3v/dwn4ZpegsC15+Wk9mwAmjxdpKgRiRP7xhu6NkJaOFvzQHvETZhRnjq2w==
X-Received: by 2002:aca:3045:: with SMTP id w66-v6mr9434754oiw.61.1530832974480;
        Thu, 05 Jul 2018 16:22:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id z196-v6sm12338850oig.12.2018.07.05.16.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:22:53 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:22:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] dt-bindings: mtk-uart: add mt6765 uart bindings
Message-ID: <20180705232253.GA14497@rob-hp-laptop>
References: <1530669174-17623-1-git-send-email-mars.cheng@mediatek.com>
 <1530669174-17623-3-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530669174-17623-3-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 09:52:52AM +0800, Mars Cheng wrote:
> Add documentation for mt6765 uart dt-bindings
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
