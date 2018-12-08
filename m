Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0ABC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9352082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 07:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDa2v986"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9352082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLHHJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 02:09:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51666 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHHJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 02:09:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so6332243wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 23:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ek7vo3RvdX0CT8AbAjEa4CaJ5kRaBTm5HswXMMc7hj0=;
        b=dDa2v9865m9JRu+A4zXuIO2/rSW5rdrkMtaw3TNtzcSjmM04VZIo3z5N3dJimZ+v/X
         Zv50gFnShfItXEh1DFW5yht5VMj1t1SyqNhnVXIO3Z/vi7beF8X5N4JmKwyJbp6VK3Fs
         ZN0h7Za6mZ5Kle8cEyvVhIskhMwUVdbqTjUhcYWit1xIENDVfHSrlH6CwQNgTqUezuRb
         CYuNVZaiO3y2O5UMKkCp/7GIcBo6ltwaUU9bIDm2pCuxUUV/yKjSyV1hSxC79fp+1QSD
         UP6CRrO5+/1ZA3BcoBfG6yEZY2oagpXujuqJO2FJ6D6MXds8rJapo6wkSyYCorFx8qdB
         uiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ek7vo3RvdX0CT8AbAjEa4CaJ5kRaBTm5HswXMMc7hj0=;
        b=e5ssX3ZlHu4oNt/2p+SaUuALHNTc1abCd+0bzRCQmrobixT4qn+/SKaWo5QVJS2WzK
         P6EQoGt9qbSiXz2bJW9BCGi3KtTsiV2I8YLUgRmx+wF9isJJ66WvqZzm6OkxcnNsthLN
         bLbE7EIJ1XG6TPkE5bUFIf/REeq/XFl5L6kQMBGPdUOKMqbBdVkQ8RSJu14RNu2M/odh
         CNx57KxTIhmOULj4GTUgOA7WymVtNQ2piD6yTRGSYfmHTM5s8fcYdaX61CHBNyHIDSlf
         jdY3zYOG+Csg2cH3vuCRrdoDLJp1LTgTNUb+dlFVfRsi8iZQ+ACtFs9ZVOmYvkTb12Rj
         97EQ==
X-Gm-Message-State: AA+aEWb7qmX0j/BXRdvDRrGIRDmCuhAH401oXHy/I83bpDRL+yugLODO
        wmOD1kdEDISOqQgKZ8VsKw==
X-Google-Smtp-Source: AFSGD/Uk/gC5CO0/Q9sR4wxTFBXSuj1uMtyNrONHllMamXupS2Ogt2YySj+mE0hFtOmg0B1iG6U2Kw==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr3979786wmj.29.1544252963578;
        Fri, 07 Dec 2018 23:09:23 -0800 (PST)
Received: from localhost (host34-126-dynamic.27-79-r.retail.telecomitalia.it. [79.27.126.34])
        by smtp.gmail.com with ESMTPSA id i13sm4381732wrw.32.2018.12.07.23.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 23:09:23 -0800 (PST)
Date:   Sat, 8 Dec 2018 08:09:22 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Yonghong Song <yhs@fb.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: x86_64: blacklist non-attachable interrupt
 functions
Message-ID: <20181208070922.GB2237@Dell>
References: <20181206095648.GA8249@Dell>
 <20181207234731.f52a8c1eff6c0e72c073ad40@kernel.org>
 <20181208010120.c3eda9042912068aecc68317@kernel.org>
 <20181207175805.GA1369@Dell>
 <20181208124859.7318e32abfab4cc6dc2da3a8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208124859.7318e32abfab4cc6dc2da3a8@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:48:59PM +0900, Masami Hiramatsu wrote:
> On Fri, 7 Dec 2018 18:58:05 +0100
> Andrea Righi <righi.andrea@gmail.com> wrote:
> 
> > On Sat, Dec 08, 2018 at 01:01:20AM +0900, Masami Hiramatsu wrote:
> > > Hi Andrea and Ingo,
> > > 
> > > Here is the patch what I meant. I just ran it on qemu-x86, and seemed working.
> > > After introducing this patch, I will start adding arch_populate_kprobe_blacklist()
> > > to some arches.
> > > 
> > > Thank you,
> > > 
> > > [RFC] kprobes: x86/kprobes: Blacklist symbols in arch-defined prohibited area
> > > 
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > 
> > > Blacklist symbols in arch-defined probe-prohibited areas.
> > > With this change, user can see all symbols which are prohibited
> > > to probe in debugfs.
> > > 
> > > All archtectures which have custom prohibit areas should define
> > > its own arch_populate_kprobe_blacklist() function, but unless that,
> > > all symbols marked __kprobes are blacklisted.
> > 
> > What about iterating all symbols and use arch_within_kprobe_blacklist()
> > to check if we need to blacklist them or not.
> 
> Sorry, I don't want to iterate all ksyms since it may take a long time
> (especially embedded small devices.)
> 
> > 
> > In this way we don't have to introduce an
> > arch_populate_kprobe_blacklist() for each architecture.
> 
> Hmm, I had a same idea, but there are some arch which prohibit probing
> extable entries (e.g. arm64.) For correctness of the blacklist, I think
> it should be listed (not entire the function body).
> I also rather like to remove arch_within_kprobe_blacklist() instead.

OK. Thanks.

-Andrea
