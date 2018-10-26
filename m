Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2351ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792B22086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJbNIeke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792B22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeJ0GPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:15:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41589 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbeJ0GPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:15:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so1065887plq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IekUgV9S+nZkNFpYEsmzri3PeQejCg+2NBW/Nn0Du6k=;
        b=wJbNIeke6zYlEqo/uSLGqHfvqetiiBlLi7/ej9dliSnFmKjOe6SL5tN8ks1O32VbGr
         Dg4yzw/kmRDSEmRT9LhHW/U6D5ULKDWDp0ud+gFnr9KxyPEbUHIDJBiED82LdZG6dWqz
         udlbsv/W2Z27Mx9X+/1puN1C78w7xgHXb6NoM5pPIymK2gR+1wZZE8rsqEu0lzGyh3iQ
         Oy6Me7bjWExgoe2wAKn1N49pad/at5tLDR59jzYW+TXOhYQUR+BX0n+vUlpjXNManWJI
         jH8zKEH+vlZIXipNKYFxdtl2nTcaMEe1FBP6+uLJAzWChQHpG01OBJFm3UpA49CFgQ58
         8b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IekUgV9S+nZkNFpYEsmzri3PeQejCg+2NBW/Nn0Du6k=;
        b=QhZh9ynhBfDoYk9nafBSUQGpSq8+pjyi0bL3ZbD9Sz9jBQnumUAxsMv9A/fiVyPkdQ
         KQZkU4jwI7EKCjijpAth6PPIvz24HXYv7GSBjI3FcKNkgV2nSsE7Rteb/zFPEvAeC3Co
         /UdN4NCjEnJLn+DNSMyHxJchBzGj3jYQhbyIy7+F4Q/2JCARqFrhcCwE4OWHQMOtT+VZ
         HVVDYsN4Ii8Er2FKhcAALPusqoLXaKIpE0tzu8shxayqrOsVUGb2bygbo8cR+TiIh7IN
         T52nkBF8/O7GTROk1d83F4pWbY2yGcgnv8y7zKcQ4/ywkzUk4/jCz+Jx4wg8/B/IcE5k
         dgHA==
X-Gm-Message-State: AGRZ1gKbiHPrWds1/MHSycmOZaeM2sxLs5lebHB7HrB5gIS1AGKFLIia
        VI2LrXmNQpD4+JAJjSeB/NvtDHuu9DosLtzRvz/IjA==
X-Google-Smtp-Source: AJdET5d1IoCazpvl1hHuY3OpXJWIs1dwap7pZyRxQ7UbeFpiUaT5fzwPW4eTGGWeH0g2VnpqAcS38N1+sPwoW3NAgLQ=
X-Received: by 2002:a17:902:b412:: with SMTP id x18-v6mr5147087plr.13.1540589799236;
 Fri, 26 Oct 2018 14:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org> <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
In-Reply-To: <1540589437.66186.124.camel@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 14:36:27 -0700
Message-ID: <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     bvanassche@acm.org
Cc:     ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 2:30 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2018-10-26 at 14:00 -0700, Nick Desaulniers wrote:
> > On Fri, Oct 26, 2018 at 11:01 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
> > > > If creating one instance of this variable is a functional change, I
> > > > can't help but suspect the original code was wrong.  But maybe Bart,
> > > > Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> > > > like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> > > > OSDv1 Headers").
> > >
> > > Hi Nick and Nathan,
> > >
> > > Had you noticed the following e-mail from early October:
> > > https://marc.info/?l=linux-kernel&m=153849955503249?
> >
> > From this subthread with Linus, removal of the exofs fs and scsi osd
> > code would be a user visible change and is not an option. See:
> > https://lkml.org/lkml/2018/10/27/3
> > https://lkml.org/lkml/2018/10/27/44
>
> Hi Nick,
>
> Linus wrote that removing a filesystem is considered a userspace breakage
> if a user notices. The key part is "if a user notices". Who are the exofs
> users?

See my thoughts on this in https://lkml.org/lkml/2018/10/27/27.
Particularly the part about the IMO catch 22.

Neither you nor I can claim "there are none."
-- 
Thanks,
~Nick Desaulniers
