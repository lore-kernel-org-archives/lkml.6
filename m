Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7971C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE520664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFCE520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeJaWtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:49:08 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34727 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729271AbeJaWtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:49:08 -0400
Received: by mail-ot1-f49.google.com with SMTP id e9so13081795oti.1;
        Wed, 31 Oct 2018 06:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaIAACknXTZ6Fox1D/YCusoCm9hnJJdr0PEj92pjfkM=;
        b=srFAiR2+G0eL59/VWXMLsU2OqUf7kcpWBi27zUmMto0isC/jtbiLW9fmsoOTVIjdSI
         K6IBKkgzhvnH3ixFQKV81kIBS2hsBAtASw7HEun1nJG1TxoZTqNeMK0U2OavtA4RF+5K
         S2KpK4B331a3PPV4UZ5fzEsi/LXcgwPfm2k7b7i9bPI58KmluCecb6Bsnd6KE1WvKmAI
         /LSLL+m5rc65TLCAiGOMMsxuFrVbNXYBi7J/RZNswRA6g4yEeT0ttVacjLnDkWzlthAJ
         dA4keBmkB6iBO9xIWZYPfVfHGIpB1bk8SMgNjrFcGuY8Lg1vUTptJhnP9FYZkAJcQ5Ql
         Fohw==
X-Gm-Message-State: AGRZ1gLTtxjqkutjW/As9loqKtyT5DaXB8eXzyskwe/KptlRFYL7IhN4
        q+4md3LQHFoUKZ4DkfAQ7Va2XwfbxkYEC8QzsYQ7kQ==
X-Google-Smtp-Source: AJdET5dbEgbXoMgQeclC421nZpWcQw1+bTAX5DHyPmCq+qpNy4qGj7c6kVMg2wR/pEalylMX53Z3BavlukjFMFt4Lfw=
X-Received: by 2002:a9d:2987:: with SMTP id n7mr1946829otb.339.1540993861047;
 Wed, 31 Oct 2018 06:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-2-git-send-email-harini.katakam@xilinx.com> <20181031134810.GD20889@lunn.ch>
In-Reply-To: <20181031134810.GD20889@lunn.ch>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 31 Oct 2018 19:20:50 +0530
Message-ID: <CAFcVECKDhQHcHyHoyP-xWRkAt0sVAhy2mB8yweZGsGwTnBsyVA@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: macb: Check MDIO state before read/write and use timeouts
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        David Miller <davem@davemloft.net>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sai.pavan.boddu@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

>
> Hi Harini
>
> Could you make use of readx_poll_timeout(). You will need to add a
> helper for the read of the register, since readx_poll_timeout() only
> allows one parameter.
>
> Otherwise, this looks O.K.

Sure, will do. Thanks.

Regards,
Harini
