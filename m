Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA8CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A682082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xOxiTtMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A682082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbeLEBAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:00:30 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:45000 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbeLEBAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:00:30 -0500
Received: by mail-oi1-f175.google.com with SMTP id m6so16056220oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 17:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liGYvibBZS06Z2clwd5T65w/f1vhnHnTBJugp44TAtI=;
        b=xOxiTtMJcrP3c4nDbWw7M7TR/l6r5vVioW9Thhdhshe0NeZ/Ldk/wP+cJfdXwZLtJ4
         fiMRhERLlO13ehlNuEBQmb9IadfSw/kqOO+IkyTY+EwxBNdVtguf78T9d5oIPpF4+y9H
         zm2xPo+5YBGeXmRapmtH1JJVccmbYUUyf2TkDqk4mGCAclbElfVWa6Luuub9O+lBnphU
         X88x8QuZm8nNU+4ugEODLcGf7i9ZN1ne8h44MVzwexjPVibumCa8jCbHYAc9N8Z5lx//
         A4fSqeZzdxeDv8ZCl9uqsRE+9UVWbVSnwHx9z+RVIObRdOmE4Wh2fHYst0R7LOCAeC6e
         hqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liGYvibBZS06Z2clwd5T65w/f1vhnHnTBJugp44TAtI=;
        b=Cg9h7Vldhew2sNoVsuR51l8CKnOiZxIjVa2h2Vvknet0DgRTA5V/iU5PkXarPwgoK/
         Xq47wSOY6P2o5txlq3qGnn76bmNo4cFDyWOg+w40kUtxaT60sb5Ps0djAv7XGDSnwVOo
         1Oixr6OM9XeNgZMQB9Uw6Az1lJp93PJa8zlo9ow//yG1IOp2T/c0tPhR++90bewaVgRX
         J8ydtoTBvTWmxTo6N6uD+He4K1Hr6MpB04rNXZAslEkne8BxUzj+k8U0NdFzPMN8aMSP
         hVS7RsHkSMs1xK/2kGoJ1CgH1EnXK0FPD+wwEPbhxSHn1kkwra0+Bw4a22gj/UmFSVMW
         eh4w==
X-Gm-Message-State: AA+aEWYQVhA5w2fxnjyr6HCTbKCDiDg9gkijpwVny+v9a3KWe6/2OL1m
        r1cyd1KzjGbyfMbw7ETow4FY5rO55S+EDHbeCS/aKw==
X-Google-Smtp-Source: AFSGD/XhqIshbnUBK7Kg6e6eIwflB4N0bc50kYmOoP/IhOw7oywntiJTs9A4kSZJDIbSEpR1AncvIxq3v6XOp44KIIQ=
X-Received: by 2002:aca:4307:: with SMTP id q7mr8043451oia.105.1543971629135;
 Tue, 04 Dec 2018 17:00:29 -0800 (PST)
MIME-Version: 1.0
References: <20181204001720.26138-1-jhubbard@nvidia.com> <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
 <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com> <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
In-Reply-To: <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Dec 2018 17:00:17 -0800
Message-ID: <CAPcyv4ii1F3iRv7TnnT2QAG+M4fst7Cu=8zggVauSizEmCtfTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        tom@talpey.com, Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, mike.marciniszyn@intel.com,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 4:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 12/4/18 3:03 PM, Dan Williams wrote:
> > On Tue, Dec 4, 2018 at 1:56 PM John Hubbard <jhubbard@nvidia.com> wrote:
[..]
> > Ok, sorry, I mis-remembered. So, you're effectively trying to capture
> > the end of the page pin event separate from the final 'put' of the
> > page? Makes sense.
> >
>
> Yes, that's it exactly.
>
> >> I was not able to actually find any place where a single additional page
> >> bit would help our situation, which is why this still uses LRU fields for
> >> both the two bits required (the RFC [1] still applies), and the dma_pinned_count.
> >
> > Except the LRU fields are already in use for ZONE_DEVICE pages... how
> > does this proposal interact with those?
>
> Very badly: page->pgmap and page->hmm_data both get corrupted. Is there an entire
> use case I'm missing: calling get_user_pages() on ZONE_DEVICE pages? Said another
> way: is it reasonable to disallow calling get_user_pages() on ZONE_DEVICE pages?
>
> If we have to support get_user_pages() on ZONE_DEVICE pages, then the whole
> LRU field approach is unusable.

Unfortunately, the entire motivation for ZONE_DEVICE was to support
get_user_pages() for persistent memory.
