Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD2FC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E512086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAbmvJ0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E512086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeJHEPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:15:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36000 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeJHEPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:15:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id f18-v6so6913318pgv.3;
        Sun, 07 Oct 2018 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/XtOx9ddrUlhCq64yA92kWH9QKRy9rHxPsL/tOf9j4=;
        b=QAbmvJ0enPN/xBmUdmekFqIclQNCjk6EjL2GA79L+ME3qWpaaMy8tB0rlrJpNsSqDN
         n7Qp6MhdHqYPpCb46GBkMB87rGD9RQe5BTO1MWKFRmM1NDOfWj33UvF51A2N0cCTTBRe
         usTtG3Nxqhxplf11sLHOfPTUJiarPhGDR2FsEEi8je40U4+X79S7WHw9VXjxTx6Kk+A5
         ifKjC6tNMCB3cR5fvap4UNgesaydryDllnlpqqmpdSO7dfpTueyJ8byUgCkVRLW7Lkh2
         W1KOHq6RPgqejBt4wTzA9Aa599OFWTvzaZaprly8m4X/cf50bI11uEbNAirN05UNIxKQ
         m3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/XtOx9ddrUlhCq64yA92kWH9QKRy9rHxPsL/tOf9j4=;
        b=BVAiCVCn5wTx1uu79C6zv7vAxn6OEJ+linuywrR4aAKOT5P5/o+2o9jzhPIYuqQOGa
         svK4pS8rnEcO9GGelvDUpdwuki13sFOwmmuWnWOan6MZwdM1LB1rJ7PNlHQPklS+pA7B
         5ZnHXwFewAn2SgP/WflXbTo5/5CB1WAx28O1gyU6TOejbeGbDOFXfAB6hRSnwMsfsbz8
         wLRzvQHqcD6CTASn2M2xAhA9uIFxh10JbT3gaj0stUY5+W9UfLPvDPk6QHUTLD6qxw1S
         6XN+DRxuxU1YDpUJ3T67FedR1TE4HCfD0KxIZWyD5YsYl5HbMdbijK5WZmSsl7DQEU+C
         rjsg==
X-Gm-Message-State: ABuFfojbXI0D6I/bN/9MDhSrTElCbly2fQoB5RVxfIiFEIw+wncSSsAP
        P4uGo559erTRV2v16DDbcn8sv6EMhw+Q+GMP5SU=
X-Google-Smtp-Source: ACcGV62XdMCWj7lo03POAbzbbTj0dNtm80n0m4yDa1TROcSYYdk+5BuEEYQSvyJRcfsn1jL/rj5LCTs5P5XvAZY8WJk=
X-Received: by 2002:a63:6b05:: with SMTP id g5-v6mr18803673pgc.344.1538946406932;
 Sun, 07 Oct 2018 14:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538873915.git.rfreire@redhat.com> <CAH2r5muEpTd4xG7oWV5BdA12AOogqscEnFdbUri9C=MFHrN_gQ@mail.gmail.com>
 <9006BE8A-38BB-4249-BEBA-C0DB34560885@redhat.com>
In-Reply-To: <9006BE8A-38BB-4249-BEBA-C0DB34560885@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 7 Oct 2018 16:06:35 -0500
Message-ID: <CAH2r5msPHc4qup7W=9Pt3PTATtEAN8QcgXQ8Y3r1mZdq1=T7xw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] CIFS: Info-level log support, print message when
 attempting mount.
To:     rfreire@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 7, 2018 at 3:27 PM Rodrigo Freire <rfreire@redhat.com> wrote:
>
> Thanks Steve! Sorry for overlooking it, whoops.
>
> One more question; what=E2=80=99s your/community opinion on rewriting the=
 existing pr_notice to the new cifs_info?
>
> I could happily retrofit it.

I don't have a strong opinion. The four callers could be changed, but
my gut reaction
is that it is a much higher priority to add useful dynamic tracepoints
(ftrace ie trace-cmd)
to cifs to make it easier to debug real customer problems that are
currently awkward to
debug.   By comparison, even ext4 has over 100 dynamic tracepoints, but lar=
ger
file systems like XFS has 500 (!), and nfs (including SunRPC) has about 100=
.

My guess is that going from our current 28 dynamic trace points (in
cifs.ko) to double
that (at least) will happen as developers add tracepoints to help them
debug real
problems (and of course it will help developers working on future problems =
even
more ...)


> > On 7 Oct 2018, at 15:59, Steve French <smfrench@gmail.com> wrote:
> >
> > Merged into cifs-2.6.git for-next
> >
> > Made a trivial tab/space correction in the patch (pointed out by
> > checkpatch) and then added a trivial followon patch to address a
> > comment/style (trivial)
> > issue pointed out by checkpatch and to add a little more detailed
> > comments about generally when to use each debug function.  If any
> > objections let me know.
> >
> >
> >> On Sun, Oct 7, 2018 at 10:21 AM Rodrigo Freire <rfreire@redhat.com> wr=
ote:
> >>
> >> Hi Steve,
> >> From our conversation over v2, I came out with this v3 patch, which I =
broke
> >> in two commits:
> >>
> >> * The first commit in cifs_debug.h, creating the cifs_info() function.
> >>  - The aim of this commit is to allow to the developer to be able to p=
rint
> >>    informational-level data without having to use pr_info, pr_notice e=
tc,
> >>    in line with other filesystems.
> >>    . One interesting and noteworthy feature of cifs_info() is that it =
is
> >>      transparent to the CIFS_DEBUG config state, either in "y" or "n".
<snip>


--=20
Thanks,

Steve
