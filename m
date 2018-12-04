Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A9FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE542081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oq/+dMEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE542081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeLDXYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:24:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34226 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:24:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so9008501pfg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTTuol1bZF7R6lWOkqo7VOqed+qKygyky7VyyaMcERs=;
        b=Oq/+dMEkol7UgnbTXwCOxDFb2YwahwdM17N8tgxD+SdOTO5e7of4jU35Pz4eO3Aya1
         NMbF9eNJYd0rGnGZRyZjci0AECM0hMizqz2QCdPMBRHojh+9/2QYTHWCSuAd2fkB38Mn
         CxjNkQr3ZqCE0YMPKHZIIjFji5wI3dkAQZJJzrVMuboh2CVXmi4V42VWYHdBK+NqJGgk
         yaBfIlcdurT/18ZzBa9v0J197M4HW3+9P2Vvpbg0vvz4U9woAjExumw8RanId1bvEtd6
         oMRJZb5WQ1wA9NhcQESntEI1o3thFhb4IVHXtVbA0fNSF7ntRW3vE2Muv+6NP2lKadoP
         tpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTTuol1bZF7R6lWOkqo7VOqed+qKygyky7VyyaMcERs=;
        b=M6NE+r/fTFv3EjEuSTcXZ/0BEl+GSMQQeArzGgbzOrevhwNy/mY+cd5KBbrdR+3km4
         xQA/xTHOtZoRFPbYKdPD+2xy6cPHhTDWrbPf/kOsfcq7ccRDTaaI/LsGKg98JjV+Bwai
         ih7JB3skOISaS+iXm5HX10adAiPwy5u7tAV2EZ6yX2ntFoozQ8VLYpEU+2v8zjI+uXg5
         eM7mMufUQpE6P1CObi4BiMh4spz9U81DeGsXQaTJ69GEuNPx+yMgk8JrEVNwi0ZLhvIZ
         /dv1qxO0KV22cUq+W1s026gUxZo6IiADs5lIDO5odiEo+u0WI65K/ddazo41ZIMsFy5B
         cDRQ==
X-Gm-Message-State: AA+aEWZbsbbtkxB1Z4NIIzU7omoBzbunJMJXhy3Mwi/fQqj8OrTXAmu4
        at4aMCj1o4rjwlW6+g4rZhD6Kw==
X-Google-Smtp-Source: AFSGD/U8oENdQe6mo6iLxU5p6w+ZFTAD51l5tp4RbXJFcBaxuH3LgqlgUPdpLr1gu6e1MnXKXyn5eg==
X-Received: by 2002:a62:870e:: with SMTP id i14mr22613982pfe.41.1543965874240;
        Tue, 04 Dec 2018 15:24:34 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id 202sm34649677pfy.87.2018.12.04.15.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:24:33 -0800 (PST)
Date:   Tue, 4 Dec 2018 18:24:28 -0500
From:   Barret Rhoden <brho@google.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH RFC 2/3] mm: Add support for exposing if dev_pagemap
 supports refcount pinning
Message-ID: <20181204182428.11bec385@gnomeregan.cam.corp.google.com>
In-Reply-To: <dd7296db5996f15cc3e666d008f209f5f24fa98e.camel@linux.intel.com>
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
        <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
        <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
        <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
        <CAPcyv4i=FL4f34H2_1mgWMk=UyyaXFaKPh5zJSnFNyN3cBoJhA@mail.gmail.com>
        <2a3f70b011b56de2289e2f304b3d2d617c5658fb.camel@linux.intel.com>
        <CAPcyv4hPDjHzKd4wTh8Ujv-xL8YsJpcFXOp5ocJ-5fVJZ3=vRw@mail.gmail.com>
        <30ab5fa569a6ede936d48c18e666bc6f718d50db.camel@linux.intel.com>
        <CAPcyv4izGr4dLs_Xpa1wbqJRrHZVEKFWQNb2Qo2Ej_xbEXhbTg@mail.gmail.com>
        <dd7296db5996f15cc3e666d008f209f5f24fa98e.camel@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On 2018-12-04 at 14:51 Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:

[snip]

> > I think the confusion arises from the fact that there are a few MMIO
> > resources with a struct page and all the rest MMIO resources without.
> > The problem comes from the coarse definition of pfn_valid(), it may
> > return 'true' for things that are not System-RAM, because pfn_valid()
> > may be something as simplistic as a single "address < X" check. Then
> > PageReserved is a fallback to clarify the pfn_valid() result. The
> > typical case is that MMIO space is not caught up in this linear map
> > confusion. An MMIO address may or may not have an associated 'struct
> > page' and in most cases it does not.  
> 
> Okay. I think I understand this somewhat now. So the page might be
> physically there, but with the reserved bit it is not supposed to be
> touched.
> 
> My main concern with just dropping the bit is that we start seeing some
> other uses that I was not certain what the impact would be. For example
> the functions like kvm_set_pfn_accessed start going in and manipulating
> things that I am not sure should be messed with for a DAX page.

One thing regarding the accessed and dirty bits is that we might want
to have DAX pages marked dirty/accessed, even if we can't LRU-reclaim
or swap them.  I don't have a real example and I'm fairly ignorant
about the specifics here.  But one possibility would be using the A/D
bits to detect changes to a guest's memory for VM migration.  Maybe
there would be issues with KSM too.

Barret

