Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB01C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VawajPHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216120BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeGLQtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:49:40 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:45543 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeGLQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:49:40 -0400
Received: by mail-pf0-f175.google.com with SMTP id i26-v6so9496507pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mk3A1cwPF37A1Bxi0PustfwVrggIYpfYYY5+Q2B8LAc=;
        b=VawajPHeXJ+GPQmVIi3kvpBekSBgmQFuGFDHPSfsLPy9nJ44OT1cP9HJ7qeE5HoKrw
         5+eVCM1tPeXTKO/jzu/La96tRPnmnkz0OARmhDiRDh2sG975xjLAxFVGnDsjCeN5ILdm
         kY8GK2uFmPJMjnNGaNWvfCwY0TRFJyYN8NX2U4jAyffiYyp4PaFsGpe4GMhFC4KCdf6u
         4uarBbtcfvo6vZeSipQAPtXWZ59jJYyBoZHMIcKSykTCBdWACln4fQuWNJlnhf8rCKcD
         5I94Jy0XVQiFt4mu97ykIyogtMvt2N7Bn3x+6tsxqcvGCoLILykZj/xEMNj7VfYFJqGs
         zqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mk3A1cwPF37A1Bxi0PustfwVrggIYpfYYY5+Q2B8LAc=;
        b=YIUBFMihGIme/A7vPlNxkA6TY6xGZy84k+HpSGrhLuOlbWdUubnAH1L4ZPI+bC8HlW
         3sUUXjW/hq3IjbKptffKbg6FXhRlKDW46xp6QFzkiSCUxl6KfX3fkD//AcqPqWJTwm1E
         EDEaqyD/PqEfLcRzUZmS+ythkHt4Mc7/jW/nEdUQsQ51NShLnawrXEQn9ke/EdAoX8Mx
         Ah5jnhvpvxMBg+ghXeeKk19P7si3G0cnlguIYXmc+lZHbDxrXkq2hM2Pfzw3yqLaRrjr
         yEGEY60uNbSQUtEDeVB04ruri8deJ9YnCVZmYbZiAFsf0uKtiyJ6zM8/ouKova06cbzp
         UptQ==
X-Gm-Message-State: AOUpUlGUvBuksa7HzxKpCcIB5mPKVS9RS/NHLvSsLBgPINWWJnAbuAhg
        ycJ80BFn83LhIR+JEtderQjwCpe9
X-Google-Smtp-Source: AAOMgpdjYdzjxwR5u1C55MvfuopqypuI6GE2mlfqWAOwD1R4SVcsaIOpzrhYbFqLKCrnLk77fZgfdg==
X-Received: by 2002:a62:9bc5:: with SMTP id e66-v6mr3175887pfk.84.1531413561977;
        Thu, 12 Jul 2018 09:39:21 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id v30-v6sm56090431pgn.80.2018.07.12.09.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:39:21 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 641E830029E; Thu, 12 Jul 2018 19:39:16 +0300 (+03)
Date:   Thu, 12 Jul 2018 19:39:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm: Fix vma_is_anonymous() false-positives
Message-ID: <20180712163916.pzewd3nhane7af3u@kshutemo-mobl1>
References: <20180712145626.41665-1-kirill.shutemov@linux.intel.com>
 <20180712145626.41665-2-kirill.shutemov@linux.intel.com>
 <20180712162039.GA16175@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712162039.GA16175@redhat.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 06:20:39PM +0200, Oleg Nesterov wrote:
> Kirill, I am not trying to review this change (but it looks good to me),
> just a silly question...
> 
> On 07/12, Kirill A. Shutemov wrote:
> >
> > This can be fixed by assigning anonymous VMAs own vm_ops and not relying
> > on it being NULL.
> 
> I agree, this makes sense, but...
> 
> > If ->mmap() failed to set ->vm_ops, mmap_region() will set it to
> > dummy_vm_ops.
> 
> Shouldn't this change alone fix the problem?

Unfortunately, no. I've tried it before. Mapping /dev/zero with
MAP_PRIVATE hast to produce anonymous VMA. The trick with dummy_vm_ops
wouldn't be able to handle the situation.

-- 
 Kirill A. Shutemov
