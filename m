Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14380C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED4920866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED4920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIKBLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:11:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33844 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeIKBLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:11:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so42846555ois.1;
        Mon, 10 Sep 2018 13:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpCYglHPHVA4ZcuAqJhkujVqT7RJ8F/aocBAilqevxY=;
        b=f4jsjzGEO8M87moX6k9Za9PhrRVaxYGD6BD5K4vg9XbZ0SENQqB/HFhHdGS1TJbwY4
         Et0XumXBwFtOXXKjh6CBIPpX2xCDz/LuwYmr0xUMEHXh1RKQm9AcgyfQv992QfPMms9k
         5CdSBcipBOW7CU3SxLEEk9NDXg5Boz/f8HxFy38JrTW/HBLxrO2DAKEkQeE0YRFCjH5f
         dsX7mpgJ6PbbaT+ZhG//RcFsDjjMtgO29idXyBRUxA0tAP3rjR9vAeMlT9qsZy2hCkUS
         87sCiwnPzEz7RxnqvvjtLDGwKN4QpWGBnPJf+Dz3kQ4agvsr2nUJPXRdDaf8bxuWuqmL
         K0FQ==
X-Gm-Message-State: APzg51AIzTmpm8GS7n4wjjpxVZ7qfax3XMx1w00bwMjoEop/XBNsSktr
        4eYfTCHr6gVkRcD6fi3HgQ==
X-Google-Smtp-Source: ANB0VdZK+7IASnIt955+DOr0Cqfp3q5I0rLmmqgiqzH9ZzgPot16CTPCuqEh/hkyIN6wYHVq67jIzA==
X-Received: by 2002:aca:305:: with SMTP id 5-v6mr21549992oid.84.1536610524901;
        Mon, 10 Sep 2018 13:15:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q63-v6sm18680270oia.54.2018.09.10.13.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 13:15:23 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:15:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Cc:     kishon@ti.com, michal.simek@xilinx.com, mark.rutland@arm.com,
        vivek.gautam@codeaurora.org, v.anuragkumar@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Message-ID: <20180910201523.GA4024@bogus>
References: <1536165747-6405-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536165747-6405-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536165747-6405-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 10:12:26PM +0530, Anurag Kumar Vulisha wrote:
> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high speed
> peripherals such as USB, SATA, PCIE, Display Port and Ethernet SGMII can
> rely on any of the four GT lanes for PHY layer. This patch adds driver
> for that ZynqMP GT core.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
> Changes in v3:
> 	1. Corrected the Documentation as suggested by Vivek Gautam
> 
> Changes in v2:
> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
> ---
>  drivers/phy/Kconfig            |    8 +
>  drivers/phy/Makefile           |    1 +
>  drivers/phy/phy-zynqmp.c       | 1581 ++++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/phy/phy.h  |    2 +

This goes in patch 2. And patch 2 should come first.

>  include/linux/phy/phy-zynqmp.h |   52 ++
>  5 files changed, 1644 insertions(+)
>  create mode 100644 drivers/phy/phy-zynqmp.c
>  create mode 100644 include/linux/phy/phy-zynqmp.h
