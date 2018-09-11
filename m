Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6104DC43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0327520865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2xc4V3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0327520865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeIKFcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:32:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53634 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeIKFcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:32:20 -0400
Received: by mail-it0-f67.google.com with SMTP id p79-v6so32053093itp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FjE84oBWiXNArrUL3mReRREGILdoIzO9HKkSHb6WtcQ=;
        b=U2xc4V3PHZSveUCB15uF0vm8lbw4pmNLtzkM7+FqgMm9gSMrQS7Kvhk9Xifax+TWx5
         L0c+C1aWqZ4LO7bONB+XYLguRjaKeJhBa6AUVfgd4uR4VKbwg8GRNi5b4icLZ04tXDgK
         P9JXjcernYPAkmKLVfDHCvmZuXZ+O+8G3A83yNu2e/4enBjQUiR4CLuB++0FFqFvI3ro
         piMzSSBYJSd6T++ThaLXrdcfvqiKX8dvevlubEdycikpzLB2QKK4SQVdpAyQPZyYIBt0
         mGGaagCo1X+NCXwQR0OAG28gxCglgaB5qWMTQ4yXuXV9AY7aNQ3C6DJGproLrmYq3WOp
         V/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FjE84oBWiXNArrUL3mReRREGILdoIzO9HKkSHb6WtcQ=;
        b=MOMCiRDrIRhud+OLrXGwksrriw61EtRUNt5O6jM1VDYltF3K2ChtqJ2qz0O9fMJr0J
         X2C6lW+peNRft1CMm+oHr95DGoCcTfe0YwGKdHA6RfPoAdPGL4zy6KFmBBpBcfMjPX//
         grza8RiuIWucuKIu8IiVF+qAMrO6EBvHRUT204zXIJV6J5Ze9fL1ZzkfIqsGSO10J4+u
         LkhSezktBHWZwpx4X3AYL0BeSXQ7S1valddUAOnKPq+mcInE5kv8YfMj0xoBCReZq/6o
         c6ZI2NKvegDG+/jvN2UzA4Xqwt7tYmYe5VIrYwuSXKK7rMHzRQguZdE3GxL7Ib7zmLmT
         Sh3Q==
X-Gm-Message-State: APzg51DikTXuGyPiaUUtAWjhR+mJUrZnGir6h1w37piTMYCcbmFZrU6F
        fn3Bryc9YlexXMMf/jIrssqtRTjt/OowjST7X6A=
X-Google-Smtp-Source: ANB0VdY2MK/JJuYkJbEkd/N9JsYgmYkahtPBcGf58xZMMkQKh2/Elv/KSspGgffBLPI72hc2CNQs9CFAngZZ3EYYngY=
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr21629593ith.58.1536626145046;
 Mon, 10 Sep 2018 17:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain> <20180910234341.4068.26882.stgit@localhost.localdomain>
In-Reply-To: <20180910234341.4068.26882.stgit@localhost.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 10 Sep 2018 17:35:34 -0700
Message-ID: <CAKgT0UcP4G-Y8ad2yGh_kGSSD4ry-Z+FtZ+6wwFzUS3YkpeFyg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        dave.jiang@intel.com, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        dan.j.williams@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 4:43 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> On systems with a large amount of memory it can take a significant amount
> of time to initialize all of the page structs with the PAGE_POISON_PATTERN
> value. I have seen it take over 2 minutes to initialize a system with
> over 12GB of RAM.

Minor typo. I meant 12TB here, not 12GB.

- Alex
