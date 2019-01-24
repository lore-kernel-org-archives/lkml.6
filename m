Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9DCC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E605A218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drXtzS1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfAXVqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:46:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfAXVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:46:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so3518486plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TrDZii3mPD2cyirFklI+XY6foFu42Tl0biRwdMhEyFA=;
        b=drXtzS1I1MQhgYis+j+C9ZLKFE15dpyaDIayCTwfdb1HmoBlvNF2L8OszIDYcvIvaF
         HU3yhq1SBBgYqmm/b5nufOzcklsuvP8sgNTtRo/OZhF0Z/xv4dYB/uG0y+N+J8r9Lff5
         eR1rQUdxdRUHBGgrcD4ZWIEnYJfYhNqo0O8UBPOawLnQZ9qdvwhxoIKxTE4gtTrEdKeD
         cN2WcRPvwWy+4hfSp8j6pR7SkG6yPlUOC6A79pBN1Q5cqp3iXLMVzEPrb8+u6hLARmZd
         oyEmXMaxPGvUOs9STviKe12bMAvRjXlkv70N3AzMK2H+kR95nNMKbH9803Yoil/zzhw/
         0iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TrDZii3mPD2cyirFklI+XY6foFu42Tl0biRwdMhEyFA=;
        b=JcAk4uXzpEULg7M+7+de+PtJT+srLH9tiG44Mc6WH4/j6JCuBENDzRWjCsflWPS8Wr
         Y81/1wZK3wfkjr2G1KMzbEtpe26XXiTwrPKyTwmUpri9Q2+eOJ1mGzp7OJ+jUCbZlMrj
         ELjg6zzVjzoDjft62MiHqhB5CAY/RmK4X1Gscl+WrrvZsM70OUlzdh0fOES6fNImmX7u
         nSjVugXtmFaQi80inTKn/7GuSMZRsZBb1XXdwhhtImiJyOH16T/SpspmM1J8nBNZuvOM
         tAS+jpqd6QtYQfSlQ3fM1rj8Ta+Qto4mEi//U4mJBgBAAL+Oty3rdR04Ppgkrl47o4HY
         igQA==
X-Gm-Message-State: AJcUukfIeK4hXcgwpUVrcz3+Xdrq0FyXy3l0952FYL/GRraYCJtS8gt9
        LwD4tUFoerbXn0goS/mqOndhwQ==
X-Google-Smtp-Source: ALg8bN4Iou51m+IBBfZQ5uPb5R8AX+Fbl71g7oe+sUfamciFnIqIpwArCUfMcY8G4IkktzW3lfxNWQ==
X-Received: by 2002:a17:902:5601:: with SMTP id h1mr8399241pli.160.1548366369953;
        Thu, 24 Jan 2019 13:46:09 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id d21sm31792799pfo.162.2019.01.24.13.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:46:09 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:46:05 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Message-ID: <20190124214605.GA174751@google.com>
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
 <20190114234728.49239-1-tmroeder@google.com>
 <20190115024304.GD5141@linux.intel.com>
 <20190115175111.GB68985@google.com>
 <20190123183322.GB160275@google.com>
 <7abea144-772d-bb3a-bd7d-a9117305c2fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7abea144-772d-bb3a-bd7d-a9117305c2fb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:18:26AM +0100, Paolo Bonzini wrote:
> On 23/01/19 19:33, Tom Roeder wrote:
> > 
> > Even in vmx_set_nested_state, there are about 30 lines of code in
> > between enter_vmx_operation and copy_from_user, and there are a couple
> > of cases that cause vmx_set_nested_state to return with an error. So if
> > we want to fix this by handling all the error paths, I think it might be
> > cleanest to convert vmx_set_nested_state to use goto error handling,
> > since that would allow us to clear the allocated memory in one place.
> 
> I prefer to have kzalloc, and change vmx_get_nested_state to copy the
> whole page including the trailing zeroes.

OK, sending as a v2 patch in a new thread.
