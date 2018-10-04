Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEBDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1433D20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Lk1ekR8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1433D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJECp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:45:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJECp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:45:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so11193949wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQgTDB1tgmOGWrvma7TyYlQKrPoy77My+MQO+xJ1W4w=;
        b=Lk1ekR8E0VLkVy40NAgQMBd8DKR1XNIe5fuR1XTcaDmpEVwJD6jhNfOrgnDcZCibcR
         VaGzjVqV+Qk4NztTgaRErHqLeak6aiHjvEEH8GFOceC6deuz23gCc0rR5MgzOtNMJlSF
         kAwMVsa0dVKA0sJFrnqqH+HyXf6t7aIXXhGx+IZNaDf0xEuuzjEvHNMNk2kFZSCmEypp
         yMGRH4OeM09ujdPSH2m1G1wrXglCAyq5kEZxI5DnW3tkmSbzFqk4dvLL3SgDNaXPLeXM
         HRr/y+kmOOSLqllEfXsUSuD7mR6OivlN/BJ0zVZbh1fMjbBGQ5uiWa5/uTSFdyTC+G6G
         aBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQgTDB1tgmOGWrvma7TyYlQKrPoy77My+MQO+xJ1W4w=;
        b=nThwdLYwncN/K1wXmQKgETT8zxyZHvR9B2cf8n0MNluRxJPg9vcLS/zM5chCfVwzFY
         oDOrepU18xpaea0IJzB5NA+/WGmfV5OssT0iMa3yl/owI517I3rWSbkCAJnGYjIRty+p
         rRX+llU1cB/vxc8C2JllxVyyh7McmIvGbYHH1p3OtAkmFP9FcHedD1BHb0vu/RU6h7Kb
         sfbe+cTh9GiSVHAy8LuVDJ5PVoWm0s4uhB2KznRNu1UIH6Y1KQC4XWaHGhA1NchzEZJJ
         MVcSMXqcnncmGcoS4KUE0rmUHGclYxdlvjSAQwYLRTOXaWCHH7nXBuJo8TB8hvQniarx
         7A+g==
X-Gm-Message-State: ABuFfohlB5joOK8/VzFExmlznBNbFqaxkKPvKHd28CGmAq9aP7m8cE1d
        exRhC++qlVvS8jBK70nqmXbcm4Oia4ik43c5ZRlp4Q==
X-Google-Smtp-Source: ACcGV61hohp9XFWl7P+FIfO3TQ5DNH6fodAwbiD16RA3kSfQ19Vg5app3LyeqgTI9CAkpnnbIOJkzy5LlP4XaPqhmis=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr5931305wra.95.1538682672172;
 Thu, 04 Oct 2018 12:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181004025750.498303-1-ast@kernel.org> <20181004025750.498303-2-ast@kernel.org>
 <20181004194123.GA12697@castle.DHCP.thefacebook.com>
In-Reply-To: <20181004194123.GA12697@castle.DHCP.thefacebook.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 4 Oct 2018 12:51:00 -0700
Message-ID: <CALCETrUp69Y01v628KydCNxEqzGHSgs6dQQJxrzVAgs7DhPMxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
To:     Roman Gushchin <guro@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:41 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Oct 03, 2018 at 07:57:45PM -0700, Alexei Starovoitov wrote:
> > Similar to networking sandboxing programs and cgroup-v2 based hooks
> > (BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], etc)
> > introduce basic per-container sandboxing for file access via
> > new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
> > security_file_open() LSM hook and works as additional file_open filter.
> > The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.
> >
> > Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
> > is only available to root.
> >
> > This program type has access to single argument 'struct bpf_file_info'
> > that contains standard sys_stat fields:
> > struct bpf_file_info {
> >         __u64 inode;
> >         __u32 dev_major;
> >         __u32 dev_minor;
> >         __u32 fs_magic;
> >         __u32 mnt_id;
> >         __u32 nlink;
> >         __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
> >         __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
> > };
>
> It's probably nice to have file uid/gid as well.

And an indication of which mount namespace we're looking at.

--Andy
