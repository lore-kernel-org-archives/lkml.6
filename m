Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A020D2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fRB25mlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A020D2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbeGMHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:40:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbeGMHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:40:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so24010603wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=okQBUURqpmt9rwgYUbk4woJWkbBP/cfdnjziPlE8M/4=;
        b=fRB25mlfk+vxO8b9etpo70Smn7ZUclg0J/gfIjitg6QyCWTlG/6QR07k3ztSWjK1rt
         bpjB1L1N5/GR/aOE/DQxDNW5OtASAN5cnyYE/d+uA1DAY3TgHqkodcmWfjlM/2X5bvWW
         JnQ/aq5VEX5IyFvD2BkoLqKaSjCbs7mDs8O0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=okQBUURqpmt9rwgYUbk4woJWkbBP/cfdnjziPlE8M/4=;
        b=h8Y2V5dOI3sRB2mwL6YQdvPzkiLgcnxMjISlkEnPwGsR9kmb+Zlp+TThlB19qjklKz
         apH9ZQDX+ErK4ugoLV09ofj1aXQcT64d1LdCdc8BnXM4aDGleFZmhI7QNxYbNZQqfhsY
         sJ55yRnjLUVTAxFvXXnpIaVK/w1TbSSGD/pED6MaCiOYx4ehhj72zkA91SNccwgnMg67
         j3aMyfOmf/0NUj9qNO4EvM3tVFQLGTHdm2arJh3KzJIKaqjEG5qsX5WBaL89BJ4RW4mx
         FrEQMQrjXJp1Mw5HtAOOjBLoCo7zXEB6mxgQsvZhsixrpzma3KWcj4FUsPEqfTnWa1Gr
         dvNg==
X-Gm-Message-State: AOUpUlE9g+1Kvhue/lVEty7muD2Hhrha0G8xV4UKn3KJlDZ4d8h7nyx1
        h17SGt6ga+FxsWvQqbzCyw5PnQ==
X-Google-Smtp-Source: AAOMgpfLKcXsi6aTjD05GOUiHr/UwOhNXdKBMtXK+9qqfQcDrsQkJ8XyzHUGPFWceLsY70RMPl07qQ==
X-Received: by 2002:adf:e78d:: with SMTP id n13-v6mr3948048wrm.136.1531466819830;
        Fri, 13 Jul 2018 00:26:59 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id 64-v6sm15795077wrj.50.2018.07.13.00.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 00:26:58 -0700 (PDT)
Subject: Re: [PATCH] hostap: hide unused procfs helpers
To:     YueHaibing <yuehaibing@huawei.com>, j@w1.fi, kvalo@codeaurora.org
References: <20180713070317.6724-1-yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, davem@davemloft.net,
        Randy Dunlap <rdunlap@infradead.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B485441.1080305@broadcom.com>
Date:   Fri, 13 Jul 2018 09:26:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20180713070317.6724-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Randy

On 7/13/2018 9:03 AM, YueHaibing wrote:
> When CONFIG_PROC_FS isn't set, gcc warning this:
>
> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>
> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>              ^
> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>              ^
> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>              ^
>
> fix this by adding #ifdef around them.
> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
> into #ifdef.

There was already a fix for this posted by Randy Dunlap taking a 
different approach, ie. use __maybe_unused classifier. To be honest I 
prefer the ifdef approach as it is more explicit and does not feel like 
a cheat.

Actually some of the functions are between a flag already 
PRISM2_NO_PROCFS_DEBUG which is in a private header file 
hostap_config.h. Seems like this would be better placed in Kconfig and 
depend on CONFIG_PROCFS. Anyway, this driver is old cruft. Maybe some 
people are still running it, but it is probably not worth the effort so 
fine with either fix.

Regards,
Arend
