Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AEAA6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646082086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdNVBofg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646082086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeFLTgA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:36:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52186 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932589AbeFLTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:35:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so883170wmc.1;
        Tue, 12 Jun 2018 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FH4GWJUQbywt91Uqiv4s/rPvoA1GUZchfACnO4T4JtM=;
        b=JdNVBofgwBd8ekaN4Od7n0bt8xXzGSnb06oZqN42zeBQnfj1g3Q6I5AbdlK2WRR11r
         hkFtZQkCugq3BL7eva4nRpB77SDAGlY9oBrhO1dzcKrcd8D2XYJud9zXt6AEh9NI+KO7
         4vXjp/G0i+MyyBO/vIUhXgg4ttZC3efUZ13wnH9zX0vM2QgYOF+dyUghRLwFS/ylvGvT
         EuLE5d6BKIIJskaIbpRvypwg5i42y/x6Tm8A3RjQCTHFsrGzHuK7wMi6ll10FlG5Vy0w
         0MwEiD/VUH6iM2Y5NubhLplyg/6k7BKhxOqLZ8QMHJrciYgJi1SfeHIWi4uaPujsSy/I
         QMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FH4GWJUQbywt91Uqiv4s/rPvoA1GUZchfACnO4T4JtM=;
        b=dnL9zdAbZKqc+ZIREjAJfSPSfYvtGfS+MPKzweEM+JeE/jQw2JZjJlyTzi7oVh6Rq/
         h4hbilXPdNR8/+y0b/BSOTz5TBdXFjj5YLMHy9lrQlMZfIYQjpzpiZ+nqzuTEkEk30go
         Ks1omYC7tlIgK7TSau8BIF4F8/jE2RnNYVwRzD+oGE6+q/zUdbYDY7EFDXvcul+NwS0o
         Y6jbqBKl2uudnE2NyZsKxAm5dfzhqilbe43+bThxKPJ1itl7wCekvidkt+yk1rCNU/Id
         AvIrOGzH0vEtvuieURqtskMgmK0JMzPC4KlnLY/ZJzqsEmoD7ANz/bLBfrIWY6vXvZBH
         Q8Bw==
X-Gm-Message-State: APt69E0j9uDThHmuXymM3t8fEhfLWdfjJf0awfMjSdkQw94AoWFYKyTe
        INz/eCW2Lqa+cqR6AoBO1Mztbw==
X-Google-Smtp-Source: ADUXVKK1o5H+18dAH0HrYyCxvM0ebCv7v/oVQmRWwCWrjfQ3abivSOFr4mONr5NgNZdF+Tl9bti0Ow==
X-Received: by 2002:a1c:71db:: with SMTP id d88-v6mr1392801wmi.117.1528832155747;
        Tue, 12 Jun 2018 12:35:55 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:bd18:6b21:eca7:82b0? (p200300EA8BD4D600BD186B21ECA782B0.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:bd18:6b21:eca7:82b0])
        by smtp.googlemail.com with ESMTPSA id t1-v6sm1109539wmt.40.2018.06.12.12.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 12:35:54 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] r8169: Don't disable ASPM in the driver
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, davem@davemloft.net
Cc:     ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        romieu@fr.zoreil.com, bhelgaas@google.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Message-ID: <caa66d98-e5cc-8bcd-1052-cef4ff00c32d@gmail.com>
Date:   Tue, 12 Jun 2018 21:30:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.06.2018 11:57, Kai-Heng Feng wrote:
> Enable or disable ASPM should be done in PCI core instead of in the
> device driver.
> 
> Commit ba04c7c93bbc ("r8169: disable ASPM") uses
> pci_disable_link_state() to disable ASPM. This is incorrect, if the
> device really needs to disable ASPM, we should use a quirk in PCI core
> to prevent the PCI core from setting ASPM altogether.
> 
I wouldn't call using pci_disable_link_state() in a driver incorrect
(as it works), there is just a better way which is more in line with
the PCI subsystem architecture.

> Let's remove pci_disable_link_state() for now. Use PCI core quirks if
> any regression happens.
> 
The vendor driver disables ASPM unconditionally for chip version 25
(there it's METHOD_9), so I think ASPM support is broken in this chip
version. I'll cook a PCI quirk.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Please note that netdev is closed currently. Once 4.18-RC1 is out it
will be re-opened. Then please re-submit properly annotating PATCH
with "net-next" (I've forgotten this often enough myself).

> ---
> v2:
> - Remove module parameter.
> - Remove pci_disable_link_state().
> 
>  drivers/net/ethernet/realtek/r8169.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 75dfac0248f4..9b55ce513a36 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -25,7 +25,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/firmware.h>
> -#include <linux/pci-aspm.h>
>  #include <linux/prefetch.h>
>  #include <linux/ipv6.h>
>  #include <net/ip6_checksum.h>
> @@ -7647,10 +7646,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	mii->reg_num_mask = 0x1f;
>  	mii->supports_gmii = cfg->has_gmii;
>  
> -	/* disable ASPM completely as that cause random device stop working
> -	 * problems as well as full system hangs for some PCIe devices users */
> -	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
> -				     PCIE_LINK_STATE_CLKPM);
>  
>  	/* enable device (incl. PCI PM wakeup and hotplug setup) */
>  	rc = pcim_enable_device(pdev);
> 

