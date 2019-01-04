Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B55C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DFE2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pad8KbEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfADFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:23:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfADFXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:23:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so35678572wrw.1;
        Thu, 03 Jan 2019 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZGxGpHvNGZ/vjEcXF5ZcR+wHaQzCOAH1JLHCYtcK9s=;
        b=pad8KbEU7eu6ykvKXqF46s6E4OKSPQdoD33tGbtX3qTVLJhpUKmjq33zQPenABBZbc
         9aK3An6BHNzE9YZc1x56qeJPnUR5LEhRhNX/sWAtJb9Dqnh6nIcjXq09GIGBPYCrJSjI
         zjMp5XajsCssHSVmrPU/oXHTstcqO7a1ugMvwWea/Av/qyLyIM4CDdntZQtKOYYMEebn
         C3IVzGUWTCw4JVyhXLA+AjBc+gPCCwjTX1HVRCnOX+1bkBis8V9A7AZoCylyN5Rfh53/
         P6eFDoXXxad7Bh5h6Qn8aKuJUS7ukwpvt4dNgPLsC81rQgezjTGAKL4ESSpmliuMMG8d
         SsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZGxGpHvNGZ/vjEcXF5ZcR+wHaQzCOAH1JLHCYtcK9s=;
        b=DPhM4oaGsT8NMI59CjJqVuctqPfWiWMuNQ1dx7tI0x2uwwgalVLbsldczL6P8GxTIU
         C9cL2m3HfmSC8ll2bdhmiSJFJ19Mu3gJQW8cbrhiRupqKUZu/sRpvfAZHYfOhU3K8AUw
         gE2vgE4qXo7acik28pU1YBO6Qv1+NorXw6iEucSiOxYsqBgQB8ENpdLYUdpC73EvdIMz
         0eCh1Lz0gRpG7FiBpzTSdsbBkYElX2gvpAy+ya6tsSA6jM4UJUtHn2ONpzNaQlJ6yCuf
         IKfB0oatRu3zgnoKo1oPX9y0R3KUQT9dOT3K5QAebdhgknYrvoY4OLF265iUYvPebxwo
         jw0g==
X-Gm-Message-State: AJcUukeO1v2mibo8KMlcKKe+qYQBBfjmpU1GGcucIvKq171YtlACtfw7
        H+N4JzOF4kJyQNm7ctSfm8Q=
X-Google-Smtp-Source: ALg8bN52W2XeCTOUE/OITjOGr0BAFctnMm6ExkVTPBSIBrM1Zu9eS/nzGbbhlwupZ/28g5T79cAGNg==
X-Received: by 2002:adf:e08c:: with SMTP id c12mr40976396wri.199.1546579378932;
        Thu, 03 Jan 2019 21:22:58 -0800 (PST)
Received: from google.com ([2401:fa00:fc:1:6924:4b22:cf4b:bbca])
        by smtp.gmail.com with ESMTPSA id a62sm159909wmf.47.2019.01.03.21.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 21:22:58 -0800 (PST)
Date:   Fri, 4 Jan 2019 13:22:51 +0800
From:   Randall Huang <ihhuang@abmail.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, huangrandall@google.com
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
Message-ID: <20190104052251.GA205256@google.com>
References: <20181226041504.66283-1-huangrandall@google.com>
 <20190103075133.GA5141@infradead.org>
 <20190103094755.GA96532@google.com>
 <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
 <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com>
 <yq1ef9t81fh.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1ef9t81fh.fsf@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 11:57:38PM -0500, Martin K. Petersen wrote:
> 
> Ewan,
> 
> > SBC-5 says that support for the grouping function is indicated by the
> > GROUP_SUP bit in the Extended Inquiry VPD page (86h).  I'm not sure
> > how many devices actually support that page though.  Probably most
> > don't.
> 
> Several devices support it, albeit for various different purposes. It's
> one of these wonderful features whose interpretation was left outside
> the scope of the spec for a long time.
> 
> So even though we absolutely and positively need to make setting GROUP
> NUMBER conditional on GROUP_SUP being reported, we also need additional
> information from the storage about how the field should be interpreted.
> 
> The official way to report hinting is for the device to implement the IO
> Advice Hints Grouping mode page. I wrote some code to support that but
> no vendors that I know of ended up actually shipping an implementation.
> A few implemented my older I/O class proposal but didn't ship that
> either despite really convincing performance results.
> 
> If Randall has access to a device which implements hinting, I'd love to
> know more.
I am working on Android phone.
The idea is to enable write hint for Turbo write UFS feature.
Turbo write feature in UFS 3.x is under discussion in JEDEC JC-64. 
This patch is the under-lying framework for supporting this feature.
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
