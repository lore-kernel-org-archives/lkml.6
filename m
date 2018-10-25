Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF55CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CEC20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CEC20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJYXVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:21:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38085 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJYXVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:21:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id k19-v6so6880811oiw.5;
        Thu, 25 Oct 2018 07:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BreMMZGMFBdTXNCV+sss0CsEzDy9qpYfyC6i10Lsrg=;
        b=osn6ZYx04q16VcgYoHc7OdTCOnufQCB0yscCYFc+y5pmW63sDUpkZ5Sc6HPkzth+h3
         Ybti1P1rxLiWK+RlmeD+K1gFWnKDA/rOZCkU8xDWE+YK5U0AFS8ZEWMnR2Pr7YcSzJwf
         Ah2/Lbzl1TWJ2J4umlxWV56fz2nfk3o6A4wzaoz0k5rQ29LWXzJishXpjnnuZkJhtvQ/
         ll7EOA62USydVyNtq6osbsbwir6OOr1Vbrsh45xwN/2ekf+pdc0g1E88+M69EfPQ/cY/
         LT0d8AWq3Js05hlr563qN77QVc3Q5yMqCgVJ8miP1c1uiFb2SGeK6bI1Y15nlNZqv06S
         rM7Q==
X-Gm-Message-State: AGRZ1gK5+aWiOK286M6S2A/FElKEN30QFVUy2ypNWlMuFi9aZ9qJNSIQ
        VSA7oDiw3b1v33XAx+JYqA==
X-Google-Smtp-Source: AJdET5ccJmzBi8kCMJUxNz/3BzadyulcDbwGjjOW13fNesvmmkUc4bknCqmPYDwzMiVxi3gDzE11QQ==
X-Received: by 2002:aca:5dc1:: with SMTP id r184-v6mr623972oib.242.1540478922912;
        Thu, 25 Oct 2018 07:48:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e9sm2643918oth.7.2018.10.25.07.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 07:48:42 -0700 (PDT)
Date:   Thu, 25 Oct 2018 09:48:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: Re: [[PATCH] 0/9] *** DMA support for UART in ASPEED's AST2500  ***
Message-ID: <20181025144841.GA21004@bogus>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:40:57AM +0530, sudheer.v wrote:
> DMA controller driver  and UART dma client driver for aspeed's AST2500
> 
> sudheer.v (9):

We need a full name for author and Signed-off-by.

>   DT-changes-for-DMA-UART-of-AST2500
>   Defconfig-changes-for-DMA-UART-of-AST2500
>   configuration-for-DMA-of-AST2500
>   Documentation-DTbindings-DMA-controller-of-AST2500
>   DMA-driver-for-AST2500
>   configuration-for-DMA-UART-of-AST2500
>   Documentation-DTbindings-DMA-UART-of-AST2500
>   DMA-UART-Driver-for-AST2500
>   updating MAINTAINERS for DMA and DMA-UART drivers of AST2500

Your commit messages need some work. Use 'git log --oneline <dir>' on 
each directory for inspiration as to what the subject should be.

DT bindings specifically are "dt-bindings: <binding dir>: ..."

Rob
