Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E26C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC9220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="db9RS2m0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXxiHvbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC9220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeGZHXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:23:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeGZHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:23:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9453C60B7A; Thu, 26 Jul 2018 06:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532585267;
        bh=iU9qvAjLcbg1VftyvKJRpvf2c/x12jD8fuhCRmWGqPQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=db9RS2m0+ui9/OU2ImUqdzQGAYoh06Wv6dMjaGmxGz0uW9rlva1SbWHzWqeSbF4Kn
         CRaHtxtojPVpvTEol9MIg4ltnCyjeUtZ/X7sdYfo5K7obaGg4aN8E62R/JB6m/esxi
         yQaX0YN2eQ8gSZ3/0w0+RIA6CFq1coSPyFV5LFKI=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B002B60B11;
        Thu, 26 Jul 2018 06:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532585266;
        bh=iU9qvAjLcbg1VftyvKJRpvf2c/x12jD8fuhCRmWGqPQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hXxiHvbQSgHYMtlgbnHHdYnVP3IVtA3XVuObv49b7N+3TuEZ5bBlaebOOx3hLNXi5
         9oHMB2GF1yf2hL5fPxlijis4BWK89y+sH+rBIkYVrTGYTAtJgxQG456Jw5Ku4t7AWG
         SBxCtn8nu6oNf6SYsNNHttHji3ciH+w4UobAKlSs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B002B60B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        ath9k-devel@qca.qualcomm.com, linuxwifi@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ath9k: Remove unnecessary include of <linux/pci-aspm.h>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
        <153254835812.92573.3566522887325831923.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date:   Thu, 26 Jul 2018 09:07:40 +0300
In-Reply-To: <153254835812.92573.3566522887325831923.stgit@bhelgaas-glaptop.roam.corp.google.com>
        (Bjorn Helgaas's message of "Wed, 25 Jul 2018 14:52:38 -0500")
Message-ID: <874lgmv8b7.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The ath9k driver doesn't need anything provided by pci-aspm.h, so remove
> the unnecessary include of it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me and feel free to take via your tree.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
