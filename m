Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F95DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A1720881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="VkpOVspP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A1720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJPDnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:43:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38474 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeJPDnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:43:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so10221042pff.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zTGhJWUuog5rNyx6JT5xM8E6VgDkHdp2o3ZQAjpKr4=;
        b=VkpOVspPiLHf5MZTVHpoSJoxMxpuw01E04jUUBSQefTHpeknWq0J+fpCq3GVLao+/Q
         Jz0jJP+RiAe8bqPdUEKq1o0yfGliQOON7hJ2i1kHOnQckPYaBhjfDZ26gECcx4SC6cZz
         XoEKamnupBt6eG7EcyAchfMuIocT1vwwFvKSRiJmbLOjfnK6YIGv1oMQmWi4BE716Pc5
         y3PBsUjTw6YolFuJhUiUTt2uWbEl33ZYMsJsWlDSUyg3HtiHMU/qvOUR7l3/TbauqVFV
         HwboOvBl87bw09i2zgZRQ6C0YzHau0gzbGVZx2iW5USoHpqPq2UlW0J/lpm8FwGE9xlV
         UEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zTGhJWUuog5rNyx6JT5xM8E6VgDkHdp2o3ZQAjpKr4=;
        b=SME3iQnMv7CIP+dbeMDwznmYcefECZobKhjUfF0wlJsvTtnhJb0ex5JsJ0bZQefmpn
         BIVxG6QCl3juZ+RNXJhZOuAI0ap4PzbxORE/IAlWF3RZnL6wR5Q9tVvyOY48BLuHxd4M
         yYrAQc4NiF9nCsOa3ilpLgX0ZE/Ksvwb3RHp4rOoMJglLlpU9euKVfKr89fZm7YFkJCb
         eJaLxtmg7kCxcsWv7V5nQlUB5ngXFJRAHDzoSOwv7hqWWhgtH0jlD2JSYXPdJV9PCbRM
         VgMiki5A8xq/bkccNX5ZYahU0sfczW4gpNZ/0dBhE+/RCATaraKAj2JfvyD4kT1MY4D3
         WEpg==
X-Gm-Message-State: ABuFfojV0cANxvLzEbYRT+zYVOfuX0FIUfubIW1CA5oT54tcaTs9eYo0
        uxYtcuauq1OAUq/1/RlEV8xQLBlUOqc=
X-Google-Smtp-Source: ACcGV62MAgrOGj29P9qrLjNYRl39Ok4mqU+TgJGmizBSWwgeffT0xFu9En+NE2xx2ldMtfyD8VxIzA==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr17123777pgb.411.1539633389237;
        Mon, 15 Oct 2018 12:56:29 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d186-v6sm17518692pfg.173.2018.10.15.12.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 12:56:29 -0700 (PDT)
Date:   Mon, 15 Oct 2018 12:56:27 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, davem@davemloft.net,
        netdev@vger.kernel.org, olaf@aepfle.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH net-next, v3] hv_netvsc: fix vf serial matching with pci
 slot info
Message-ID: <20181015125627.0516de8e@xeon-e3>
In-Reply-To: <20181015190615.30628-1-haiyangz@linuxonhyperv.com>
References: <20181015190615.30628-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018 19:06:15 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The VF device's serial number is saved as a string in PCI slot's
> kobj name, not the slot->number. This patch corrects the netvsc
> driver, so the VF device can be successfully paired with synthetic
> NIC.
> 
> Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>

