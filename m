Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33871C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE22E20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="YcbDIi22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE22E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLCL3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:29:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46415 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeLCL3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:29:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so6193274pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0iuWjkOxQBenD+P0anRhGKAmECB3xqeSTJUQgXhNipM=;
        b=YcbDIi22C/mj8dTPsTqTqOsoZmTffMkY3DuFZhaUfqik5+1VcreRJ/LCvn9dYtTrSa
         csE8lIr7zRJ7NQO/n45fmLijg4pQQLRYaSbkvI7MnTTwtJ8Cin916Q+ygtAXL1UO4Chb
         /oVpWn1MqONnCiFFM/FNjd+gTIH+ZsfV9fcKh3KZS5lyfxrbKAf2UwJ5iRh/beHsdkH3
         8JtUJKz863w0OrtV4KlF2/Fp5OMnvb6ADY+wFY1oBscsLl21iKa5BMuMYn2FT5Rk1uwi
         WSL+2efZyP2yi+PSyWpU8GBijK+mzdh/6eUcOrGVP9bihPUcVAImVf7U3atIalksTB5m
         3xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0iuWjkOxQBenD+P0anRhGKAmECB3xqeSTJUQgXhNipM=;
        b=acb7jFT0UBYXekCX1TZUDqqVkzodutyyH5+f30DZQuXNHYvh7z6cCtPpV2vbY4a8AF
         pLExA3U7O2vsQa7oGpWVN8RRwGuxcO1myQuBLdnPD+j2SwEkNbzD7+St1tgKEnBO+ZWG
         Sj2TQiC6qMrzgH75iwtzDW/MBWNN8oNvN1mbFlvb9gBVUMe5qP3qip+4lzOpkSLx1iTB
         WtCFsPz1vxdZgdGD78IANAAPA3FddVqgYRyVFDXpkKpfEI2CMDTY71Ss1x/aoALNREsr
         jwo+6Yg+VmwCp09G8NKhQgzKX++GiQvweB3vH25Zt/D4qwoT7Ldkk2awhXT2RA7hxWek
         EG+w==
X-Gm-Message-State: AA+aEWZtscEcqsAMQxynIJfQoTZi0Ve1L3EyLHhqHmBDP65OlEOHxSRm
        zvCB5nTkGcKD19jh3jZazqoAOw==
X-Google-Smtp-Source: AFSGD/WI/AKvRmUB4RqjtOLEO44KBwTtwM+8IDUiE8V7UDLaPAO5pXI5nEGM/DV/Iy7/lXR5oimktg==
X-Received: by 2002:a62:8096:: with SMTP id j144mr15782356pfd.140.1543836534489;
        Mon, 03 Dec 2018 03:28:54 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id x3sm21602445pgk.18.2018.12.03.03.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 03:28:53 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id BBDA53003F7; Mon,  3 Dec 2018 14:28:49 +0300 (+03)
Date:   Mon, 3 Dec 2018 14:28:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-mm@kvack.org,
        alex.williamson@redhat.com, aarcange@redhat.com,
        rientjes@google.com, mgorman@techsingularity.net, mhocko@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: page_mapped: don't assume compound page is huge
 or THP
Message-ID: <20181203112849.jonqywnd4rx2wpe7@kshutemo-mobl1>
References: <eabca57aa14f4df723173b24891f4a2d9c501f21.1543526537.git.jstancek@redhat.com>
 <c440d69879e34209feba21e12d236d06bc0a25db.1543577156.git.jstancek@redhat.com>
 <35a664c0-6dab-bb32-811e-65250200d195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a664c0-6dab-bb32-811e-65250200d195@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:23:58AM +0100, Laszlo Ersek wrote:
> Totally uninformed side-question:
> 
> how large can the return value of compound_order() be? MAX_ORDER?
> 
> Apparently, MAX_ORDER can be defined as CONFIG_FORCE_MAX_ZONEORDER.
> 
> "config FORCE_MAX_ZONEORDER" is listed in a number of Kconfig files.
> Among those, "arch/mips/Kconfig" permits "ranges" (?) that extend up to
> 64. Same applies to "arch/powerpc/Kconfig" and "arch/sh/mm/Kconfig".
> 
> If we left-shift "1" -- a signed int, which I assume in practice will
> always have two's complement representation, 1 sign bit, 31 value bits,
> and 0 padding bits --, by 31 or more bit positions, we get undefined
> behavior (as part of the left-shift operation).
> 
> Is this a practical concern?

Not really.

Assuming 4k PAGE_SIZE, compound_order() == 31 means 8 TiB pages. I doubt
we will see such allocation requests any time soon.

Even with 1k base page size, it's still 2 TiB.

We will see other limitations in page allocaiton path before the compund
order type will be an issue.

-- 
 Kirill A. Shutemov
