Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF993C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F63208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="uq6iHASD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F63208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeLCSyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:54:04 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:41736 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeLCSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:54:03 -0500
Received: by mail-pf1-f177.google.com with SMTP id b7so6829874pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rAAx7BZibKLvxgAREOeqyaB/D2qK74/zIA/3uaPuhYE=;
        b=uq6iHASD308tXE/7x5vkUN5hJmC8w1BGNJoKSy278AnPpWRETdaYoLtfwgNQb7EFkt
         +MBfURyIoiOWAT/eqsunRbVht1B6KIgkX+9Va0PFVvXu6c7abmbh6Yt/QWniB87eOtPC
         cCVOP8M0RBiPnZioyM+77FivvzXIo7VRI4K6va+qA5StSFUhy5k9MDrwqaoFr/W43A9G
         n4vemrFd2+HDy0VEBlN4bjRQbyJxyHSRwk+TydRijf1sXMOWLfseMTcxCncPCSsFdHn0
         t9f5M4SDl888/7r42hVq68LIVnqKG6aP4/juylM2WhnhtY7tmmkHDl/BfslLka34fYeC
         /R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rAAx7BZibKLvxgAREOeqyaB/D2qK74/zIA/3uaPuhYE=;
        b=aNx2OgZUyj5aC9hT6m1zElYQwXAuo242N70ePIsFgEI4qD6L5Qf2NSw+kkGzeNj7JH
         oW+y8zz0qAqV6mG4ti70j4kKIazcHI6JxRp0RBvMaqw9t9DU/qACIsUd6ZIrMCxNaHh0
         MPr1v9b2k648eV9Z2VnIgqWgbE8ztuMeSaB/pzScUd1yGZyXLOnlBafW1dgzKPAavjOl
         fxHIi9pr3/E7YqM3XxN/7NGyYI9acgylMKUO2xie2p08NLf4p6HGX9qN46LWy1nax+Va
         NciUhtoe2dUn9E8dBi3Cd6RnoSJnykLDLkMM/8JhbmdvrUH5Nraywo1tS5MD/qoLCHnK
         rUMw==
X-Gm-Message-State: AA+aEWbxY9ZxKr7Qdgf/fvSteslLBhMN8mtl59TN0eCVCEmQ7sZiunYa
        Pwcl+poNxqCAPvPkI6C/0qy25w==
X-Google-Smtp-Source: AFSGD/Vl/Fg88QFXHEKREeNnQEHuUzeJFsBgU3GzipPDiiNECBOKgpd87J6meJGqVVDUlyFWr33OeQ==
X-Received: by 2002:a62:5444:: with SMTP id i65mr17594424pfb.193.1543863240511;
        Mon, 03 Dec 2018 10:54:00 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:727e::5])
        by smtp.gmail.com with ESMTPSA id c20sm27112031pfc.92.2018.12.03.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:54:00 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:53:56 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     davem@davemloft.net, nick.viljoen@netronome.com, joe@perches.com,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfp: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181203105356.1c60e5b8@cakuba.netronome.com>
In-Reply-To: <20181203141335.12928-1-tiny.windzz@gmail.com>
References: <20181203141335.12928-1-tiny.windzz@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Dec 2018 09:13:35 -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
