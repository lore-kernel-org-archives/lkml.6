Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E12C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CE820684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEx/fUP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CE820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeKUCsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:48:16 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43528 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKUCsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:48:16 -0500
Received: by mail-yb1-f193.google.com with SMTP id h187-v6so947865ybg.10;
        Tue, 20 Nov 2018 08:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/OLQeObNGd0IBy4Pr7rtk0Du4O9Sp4NE2NCjWtQiVNQ=;
        b=OEx/fUP2CieC2K6VApF5yHUn4YOqeIzlNvYwkf80lGKgIssnrURiCic/xU5APVrMY0
         QKA7mjU7FJYaQ6KIpmJAJ2F8x1U02avEvLh/81vjdGx+XvIrVbEBpu0mrDHDAMW+iy7O
         sa5p3jneIpm76MYCxtx05hNVvA5rJb8fppb5MJXwuMch8AQneH1AkRM2ZzVyXhV6V1D+
         nUBZ0wm5jo+SycWHIyIA+x/I9tX396mKr6Dhlkx/cfCyXyjA1VMbcdaCUji/sEW4epFD
         1L4wSSZSwd9X6EnhliXT60nXyzLjyGiUHyj7yJInU3lRj+i9FnTOBop7/5apaQGEohmG
         UY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/OLQeObNGd0IBy4Pr7rtk0Du4O9Sp4NE2NCjWtQiVNQ=;
        b=JNIhpa3mso8W23SSwOcwJqkakV2SvMXxgE0YAgnD/AhRRNkcIsC2i2+9/MZk3ksEYC
         4BKnqiX8i/gSXDRa5s33iJt0q8w8S7PUuPHbvTnrhbRlBMX74dgDt7YGzSFBx5+UKKe6
         IMDR+py3uTm7oRqZruLkrOrhxw1qwPIp0bCoPNcuMVmjpUUc5l1eOYMpXxVwpllSAMN1
         /OLaTWsrQ4/5nBqfPs57YsgbpXd+OVi0gVTBTMtIa2IOi2sG1eh//ax+lRaZtByZtHtI
         NCC5rgQPxx+dnN6PBEE54IXsur5QbX1NdsaPq2dMt99HRlJ4rj/ZL+iagYSWW3gQlvRO
         rsxA==
X-Gm-Message-State: AA+aEWYQoNpfThgi7nb1ABXsAKGqJ2Fs32paSvty4dxQMDn8jvqduVed
        KHejK1v0NkYUxooVA9YqSTQ=
X-Google-Smtp-Source: AFSGD/W/QQ+DAdafg4XaYpXkjNlIJ27YrSlE24i7EW1UcD7T2e35EyHuqFu2wqlutHVr4dtO4hQ3og==
X-Received: by 2002:a25:8445:: with SMTP id r5-v6mr1977184ybm.182.1542730701122;
        Tue, 20 Nov 2018 08:18:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id p201sm2906019ywe.45.2018.11.20.08.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:18:20 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:18:18 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 3/7] cgroup: protect cgroup->nr_(dying_)descendants by
 css_set_lock
Message-ID: <20181120161818.GT2509588@devbig004.ftw2.facebook.com>
References: <20181117003830.15344-1-guro@fb.com>
 <20181117003830.15344-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117003830.15344-4-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:38:26PM -0800, Roman Gushchin wrote:
> Now the number of descendant cgroups and the number of dying
> descendant cgroups are synchronized using the cgroup_mutex.
> 
> The number of descendant cgroups will be required by the cgroup v2
> freezer, which will use it to determine if a cgroup is frozen
> (depending on total number of descendants and number of frozen
> descendants). It's not always acceptable to grab the cgroup_mutex,
> especially from quite hot paths (e.g. exit()).
> 
> To avoid this, let's additionally synchronize these counters
> using the css_set_lock.

Can you change it so that writes are cgroup_mutex and css_set_lock
protected and reads can be done under either cgroup_mutex or
css_set_lock?

Thanks.

-- 
tejun
