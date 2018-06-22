Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913E1C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406A23D60
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 05:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5406A23D60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeFVFIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 01:08:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44782 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFVFIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 01:08:40 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C92EC119C1EE5;
        Thu, 21 Jun 2018 22:08:34 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:08:31 +0900 (KST)
Message-Id: <20180622.140831.1245451103607060086.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] r8169: Don't disable ASPM in the driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180621083039.22545-1-kai.heng.feng@canonical.com>
References: <20180621083039.22545-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Jun 2018 22:08:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 21 Jun 2018 16:30:38 +0800

> Enable or disable ASPM should be done in PCI core instead of in the
> device driver.
> 
> Commit ba04c7c93bbc ("r8169: disable ASPM") uses
> pci_disable_link_state() to disable ASPM, but it's not the best way to
> do it. If the device really wants to disable ASPM, we can use a quirk in
> PCI core to prevent the PCI core from setting ASPM before probe.
> 
> Let's remove pci_disable_link_state() for now. Use PCI core quirks if
> any regression happens.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
