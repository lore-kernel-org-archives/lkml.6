Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E12077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq/dkhvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381E12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIESWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:22:53 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36801 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIESWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:22:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id r69-v6so13731681oie.3;
        Wed, 05 Sep 2018 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LKvwu8OtoZ4dTxSvruBW9IKHgvV54zzmvBgHNM4O3bE=;
        b=cq/dkhvV8mwFZcmG3FO7RQWWnpOezy+dh0Ftsme1cyryqJHmv+xQXkRER8+KRAJPAZ
         pXe9Buo/9KVTNoq3CrvNxlFafZ/wDQrfqULLfLUg0T9pESVcT88Yub2Z1XFy0CaJse9Y
         /shXHWQ+JA3DkGiNRwONQKyNbqP8FZqoh21rRZy9EkcdNbX9z8NliRrnu56KkDKZK4Bg
         Eae4On6caFDthYtvZCb06BYYXgHWzshSiZz42H+5mUlbBwutk6dn8Q3DSBMEHC8yVbQi
         RIrgVuCfJlcdnyTPkUpJFRDdv7FqXwdlr4e5CuYQFe5UAfwHKU4bDeZDxG4ZdSURCVCG
         Of3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LKvwu8OtoZ4dTxSvruBW9IKHgvV54zzmvBgHNM4O3bE=;
        b=N7LMwnK7FgvJuc/smTFs1c/K97yhivlnwPuufUuOVhErjQ0CshwiZ0kb8ri3ZJWyi+
         chucB7+m9m5W3M3VRfQSzwLzeNdoWTNCVEZps1Fv5Djx1tdfPjEDXXGZ+rhJMJ3so2X/
         AndJ3v5nOFOd9ZW2efi9ts1tuAE65lqnfPbDa4kxD6soUyNpdRnR6tglQmwRDttqzGwM
         GR99pWj9Gg1EiRHXEr1yFhOm5sIc9nwlny8VFN+MrnrV7KQFCS1LWSXiqVfg4ECb+z3r
         f+Y8ajR+Tf68LaF9nsFeHgOwKEa1/xwrpnUxtANDHeLq23tM1Of32UTuDwjuhB5rbCG+
         IF/w==
X-Gm-Message-State: APzg51AhXfgqixioQx/4G4WyZmEO4e9Gu1aTeBpKfKsOQYkhbukWt4J9
        K0RJY7AMH71ymsRW5XR16Ow=
X-Google-Smtp-Source: ANB0VdaWyDyq6adLuGO3u5lxkvP9ZUtPmtmq9qenYyp/UkxY/qGEsQpd/ZEE44IqbAC3Mjz7tfxUQQ==
X-Received: by 2002:aca:171a:: with SMTP id j26-v6mr27666494oii.277.1536155553625;
        Wed, 05 Sep 2018 06:52:33 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id t3-v6sm1502421oie.52.2018.09.05.06.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 06:52:33 -0700 (PDT)
Subject: Re: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-2-mr.nuke.me@gmail.com>
 <20180905082605.69d9e5a0@shemminger-XPS-13-9360>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <122e86e4-7c0a-8539-75dc-1515c1b8c68f@gmail.com>
Date:   Wed, 5 Sep 2018 08:52:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905082605.69d9e5a0@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 02:26 AM, Stephen Hemminger wrote:
> On Mon,  3 Sep 2018 13:02:28 -0500
> Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> 
>> For certain bandwidth-critical devices (e.g. multi-port network cards)
>> it is useful to know the available bandwidth to the root complex. This
>> information is only available via the system log, which doesn't
>> account for link degradation after probing.
>>
>> With a sysfs attribute, we can computes the bandwidth on-demand, and
>> will detect degraded links.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> In other places (like /sys/class/net/eth0/speed) only the raw value is printed
> without suffix.  The general convention in sysfs is that it should be one value
> per file and in more raw format.  So why not just print it in bits/sec without
> suffix?

I wanted to be consistent with other PCIe exports that use units.For 
example:

/sys/devices/pci0000:3a/0000:3a:00.0/0000:3b:00.0/0000:3c:05.0/max_link_speed:8 
GT/s
/sys/devices/pci0000:3a/0000:3a:00.0/0000:3b:00.0/0000:3c:05.0/current_link_speed:2.5 
GT/s
/sys/bus/pci/slots/182/cur_bus_speed:2.5 GT/s PCIe
/sys/bus/pci/slots/182/max_bus_speed:8.0 GT/s PCIe
