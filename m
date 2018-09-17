Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098FAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6A42088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WtpHWIvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6A42088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbeIQTaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:30:52 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33258 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:30:52 -0400
Received: by mail-qt0-f176.google.com with SMTP id r37-v6so15368925qtc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=uIX2Rh3UCaUYz7ZnRqJgXFg1q8v1cg2ZU7VeA1RFUbk=;
        b=WtpHWIvT9xupj0e0R4baBZ6qQo6YZxa2/a85Xxuyvru1ZYFOuDlq8+OHMxbsG4uj8o
         QXq3HPVxenk0q9EPpDfGxbWT4raWshNTJRu6A1zy5Bsw69ITw/sk3LYQvwWe5SaWYcmC
         R5GCb7/uPO/2vfIQapvpQJMDOrIQLPLyqqhFSjrGuqKlmVW3/PfabQOQXRUkcG3B4ND0
         HGdbEzrw5uDC2Aef5rsPYMiVwRGwwwOW6mmZHqTG0FWgRrNhAZ/1KsxUOQEsyaf88vl6
         HfJce/uJ2Hi3r3dPIqabcn1VmGfz8yfiTGVe3wJ+L7uzoo0rLubUjy/oaviaWkR1+Ic0
         funA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=uIX2Rh3UCaUYz7ZnRqJgXFg1q8v1cg2ZU7VeA1RFUbk=;
        b=C4ii1EUEBnUu7WYuJiuC3JdsXD8s4iAGpCWoA7GI4fXsPNmugO1LTth8FXiUgiYdkP
         LkPNIki/UseVngXCgcoR2uTzvYwbb3CiSjjv6yUUBVUwmt6Rc7N6CgAwwgQsLoTcUza+
         kA9D6N4w8Ar1wvndUnQL7tZZctakM9PjfZRKX4Kb/ulht+MwQ+nr96TbGY+HKsZ4mbND
         UvcCiRshNu2tyqWa81HYgwfTVUefZHPDtfhtp37ZFnXLqZSIr/V1piWzpmLELsIhOcvx
         Cb1T6euY/tlqLfs3qDsQDsUBkndIrJ8UeC9iPwdi856AG+hnVbEhgVCwNIuxt3bIfPFk
         DHUQ==
X-Gm-Message-State: APzg51Dj0LSLr1yH1Qo/smzj8VEOOsW/X2kEZpW7cnHW3hzShl+N2AoY
        Uxx7/xB3+5HBSWRE9J9uGazXMg==
X-Google-Smtp-Source: ANB0VdZKDVsgnAHbVbJL8VbYAzB0hd3OKJsYM0MuMylB8tpxd2R196dCYGI+PJLaSNFBHANV0mYmRw==
X-Received: by 2002:a0c:c38e:: with SMTP id o14-v6mr17821829qvi.36.1537193001990;
        Mon, 17 Sep 2018 07:03:21 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id u184-v6sm8936141qkc.87.2018.09.17.07.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 07:03:21 -0700 (PDT)
Date:   Mon, 17 Sep 2018 07:03:17 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL 4.14 52/87] nfp: fail probe if serial or
 interface id is missing
Message-ID: <20180917070317.19c09e88@cakuba.netronome.com>
In-Reply-To: <20180917030220.245686-52-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
        <20180917030220.245686-52-alexander.levin@microsoft.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 03:02:55 +0000, Sasha Levin wrote:
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> 
> [ Upstream commit 18aa5b180f00a10c2f63944b4f0ab116bf8ea19b ]
> 
> On some platforms with broken ACPI tables we may not have access
> to the Serial Number PCIe capability.  This capability is crucial
> for us for switchdev operation as we use serial number as switch ID,
> and for communication with management FW where interface ID is used.
> 
> If we can't determine the Serial Number we have to fail device probe.
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

If the problem occurs the driver would usually fail to probe anyway
(e.g. due to missing SR-IOV capability), just without providing any
clear message why.  So the patch is not of huge importance, but I'm 
not opposed to back porting it.

I should've put this info in the commit message, my bad.
