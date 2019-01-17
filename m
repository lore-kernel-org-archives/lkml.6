Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564A5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249522054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcyY3yHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfAQK2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:28:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36623 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfAQK2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:28:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so4268294pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 02:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Km1cfzQ/hMEWc3AxHM51l27lTf65fOZ4glWH5feUhpQ=;
        b=EcyY3yHi7zKPCkMMUCAJGiiZXlOHdySISiSNLf4jCs28GiDcMFgqy2/WmsI43jc1hA
         PU6CQ7nzbHuuN9e/ee1jaVaksVBN5o6bzj9xKL2YnsmHnzewzYyyP0CqvD76MYNWsNWo
         X4q5/2bQpnsbQ5oh5O3BGk0/TSFQxF47Pv/kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Km1cfzQ/hMEWc3AxHM51l27lTf65fOZ4glWH5feUhpQ=;
        b=Ajz2rKkirzhXgvHJf+vFkTE5VDMLdLgHg22Hu/OWh0RbDCs/b+q9svQhDUiIY6qtxT
         mBOcwKCYRQ2rtGqyAmErKIkj+J8nKgsxJvQz9la6V6aASAsmxpbyP6O/VMt8OZox6X/6
         5nU/oCg67PyK5Q9v6Pye/gH9m1yhYmsb7vLFPhIR5TLUyv6DTSZkB0KqMd4SZJ3z+Mxs
         kK3gfhDA5HXn37b1KIGomMjiSToJ3A8WpM7MEFwIytqxaTdMrSiuHMtVDJ8oSoFbtONZ
         A/uG3sz9SxZjzoHOrpHAYjh2AtqLWVCMoJJn559SK5nl/+l05df+7/yVxixo75sL7LSi
         b1PA==
X-Gm-Message-State: AJcUukeizOn1emfllZrv9TttjWKTYNunGlBBophL40jn1ljhWqfizjNZ
        4+ZoiBEBh3oR213b7E/6qHEHrQ==
X-Google-Smtp-Source: ALg8bN5PlbXwykoFB5VP+i/S481hEwUbzpTdF+NiYBsxRhyjum08eIBroMsBp3Juk3jZ0ak4P0DieQ==
X-Received: by 2002:a62:a99:: with SMTP id 25mr14161551pfk.121.1547720922180;
        Thu, 17 Jan 2019 02:28:42 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id v9sm2394725pfg.144.2019.01.17.02.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:28:41 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:58:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190117102839.xrkhmghp44nzlytd@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7>
 <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
 <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-01-19, 11:14, Rafael J. Wysocki wrote:
> Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
> too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
> then, AFAICS.

That works and this is the easiest of the changes to make :)

-- 
viresh
