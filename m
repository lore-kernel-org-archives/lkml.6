Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98450C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547D7219CD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547D7219CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeHRBwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:52:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41293 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbeHRBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:52:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so4945025ywg.8;
        Fri, 17 Aug 2018 15:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UnNGo8D78Bo33rmz8map+HM3C2S/MuF2ULlGUwIEizs=;
        b=A2N/Kfx5Pu9uz8cKXXDpxgk84xx8G9Lf4o+97bufX5bd3MO/1nRi6V/ROF4APea74b
         FEZTiMvmq41swtrpedZFqwQWyRS+ovKHnBy4wqiKUKLNMq9omImDzk9bzKQoqjG8GYqE
         TVHzFinI+647751XeMniec7Jt7PtxHijZulh5lD5zgT+ODBYP3LReQ4yDjDNPZNUuy8O
         WTGUcMaz4ERuog3lWdSJjW8hC9uoGRosf52MXaWrxxm4xYG2f1S+D2InRXB/i6fB+Hih
         JYHnX9s02iSw4MTIolYpKe95m9oyXIp0v7mV6Leks8kzwC3AWdZj9mE7MCczSAPbq/qW
         9Lhg==
X-Gm-Message-State: AOUpUlFabMfUZNPuVXl4JqXmK4wJ4FzE7b3M/UVxpnfX4eSrkinZw/5P
        T9TNngOA3pB3rb92ajHpuX8=
X-Google-Smtp-Source: AA+uWPzi1C1diRM06RkOrfeIsyNQc3sIUnahldSzADVVBzq3WmprN50ad/p6xB+4UdcrY6+ZJHrXdg==
X-Received: by 2002:a81:760a:: with SMTP id r10-v6mr20631641ywc.364.1534546027311;
        Fri, 17 Aug 2018 15:47:07 -0700 (PDT)
Received: from [192.168.16.57] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id b135-v6sm3791007ywh.24.2018.08.17.15.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 15:47:06 -0700 (PDT)
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
To:     Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hare@suse.com" <hare@suse.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>
References: <20180814073305.87255-1-hare@suse.de>
 <20180814073305.87255-3-hare@suse.de>
 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
 <20180817070013.GD11170@lst.de>
 <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23e2d972-c1fd-4581-60d1-a3a736f311a8@grimberg.me>
Date:   Fri, 17 Aug 2018 15:47:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello Christoph,
> 
> How about applying the patch below on top of Hannes' patch? The patch below
> has the advantage that it completely separates the open channel sysfs
> attributes from the NVMe core sysfs attributes - the open channel code
> doesn't have to know anything about the NVMe core sysfs attributes and the
> NVMe core does not have to know anything about the open channel sysfs
> attributes.

This looks better to me Bart (unless I'm missing something)
