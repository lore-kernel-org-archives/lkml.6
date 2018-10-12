Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D917BC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22AE21470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 23:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22AE21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeJMGib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:38:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41368 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeJMGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:38:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id l41-v6so15595735qtl.8;
        Fri, 12 Oct 2018 16:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sl2NXSIGVg/TtmXzNKFTngWKViZSonIOXep3zu0gGxk=;
        b=Uxj9GjlE4u+0tt9gUjJpZ+O0rZKdBH/aNCKvUkiar/ipMUrwKIL5WNfRVI9P1B7dqp
         8c5bfwyb6ZuvXiazIdkld30A7/dem+JYQpFO06IKVTzJDz90CcWj8r4DqwomHx9z0hN0
         GOOsCZhvOH51JZ8xWL0qZeJf/2lmOvKYIiXxEjKnTzuHgcGbccuu832ceWgCNGCQCbZq
         pVc3YhPJdMvYL9USBY10rzPhP1GeRk4UV0YRfJgoQwmUxsc6KOV+7wWXajs/73zg1eVB
         d54/zsmYxis9/+JCe8Mm3/j+TWVrfEp8700W34BCqaapZ7LsyJ19fllifKryPdxIN8v1
         ecMg==
X-Gm-Message-State: ABuFfoh8wCH7ZcOQ0HRcWzzuL+2hUzAizSPHQkqqV3zwLEwn5bOkOgbX
        5zkBLx1ZncX5tVeQ2ZxSyUzkFINWEcqvyxleCJ0=
X-Google-Smtp-Source: ACcGV6285m18mN8BaG+IGaLFBvnnoBYqL2QNPWVeSvvjiqBeeYZjrgVYi1X/HgRq/iBrLlkScqXfD1CpNDuUddS8N70=
X-Received: by 2002:a0c:eb42:: with SMTP id c2mr7973848qvq.105.1539385432156;
 Fri, 12 Oct 2018 16:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com> <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
In-Reply-To: <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 12 Oct 2018 19:03:41 -0400
Message-ID: <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
Subject: Re: turbostat-17.06.23 floating point exception
To:     solio.sarabia@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>, shiny.sebastian@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why would the cpu topology report 0 cpus?  I added a debug entry to
> cpu_usage_stat and /proc/stat showed it as an extra column.  Then
> fscanf parsing in for_all_cpus() failed, causing the SIGFPE.
>
> This is not an issue. Thanks.

Yes, it is true that turbostat doesn't check for systems with 0 cpus.
I'm curious how you provoked the kernel to claim that.  If it is
something others might do, we can have check for it and gracefully
exit.

thanks,
-Len




-- 
Len Brown, Intel Open Source Technology Center
