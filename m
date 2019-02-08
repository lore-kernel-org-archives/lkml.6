Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8225C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9920855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jni/BN/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBHRBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:01:17 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:55462 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfBHRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:01:17 -0500
Received: by mail-wm1-f47.google.com with SMTP id r17so4108055wmh.5;
        Fri, 08 Feb 2019 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qb0yx7e0wzi3wA+bhNZChpDDvqoS7B+GJdRcrarJ+bo=;
        b=Jni/BN/FI+0O4i/6d68jE/+FM4+02MgWpynCDbEj+LBXpNxAxWBD/tYRCEQz5RXAji
         FsvtlzKWI2z2CvrYEB+5KzdlY8Y5qRM8bHdE1S6YXTqAiuCxebUWxLzzTKfZAPw2GDk5
         W11lyJUqGghkBcjC/Z2aj02Xu6aBBLmKlUxvzuHjd3U0v7iGy/jcKVpldkhyCtcNPPR+
         S3L+fvZ5YgAjJviK8zwEEaV1E/NNJ/sUtUzyo1I/aWAYmbzB05grcztEnlF+Kvy5/BGH
         NtsNwQKjp10Hp5MHv18B4n+y/z5LGe4H7DL2s6TIyM74TOuxw0PMjgA6KyFU3BDg6zkP
         UaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qb0yx7e0wzi3wA+bhNZChpDDvqoS7B+GJdRcrarJ+bo=;
        b=IEdrMm4PZ6yvFnGwfumvwE+Vb7iZ2Bko35J25bxl2oKFIplrbUwQuDSdJQFhok9eJ3
         xs+TQZrOOIGIjznbtaaqHDeodGMgDPYbinEv6THtyV/bSTiui5VoYp1OCqP4TGUaXx6j
         n8UAE0XDBISJXySgkL1INZdsS+BvUTbDuYO8OH9S/pA3gVQlfMdkO7rQdVzTOOOhXsH+
         pl2MBJ9ybNo/MP/gQNydVEqsW2mWdwT0Dw8kgVTBnF+GzUmsYJYsHd/yzfYO27jpwl/q
         46TcA4GzAxbY3uxibNro6n0vmPmcXx3F+dAM3j6Wg4HBCNINmlEMfrdzaL5q5e+Gl2lx
         9Bkg==
X-Gm-Message-State: AHQUAuYWkz3IXJmOvecQB8e4Xcrj/0eQsIQjNBlpXfPhkpXtPVlgpf5/
        UI8StbESMnnIrwwpFv8o5A==
X-Google-Smtp-Source: AHgI3IaZJ+CLkFkopHTT2xC7RCoPZ9dRvR03Lr+LoHOPWlqopw1ueKSpO5daytamVoNQHFvAx/mfDA==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr10824975wml.120.1549645275203;
        Fri, 08 Feb 2019 09:01:15 -0800 (PST)
Received: from avx2 ([46.53.240.199])
        by smtp.gmail.com with ESMTPSA id k12sm2934729wro.75.2019.02.08.09.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:01:14 -0800 (PST)
Date:   Fri, 8 Feb 2019 20:01:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch V2 2/2] proc/stat: Make the interrupt statistics more
 efficient
Message-ID: <20190208170111.GA20009@avx2>
References: <20190208134802.218483159@linutronix.de>
 <20190208135021.013828701@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208135021.013828701@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:48:04PM +0100, Thomas Gleixner wrote:
> -	for_each_irq_nr(j)
> -		seq_put_decimal_ull(p, " ", kstat_irqs_usr(j));
> +	show_all_irqs(p);

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
