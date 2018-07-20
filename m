Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B14ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F8D20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwIdtaG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F8D20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeGTFr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:47:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46708 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeGTFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:47:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so10013265ljj.13;
        Thu, 19 Jul 2018 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ts2T8FNMiTVDr0g4ZHkC7SBDKhTYPqN8fSN2Z8XcC3E=;
        b=rwIdtaG07dtJfvQeeAmDCLizV29heAkPAluBmWXso4PgiXFXQJwx7zQnzB+5kUGsRB
         JfENSd62iiPBf8iQTPJ6ff4KHBrA461uCYqKGUzinPBG7ZRwRauc7NPhaZmSW2p6tQ8W
         sNWKHUu47mI3kO86cUoW/mVFbNjN1Ow3nzf0rrJsssNiTQe5BWXYAjev4bOQiDQJBtdG
         Bt4AcWzs/t21j5SFuXmf2qBJqNDQd49ph+C713OB+Gtj3nK8WL4K7fJIJ6hPInMG6OqW
         nnUge5TEVVrE2Mair2f06itUzRuZhsm2C9ATRUvh7KG8vnuMD9eRP05ljleKCDFYn3uU
         rh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ts2T8FNMiTVDr0g4ZHkC7SBDKhTYPqN8fSN2Z8XcC3E=;
        b=RDykgkW/NaDZlaKPfLLx70+7VoVB5uRd/V5NIH6NbSzhxDDXFC4IqasC4L9qbRSqSa
         jYXQcnEexyef1gd9fOWQUPmIpN+YgNdmGgoy3Bv2S+ifQzCdXQWc0rBdXoMhxUMwG+hH
         XkzZ7XZwrKS6uvIMHGYEWtMfd9u96yam+JggntK2epgpZPzgZ/QsfuCsehmMLy/oDqH6
         OwidhabX7TKzXC/pYQgm9FaZ7CL8kYhOZMLrZp+X/0lMEE/OJV/QhcG7oGfNYumfNHcc
         JYjdYOTQjSL37iZgJK4+Oq29yHOtyB4bxUSKJupVeQGpc8sXSoVtGd16UJtPSm6px01T
         In0w==
X-Gm-Message-State: AOUpUlFVKHEco4+ISLgQdTtKRGM91fXDYK1Jgs3Y53FVNiQkKGWDHs9l
        ZaLAQKfQoE7R9/1D2WZZYqthQKOnRBKvzShM2jA=
X-Google-Smtp-Source: AAOMgpd7sJvM7euTgTUtCKO5zGwz0+/r6kzcaMEpZRoo7O1nNWQHHh65uD3nzzH+QVyUHokMHzQEOvoyiP7XajNo5bk=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr334746ljb.86.1532062891926;
 Thu, 19 Jul 2018 22:01:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 22:01:30
 -0700 (PDT)
In-Reply-To: <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
 <20180703213943.GU32415@magnolia> <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 20 Jul 2018 10:31:30 +0530
Message-ID: <CAFqt6zY4BLw4HeaQmwgv2B+hQLnULuyvJDkcRd5-CbYTZuPw+w@mail.gmail.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 3:22 AM, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On 3 July 2018 at 23:39, Darrick J. Wong <darrick.wong@oracle.com> wrote:
>> On Mon, Jul 02, 2018 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
>>> On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> > Return type has been changed to vm_fault_t type for
>>> > iomap_page_mkwrite().
>>> >
>>> > see commit 1c8f422059ae ("mm: change return type to
>>> > vm_fault_t") for reference.
>>> >
>>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> I don't recall Christoph [now cc'd] rescinding his NAK of the previous
>> version of this patch[1].  Has he changed his mind since May?
>
> Oops, a reply gone wrong -- I was meaning to reply to Souptick
> Joarder's gfs2 change which I've added to the gfs2 for-next branch.
> Not the iomap change. Sorry for the confusion.
>
>> [1] https://spinics.net/lists/linux-fsdevel/msg126032.html
>>
>> Now granted I didn't have a problem with the code (and applied the xfs
>> version to 4.18 after monitoring to satisfy myself that nothing
>> particularly weird happened during 4.17) but seeing as most of the iomap
>> changes have gone through hch's review and landed via the xfs tree...

Darrick, is this patch going to 4.19 through xfs tree ?
