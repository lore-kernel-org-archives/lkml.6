Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359B9207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzI+Ai/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfBVI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:28:37 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43556 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfBVI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:28:37 -0500
Received: by mail-pf1-f202.google.com with SMTP id 19so274686pfo.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7KTT85rso/lMKhuSDgs90LW52B1l9AJKr+Kc6YQAGto=;
        b=RzI+Ai/jnsjup7nCegI1AKo9l+dfXmUQFi8NBWkg32GCtVSb1UWxgQI2qRqBEmzhIh
         hEQ8eCk4G3i5r7mt4pequ5wuyPS1naBXZyq2PzuRlS6akYO6bzvo9JKdWNo7Btrlher5
         6r0dh+UVdnEbaLdEluhSewcwRaI/t6cKXAv9pTLJREWLlrNsE3uE8vKdBv6tokGSw2ak
         BqK+wcPuIptNTmO3FXrAU6W5f5BzRmHn8AT4ix4q8rnz9GSx+C7664L2UytrjFLxid2Q
         W/4ryvL+AG92Hb+1UTvBUI0YH7yKo3qEkbT3i1hPTHvBqtymTDp9cxcsP3SytEwkkqml
         2N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7KTT85rso/lMKhuSDgs90LW52B1l9AJKr+Kc6YQAGto=;
        b=Npw1QGIHo4pJljBtzWwJs8p8CVyZFOSH5eMjXtCUrnRGe/ebF+TOtEW5vy6BQW2S7d
         YgFiukviCXjpGc8peE6PaA5LJFpGtD08MlNIj435PpnPPJ35duB28RZNvJq5THYP4Wpd
         GL25dp8El4dqPjl5q1RXtXQgdQe1LfHm3EB82u3Z9e9RonEXVEFCJP63L46JfqRk25LZ
         y0ahXc/PNrBPoIaQ4ILZMy3Lcr7l+Kojo5z/FNBxir2Zc1GJ5iUYi0MUs57wLg3xKq72
         Efnjf6oT5g4MRKku1TWcJqinZwtnoo+v7p22XgQiFsm1c/ff7Y41bm5//nyEaqfnU8Wx
         3s3Q==
X-Gm-Message-State: AHQUAuaslFVirEL9j41MTIGMm4rwzpsrvbhuXqKNEsWrZBjSxvnlqgiz
        ulqcWcFIJxskcIlxSvsmI3FJTnvP0Jg=
X-Google-Smtp-Source: AHgI3Iaf2vI/mXrfv5sfowxJbktDloQiEXYdLTjnCCUNMfyF6usVhtKNq0ezIR7a92XZAumDuAeLSLR8TPU=
X-Received: by 2002:a63:c847:: with SMTP id l7mr944432pgi.119.1550824116314;
 Fri, 22 Feb 2019 00:28:36 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:28:29 +0000
In-Reply-To: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
Message-Id: <20190222082829.75567-1-xmdong@google.com>
Mime-Version: 1.0
References: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: RE: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
 mapping setting
From:   James Dong <xmdong@google.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jis Ben <jisben@google.com>, James Dong <xmdong@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolu:

The reproduction depends on devices. HW passthrough PCIe devices with default
identity map could have the issue. Make sure that messages like following came
out in dmesg and their mapping does not change after booting:
  [   10.167809] DMAR: Hardware identity mapping for device 0000:30:00.0
  [   10.167823] DMAR: Hardware identity mapping for device 0000:30:00.1

Devices which make following true could also be used for the experiment:
  > static int iommu_should_identity_map(struct device *dev, int startup)
  > {
  >		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
  >			return 1;
  >		if ((iommu_identity_mapping & IDENTMAP_GFX) && IS_GFX_DEVICE(pdev))
  >			return 1;

Once they are up, remove them first by following command:
  echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove

Then trigger the hotplug device rescanning:
  echo 1 > /sys/bus/pci/rescan

To provide an example of specific devices on the market, I need to try out.
Or, if it is fine with you, forcing a PCIe NIC card to be default hardware
passthrough by changing the intel-iommu.c is another easy way to reproduce
this issue.

Best Regards,
James
