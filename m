Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BAFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350A12075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="gmrnvy7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350A12075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeGCLBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:01:08 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:46163 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeGCLBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:01:05 -0400
Received: by mail-pg0-f52.google.com with SMTP id q14-v6so805943pgt.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 04:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l+w6YCRME5wrgZA1lOoTgMPVwi9HGauyU7INXoPpTrA=;
        b=gmrnvy7db6CSDk1jgiaITg/qQDTfpPUpnoT2yMlx0/tNaVFjcHqVjGFha7fRT2bqDk
         vn/JC+6xvkESKt+9TL2PszwTUD7NG+QTroA1qmWG/LHb66gIiduQSjG1wrADGqH/lDMr
         ZBjX5JWq8dkqIT8ffAUmUrIt7/JoNEVgaZyfdSWOjDOibcYRuSo01JV98COoodxo0+DC
         lULOv+dKWmMuNG9p+lGQUb4bnTps0/7X3NEkIPTA/EK1TqS8QNwEDEFmdWm36Iqh0WVa
         6NUdockIB+aZzzwqxNONpWzCNEEAah8KeLU+DGELOOrf/mXumwVnUAavIVDDxmgx7VcX
         kLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l+w6YCRME5wrgZA1lOoTgMPVwi9HGauyU7INXoPpTrA=;
        b=RGlismFVq0krhPyjqkiHmB3/qjK9DFiBbAjazo0CaJCyCdWJGNA3pKZlc5DUgVWtUI
         11Ae0hjgF+K1HHrwroub9cib5HgHta3inBy/mPpJVPlGsGTKLZu48MDE2m/SRCigVfaG
         7oKcwlyEmegpRATYUyxLBhOoWWDn/eMGEGUR0wJsepj4ZmQjUkCMxntRHt4Dxzxl1bMu
         Bsgeb7qF4/moIxzCQb7Lx/0uS49rOrT5SEQlt+Xin6pY342tfgx6DuZ6l3VsA28eLn9t
         5XJDdKK3hgXsEbjLMGgeNlLb7eE9pXwKckCh+8y2y+bgvlrmK3pAQNUp/K0deqnA05A+
         7hxw==
X-Gm-Message-State: APt69E3zGQwGHswWFXMUkIGWf0n5avMA8zubtU8oMadGi4s7rSMTH56t
        nAQ3SQE446Z+qwEqXPEQZ2O6KbO1
X-Google-Smtp-Source: ADUXVKIbEmZbyd3/t10XQfDLlSoBPK6jPaOqZkQh60hsQZh3IdqL6MafPvyIA1XXaL1mjWmib/Vayw==
X-Received: by 2002:a65:4587:: with SMTP id o7-v6mr25540278pgq.317.1530615665117;
        Tue, 03 Jul 2018 04:01:05 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.44])
        by smtp.gmail.com with ESMTPSA id z184-v6sm3058782pgz.88.2018.07.03.04.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:01:04 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 5229530003D; Tue,  3 Jul 2018 14:01:00 +0300 (+03)
Date:   Tue, 3 Jul 2018 14:01:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180703110059.o3qm2jyb4qqit55x@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <20180702093450.h5tfjeynpi3nwjbo@black.fi.intel.com>
 <20180702190128.GA455@trogon.sfo.coreos.systems>
 <20180703083038.cxvyhq5vsxyeuyvu@black.fi.intel.com>
 <alpine.DEB.2.21.1807031059250.1601@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807031059250.1601@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:59:48AM +0200, Thomas Gleixner wrote:
> On Tue, 3 Jul 2018, Kirill A. Shutemov wrote:
> 
> > On Mon, Jul 02, 2018 at 07:01:28PM +0000, Benjamin Gilbert wrote:
> > > On Mon, Jul 02, 2018 at 12:34:50PM +0300, Kirill A. Shutemov wrote:
> > > > Could you check if you can trigger the issue with my changes to config and
> > > > the way I run KVM?
> > > 
> > > Yes, the issue still triggers in that case.  I've also verified that the
> > > kernel boots normally with your qemu command if the commit is reverted.
> > 
> > Hm. What toolchain do you use?
> 
> On Sun, Jul 01, 2018 at 05:15:59PM -0400, Benjamin Gilbert wrote:
> > 4.17 kernels built with the CoreOS Container Linux toolchain and kconfig, 

I've built the kernel with toolchain from CoreOS alpha (gcc-7.3.0,
binutils-2.29.1). Still cannot trigger the problem.

Benjamin, could you share the kernel image?

-- 
 Kirill A. Shutemov
