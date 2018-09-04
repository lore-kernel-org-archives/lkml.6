Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A85C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CA920867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Zbfp54Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CA920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIDNGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:06:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34758 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeIDNGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:06:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so1360260pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/hiVSBk8lW4GZkfWSUxWPhfr7/85tz1N9Wcp38U1Yk=;
        b=Zbfp54Sy3aZgNQPhoTSpH9X34uUF5vVjqpMYJtIWXvbulMV1M4RBb40pakp25oCFiI
         sxqW+m39GnF7x5ka8uu5j1nXFSYyORerxPBBDRusIDsqvdGEUBxQEEiFob6IPeV9LeWS
         lFUW6Ck7t6eLoe3Y5VWpNtiiawpChndI1Rr8oElycr2HuhnMoU7cDuREUM748qlRAGI8
         i4geFkVBLnq+7L1Ah3OSHlJroEdCeGPUDAm/GtcVjhwOBLwMdSieg75Dyzf0E9ahrk7V
         hTclIbAZ3YH674LFMz+iyc1zOUd9peNlpc4wSYXhxvZ4l3zsJWIOALZHzEj2xAXNEwZC
         nigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/hiVSBk8lW4GZkfWSUxWPhfr7/85tz1N9Wcp38U1Yk=;
        b=Taq7yIZqhgfnrBLwH3DaQsQHsnX9HjmqdzWAIzuIB4q9CmNXDBd49gxlTQ6R/YR4Bq
         FYO6zvSZihzZ1EEe5BqPY3QasJ2raUapwn5EsRjPm2fTTsmQ9TXBxoMGoR0E95DYZN+4
         6h73cuopeE0bx9C2kKDRuDk+pXLW+/fBrqeJ3IajYxBQ6zmaNlFjnK1+4J2m7KRF/45B
         2wAiTMPVH7WzmDtj+9XpDrilugA4UIOf4beMM+iIxOx6XihUgYJL+QcAMih0i7Y2Fcl8
         SraGXhcY7ihpqY2yvEzQSldXu3E3g94g3LYkNKc/0wUFDAVLBa2vb/n7T2n+RN84x0L6
         X1+w==
X-Gm-Message-State: APzg51BVoiU4nL9oOtf7u3BxJYG18zTsx/NYoEHlcDv55EQKrS4FTx8I
        ukMsY8nPOLlpjBOMGxgegMD2le0H2AcwRw==
X-Google-Smtp-Source: ANB0VdZJf3p7cnQfPgMkUOVTTI20oxZXROcDBG75NkJZjwyzqxRASb1JwRv0LNjxXrjFNSGW5y6n+A==
X-Received: by 2002:a63:5c5e:: with SMTP id n30-v6mr30463219pgm.253.1536050558042;
        Tue, 04 Sep 2018 01:42:38 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id d24-v6sm21700645pgv.23.2018.09.04.01.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 01:42:36 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 0A28B300D89; Tue,  4 Sep 2018 11:42:32 +0300 (+03)
Date:   Tue, 4 Sep 2018 11:42:31 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Baoquan He <bhe@redhat.com>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904084231.ubyjaqp4xhqcnper@kshutemo-mobl1>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
 <20180904034414.GI1740@192.168.1.3>
 <4546fc39-4982-4c91-c812-0df1e9bc9e20@zytor.com>
 <20180904052036.GJ1740@192.168.1.3>
 <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f65956-ad99-84ee-d4bf-044a6f0c5010@zytor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:46:33PM -0700, H. Peter Anvin wrote:
> On 09/03/18 22:20, Baoquan He wrote:
> > On 09/03/18 at 09:13pm, H. Peter Anvin wrote:
> >> On 09/03/18 20:44, Baoquan He wrote:
> >>>
> >>> 1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
> >>> if the 1st kernel is in 5-level mode. Then in
> >>> arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
> >>> if 5-level mode will be enabled, and prepare the trampoline. If
> >>> kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
> >>> specified, it still can handle well. But for the old kernel w/o these
> >>>  5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
> >>> in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
> >>> is used to mark. 
> >>>
> >>
> >> That's what I'm saying, don't do that.  Always jump into the second kernel in
> >> 4-level mode, i.e. X86_CR4_LA57 unset.  That's the only sane thing.
> > 
> > Well, this might not be suggested. Kexec has been a formal feature in
> > our distro, our customers usually use it to reboot high end servers
> > because those machines may take one hour to boot up from firmware. And
> > 5-level may be also supported very soon, if people want to do a fast
> > reboot from the current kernel in 5-level, and expect to see it's in
> > 5-level too in the 2nd kernel, this always kexec jumping to the 2nd
> > kernel in 4-level mode might be unaccepted.
> > 
> 
> That makes no sense.  I'm talking about *entering* the kernel; the second
> kernel should switch to 5-level mode as necessary.

Switching between 4- and 5-level paging modes (in either direction)
requires paing disabling. It means the code that does the switching has to
be under 4G otherwise we would lose control.

We handle the switching correctly in kernel decompression code, but not on
kexec caller side.

XLF_5LEVEL indicates that kernel decompression code can deal with
switching between paging modes and it's safe to jump there in 5-level
paging mode.

As an alternative we can change kexec to switch to 4-level paging mode
before starting the new kernel. Not sure how hard it will be.

-- 
 Kirill A. Shutemov
