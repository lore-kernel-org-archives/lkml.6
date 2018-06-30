Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DDC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A4B2802D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AU5yijqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A4B2802D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936150AbeF3CWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:22:18 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:52341 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbeF3CWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:22:13 -0400
Received: by mail-it0-f49.google.com with SMTP id p4-v6so5375815itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcyxqYYcay/Qsr52+haYXlxp2B0gkYov29mUd/11po8=;
        b=AU5yijqmW/ZaRQlKskFG6uFzFrK/RSpbOpkmevd5USL2Ee6mvT0QTldhSyTEJxBGc+
         h2IY/pQcDef3SbQwRExsqNMB9jDSG+rKh3bwdA21L/hO6J42qH8uyjrc25udQJd8wjgL
         qftqCxy+xpO7Smk5R4MbyFHONZzen9s9jdFcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcyxqYYcay/Qsr52+haYXlxp2B0gkYov29mUd/11po8=;
        b=l628ikpvfpFCETO9qNNymOvNA4DkiCrcOo4yncV3bWDNLFbnDL8/n01b2uUHxEBryP
         3cOjAq7u0VD9mTJP4Lf/izf5gLpKeB9haXVl5E76lDRLf6uQ/dRBPYD2ksZZKwd7SxLG
         6bxxhqvzAaEmuM6HoFEG0oZPugwPnpPEXtZlKOrGYBBA9q1gcA9Z74XweGEUdx395Z7m
         zVrUAgk5nP3PBfDC28LVUKbVwyw6nDwrWOVCwwdWXIrFn9r1eeO7qn24Z3z6OecIegN/
         DaqvYR8lHt4fcvEbG+bi2TTjIiKJ2mN4UR9OAHo82vGQxpPdDtt2Om/j/M7SPNGsu24Y
         jaLA==
X-Gm-Message-State: APt69E0643afmT9IwhUyai79Stvalm/0cZ28OL5F2RpPi050OxslhefM
        6TLDPa2PZDh3WvKGdZ2HR0fRNsR9mr/pDHdQupU=
X-Google-Smtp-Source: AAOMgpfdEf7RqLkGz2WRV6/fFW5XABr5eDxPRhJcGEA6VgxXxcPUKfmUlxdukp5SFdleILWrwC1E+YYyHx0Y3PSK1Ew=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr14520665jaf.70.1530325332255;
 Fri, 29 Jun 2018 19:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com> <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
In-Reply-To: <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 19:22:01 -0700
Message-ID: <CA+55aFySZ39GHpK4XPvsOGv6yfsn9PyR+3Fs9_zb=2CQ2ha+rQ@mail.gmail.com>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     aneesh.kumar@linux.ibm.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 2:46 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Looks like pgtable_page_dtor() gets called in __pte_free_tlb() path twice.
> Once in __pte_free_tlb() itself and the second time in pgtable_free().

Ahh, that would certainly do it,. and explains why this hits ppc32 but
not x86, for example.

                Linus
