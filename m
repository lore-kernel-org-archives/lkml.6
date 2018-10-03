Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24303C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAD920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOsmrCRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAD920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJCM16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38358 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCM15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so1109068pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtSHqbROg5aIdtQ5EV7dkBPXom9wik6oinmHzRs5kyw=;
        b=QOsmrCRyYvXIFMDgJfet9c4+GqiB4aRteyPBBrddzwurHXu6y2K290X2mumQ2sqqsV
         r2xwnYjo2UaEaF1pYYShfL26HCXDwoOMVUbd4hWQLzVCcMdTMZ6BHfSZDXixvr5U0Qe5
         mkR4UccDqyFmrv6/Afsn9rr7YN48BfsOkLj3WRd4fVPh2rlo0LmiQ9JPfhg960PARXEJ
         qHGzPf5suDOsos6JQaHRW9WvD8p2M029OBMDbyz+cRmlvYUTx5Zh1RnKpUU3yceiRrpj
         TxB7b/BqY1wwK66f+g4B26g+uXqQhaW7VGujae1WoQ+sDOfFjr0LZ2IEU8cFAQAHpanO
         esmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtSHqbROg5aIdtQ5EV7dkBPXom9wik6oinmHzRs5kyw=;
        b=dJbpl4d2E2OMnrC0OBd5E4f0O11yQ0AHDT59ctcQINXYQ6UvNhpVtb2dkpj1MZ0uAd
         qQ2RH8iYML4StGaXTAvedDepH2OW/mKbKG0xWl0a9xl1+pPepcGOWCQdhwgwVmf1hJbl
         nBn8ED21k6mX4Ex/MbM7AkljOVxtZWm0pcp4lMdktuKdXC+TfBFUY0c8+sfYH7rJzx2o
         gr50lAWX/7CPXjsjGiJLNa0Czno+vT9F2YcJvEGdE/iZqVqrQnaUFrr58sVdJdjvuxin
         28RXtzNmydrafv+WWTKMcanSG92eMTDbaNewOjrmk2vkiKnbcMBwZ1ob9kLkvoBPs0mN
         iWgQ==
X-Gm-Message-State: ABuFfogn2BMyTLyzhcTpSa3eMxDBKJ0mC37VQUj5PQV2Iwogz1qpgWlp
        cF9gh+b3q5CRHoqSd2CbFp4=
X-Google-Smtp-Source: ACcGV61ENre3fHt1Cuk2HQbQdnEq0EX4RWaVnWmKqV9Zr6SeVOBzKaarDhCA43vlBG7TwLF1L9j/NQ==
X-Received: by 2002:a62:9c4a:: with SMTP id f71-v6mr14434396pfe.135.1538545267530;
        Tue, 02 Oct 2018 22:41:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id u21-v6sm531193pfa.176.2018.10.02.22.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:41:07 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:41:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 5/7] powerpc: 'current_set' is now a table of
 task_struct pointers
Message-ID: <20181003154101.0b46956d@roar.ozlabs.ibm.com>
In-Reply-To: <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:30:27 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> The table of pointers 'current_set' has been used for retrieving
> the stack and current. They used to be thread_info pointers as
> they were pointing to the stack and current was taken from the
> 'task' field of the thread_info.
> 
> Now, the pointers of 'current_set' table are now both pointers
> to task_struct and pointers to thread_info.
> 
> As they are used to get current, and the stack pointer is
> retrieved from current's stack field, this patch changes
> their type to task_struct, and renames secondary_ti to
> secondary_current.

I'm not sure if current_set is actually needed is it? Because
64-bit already initializes paca->ksave / PACAKSAVE. That might
be a cleanup to do after your series.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

