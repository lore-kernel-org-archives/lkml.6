Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AAEC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF920833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcAA4Y4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEF920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeKCGRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeKCGRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:17:34 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D3820843
        for <linux-kernel@vger.kernel.org>; Fri,  2 Nov 2018 21:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541192931;
        bh=gJSmTDkvmQPHiGOknTbT8hKXfUfQeACJtUz+IutsXD4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jcAA4Y4OsP5RLVNnp0Zn0vUlzhWs2uLzoXZlI/BEavmX9xT2q67Lza8Yy3H89OYRn
         OVbDq4bTKQmp4dMYrkWghiCyk+7puApJn0IK2UIstKhvHGWjA6shRjt/UTNm6WYNoA
         1af1wF9L98WYX9Cs5+BqaFhz0qvBhvJp4honK/Bk=
Received: by mail-wm1-f42.google.com with SMTP id h2-v6so3104646wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 14:08:51 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKGDXpjCfdg25pSXe3krUKWVqothDS2z+9MUDexLoKKdZ48iTM5
        LsH2SmLIQ+SGV9jLhlp07BoVC7DNyCVANlwxBZhLWg==
X-Google-Smtp-Source: AJdET5dVDVxjTq9ZVU6eVq+a3JCMCaTfjilFhw+eZt+2D7AKIeiMKCJ6H2geVyd1T8PkifyHMlRopzxrf9/Um0i5YVM=
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr162294wmd.128.1541192930081;
 Fri, 02 Nov 2018 14:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181026122856.66224-1-kirill.shutemov@linux.intel.com> <20181026122856.66224-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20181026122856.66224-4-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 2 Nov 2018 14:08:38 -0700
X-Gmail-Original-Message-ID: <CALCETrUe7nNxbpHJaO0mKS3g8RvL0am4WnKOofei8fviK-PgEg@mail.gmail.com>
Message-ID: <CALCETrUe7nNxbpHJaO0mKS3g8RvL0am4WnKOofei8fviK-PgEg@mail.gmail.com>
Subject: Re: [PATCHv3 3/3] x86/ldt: Remove unused variable in map_ldt_struct()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 5:29 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Commit
>
>   9bae3197e15d ("x86/ldt: Split out sanity check in map_ldt_struct()")
>
> moved page table syncing into a separate funtion. pgd variable is now
> unsed in map_ldt_struct().

Reviewed-by: Andy Lutomirski <luto@kernel.org>
