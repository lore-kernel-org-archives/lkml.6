Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A51DC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADA20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="an6fWqOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ADA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJOUUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:20:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40091 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJOUUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:20:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so17319364ljr.7;
        Mon, 15 Oct 2018 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=og9UmACM5DrLcUxc+moRoO36LXCrLbcPoFuNce2qZh8=;
        b=an6fWqOy4fU8BCaPA9NF3EZyuuVQZAdwLcONLJBAj5Bi9OxIOekRFa4cM0bjC2RdnY
         IJgpcl4snfQNpItrZWaFy/XuDGOYktUEs3NCRT/6OUVppHQ07UWv7WW2mT+PY9ye6XuI
         XTszyRCaxC6F2Us3iF57OOe+JfMRKec6mH3OvITEY+4DdE3Cranr8btJ6vi22Gynp+m+
         bAl/r0iltO4faBC+uv2KeCyVfG1EFWsZne0v5ovhi4Hn0wsChq6MZtbHqyj4pwN3HhJI
         ArwkqVA3arEJ1j0FsyBtC0RO31t0RJxrDrEhxrQusRmHPoXr7MRAMGQ//4Inw0kJ3WXu
         fPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=og9UmACM5DrLcUxc+moRoO36LXCrLbcPoFuNce2qZh8=;
        b=I5rmeldqwOT1QBbl1JkkB/5AVLIVBZpHtoars9KyyfE/rEW1/7B1gwrNB+f1og2e9f
         FjjPHKPDn3IBRtshAH3C/acMyBsE44uUq1d0ctA6NlrLdrmw2TKjegzL+aPAHvRruf44
         Bqbiv8r8bzY1Xr84+6KLFLrrrobFHDW++KJPj2LbyyykI3aW49/e+53xxcVyXDs46iP6
         ABC4Z+rhUJtbTy28Cljat4pbk0/27vCpMjJ1UkrYiVv3UodvZLQctHnT4dcC9t25ob8u
         2nd2cMljaITb57rS1bzIT/Gqg8hzh+ATkU/s1xhTpOM5VE8Py5Goplo/Ys94u7G2Bfus
         uH3w==
X-Gm-Message-State: ABuFfojBQJFH2m03di9eBvKavHVd2LkZlnZi3hxFg5efVWcWYx7GTBoo
        3pa6yMacw8+Tawg8JPd+ET20w+Wi
X-Google-Smtp-Source: ACcGV62Dp/Sy77ToltNJLZ+RSlhX0HrU6AuyGDwXBWvdxi7fru0ELyfy1OBJ+p4y435zYiiJdq9slg==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr11626164ljh.0.1539606936160;
        Mon, 15 Oct 2018 05:35:36 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id j13-v6sm2363474ljh.42.2018.10.15.05.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 05:35:35 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] soc/tegra: pmc: Turn powergates_lock into spinlock
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830183635.4474-1-digetx@gmail.com>
Message-ID: <b888a206-0970-01a8-e039-920c03c00c06@gmail.com>
Date:   Mon, 15 Oct 2018 15:35:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830183635.4474-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 9:36 PM, Dmitry Osipenko wrote:
> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
> and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
> offline.
> 
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>  in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>  [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
>  [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
>  [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
>  [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
>  [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
>  [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
>  [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
>  [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
>  [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
>  [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
>  [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
>  [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
>  [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
>  [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
>  [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

ping
