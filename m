Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C3CC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97E321A61
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4EwkXdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97E321A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeGGLHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:07:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39637 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeGGLHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:07:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id t7-v6so10875269ljj.6;
        Sat, 07 Jul 2018 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJEFotXbzAquOFKXgw8SCEnLyM10C8A3LaDxyc53bUQ=;
        b=V4EwkXdKiSWMXW5x1K9k/HzLxtzjPrD+T/GYQZ5jP7NoOFcB0oFtRDfAQtKg697+C4
         s6Czj+3QbjohXoj+TFAnrxmYkwzYTrgkvSFyjDR6upJ/+/OiEBn2UBL7Mcx1NsTUgKbg
         mte/ogqAiYbvOjuHCfmt3LJBZFGwUkttpRKNtHZtNHTcjCwuQRd65Y9g2mEwRbrLKZEp
         u/bvQntju8xtBQRJx1xpiBJeNXVc3OqYgHlEKsXUCvNE2C3beVmSE8pwtyQPgnp6RT9g
         M+VbUB5ezIYtI38tLUGl+txvuwpUcWID3Ldbs9+2IcVh6BVNTjRZ9i6DccBWybejI88o
         ny6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJEFotXbzAquOFKXgw8SCEnLyM10C8A3LaDxyc53bUQ=;
        b=FSlXFDE9JBOpsyygNRPQwSTVpuuWembscSF+/Lac/MuVJ1v+CzrMPwW20OPQ/aQ9Mf
         H0TPVJQHxY3+bHKqgkNTFe3CmVIay/bvFLTOKKZ0eWl7pigMRRZpiU68EimeeSppCQHD
         MGXzALAn1wDb1bk4INTgyz5dV9mKiMTd2Xy5sJxo6woetjh8vqOmOT8U3BlKkNdaM7qy
         rmrRseoj9U2NpGISt9aG3iMUdFVlOyR9Fg6dEWLvI6Mk31WlKDwbEiiZ/mr1XT9NSlY7
         4Tsl8Otrzyxtjkbce+VH+lflwlAqxKFl73mBp7gLtelnZ7MJrQZb3nyFEvSHGMaavZCW
         whaQ==
X-Gm-Message-State: APt69E1rnPLvvAyHxAS7WbBP5JYeQ0qGEyY5f2aDkjqhLDQRtooVMzDM
        19bQTwQXrWuTbn1DXfqkMP10NVPI
X-Google-Smtp-Source: AAOMgpfrr8zunc3/PHuaCYzHDrm2SPufQ7n0UIwAgAekkVUTsE7ty/Wmo99RAuYcNq49zUtlssnAXA==
X-Received: by 2002:a2e:944:: with SMTP id 65-v6mr8897441ljj.30.1530961629693;
        Sat, 07 Jul 2018 04:07:09 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id p88-v6sm1581210ljp.90.2018.07.07.04.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 04:07:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Skip IOMMU initialization if firewall is enabled
Date:   Sat, 07 Jul 2018 14:07:01 +0300
Message-ID: <1530965.U9eOrqsrov@dimapc>
In-Reply-To: <20180519010710.11693-1-digetx@gmail.com>
References: <20180519010710.11693-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 19 May 2018 04:07:10 MSK Dmitry Osipenko wrote:
> Host1x's CDMA can't access the command buffers if IOMMU and Host1x
> firewall are enabled in the kernels config because firewall doesn't map
> the copied buffer into IOVA space. Fix this by skipping IOMMU
> initialization if firewall is enabled as firewall merges sparse cmdbufs
> into a single contiguous buffer and hence IOMMU isn't needed in this case.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thierry, please consider applying this patch.


