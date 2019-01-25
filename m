Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABFCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539ED218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mI7pWmpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAYMFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:05:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45605 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:05:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so4468770plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYerEVw6IssCCxpGJkw6avAZd61Hs49Yxy3OL+A51go=;
        b=mI7pWmpih1vbDR7kT9+sQ0MCtn5eX/mWFK1IsLqDlwj1sVyoIWFFQgIr7S3btsBFTc
         ip49HSzU3wHVbDNbWVjZ/C6ncck96pHffvo8gwOre94A+JcNbTvSa0pRO3M3gXPFJh+D
         SmTM8pUY8HwEMxsYSpDpFRQuxe1Y1cNbDYSGUWPPixpMaUYXErGPdjeTkAr9PSlGZbQL
         uA5YmzMB1z4/dCLzmI3ZS+0EZqz67MPtyjIM5LcMapQ9WPy2E2Qw88J73bu4SMWxh9Qn
         YZwaneO0/0gqYePaDip8l/8+LDHphBTagiYme55/VdGEdbRd33MVHVhDymiJJbJae1ea
         qTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYerEVw6IssCCxpGJkw6avAZd61Hs49Yxy3OL+A51go=;
        b=rMqe/5D/EQsiNLhcXH6rrgXr0ukBG+1/2k5kqu0K2LVNG5SYDUc/OK1AwA5zjckr9D
         93BzYxdz++w9I7WD0OBySHFC//s7QoU59n0H95hwFDsYDAJg5DifchJOzB2pOgiMI824
         nFi4OfkTWCY5sJ/cZv3SLSwelAV1D/T9xhSHVgcWBauSmkREQfikcF+lHgye+F3wgjUx
         pvRwrbsYcVAier0x1+Aw5UwVoKVEhF2e7qgpPb4Cqfs5RhbTniCaR+PvoI5Plll6ZdYb
         lDELoYgRkDB4wQC4lvDlAMfslgE9gucvQWfAf/u0g+48xGaqXZa9ToiMjpbL9FYsW+v/
         8d0Q==
X-Gm-Message-State: AJcUuke2al6mgC7jKpOlZtnuzkdvFrrL0l5/Rlrv84kL9+VE2rDBAjP9
        KEu0lzVGW1Eiv03vc/+R+yiLvg==
X-Google-Smtp-Source: ALg8bN6OvhID51Lh5UZvtoLt1zMetL1EGXHDJEHVYZyAvwY9xOtc7T2M+VKovacjA4OT25yHuoYmxw==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr10661575plo.194.1548417933180;
        Fri, 25 Jan 2019 04:05:33 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id w184sm30112522pgd.34.2019.01.25.04.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:05:32 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 631D9301A3F; Fri, 25 Jan 2019 15:05:27 +0300 (+03)
Date:   Fri, 25 Jan 2019 15:05:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bp@alien8.de, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        dyoung@redhat.com, x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND 0/3] Add restrictions for kexec/kdump jumping
 between 5-level and 4-level kernel
Message-ID: <20190125120527.3n6pqt5zzvczkct6@kshutemo-mobl1>
References: <20190125022817.29506-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125022817.29506-1-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:28:14AM +0800, Baoquan He wrote:
> This is a RESEND post.
> 
> The original v1 post can be found here:
> http://lkml.kernel.org/r/20180829141624.13985-1-bhe@redhat.com
> 
> It's trying to fix several corner case issues for kexec/kdump when
> dynamic switching of paging mode is enabled in x86_64. Please click 
> above link to check the details.
> 
> In v1, hpa raised concern that why the paging mode checking is not done
> before kexec jumping, the discussion can be found here:
> 
> http://lkml.kernel.org/r/alpine.DEB.2.21.1809051002020.1416@nanos.tec.linutronix.de
> 
> As tglx said, it might be not doable for kdump since kdump kernel's
> reserved crashkernel region only owns a portion of memory, may
> be above 4G; and might be not safer to do paging mode checking and
> switching thing after crash.
> 
> So resend this patchset.

Changes look good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
