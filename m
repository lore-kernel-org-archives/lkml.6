Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kNQxI3p2GVveFwAAmS7hNA
	; Thu, 07 Jun 2018 18:39:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 04E456074D; Thu,  7 Jun 2018 18:39:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="mflQk3Mp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 92A62601C3;
	Thu,  7 Jun 2018 18:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92A62601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935018AbeFGSjr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:39:47 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37925 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeFGSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:39:45 -0400
Received: by mail-ot0-f196.google.com with SMTP id n3-v6so12720628ota.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E9pLxOe+TDsNJHMPfp8ohCQ56TYz4uhxDek+2sIsCq8=;
        b=mflQk3Mpelj7NYfJO1m7nJCM/FxsCrRi1LRv4uoFSjoFr8bnAN1/0v7x9WwLHeHj8j
         5amKB3ybDVTtZLPkJHlCCY9uO7kpSJ64KA/HoEPNK8qncTFCXdj/eiaNkCIKcVmwULlA
         gAQ7yKL4id/t0+/p9YdfJ950aoZ3hwxM4991Km3BY0PUbVkxZy/qesZvS4+g1utjCJ57
         s1TSSDGjigfdNp6Bms7qthz2YvNaYRKp6mUAAcxA8ngiKV1gn6NHj1k8qaWJ9rajMsN7
         gVjX6mUKTN1vtd8DjhwIvFpdQSprylPYeLnmtKq1F5+ZcpaCFHiEAEt4cm7cuZkubgU2
         XWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E9pLxOe+TDsNJHMPfp8ohCQ56TYz4uhxDek+2sIsCq8=;
        b=tdKsQiCtfErGdvOJjJHJrc7F9wKQHlQLID1025P6UMwLTixpygMRSnBfvTR1CgEEGy
         A9ez7gCE7yDpvvDQkaiduYSlWb+NsY4rBDX+wSFdix39mM1121hgi/i7ruw6/EQU17VS
         kiCa41o6qH25e21PFMOTKWpWaGykTi5W1+OroU5cC3ooBiIRuVFTLgizZi14e48vNACg
         qhOQlCxfwyAYDuJfK084HZ30KtxbJ+AD5rqLzDlDMRRtwy25xS97tGcBJ25pooQMPoro
         QLRPdJg4jE6dTLOlfNzJ6vBSfaWTFWZgJF0KBGDS7RgdlMBTbJ73XWMT7Yg9Kc9UKYnj
         hGng==
X-Gm-Message-State: APt69E3XSZBBOAdEL8CvCxZIE6DyBfqnHM8c8GVdJLHPTcP2IXOnhEYd
        8IKqq418pHvLGtOxVZF7+EESbqY3zb1siMt+OlWCxA==
X-Google-Smtp-Source: ADUXVKJfAUQLZlDGRu9WIeT6FnvNLqvUK6lHZgIFBjXIsWl2PtO8Aj8EVqfpdK2VnOmlg+ldsRDPh+fLfxBczFr6WS0=
X-Received: by 2002:a9d:36c3:: with SMTP id s3-v6mr1619962otd.292.1528396785148;
 Thu, 07 Jun 2018 11:39:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 11:39:44 -0700 (PDT)
In-Reply-To: <20180607141640.GA4518@redhat.com>
References: <CAPcyv4hVERZoqWrCxwOkmM075OP_ada7FiYsQgokijuWyC1MbA@mail.gmail.com>
 <CAPM=9tzMJq=KC+ijoj-JGmc1R3wbshdwtfR3Zpmyaw3jYJ9+gw@mail.gmail.com>
 <CAPcyv4g2XQtuYGPu8HMbPj6wXqGwxiL5jDRznf5fmW4WgC2DTw@mail.gmail.com>
 <CAPM=9twm=17t=2=M27ELB=vZWzpqM7GuwCUsC891jJ0t3JM4vg@mail.gmail.com>
 <CAPcyv4jTty4k1xXCOWbeRjzv-KjxNH1L4oOkWW1EbJt66jF4_w@mail.gmail.com>
 <20180605184811.GC4423@redhat.com> <CAPM=9twgL_tzkPO=V2mmecSzLjKJkEsJ8A4426fO2Nuus0N_UQ@mail.gmail.com>
 <CAPcyv4gSEYdnJKd=D-_yc3M=sY0HWjYzYhh5ha-v7KA4-40dsg@mail.gmail.com>
 <20180606000822.GE4423@redhat.com> <CAPcyv4gsS4xDXahZdOggURBHS2y-oJ5tPG9vXPDdY2p6jPufxA@mail.gmail.com>
 <20180607141640.GA4518@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 7 Jun 2018 11:39:44 -0700
Message-ID: <CAPcyv4gSn6O+rWYxAfqjkY6pkGAjvTNRUeMY1Ynde3_Vw6gTUA@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm: rework hmm to use devm_memremap_pages
To: Jerome Glisse <jglisse@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:16 AM, Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> HMM is self contain interface but i doubt i can convince you of that.

I agree that HMM is self contained... after it completely subverts the
core-mm. It's that deep understanding and working around of core
memory management infrastructure that makes devm_memremap_pages() and
derivatives EXPORT_SYMBOL_GPL ("considered an
internal implementation issue, and not really an interface").
