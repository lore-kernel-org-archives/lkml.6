Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE6B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vzmN9Duz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE6B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbeK0Tnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:43:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeK0Tnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:43:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so134873pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GD/mJ/4LVmZ7pe+vwKD8oyKo0/Shm+lwnbKmfy0Gwio=;
        b=vzmN9DuzzqHd6NutLzs3i/48D2mgJYssnF04v3YQh7tV6tSioaUzSZD64FJuFlDoYA
         0bk6ey0gGqZp40QTEAv5FsyQDbGTDlYqwleVUAdiLR4wiI/oAgY+u1gBGbz9DRaDnWfg
         HlzuhmUZz9uu8lQOrBh6YjRBJ9Pv7DR2W/ajikXBQ0rxldzhUc3eYgYkfAAUcbQc+lwi
         UpYy0zxKeO9A+tyRCaS05MfNccxa1w+C206YhaYSFQvYgM1wmgcJe83wlaw7/hEx2S2b
         6r+Fo8R5VSmwF0UyvR5grL91DdfPvhWfUMrDrU7rgj9TL1gvkuNVaUNnnUobisu9sso6
         UBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GD/mJ/4LVmZ7pe+vwKD8oyKo0/Shm+lwnbKmfy0Gwio=;
        b=RhYXM+c/EosJEeZYJHQcR8P811lBMfOf0M4U+YBUM4sv48pp/3KZGJf/oGr8/HYeTF
         bEe6QdWIPCa79q2UrKozFVW5VynPd1NRPXW+MegcD+VK+5iqaap5XaQxMYXCaoh+Gi3a
         4w5R+hxaBK5yhU3716UCM94KHtzRLqOtO9IUdPa2qTGi+Etu7/QRbmxu29nTByNSnB/4
         eDBtuwANwMTU3MV4wrlEOjFV9Stfsg0PI7rCIC/YYfJOBxvWcGI8EbY3yu/pNTcMNI+s
         X0T9qeycYv2owRTPS6ixgoGdYt75SANOh3etp1Gou0phUgL8qIOqySQ6eEddSBUkX6Oo
         8Hkw==
X-Gm-Message-State: AA+aEWaoQCZwUaC/9jkYB6szYwGf0XnS1B0WJN7jiq+HOsSVrXpVcSm9
        SFdW0x30Ve2ANUiLz3u7grmkEA==
X-Google-Smtp-Source: AFSGD/UY5ac8FowP2ou6xOeC+TS/+5jtb59ZlgVkVbqANnZ557czW0CeFoR1ojvBPjrOrwv7ALmpOA==
X-Received: by 2002:a63:fa02:: with SMTP id y2mr28770100pgh.177.1543308390735;
        Tue, 27 Nov 2018 00:46:30 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id p6sm3713946pfn.53.2018.11.27.00.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 00:46:30 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 725A03003AF; Tue, 27 Nov 2018 11:46:26 +0300 (+03)
Date:   Tue, 27 Nov 2018 11:46:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
Message-ID: <20181127084626.a4l65sqqipqukrx7@kshutemo-mobl1>
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 09:36:03AM +0100, Heiko Carstens wrote:
> Use pr_alert_once() instead of pr_alert() if page table misaccounting
> has been detected.
> 
> If this happens once it is very likely that there will be numerous
> other occurrence as well, which would flood dmesg and the console with
> hardly any added information. Therefore print the warning only once.
> 
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Fair enough.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
