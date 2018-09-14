Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B63C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49B208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1R4QWbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A49B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeINGp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:45:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38849 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeINGp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:45:56 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5-v6so3106131otl.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcZFk35HS34jGXkVQdUbdiMbpUGHpuZeaJjw92PAa7g=;
        b=l1R4QWbxyCjOXvaaVoLxosMlNPx99WkAeT1AzqRjps8elb+gr22hb32EOXAx/4svto
         PrvCAbMIql6e8s48Gvg/yAqVIlEmxxjDBQxbk4CXsX81riDCN8uITiX9WzSoQ/4uhOAs
         SsiJb3JMoenKDl4qgCNK6F0TN4iw0o/ekOpJGiRPm0HETqDdzMeAoQQAPUjQM04dJ/7F
         41uyE0odt9TEqElxoLQYHBzoIDZFuGMjTmMP6YTv7Tdj4r7L3Bra8VV3Bvu1b6mH/FTx
         LKxYJi0HkxQzUnPFhQOyel6rFGgAiM1JZ5fpnX3mE30DYNgvUKhXIHzjbIee6fWzhvCp
         HfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcZFk35HS34jGXkVQdUbdiMbpUGHpuZeaJjw92PAa7g=;
        b=HemP8uoUXf8HmjNwQEGOmSfqYXb2dLPEN2M/W4sHa+zqV4SLtSRXjZuhYuc+llWpJN
         Ro7YLqlRQHf5Fgs0OJCrHZlXJ2v/+L4DGNodEuoS4+UwAnsQ++ZcxMzRUJ1eIE9/JRkO
         3941kD1y7Xy8zflz+1CC9uFPC5d11/z+E53KR9IgoKb51lOXyuIVsgnhT66gmlFh9fUF
         NzbwAHEGzP2wb1pEMS7xF9LLu0h2LFHcK7294m2mJR+iDzK2F/FbLplbLNirVj7sDgCH
         8YUZO1giUobDDnNRrqCNReUQzdNtQ5XVqlg4oGMvdujszy0R5Ip1sTV/Vsr7UvmkXeO0
         4/NA==
X-Gm-Message-State: APzg51D4WdHWzMPwn2/AHBanxHh4nyNo5za2zkp6YWbXKQ7/hGWWCGLX
        nh9D/xV2rP/FEFOvdFO7oi/+tBbVQRP+JrhX87rh1g==
X-Google-Smtp-Source: ANB0VdbzuotHF4NQqSxd54BQ8mrJvqS9eiwnUAKhMsmHwdC3MuW2ku6M26KVMxisULm2QLX/TywLK8+egJ5nErnGtlI=
X-Received: by 2002:a9d:3b42:: with SMTP id z60-v6mr3181752otb.32.1536888834333;
 Thu, 13 Sep 2018 18:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com> <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com> <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
 <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com> <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
 <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com> <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com>
 <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
In-Reply-To: <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Sep 2018 03:33:28 +0200
Message-ID: <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com>
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com,
        nao.horiguchi@gmail.com, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:43 PM prakash.sangappa
<prakash.sangappa@oracle.com> wrote:
> On 05/09/2018 04:31 PM, Dave Hansen wrote:
> > On 05/07/2018 06:16 PM, prakash.sangappa wrote:
> >> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
> >> different with respect to seeking. Output will still be text and
> >> the format will be same.
> >>
> >> I want to get feedback on this approach.
> > I think it would be really great if you can write down a list of the
> > things you actually want to accomplish.  Dare I say: you need a
> > requirements list.
> >
> > The numa_vamaps approach continues down the path of an ever-growing list
> > of highly-specialized /proc/<pid> files.  I don't think that is
> > sustainable, even if it has been our trajectory for many years.
> >
> > Pagemap wasn't exactly a shining example of us getting new ABIs right,
> > but it sounds like something along those is what we need.
>
> Just sent out a V2 patch.  This patch simplifies the file content. It
> only provides VA range to numa node id information.
>
> The requirement is basically observability for performance analysis.
>
> - Need to be able to determine VA range to numa node id information.
>    Which also gives an idea of which range has memory allocated.
>
> - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
>    directly view.
>
> The V2 patch supports seeking to a particular process VA from where
> the application could read the VA to  numa node id information.
>
> Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
> file /proc file as was indicated by Michal Hacko

procfs files should use PTRACE_MODE_*_FSCREDS, not PTRACE_MODE_*_REALCREDS.
