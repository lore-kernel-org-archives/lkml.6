Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523F7C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F292801B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfuKbSkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F292801B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934192AbeF2VZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:25:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56043 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932429AbeF2VZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:25:26 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so3482676wmv.5;
        Fri, 29 Jun 2018 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ttpw6N8A8EktUj7dbL2aPnUGzcpbxwbHRvH0dVY82s4=;
        b=KfuKbSkF9I523rIDLITq3RPyzZoWebPPBzV47hUd2U1Fpk/d2sbJO5hv5XNYboe77t
         6BQaJm5qnFmI1lQIWdq3je4KSnGgYCwgRYuUHH07hadB0wzdE9p1dSYBcAPp4dTqKjL0
         Xi9jlXRFZ8r2It5wBaT4tGJ88TlMqFRro/TCVo+VSBVI2Zn1S9BTpfqhxurwX6OLp731
         ZbI5RBolpD0aHbhTowV8JtivUZE+sEJXkNXPra0YjJdu7oEAECxrMS+TFoyp3COgSe0A
         eJVWjS+unVoAxzW+In9fboi/cK/IIEfSeGuvwWkNWsjaEH8vlQFLbOc3r1wfMtZszIjC
         ov2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ttpw6N8A8EktUj7dbL2aPnUGzcpbxwbHRvH0dVY82s4=;
        b=gXfgQ8a8jzbXeu0ZR6XD+cwdk/t9jEnq1hhtl/gECYAtjEStd71+0eDwOs6TKZDCRx
         CKZyiH6QkWhHPWUDidolm2UT2TRUU3jGSadpb0NGH3lm+kufoXDZsZNkDOzLnwFQ3PEa
         STISZWOg7+eQWPhdJBBTU8Nbv1LPBkF38iszQ82yBeICbz/6WNaHE/OmKKQwa+YHaa7j
         ULz3RZmJAUMqi2VaBIKDdlEospQyIEE5TsGtienmUfD/vwKX5T9uVUjwnQ3rQzDqz0hY
         1toS5Qej6ma2YkCUa1rU5W0tL0kaBWZ+dADn7LBMXnLJw+Am9379x/Yj9DBnSIlwYrom
         HUIg==
X-Gm-Message-State: APt69E2AwPZ4ew8IAdz5iabB7B5FXBY+mOHYkvCvOAXXllV8pFC30QiJ
        RBbcb182qA4eQ1ezPcWYJn4J
X-Google-Smtp-Source: AAOMgpdEhA81Y36WBvlzBxR05FV+K949rm1hVNvUnni75dSVe0ewVzYDiBtLA0Sq8RgOITjBst5JWg==
X-Received: by 2002:a1c:81c5:: with SMTP id c188-v6mr2643647wmd.122.1530307524991;
        Fri, 29 Jun 2018 14:25:24 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id h4-v6sm16645333wre.89.2018.06.29.14.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 14:25:24 -0700 (PDT)
Date:   Sat, 30 Jun 2018 00:25:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20180629212521.GA23437@avx2>
References: <20180629174946.1b4f40ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180629174946.1b4f40ef@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 05:49:46PM +1000, Stephen Rothwell wrote:
> fs/proc/inode.c:110:2: note: in expansion of macro 'BUILD_BUG_ON'
>   BUILD_BUG_ON(sizeof(struct proc_dir_entry) >= SIZEOF_PDE);
>   ^~~~~~~~~~~~
> 
> Caused by commit
> 
>   527ae8759f10 ("proc: fixup PDE allocation bloat")
> 
> I have reverted that commit for today.

Can't reproduce it with commit 7aa4b0a46be8badd053c958481f0e89e634ae4df
(the one before revert) both on 32-bit and 64-bit.

Can you post fs/proc/inode.i ?
