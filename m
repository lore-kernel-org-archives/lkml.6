Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E4FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2405205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuPRKamN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfBXQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:10:39 -0500
Received: from mail-io1-f74.google.com ([209.85.166.74]:45852 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfBXQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:10:39 -0500
Received: by mail-io1-f74.google.com with SMTP id g3so5971065ioh.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5omNsT0ZPTKqdqXAzdvldkKhggpZUHg+YQpE1aHKJv0=;
        b=ZuPRKamNBpWZLcKfSFfIdKrbdZis4hZimJPGoMuOOifM96/yY7I6ycwynk0dM0in5c
         t0s5p5K9ygHWGLodpgejuM4bJn6dh5pVYD82e2E+ogDuCwSWn9zlldrj9U5xpkfrSHnl
         34kRcB3VGCty+47gJQQHToo2DiI+Tj4E1yxpurbqTGEyy2GDO7D4bkmoD0yWM+YD7viu
         P5OKJlGk+jMWgK64Rcpng8Ac9pi3DxC4aECZGAZDhtmnRaGUg/ZNTvEqKzeiraHVRfZ5
         UkY1JfENaBrQkhFQfku2nt2uiah/bZZK/JDDgUfIbtSA8RSTEzoX4EHuzcj5DtBYy7Fz
         RcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5omNsT0ZPTKqdqXAzdvldkKhggpZUHg+YQpE1aHKJv0=;
        b=iCCqi90qwAZ0BBftVe1qa3IQhF6eunVqB43NJHzEMVDndBOHaxf/5EfuYDz4fIuRg6
         FDEXIDUCePn1L8EURTFhGdtF8zSKNCVlpcCD1ct5DYI31LkWF5z0ZuOxnZea4G5G/f+7
         MUNXLikD4avk+/J9IA0+6yzNxxLE1UwqQWszxo12Yvsok8To77BUgJllF5sYVvdSxLnO
         mRHjfGll/ixiSaGiN8sEqXP1Xuct7qFnU9kpr6/slO+GMHPm8ZXUNKI9Lk6M/8qH2m/g
         gWaSrbgbK2vAFXmkd2sR1HoFceJ5D6fXEHrY+C66im56olAyh79vNT6NUtMaCpXsMOaG
         pz4Q==
X-Gm-Message-State: AHQUAuZdeU1B70z52gPkh8iOh3cjBbpCJ15YBc+GPwyfV06heHUUebYR
        hqJJPnmEzeisVf4ErwLd4le01+oMJ0E=
X-Google-Smtp-Source: AHgI3IbuUutwLZPGseXIYbccxfVrgZQSPboRe2/zyk1lGrqtIGTY61pTn7svjVKOOf1dEmvAjsKJMHqQvlc=
X-Received: by 2002:a24:5348:: with SMTP id n69mr5232427itb.7.1551024638188;
 Sun, 24 Feb 2019 08:10:38 -0800 (PST)
Date:   Sun, 24 Feb 2019 16:10:30 +0000
In-Reply-To: <897e8383-ad75-35d0-5ad9-3d3a8b46b6ba@linux.intel.com>
Message-Id: <20190224161030.253393-1-xmdong@google.com>
Mime-Version: 1.0
References: <897e8383-ad75-35d0-5ad9-3d3a8b46b6ba@linux.intel.com>
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

Yes, it is a generic issue for hotplug devices with current Intel IOMMU driver,
as reported in this thread as well.

The patch you provided does the job in our case. Please update this thread once
your patch is merged. Thanks.

Best Regards,
James

On 2/23/19 12:56 AM, Lu Baolu wrote
>
> @@ -4807,16 +4807,19 @@ static int device_notifier(struct notifier_block *nb,
> 	if (iommu_dummy(dev))
> 		return 0;
> 
>-	if (action != BUS_NOTIFY_REMOVED_DEVICE)
>-		return 0;
>-
>-	domain = find_domain(dev);
>-	if (!domain)
>-		return 0;
>+	if (action == BUS_NOTIFY_REMOVED_DEVICE) {
>+		domain = find_domain(dev);
>+		if (!domain)
>+			return 0;
> 
>-	dmar_remove_one_dev_info(dev);
>-	if (!domain_type_is_vm_or_si(domain) && list_empty(&domain->devices))
>-		domain_exit(domain);
>+		dmar_remove_one_dev_info(dev);
>+		if (!domain_type_is_vm_or_si(domain) &&
>+		    list_empty(&domain->devices))
>+			domain_exit(domain);
>+	} else if (action == BUS_NOTIFY_ADD_DEVICE) {
>+		if (iommu_should_identity_map(dev, 1))
>+			domain_add_dev_info(si_domain, dev);
>+	}


