Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F161F20658
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKzx0a8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJTAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:40:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38206 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeJTAkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:40:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so13014292pll.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6rT+jseijOqZyAZOjRE1+RVxwYDpWc9DUZXD/qeQ8E=;
        b=cKzx0a8gLoFQoud0/fYIKKW8UvqSApTSGx7dimlDLLqyC5GzbQY7KBpTGOuY0TJ44a
         PqQkiqt6pieOrR/Vkrk5BBxegTc82DjSowz96qPXp9xQES9LW1KKRAW1mQEPKDUo2q4N
         tOAQcDJ4eDmJcANCnKXgZ8ZEGvXgFQMEY9Kp+fm6qqtDAozjWx29a6U0Bwi3O+bVIq4b
         wa4uleO06GGcoRJ/GGfNfKfmmURshRwLyTYsC8JAULoX6Wt7Gtswc67Vb6VAnFhGxxUW
         c9aWx3mrHtpznlnFPeZ/8XSkzN40keKwLOfVNfDwuKBL+DLt1W5HZooFv93jzrqKPBOs
         VPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6rT+jseijOqZyAZOjRE1+RVxwYDpWc9DUZXD/qeQ8E=;
        b=evAQhn53BQKD4kcEjnaNeT86FGBD/NCz5ZoARAloflKvDuG4v3ToNea9qqaEdx9xpA
         2lTrrQRV1/do5R/UsaaA5fWCsoiYYiEIz8Ie2bZ/+HgDbcgIMNM+Pr6RViBBuevAPFHO
         SwnnVqQdzdfTyenFJ9dy+2wmT+skIE86kctU0lWppHznuxMgJYIGSebJqqbDZbc5709n
         PHB5Hev9HdQca0xnzKLAl4SRH2ySS94ndxc6Ejmi2po9YNJZ0ea065et1lRQH6wU5VkB
         WQ5Oa8Wj7x7A9uVGuyG9Qr/965XQRxsBFskquZZGiPTqjyWrSJn902PtSL0AJvKECF40
         gMKw==
X-Gm-Message-State: ABuFfog+9qbwz6gky0zWV9fWuiErUkKqxHkh7qMGYBzbunlhpujrecCn
        tLojjpPpMEIELS44+G6DuLv3Rw==
X-Google-Smtp-Source: ACcGV63dGQgURcc/S0+Y0DZwKpxMd04BhUl9WnVitO9Q57KZ2kqXYzdBx/tWeE+YdcHsvozWNGHbcQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21-v6mr34566893plo.21.1539966834406;
        Fri, 19 Oct 2018 09:33:54 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id n64-v6sm33494880pfi.185.2018.10.19.09.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 09:33:54 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:33:48 -0400
From:   Barret Rhoden <brho@google.com>
To:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
Message-ID: <20181019123348.04ee7dd8@gnomeregan.cam.corp.google.com>
In-Reply-To: <159bb198-a4a1-0fee-bf57-24c3c28788bd@redhat.com>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
        <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
        <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
        <fefbd66e-623d-b6a5-7202-5309dd4f5b32@redhat.com>
        <20180920224953.GA53363@tiger-server>
        <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
        <20180921224739.GA33892@tiger-server>
        <c8ad8ed7-ca8c-4dd7-819b-8d9c856fbe04@redhat.com>
        <CAPcyv4j9K-wkq8oK-8_twWViKhyGSHD7cOE5UoRN-09xKXPq7A@mail.gmail.com>
        <159bb198-a4a1-0fee-bf57-24c3c28788bd@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-21 at 21:29 David Hildenbrand <david@redhat.com> wrote:
> On 21/09/2018 20:17, Dan Williams wrote:
> > On Fri, Sep 21, 2018 at 7:24 AM David Hildenbrand <david@redhat.com> wrote:
> > [..]  
> >>> Remove the PageReserved flag sounds more reasonable.
> >>> And Could we still have a flag to identify it is a device private memory, or
> >>> where these pages coming from?  
> >>
> >> We could use a page type for that or what you proposed. (as I said, we
> >> might have to change hibernation code to skip the pages once we drop the
> >> reserved flag).  
> > 
> > I think it would be reasonable to reject all ZONE_DEVICE pages in
> > saveable_page().
> >   
> 
> Indeed, that sounds like the easiest solution - guess that answer was
> too easy for me to figure out :) .
> 

Just to follow-up, is the plan to clear PageReserved for nvdimm pages
instead of the approach taken in this patch set?  Or should we special
case nvdimm/dax pages in kvm_is_reserved_pfn()?

Thanks,

Barret



