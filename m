Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61FEC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B7E2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="N5r8+FgD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBHWcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:32:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43141 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:32:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so2109173plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 14:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MmHhrZCWwf0Jj5r3oFevIAVOPwXt80Sip+HsREXIZ4=;
        b=N5r8+FgDBOm7C2HUHTNnWDzMEI0dVoqLf+amRiv8hZLSUErnKYrK5NfT4KaVhX3cI+
         +nZjfY0Gkq8DAUsUSVBekEk/dBcyauLDUL0l9l3NmpcqIsBQm1YpMxU3olDyLuJ9PGoa
         VWruqA6cZgDn3POeESbgrGLj+rl5LRFsu9EiMZBYTrM/YRnCLRBjdqUfjCUO4wgIoi/x
         DlSUfPvFVdrurKv3+f10m+zOsejeGDwpTD46SmdFgkijWiuT2qwKuig06Ihhd8EU+7Nl
         kYZwtWgJwZub1Axm3b8/hO3lBzeh6TkIzcyOtULmnUl/2YjH1az8EQ/RFcOlPk30vhVc
         LCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MmHhrZCWwf0Jj5r3oFevIAVOPwXt80Sip+HsREXIZ4=;
        b=Ew9QKCSAF7cVY9cIsI4FA5xSX8BX2MQQp0SEvYhbGwC9QGDQ3dmFRjjEmkXUqZY85U
         mwHT4w8iInLEET0nIhADcG6wWvk2i05nwfLkssZUvPUMCLTn6K5uI/6sB7q8PkqAVQNS
         KRlJDINMCKxtIVMlJ3WvtYN77sqfifCktHdjZLcx2I7fo23Yt1tw+KVfB7dheYV/NHA7
         82e8doFhMqon/I3LFtubiTo3GBoQn/6RIjAHML3HmM8sOjttrPvttDBQkqLnvr/yYsjW
         pGcNz80kByiceg7GPZVgxa5VrP+jrc776ahMT23nWod3fPLCYJnpgMlEzYHxdMGo95k1
         TIsw==
X-Gm-Message-State: AHQUAuZD3KPWQpStkhrereLk9zoRJU7ekSu2IKvKKIxJ0szqXt5f9fuf
        6iBViGS+5SF/V0nU9btFQO2QoQ==
X-Google-Smtp-Source: AHgI3IZ91QzJG9fsgrqU++3IVe7tLzNrhOwMELRzWaq1YHGPqGPHcCs9hFptucLC34D9nZIEeMyvZw==
X-Received: by 2002:a17:902:128c:: with SMTP id g12mr24307583pla.146.1549665135950;
        Fri, 08 Feb 2019 14:32:15 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id n10sm4992076pfj.14.2019.02.08.14.32.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 14:32:15 -0800 (PST)
Date:   Fri, 8 Feb 2019 14:32:09 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <20190208143148.052c8d9c@hermes.lan>
In-Reply-To: <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
        <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 05:01:12 -0500
Kimberly Brown <kimbrownkd@gmail.com> wrote:

You are right, the current behavior is broken.
It would be good to add a description of under what conditions
monitor is not used. Is this some part of a project emulating
Hyper-V?


> +
> +	if (!hv_dev->channel->offermsg.monitor_allocated)
> +		return sprintf(buf, "\n");

If monitor is not used, why not return an error instead of empty
data. Any program (or user) would have to handle that already.
