Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A115BECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B602205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRXdYb5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B602205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeGTHmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:42:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40634 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeGTHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:42:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id y200-v6so1059784lfd.7;
        Thu, 19 Jul 2018 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=il+2QimNyvx6wWJSZM8gccNQr+iXm+me2LYv5xfz0C8=;
        b=GRXdYb5oTbuhlxgWLHq6tTnxlsPLxve6XZBmAulvMp0nxOiXWvE9tKu5TJP377+rPo
         Sn2/40la2L70XgFX+xsEarm2z5HF+jB+EUBoKCVuzUAIbNE5YQV8OYv+P9AVuER7DTeh
         61pDk2bfLuy95RuVV6Mume7dBLto82peE/fONujlwTCsqF4lymWFLaw6MvW+uWIt4LzY
         tIdwg16OJKmB1+aAkWE6j7ABTT/l4Gy7jzT3XFezg7GVXKT1VH9jg8/wpb88tWroCXOz
         VlGEyALbJUdNv2wZmmef1OKty6I/5GdKK0KmKOWo56YwI0IM9gvFg1LjBqj8kYv4wxqu
         YouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=il+2QimNyvx6wWJSZM8gccNQr+iXm+me2LYv5xfz0C8=;
        b=PoIe124z9kh/y3JgsK3RkrjvOyvuwUtM+wRiz4yYumxIy+htHLlovEiVgpXgRUh+g7
         yutewugMZdCk9h67nWtankHkvb+r1x5+Mn1wz6gR/3McdZ5vBL7b0+7y2/ZWCE5kJP9E
         tul8iAqz0QHe/HaQ3TPug7vS+TRRxtPmRf0UC3D7xYR5SIJpLJS4553ZtoKa/gJXci/l
         lTLFiXC9o207AIT6ywG1UOswrQvnoLjLkj3BMI07WDCH5OoWW/YKHRuY4Mrqy7Z9My1m
         iNqCCxZPxUu0ifubGAXLAtnyfLvp9uv22Y5qLtSy6T/Lnbs8FDRCuefHWtNA3jk4zcdl
         cVjg==
X-Gm-Message-State: AOUpUlEMfKvxrDFeTy93dTLNgVMLFyg3Ee7/Mt09C8hQt7afNwNuwD9Q
        ML7NPXaXu/iDYU0e4DU0NoSl8+xBGTzf/OWJVk8=
X-Google-Smtp-Source: AAOMgpe7MgA4oggI52xXXN/F63YyKSoD1fdZRATA8uHWujWDAN6o/Bv2imcKncKZ1faYytIVGyI1YKeoZTT72NtY730=
X-Received: by 2002:a19:e119:: with SMTP id y25-v6mr572452lfg.3.1532069727914;
 Thu, 19 Jul 2018 23:55:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 23:55:26
 -0700 (PDT)
In-Reply-To: <20180720060944.GA4823@magnolia>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
 <20180703213943.GU32415@magnolia> <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
 <CAFqt6zY4BLw4HeaQmwgv2B+hQLnULuyvJDkcRd5-CbYTZuPw+w@mail.gmail.com> <20180720060944.GA4823@magnolia>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 20 Jul 2018 12:25:26 +0530
Message-ID: <CAFqt6zZTqLP2TPE-ANn7HTkakU=zs3hLJ1DC3a2Y=ZR+ASYfuQ@mail.gmail.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:39 AM, Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Fri, Jul 20, 2018 at 10:31:30AM +0530, Souptick Joarder wrote:
>> On Wed, Jul 4, 2018 at 3:22 AM, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>> > On 3 July 2018 at 23:39, Darrick J. Wong <darrick.wong@oracle.com> wrote:
>> >> On Mon, Jul 02, 2018 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
>> >>> On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> >>> > Return type has been changed to vm_fault_t type for
>> >>> > iomap_page_mkwrite().
>> >>> >
>> >>> > see commit 1c8f422059ae ("mm: change return type to
>> >>> > vm_fault_t") for reference.
>> >>> >
>> >>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> >>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> >>
>> >> I don't recall Christoph [now cc'd] rescinding his NAK of the previous
>> >> version of this patch[1].  Has he changed his mind since May?
>> >                                      /|\
>> > Oops, a reply gone wrong -- I was me  |   to reply to Souptick
>> > Joarder's gfs2 change which I've add  |   the gfs2 for-next branch.
>> > Not the iomap change. Sorry for the   |  sion.
>> >                                       |
>> >> [1] https://spinics.net/lists/linux  |  vel/msg126032.html
>> >>                                      |
>> >> Now granted I didn't have a problem  |   the code (and applied the xfs
>> >> version to 4.18 after monitoring to  |  sfy myself that nothing
>> >> particularly weird happened during   |   but seeing as most of the iomap
>> >> changes have gone through hch's rev  |  nd landed via the xfs tree...
>                                           |
> --D                                       |
>                                           |
> I wasn't planning on it, due to aforementioned NAK still being in place
> to the best of my knowledge, at least for the iomap patch.
>
>> Darrick, is this patch going to 4.19 through xfs tree ?

Well,  the original patch was NAK by Christoph because he wanted
to see the complete vm_fault_t migration picture in a patch series
where Matthew mentioned to send one patch per driver through
different maintainers tree to upstream the changes. This discussion
went on into two separate mail threads.

At this point we are almost done with vm_fault_t migration in all drivers/fs
except 3 patches and all the changes will be available in 4.19-rc1. We followed
one patch per driver mechanism and I believe we not are going to adopt other
mechanism (patch series) to upstream these vm_fault_t patches.

This particular patch is struggling for more than 3 months now.

Christoph, would you still like to maintain NAK on this patch ? :-)
