Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CCC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8742087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="l8365Nfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8742087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeJMFzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 01:55:32 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44580 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeJMFzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 01:55:32 -0400
Received: by mail-pg1-f177.google.com with SMTP id g2-v6so6439213pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CoZqybw1+yNMW6oox86CTp/ww4450RR5QGmCjEywFo=;
        b=l8365NfqCoIfWG9bio0oUCcbHbYoApd4BYjr08b02iZCoo4V62H6uGsBmXbuWrNypc
         n0FTp7ztAVHfnsBQHuz+iwSnK520sLtMRFBE3lx9zjyIomK+Rgm2TyrGpfQJSmozeF5j
         xe3TSXLPqc45HSdEVcFBKarjw8r/170PqLQCNEC2HFcOAHWxQfxWq01wFmq7zZMucCjV
         5TILvOXsc6xAs0rWo+HoC8+jC8hitrkdLxq+I099+j1BZA69HX88FpY68ZoXbWYRSrqL
         a3/bm1NiiTEyRNzh8349ND+Ct+MaNtXBoWQAgHqzX0EKH+r6eWiPTiKhjhV5fRTOboBY
         nS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CoZqybw1+yNMW6oox86CTp/ww4450RR5QGmCjEywFo=;
        b=DZ7ML8CeiQbxHMBi1w0URRtwjTPCiS6yGz0a8eWwYJuc411nrua+jsTQqUtzlxBxip
         B5Ty2vKwrjiEec/zdQaIl23nKsXFWX0fcZN6skQl8EghF9d7LyEpnfvzCB7dNWEPkhUi
         8ZJSMq7BwqXsirT//nvATrpgNiXykHoFj4oAS/Rjo6GoEjAWNwiXMqgyBzskl5mLBEXo
         wIv3BO3uon/T0gWWP/+9OjwHYmGhKi9KwJWF1xwxXiSJtKO77TCXsE/Nwm61VlGQShuJ
         MGAcEcSXn4dX5wVQC5C5nUR4W1r6NU3S12tL1UBCNjfq107r7GYoWrhAI99g2MZscggc
         1ikA==
X-Gm-Message-State: ABuFfoiu4MZ6cdhq/Hms+zaUfIf3xP/ixeTLoMfSHYhSkD+0ZZ0VBVD+
        qd9rJWwF2gI3pWjdww8Jj5zRVW+90TU=
X-Google-Smtp-Source: ACcGV63hETCUnNCAAvi6yr20HL1iYkes1iOBSeXRT7jza/OwdoVgahoGuRNqaWukyK2VkcoRq+igbw==
X-Received: by 2002:a63:5f03:: with SMTP id t3-v6mr7238915pgb.68.1539382860736;
        Fri, 12 Oct 2018 15:21:00 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a16-v6sm3270028pfi.49.2018.10.12.15.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 15:21:00 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:20:52 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc:     haiyangz@microsoft.com, davem@davemloft.net,
        netdev@vger.kernel.org, olaf@aepfle.de,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        vkuznets@redhat.com
Subject: Re: [PATCH net-next, v2] hv_netvsc: fix vf serial matching with pci
 slot info
Message-ID: <20181012152030.4f58c65e@xeon-e3>
In-Reply-To: <20181012205515.23355-1-haiyangz@linuxonhyperv.com>
References: <20181012205515.23355-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 20:55:15 +0000
Haiyang Zhang <haiyangz@linuxonhyperv.com> wrote:

Thanks for fixing this.

  
> +	if (kstrtou32(kobject_name(&pdev->slot->kobj), 10, &serial)) {
> +		netdev_notice(vf_netdev, "Invalid vf serial:%s\n",
> +			      pdev->slot->kobj.name);
> +		return NULL;
> +	}

Shouldn't this use kobject_name() in the message as well.

Looking at the pci.h code there is already an API to get name from
slot (it uses kobject_name()). So please use that one.

