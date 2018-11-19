Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C03C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF7A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="h18Yep4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF7A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbeKTIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:55:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32949 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbeKTIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:55:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so51471937qko.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mUq5+6FfpiSTRRG5FRUBxSdXfoBSyHI18JtLl8ifeb8=;
        b=h18Yep4KLxoQuPuwxzKzm7yIrp7nxmojYUQGZnxZz53BwsAkkSRCfrflVLqgXxz7lV
         jOKK+QfBaw32KaLJbHNl6q5C5hX3ZPJScAptHcm3kkSGMjrZlVZqVk3j1vZPFSgbj4SR
         LOmyIwaITLFOCX6PRCr/bpuNacE4XtDzoiqNVo6r6twDuDcsC89yV4O9xlO/jFOoH/h1
         BUL5y24lHbngX0fzM1ap7oiQlbCJWF03ZRa96+F5wVxgcSAxCbttxHgJ4H78BeBHFxNV
         rVfZRYL8cGFPHHMZuzlLC7CEWIm6kvPChQbADsAbTGTzaYJ2FqBLoqXW5mMdDwXTOtdi
         NvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mUq5+6FfpiSTRRG5FRUBxSdXfoBSyHI18JtLl8ifeb8=;
        b=DaTlztBH1QwKZh/d9y8Zpap8fmUgbz7A//ziCEgMQlM9Wuq7E43aoVLewXahuRARDv
         vj5il7ODNO5mfpZBf4wmDUIOr4LQw8+PixGTUefZ7RXDd9nqgcec4euCXGgZ4HFBo6dN
         uHI/RHMBlJkrAxsRiWOy/+zb+qP7zM92sQr8snKoH4YJULRT7eWb5RZYyo0zEJbJtfN2
         89Vn/rccerFXo3Zp3NZYdqXX5fIu99JJ9facU1jcVwVNMvGDWwbrMQDRNdQYzPfpvd7R
         vppOOa3nqVCIgYs+5vSBQgenGcvL+GL7yboo1Hr3rGWx5ILT7BIkuNbN3hki8KFQPz/U
         vtow==
X-Gm-Message-State: AGRZ1gIiZPkVdikAotCNJ2PvT7PBzKXBdyIw8VaCMyNa76ZoFGhjFfVi
        RoZVVos3iKHaRjwqGHz2SX/YVA==
X-Google-Smtp-Source: AJdET5f7UE+PrBKvkvuIDvcwToDliWufqdDrfuKmGOQy950q6XhqCpFP7fYhBXIvotPCBXCALNtJ8A==
X-Received: by 2002:aed:2b01:: with SMTP id p1mr22985346qtd.101.1542666599497;
        Mon, 19 Nov 2018 14:29:59 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s9sm30018328qta.35.2018.11.19.14.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:29:59 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:29:55 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Salil Mehta <salil.mehta@huawei.com>
Cc:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH net-next 0/8] net: hns3: Adds support of debugfs to HNS3
 driver
Message-ID: <20181119142955.56b6baa6@cakuba.netronome.com>
In-Reply-To: <20181119211845.23168-1-salil.mehta@huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018 21:18:37 +0000, Salil Mehta wrote:
> This patchset adds support of debugfs to the HNS3 driver.=20
>=20
> Support has been added to query info related to below items:
> 1. Queue related
> 2. Flow Director
> 3. TC config
> 4. Transmit Module/Scheduler
> 5. QoS pause
> 6. QoS buffer
> 7. QoS prio map

Please provide a more informative cover letter.

=46rom a short glance it looks like you add a single debugfs file, which
can be written to, and upon that write the driver will dump stuff into
kernel logs.
