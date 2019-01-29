Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2949C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA3121473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="nvXS2ieJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfA2R5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:57:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37086 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfA2R5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:57:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id t33so23228626qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TK5Q823N9cdnhH5uLAjCRM7lh8nNdY6bySdVO5kXkJY=;
        b=nvXS2ieJhUJo1q93q2C4dgblvLoIVTtzfhlOML7Pv2s4Ya/MPzD98iRLtvagakVjpD
         nd6cj/MZlvF76e7FLdkqTWb5Gjp15kFb3VbD2uRSLlaBrl8n8DR/qFLsTElhlFCSN1wk
         i0HqCIrtZO6lDTT8g2TSn8Z0xXgfpWw0Jqqph7fuyG/YY5htb9vlO/R8DGmYQk47Ss27
         NpJxvdeU8c1U94NfqBn8rH9dOBykC0ANE/oBMbxyXLO8KGJ8ai+fEXoxlekaCJ6TbtUz
         BOhI4f35Wr1PtThunHWZCd0y7v8SxkUzUmz5eKp+PSljI7euZwcr0HvXqH9K4EyJttnV
         OpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TK5Q823N9cdnhH5uLAjCRM7lh8nNdY6bySdVO5kXkJY=;
        b=rW2M9O4q9wXs1fAYuht7uA70WLx0x+HJ1RjiOFkv4z1H+rWHQA+n+8rQ4LI94BX3/q
         rDqhxg0I3hCnYbmL8v3unfoQZWy5QdigePMA1bBypUQvG/p9YDyHSw69gaCh6py12gsu
         UQG7AuFrHSqeLqrJbopylkhdkBSDgXRX1DnKbfH9GNkxfYSUv/VRZ7o/AmqJdjb32MmH
         d1u2shi4ULR3F3BG0jmUfG+gfax04EMoHQn4U2SyKfJUOxE8/sf6Ej292pyn+NzFbTO9
         /naRcPb2fluOfKHsvaFEes0jp6C+lLBh/wsUEKBwRITCdLag+kz+21+zqHCYlwuixz+3
         H+6g==
X-Gm-Message-State: AJcUukfyQcYMiuAAfw4eiz5NamaMYiwJUS22spW3tvORonQh+tM4hvQ4
        LF5rc4oOIq6bGsv5qviPiAELcg==
X-Google-Smtp-Source: ALg8bN7SNuyaiK0XMh3lJ6B36ZVxJjtCSQ5MVAqHBKbfKuYywSIvaefjJDFIPC3aTtnqYAoPEKd1Mw==
X-Received: by 2002:a0c:df12:: with SMTP id g18mr24827625qvl.208.1548784624452;
        Tue, 29 Jan 2019 09:57:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g19sm44610190qke.2.2019.01.29.09.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 09:57:03 -0800 (PST)
Date:   Tue, 29 Jan 2019 12:57:02 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Nick Terrell <terrelln@fb.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] btrfs: add macros for compression type and level
Message-ID: <20190129175701.auj22biuwwrwtufd@MacBook-Pro-91.local>
References: <20190128212437.11597-1-dennis@kernel.org>
 <20190128212437.11597-2-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128212437.11597-2-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:24:27PM -0500, Dennis Zhou wrote:
> It is very easy to miss places that rely on a certain bitshifting for
> decyphering the type_level overloading. Make macros handle this instead.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
