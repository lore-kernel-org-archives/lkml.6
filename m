Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514802086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfCfIWBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514802086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbeKNBtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:49:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41533 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeKNBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:49:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so5868585pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIFJYXCCYbIE9QdI6j4zxGOHMCkI5//En2xA/fsGVfE=;
        b=HfCfIWBHVP9ZHgf7dtz+iirn8OFYl64MoTUn9FR3y1ATIY6kCxGOt09lWk3h1dXVme
         FOL0CwR/Q2Gh2gX4hVG5aC/kb0R/SgXP1Y78e0HPF+SFKfOLj5VsetB5BrpIMjVJqH//
         f1FJ01DJdtlZCO/gGd1r72Juv+uhl/y+ewo7+S2txm1Ric59px3GXc0aFODxpo2D3bqs
         v0J53lYV9RMfZ/ZFryOiQ9bvAah6f9yjc3qXx9/pf/gXOVFXqy+HVcsDZPKXNoHuCBoD
         mjj7jQyFrO7YTnOlsDNQWal+soLFt5746hoKha/Uz1ww9WuHBC6rd3Wred6lIGNCbJIC
         G1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIFJYXCCYbIE9QdI6j4zxGOHMCkI5//En2xA/fsGVfE=;
        b=S3qSUfNJQoOruSuOhAJB0F2vZBfsfD2wz1Qjw4oabE0o06F7C+zaJ4nCvpzQrOuvGW
         kBX4xWp2g02Xl76nLe+WejtllhwyZPfp4Jh5id20Xub91psB7+6JcdVAaee3DQGPjVO6
         GrbcNc2Oc4U1rSa3h7z6786aBxcBFAnTcMd2n/UplwiYau6EL0SvCZW9NWZCZ8Eh4xH8
         xlROkX4oyOsv4n82EeMlazqJ+y3UWaZ2YNqIZsvmJKGTlhBuchIBI1BYxruC4DV2Owd3
         87SG3LH0qHLNAWEq9QEgNoe3i33I4a32Hihqjj+SZp3LrksUW5Ir7V4OddLgDJNH8sDc
         5mUA==
X-Gm-Message-State: AGRZ1gKChjXl2zbtnLp8aaPBqpWyQZjXcQxS4tm/iQpJNjA/Mp1c02IS
        QRNCbi8L9I4bybQ4f2x5u8hO/w==
X-Google-Smtp-Source: AJdET5cDEoHy823TmzyjN0HSLmwqbNP3tbAemAJ6/Of/F12TbGrWJIZZlaqMEq0BhGPGNEEjd0SJkA==
X-Received: by 2002:a62:4587:: with SMTP id n7mr5624902pfi.118.1542124256758;
        Tue, 13 Nov 2018 07:50:56 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id k75-v6sm55824011pfb.119.2018.11.13.07.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 07:50:56 -0800 (PST)
Date:   Tue, 13 Nov 2018 10:50:51 -0500
From:   Barret Rhoden <brho@google.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20181113105051.2ffaf468@gnomeregan.cam.corp.google.com>
In-Reply-To: <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com>
References: <20181109203921.178363-1-brho@google.com>
        <20181109203921.178363-3-brho@google.com>
        <043a592d-6592-3053-15a0-68cc54a26deb@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-13 at 10:36 David Hildenbrand <david@redhat.com> wrote:
> > Note that KVM already faulted in the page (or huge page) in the host's
> > page table, and we hold the KVM mmu spinlock (grabbed before checking
> > the mmu seq).  
> 
> I wonder if the KVM mmu spinlock is enough for walking (not KVM
> exclusive) host page tables. Can you elaborate?

I'll update the commit message with the info from Paolo's email (about
kvm_mmu_notifier_invalidate_range_end()).

Thanks,

Barret
