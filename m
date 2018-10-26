Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8716ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1592082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u09kRXC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1592082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJ0FjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:39:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41427 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeJ0FjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 01:39:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so1032031plq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7u2HAo1HRtih+Fv6xh3Ej44pPgjLWj2t7C3WpTaNzrA=;
        b=u09kRXC5XzYNdTBswM4tNHuQgVLx90Gis+dWQQmPZs2DOIASiVBxEg7URy1vqC3qNu
         XVnGwl7N3r/lqFn1T0PiaS9uKRFGcb8pKMzY1zH6GPHN807CYuhDdZsvonR/EkOuxin4
         EE/E8oOtyG6+5GvT+y1hzALh2PGTezUKbpijJRWzLsshrBrI/V6vjffOj/pqFqJoAcwo
         8oWmwPrnKHPuvkZLXY9kNAHIZPS4GWZOn8uO0x/X/Fbz55Cw0O6SSOMEPMCL1MCTAxFl
         l9IHOQQq4Dazvma272VpkcAvaua2o5VFUrRV+r+6uNunEKSinitdOebdv15wqfg4i82R
         ABKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7u2HAo1HRtih+Fv6xh3Ej44pPgjLWj2t7C3WpTaNzrA=;
        b=m9p7eI8fl+B+DiZmBNbZIyr8Z17HD3swrxPuoYv2euspeLrnbc+4d7T3gPOgRcWyf/
         EhyYlEroWmF10yuPPF2Qa1FdsjUq94JFGQwJ2/65mlLyaG60eyZwLRCvLlT1fIa70P8x
         KggMIAvpKZfDANpfvfQP0oiWpvmx7SMhKwf9Ve+dUmsEQ/PoweAhRxI5953p6r8rlHeZ
         l8uejvefxXRojogmvVTUzQE5sCWk/JcUKycTLgc2wYGFKkc7POGOMjEu8IA37ZL7RNY0
         XAyK5bv2znl166CgKt2R8pg7sT5OVGNwMgZzMyCv7QqqdtgQ/0VX0jvVbhrVNYmBMuLv
         pqyQ==
X-Gm-Message-State: AGRZ1gI3/T2FjKpss0JUYYVBUX8vJrDCv6Z9S3lw2fwkVbx0HqWAEkg3
        UkFly479VAqvZfZ+RdXT669vrCf7MdpOEheNuWQGVw==
X-Google-Smtp-Source: AJdET5cNRF6OJvvFXFtunbPONMIVfdyTkuTreeuHNej5bNT6ffvSQwdv5bHrFy2K3YSAfKSONElsVQmDoyxORSX2AXw=
X-Received: by 2002:a17:902:5a2:: with SMTP id f31-v6mr4937346plf.320.1540587631612;
 Fri, 26 Oct 2018 14:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org> <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox> <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
In-Reply-To: <1540576908.66186.103.camel@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 26 Oct 2018 14:00:20 -0700
Message-ID: <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     bvanassche@acm.org, ooo@electrozaur.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:01 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
> > If creating one instance of this variable is a functional change, I
> > can't help but suspect the original code was wrong.  But maybe Bart,
> > Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> > like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> > OSDv1 Headers").
>
> Hi Nick and Nathan,
>
> Had you noticed the following e-mail from early October:
> https://marc.info/?l=linux-kernel&m=153849955503249?

From this subthread with Linus, removal of the exofs fs and scsi osd
code would be a user visible change and is not an option. See:
https://lkml.org/lkml/2018/10/27/3
https://lkml.org/lkml/2018/10/27/44

So we should pursue this much smaller fixup.  Boaz, can you clarify
https://lkml.org/lkml/2018/10/26/682
specifically:

> If creating one instance of this variable is a functional change, I
> can't help but suspect the original code was wrong.  But maybe Bart,
> Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> OSDv1 Headers").

-- 
Thanks,
~Nick Desaulniers
