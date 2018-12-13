Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EB3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO13BLo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A116820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbeLMC7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:59:45 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40342 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMC7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:59:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so312055pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tm7CGrayk8PFOhAi26Fef9rSD14WP1jinUziapv+cUQ=;
        b=cO13BLo0i8goaO8QXMxfxBElbrAE5N3QCPuSE8I7g/75aZuwQjtxdYsykH4HVCs5pi
         FMdPB8ag+YhuXrF/libn+8+OVngNPP9zEWmC+NDQe70jYK1efM+AoOe3SZVYNqB0HAFj
         FeTQY8Bbzhh2e4Y16KFGPemD333vdoUoCgiuOvM6+LnvLfEKO39PJnAV74qznnkUxXQG
         /bM729audL39v/4bHBNZNddHSJDMHHO2J6722xJpP9bXC47VDFD4HjcSyRmsqsEUu3hU
         PP5BawMNs/8MUad7kZB/tYQXpsSHxulJ9zSfoubqnn9pLcrDeNMpULjtFTKrKlYrIiom
         USlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tm7CGrayk8PFOhAi26Fef9rSD14WP1jinUziapv+cUQ=;
        b=rcwli9udcPtb0aoPJKmPhfs8CpXpBVdMFE286g3dUS0585OuG/y91Dlng0bGZ1GqR+
         GM9v/I4Sbrj4lqQvY1rJqYSb6e1fcTGsTKwrOlVQGOkhaZix7R7Ks2Xr87SueD1YI2Qp
         3HBBOlCO+izE6w+6D03v0ELhLfxXrUGbd56MBrfAUXj2mx1jRndBfXQFQndzByPM4m+2
         fr93rj2kajxhJM276d9WkpaLN2mIZ+Qji+O+DCqouO1D80JgsM5z/VhCXNbTBkA0XxQs
         mDRLb1RA1sX6SEJxW7bf+x7CXrS8wt3MGqCmi2OUE95KegWMrgqKa9peByeMw/uUJqzS
         MyCw==
X-Gm-Message-State: AA+aEWaUK+loP0Aha0LqUh3Z1TXsn9EAsztMOimpi3DbpHiYPhWzwtg0
        FMRj1kFTq/i8dStNSl8sbnU=
X-Google-Smtp-Source: AFSGD/Vr5Cex1wZVZ4mA7rPME84UZu2iDP0gS+47Cf5/Jz13fPxtXNVlFsCn2pGou70cS3hRq8e1ow==
X-Received: by 2002:aa7:87ce:: with SMTP id i14mr22471970pfo.20.1544669984385;
        Wed, 12 Dec 2018 18:59:44 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id v12sm442982pgg.41.2018.12.12.18.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:59:43 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:59:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH] debugobjects: Move printk out of db lock critical
 sections
Message-ID: <20181213025940.GF4860@jagdpanzerIV>
References: <1544653694-27873-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544653694-27873-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 17:28), Waiman Long wrote:
> 
> warning from lockdep as reported in https://lkml.org/lkml/2018/12/11/143.
> 

That link shows an empty page, lkml.org is quite unstable. Let's
use this one instead:

https://lore.kernel.org/lkml/20181211091154.GL23332@shao2-debian/T/#u

	-ss
