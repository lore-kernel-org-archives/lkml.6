Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A2DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122BF2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="huAdsO4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122BF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeIELzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:55:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36690 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeIELzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:55:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so5249900edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jae+EmGq5p8s8nGSsDorbl689s1ssA2JG8mQDCdF7ys=;
        b=huAdsO4eia/vlrtqbzDuPyKfUyv+t+/p6PFKGfE6buF8FKQxgRhZPZZxJwlQw0JKB8
         W0i0mwTGKYut6vUqxe9t69Rr+MDaSPNDhHQgn9aUiCxgfyp9/y/GDEmLJdPpN7FKKeko
         U7xqJBvuClKxVru7HcjstntQCAg9Tku+ya6aQ8ogF9jRDjNm77Gy2ufu2qEdJbWhsBQk
         BnzImmu/PIRm53bECn6wom45d28m4O0LwhckChUtvxH9vV18qeWhHI2oMX47Tlw5zVc0
         LJ374FCdWPciZGWRmpOphC8VXDm8oGYiIOyBrResaeAOI1+ExVdOeKEWh/YN7ANPvrRU
         UKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jae+EmGq5p8s8nGSsDorbl689s1ssA2JG8mQDCdF7ys=;
        b=eNRNLb0FggRF26bPJ3YwmXDeGEjqhpnOUmkAlVPs9LVsrNQdXjAdnZI6iRjBeKIK2Z
         nvmpESODV83+GXrTkNxml4hfWa5Upq4SLzTS61wn62BfFIaC92kWU1JTgJh0woIk1bLM
         vXGFSD8CmlSLzLVglmUYhiUtqqVr5A+9Hh5TkxdisZYzrMuidzuQLRf6RaswXK7LaldZ
         IXeqR/RRX9OmltZ/t1Eg27OkmzkM3bkR4kt6UK1LZKRhS2kP95NwLBX4CNxeAqR8IfF/
         7Q2pdYIPZWHyPAmeqmxg+77NbqTwzg0oVxR1V+XqM+N3Uz3cx2jfze/VUpf4Sy6zzH7w
         MYFA==
X-Gm-Message-State: APzg51CC8sD0aWaCiwcmUeIEdwWR7EFl56A5Bvz2v5BpQrNVAwkhGAYO
        PLGrklUIvGnAaBb+xXyAAJolcw==
X-Google-Smtp-Source: ANB0VdYNjuiPMkXnNPAdccnpfhOxOrmIiJdefAaCfM3TviRsVlCv3gF2rpBrtesIiLQL3HXvwXT03Q==
X-Received: by 2002:aa7:c5cd:: with SMTP id h13-v6mr39984524eds.27.1536132375188;
        Wed, 05 Sep 2018 00:26:15 -0700 (PDT)
Received: from shemminger-XPS-13-9360 ([31.216.236.195])
        by smtp.gmail.com with ESMTPSA id c24-v6sm786122ede.53.2018.09.05.00.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 00:26:14 -0700 (PDT)
Date:   Wed, 5 Sep 2018 08:26:05 +0100
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
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
Subject: Re: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
Message-ID: <20180905082605.69d9e5a0@shemminger-XPS-13-9360>
In-Reply-To: <20180903180242.14504-2-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
        <20180903180242.14504-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 13:02:28 -0500
Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:

> For certain bandwidth-critical devices (e.g. multi-port network cards)
> it is useful to know the available bandwidth to the root complex. This
> information is only available via the system log, which doesn't
> account for link degradation after probing.
> 
> With a sysfs attribute, we can computes the bandwidth on-demand, and
> will detect degraded links.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

In other places (like /sys/class/net/eth0/speed) only the raw value is printed
without suffix.  The general convention in sysfs is that it should be one value
per file and in more raw format.  So why not just print it in bits/sec without
suffix?
