Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9942145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vith4LQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9942145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJRRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:45:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeJRRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:45:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id r17-v6so548738wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=axE8sf2kya7XyE6oqYQW09Iob6sWcrc2BxSlNfVwAGA=;
        b=Vith4LQ0PZzjKOvoXY28jgaGUNyIFR1M3iDVLWQkOfSozRhI0TkrWSbSh7bRn1q7pM
         ShcpAsuxjtCgn5jZqpvRbotRAEiW4N5+fCWraR+cZ1mPPtqy+L5wlebksZI/GSG7O3KK
         DgN7BttcFBpmJ1qu/sOceKKz2EaFbbqZjGzjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=axE8sf2kya7XyE6oqYQW09Iob6sWcrc2BxSlNfVwAGA=;
        b=DPdrVWNB22fpgBoqTBNv7SRYjpcgT6llEjal2Y6Xi3waVC/WZARiQVQiqMYuBI2+3R
         aW3qb+UZmnY1y+Vshu6wGujweh87wZ4RsrL/zo4Ujz9e2NaUvcDGGjZFx/k0qtoOyxoO
         cU5ajTKUoIx5d1dhE/BKh2idumz1eSY/n7vgUeoCrVGoclNGQ68dI7lVXDc6lWFBDyf2
         swL6T+Yu6edzal8Vqd9Wf1qxA4quBizezEZG6sSIjI5huHHpM4eXq+NzVCBEtdfbeMhT
         BlYSBhsSVca1/SS4cPkNh86aprv+aWoGqbHcBJnubJGtnB9Y91zWHCi9JFhRKB/HCuha
         czqw==
X-Gm-Message-State: ABuFfoiDvPcxTrKvrMXNjBVn7TyOsFqRf8O8ZIBvp9nwX+tuQMbQ/mDy
        bTlhuRbXT4oKkT8J0XWk5kwVZw==
X-Google-Smtp-Source: ACcGV61KxeoOZ/WfnDkDXPQM2oNEKBigL1b+f2WFbVHj186NFKSm33H1vEXQhDKDR6GN8O/IuWkdHw==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr29670480wrq.189.1539855905462;
        Thu, 18 Oct 2018 02:45:05 -0700 (PDT)
Received: from [192.168.0.40] (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.googlemail.com with ESMTPSA id z4-v6sm15731724wrt.13.2018.10.18.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 02:45:04 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org
Cc:     thara.gopinath@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, viresh.kumar@linaro.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <ff7cd793-e186-9f38-5e9e-f77cccc749bf@linaro.org>
Date:   Thu, 18 Oct 2018 11:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2018 11:35, Daniel Lezcano wrote:
> It was suggested to set the scene for the PM components in the
> scheduler code organization in the recent discussion about making the
> scheduler aware of the capacity capping from the thermal framework.
> 
> Move the cpufreq files into its own directory as suggested at:
> 
> https://lkml.org/lkml/2018/10/18/353
> https://lkml.org/lkml/2018/10/18/408
> 
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/Makefile                                   | 3 +--
>  kernel/sched/{cpufreq.c => cpufreq/core.c}              | 2 +-
>  kernel/sched/{cpufreq_schedutil.c => cpufreq/metrics.c} | 2 +-


I forget to git add the cpufreq/Makefile, resending.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

