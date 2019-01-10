Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B1C2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q6mPHXay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfAJUjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:39:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37748 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbfAJUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:39:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id t33so15283742qtt.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BM10tUvFqe2/qUpdcNvy1XQgs7cykrDXn4NqoVqHHkY=;
        b=Q6mPHXayVjek0lCitJARjuKVeid7Jc5go7wKFZq3bHcPjCrVC9Dsm7ChkkeoysRtyx
         BXgrutc2eJVsQvb2iHHu7lwoYRxXCTFjC6RQQCCdPHhnX2BbaTb5h14Z/mjgIr7yMV12
         axEsxiKKxUluoB3lwIW5yGeSdGKgUgwcj5sO0ufz0m10FPs/nEYwonKSMH7tIYX17lrj
         09mqVdXPYhWG0pOqlWSwxE/Hbhro3lfU9KSQPtOXvrKF1mQQ1bbOVgAdhR7MrRkax0EN
         vlK4qmrM2NLad0H+XYUfvUbR62pYPZUcV5WZV1IVmbR8p4nIYlc5U3Q+Ly48te+pdztM
         q0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BM10tUvFqe2/qUpdcNvy1XQgs7cykrDXn4NqoVqHHkY=;
        b=Gx/XTMgShrGlmpAMAa5hm92ESE7xiEBoslkk7TFk2uPmULc4zI04GSTGD8zocA2ezH
         PCfbSfgeSUVW3BSLRm/iqPiLNnIxw4SsHznqfWZd+deBwk459pESDm023SokZEMVvVFJ
         5X6VUNGWVF5fQhJ3rezwH9j/9BdO5jmlpqycTUnMDV1eDIFHGdatjSowfKy5EdczHNV2
         A2sJ0Zq9urtNJ4TrTSg7VdydoUuNU8ZLlbkR/VY3v2JH0RaLp4sSxobDJXdcFyKLTlyt
         b57vU2MWkHAmemGWAfjMb0WjsljgZBERmtOsMu20bhjVt2pAZFQijpHqnb3XfON+IeFh
         BAlw==
X-Gm-Message-State: AJcUukfWE3UyNOh7eoF1dyz3KGaD27yKtiUan180YwKK/2J3DvVsPFFD
        wdunfSrFoN/MgniLMgGDseEtlA==
X-Google-Smtp-Source: ALg8bN56UGDqEEIeHs9djrF+w+asnMO+rW3niboUIuSnWfEL3QljA8fXBJ1tEB9ABBBMzCTj1LnRFw==
X-Received: by 2002:aed:35c5:: with SMTP id d5mr11137276qte.212.1547152793305;
        Thu, 10 Jan 2019 12:39:53 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z30sm48643977qtz.26.2019.01.10.12.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:39:52 -0800 (PST)
Message-ID: <1547152791.6911.6.camel@lca.pw>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
From:   Qian Cai <cai@lca.pw>
To:     James Bottomley <jejb@linux.ibm.com>, Esme <esploit@protonmail.ch>,
        "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Date:   Thu, 10 Jan 2019 15:39:51 -0500
In-Reply-To: <1547150339.2814.9.camel@linux.ibm.com>
References: <t78EEfgpy3uIwPUvqvmuQEYEWKG9avWzjUD3EyR93Qaf_tfx1gqt4XplrqMgdxR1U9SsrVdA7G9XeUZacgUin0n6lBzoxJHVJ9Ko0yzzrxI=@protonmail.ch>
         <1547150339.2814.9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 11:58 -0800, James Bottomley wrote:
> On Thu, 2019-01-10 at 19:12 +0000, Esme wrote:
> > Sorry for the resend some mail servers rejected the mime type.
> > 
> > Hi, I've been getting more into Kernel stuff lately and forged ahead
> > with some syzkaller bug finding.  I played with reducing it further
> > as you can see from the attached c code but am moving on and hope to
> > get better about this process moving forward as I'm still building
> > out my test systems/debugging tools.
> > 
> > Attached is the report and C repro that still triggers on a fresh git
> > pull as of a few minutes ago, if you need anything else please let me
> > know.
> > Esme
> > 
> > Linux syzkaller 5.0.0-rc1+ #5 SMP Tue Jan 8 20:39:33 EST 2019 x86_64
> > GNU/Linux
> 
> I'm not sure I'm reading this right, but it seems that a simple
> allocation inside block/scsi_ioctl.h
> 
> 	buffer = kzalloc(bytes, q->bounce_gfp | GFP_USER| __GFP_NOWARN);
> 
> (where bytes is < 4k) caused a slub padding check failure on free. 
> From the internal details, the freeing entity seems to be KASAN as part
> of its quarantine reduction (albeit triggered by this kzalloc).  I'm
> not remotely familiar with what KASAN is doing, but it seems the memory
> corruption problem is somewhere within the KASAN tracking?
> 
> I added linux-mm in case they can confirm this diagnosis or give me a
> pointer to what might be wrong in scsi.
> 

Did you enable page_poison with PAGE_POISONING_ZERO=y ?
