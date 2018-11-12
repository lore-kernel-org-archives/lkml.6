Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19879C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7603223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="NVXngCwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7603223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeKMEra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:47:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36904 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeKMEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:47:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so15172269qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oivDryuzftKKjZBJnUP8ukmsaZuxrqxB1OJMJalty3c=;
        b=NVXngCwaQeV/Ly0Y8jVtwM8ZoCXdgvKoZr0jnHKOKCLLhwu9M8E6iHeDqSsdTC29BB
         RtuhwBR1peG+FpjNNgMCvF7nD1MJ7czrvFw+shMSdsVtI5MabtElHfoNtqFRSI/nYrmB
         pBJc2HGth4IQmXrZHo0r1QBIqu2nZT71/nbW1n8UlcE2zgu/IF1Wc9ioNobZzuzi68qj
         eFW7HdTzwuYWD4HBG86VeoyEaGl8PNsVGlZcLJLCyZydv6quQ4Wsc5rk7VLh0bRnzQlZ
         6XCUugYmCZlUDkm3kvBOMVEXwmYwG/gwH22mLc0+1UFzRg/80o0i3K99JnCMlcQayoC4
         b9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oivDryuzftKKjZBJnUP8ukmsaZuxrqxB1OJMJalty3c=;
        b=nWASEnZhdB2JLo9UFcyA6V5/xButmCQfW6R9U3zmy+x1TrP/n8V/w2T13kwnVKTqci
         QO9+yhMmV31HyZcVg3Imf+YcXOigkz4G2oC1nJZLxKR8IUYuD24qdCJnhEMX9jbV38Qw
         ERN432gcSCUjusaUclcSDSNuKfhV/uAbwvoOAGe8k2e6+/mEqtcctj6s96Ac1f+16/El
         dPYCizFqoo1qojmLtBMogkbJaRFkUMbz9ORqFOBtFbTNR7MQfwmqFhAf5nQhDcrDRvlF
         iiVqGhO5OvBB13OEngZktSB9Lk4DSJWYLND77AZmlFoYxQSVuxa+NlZ9iEDK30CXZsj4
         c0Qg==
X-Gm-Message-State: AGRZ1gLWNYpCXaUIzZBnixhjLVG/GM3nvyU0rhV+pq93YoLgsHDIYZa4
        ojE8TC5G59gu0JeNa/CBFwtFRA==
X-Google-Smtp-Source: AJdET5fmmUOlQu1ShKrkLZ7p4pwK2lhECazXTgWeohIauR0EnkwR+eg+N0oRvbksnpNR1aHX7YnSyg==
X-Received: by 2002:ac8:38e2:: with SMTP id g31mr2043458qtc.55.1542048780169;
        Mon, 12 Nov 2018 10:53:00 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id t40sm8598383qth.46.2018.11.12.10.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 10:52:59 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:52:56 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        david@redhat.com, dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/5] mm/memory_hotplug: Add nid parameter to
 arch_remove_memory
Message-ID: <20181112185256.dbintostrvyoddf5@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-2-osalvador@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015153034.32203-2-osalvador@techadventures.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-15 17:30:30, Oscar Salvador wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> This patch is only a preparation for the following-up patches.
> The idea of passing the nid is that will allow us to get rid
> of the zone parameter in the patches that follow
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
