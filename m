Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61222ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182FC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2lGowbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182FC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbeJ0DKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:10:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42453 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeJ0DKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:10:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so948893pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohmZ1YIns7K33kvOBctbMS0BLdrYb+fU+vgIkOfRDSc=;
        b=I2lGowbkn4xYtyy/QSpWl6H7KtdA2Rob6n2w4nrUwYt27s54C9MoCum/5YgQ7xoGMV
         GkcKSrPLWX+DOy7Uh37nwvZmrduXo/oHWuaWFviCFW6vhqi7MPcN2PMtr6uzzuhlC9kQ
         hvIKEtroX+Fc3ADZkRsXkSKK8Cc8fHB9jMYlSb07VvVQB9HdOzrPaStvYBm9UNHGtucJ
         mJ+JkgwS/0AJVOa4QQfXpn8T60ZzKcef9KtDN1qERRNzFFMyPPjlFkoX4Fypb1VPFlHm
         Ku+JjhnkT2WEH1S4g78hCUtUdQU1I5nNBayOjbIb+XIBywTdOSNhTbHH3TkVcjzeqZri
         L0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohmZ1YIns7K33kvOBctbMS0BLdrYb+fU+vgIkOfRDSc=;
        b=sypW9AX4KabIIRGVZJrgonTT6ByXxwDgamhkARZWruJJuE2NEenz5uyM9j6mA935pg
         q6Bb7EaVX/MFhCPJ5gOgcKF4WtMcHvQ3QAYvBfGVXy6wwfCrMV+YEUkmvQj8+vu0VQ/l
         GMdiL4QgDteXz4AXM5sStnVxuk13KnW49oy2GhNxEGY0bNIvwAeBE5NTuNPX3YJa61Sy
         4MVaPG+dKJ69nLGHoNNd4sF4GhAVdK0TN4WQ8fVbKtmNKfDVHpbvntngsBnRZ45etDs1
         ixZCuRu0Afcrnix92S+YBxA0hMhX84nuztQ3SkoGy5ZoIwIEUIBcrKGxb0Blw2svjim8
         wwrw==
X-Gm-Message-State: AGRZ1gJyo/o+VCyPk8+sR8yWH6DEmJhaBt7nk8sZbpkv8bH+XeFJX854
        qhQVlAkouihpDp+Lbr2DwWPEnD0jb7wDuoA5qwQ7Ow==
X-Google-Smtp-Source: AJdET5f21DxDE1z7m/yTvLC+lDZqUKLxC6xF++/8MX86BgiEg0SnwtEqPpvM6+w/hGDoDRrg42GrkvywUawyV6CSMuY=
X-Received: by 2002:a63:a064:: with SMTP id u36mr4567630pgn.145.1540578723053;
 Fri, 26 Oct 2018 11:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <20181026180515.GA12129@flashbox>
In-Reply-To: <20181026180515.GA12129@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 11:31:51 -0700
Message-ID: <CAKwvOdnEHCmNjm-P068KQrbU0K+Dzyw_+_j7XLKJET0LWSz86A@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     bvanassche@acm.org, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:05 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Oct 26, 2018 at 11:01:48AM -0700, Bart Van Assche wrote:
> > On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
> > > If creating one instance of this variable is a functional change, I
> > > can't help but suspect the original code was wrong.  But maybe Bart,
> > > Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> > > like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> > > OSDv1 Headers").
> >
> > Hi Nick and Nathan,
> >
> > Had you noticed the following e-mail from early October:
> > https://marc.info/?l=linux-kernel&m=153849955503249?
> >
> > Thanks,
> >
> > Bart.
>
> Hi Bart,
>
> I had but there doesn't seem to be any reply to it so I wasn't sure if
> there was a final consensus on removing the driver. If that's the route
> that everyone wants to go, then I guess we don't need to continue to
> debate this patch.
>
> Thanks for the heads up,
> Nathan

I've staged a RFC patch here:
https://github.com/ClangBuiltLinux/linux/commit/03817d982606e2db143d23a8a55e97de6de6e0c2

+ Linus
I'm not about the process of removing code from the kernel.  Doesn't
that violate the "thou shalt not break userspace" rule?  But code does
get deleted from the kernel... ex:
http://lkml.iu.edu/hypermail/linux/kernel/1804.1/06654.html

-- 
Thanks,
~Nick Desaulniers
