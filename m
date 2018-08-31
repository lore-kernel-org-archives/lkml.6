Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291A9C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D720652
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14D720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbeHaQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:47 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39246 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeHaQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:47 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so14223565qtk.6;
        Fri, 31 Aug 2018 05:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uLfsDjkumhL4p/gcDeJQZ/YYguyuQX5wnoZKIyjQZTs=;
        b=jBRtGPy2gLwALwPmR9Y/8uPfhmkj1Hbr9BAokKQgaSL3tBUcwVPZVhtuPYbUhkLayM
         IloyhC7zm1tOEKLNL4QcXTX7nh9ElRX/IRt0v/6Rx4lWdM0T/YV67qmf+2cVK9D7IDG1
         QtE0k1/HUkPRI2k9xMABm7crV6RuBT6FuaTCR5fM+ZQfz3CdeMqWsreJCKctVOnHfGLF
         J5ZDeIzqto/ckoxf4bzq2mGe6HhfLoMjywtMYIp/f6SUwCsqF+PUtfLzhmwtR4JTSmrK
         5p9WzfRirFAJzXTyZ3btKG4HoY6AW2m2csfLn0myJDhGpbC2Gh63TKfblKaTkLxFffXk
         6ysQ==
X-Gm-Message-State: APzg51C7mEd0Kpn/qBnf1+nGpBQIt1QSl1zhpa0U8/iuDqh/48eG2T4c
        QN2sUjK7LVQDpddZ95TUNA==
X-Google-Smtp-Source: ANB0VdZtPL8DYAz0nMGH2bFUF68B2/nmC8Pcfo8dczJnS8ypGLfT69KMRZd8JTXiSMG6q824kgzYmA==
X-Received: by 2002:ac8:2908:: with SMTP id y8-v6mr15692869qty.45.1535718031967;
        Fri, 31 Aug 2018 05:20:31 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id o5-v6sm6392717qtc.63.2018.08.31.05.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:20:31 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:20:29 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] usb: gadget: udc: renesas_usb3: Add r8a774a1 support
Message-ID: <20180831122029.GA26230@bogus>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-7-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-7-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 08:56:15 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas_usb3.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
