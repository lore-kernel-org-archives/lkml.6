Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C31C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC332086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="s49tnqEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC332086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeK0TpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:45:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35735 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbeK0TpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:45:15 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so15779271lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UGetyeGloFdXMAyPCmZTYPSFP+5M1fESfeEH0CNG9Sk=;
        b=s49tnqEcQPZggH4VwmdZ9ltcZFkHAr8c+8wqwGGv7RSkgX+3F/zyjYVd+yE0EysY5p
         0VPpksHSTb7FWomuN36okAI3gWMlurcgczpYoYNUvdx7/EAntTVawBSC+kb2NJkK3sTR
         PduWUJEwd4LVGMMvokVyY6wi0OYI7HL9nDbqD6xIvicj/CSTwMLLQIqV5p7uI+HKB1Hb
         +qyJkhemA9mDDlq8g1KRPkYSMr1NqruUfg6j70X/7maogE+xehAoEdkbLZ4tNwRnwL4p
         6PFgGYqIJI4u5FGaDG9pfl/1PUy1Vh0FH4aobmA90aNdHwrB6+8ziIFqOYYMw8JG32QE
         6s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UGetyeGloFdXMAyPCmZTYPSFP+5M1fESfeEH0CNG9Sk=;
        b=XcUi8Sfu2Xi65/uE8ouGk6XM15fL8oeKYEWehPeXpj4ZS9BkCpcf6xrk5NIOaPgDAG
         jypR41ut+ID3USaYq5ZWWQXQQA8PqNY+p0nFF6/lSo1w6M2+i0qxwD0j/gOXICxAHDwO
         FS34K6vDKJZo3moY23RVCOfUl4Z7NysUlYJkknRNL3BJJZPMmVS1Zb3mw250vPBBSy3J
         8xgv5jrHjCAl41/U2DU/fGRla7DHGOMO+AI9HHsivmcW4fonMvz2a+W5/KGoR/lWoH4a
         wUXCoKEbH3zwHTJcQKxkdXyZciao8LxPnDfSyBGO5M/DnIv8v1hwwgdMjH+4y/IghLMR
         XaCA==
X-Gm-Message-State: AGRZ1gJSKtgvbSfICe8X6oSHRrSLjDkc2deDMe/N8WDmd6pvO3+5YQQx
        k+cAObe8YnOtTV4ac9Z3JVNsBaNbLRQ=
X-Google-Smtp-Source: AJdET5c3BaGSJKhKByiB+RpMCfgz6q+7QfIft2m+ZbQluagKZe+ap8le6B2yDWOXFmejZKC6x/qu0Q==
X-Received: by 2002:a19:702:: with SMTP id 2mr17782101lfh.144.1543308484059;
        Tue, 27 Nov 2018 00:48:04 -0800 (PST)
Received: from [192.168.0.200] ([31.173.86.208])
        by smtp.gmail.com with ESMTPSA id x16sm466816lff.26.2018.11.27.00.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 00:48:02 -0800 (PST)
Subject: Re: [PATCH] libceph: fix use after free
To:     Pan Bian <bianpan2016@163.com>, Ilya Dryomov <idryomov@gmail.com>,
        "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543302127-14435-1-git-send-email-bianpan2016@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <54c1bcc5-6df5-ba24-2774-98f6333c57b3@cogentembedded.com>
Date:   Tue, 27 Nov 2018 11:47:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1543302127-14435-1-git-send-email-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 27.11.2018 10:02, Pan Bian wrote:

> The function ceph_monc_handle_map calls kfree(old) to free the old
> monitor map, old points to monc->monmap. However, after that, it reads
> monc->monmap->epoch and passes it to __ceph_monc_got_map. This result in
> a use-after-free bug. The patch moves the free operation after the call
> to __ceph_monc_got_map.
> 
> Fixes: 82dcabad750("libceph: revamp subs code, switch to SUBSCRIBE2

    Space needed before (.

> protocol")

    Never break up the commit summary in this tag.

> Signed-off-by: Pan Bian <bianpan2016@163.com>
[...]

MBR, Sergei
