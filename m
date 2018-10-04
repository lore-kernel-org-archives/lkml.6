Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2135AC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E4020854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 22:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8F3QjRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E4020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJEFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:18:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45636 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeJEFSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 01:18:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so931916pfn.12;
        Thu, 04 Oct 2018 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hU3wq9qp5hLGsZ3tPGqiD3vd3fWw/bX5kI+FtZ2HznQ=;
        b=q8F3QjRoxEB8n28jc8mnBX99cfN+S8X8NLciDBHLdQvomDdte+iiGFb2n5RGvdiaUn
         fuPfUb2Hhr43liy19ItcQTOtAIBZrsQEDwNjfw8YPQfVLlN66T0JPlLNaLS5UNlr9oKr
         x3j8p0WHnaDNwYcQnDMhlKWnEUAxSqFp3ZJCswJSfPuSLSPoqf+yGIk/1hdnD58vnLrW
         QBW1nkJpClUrKX0aQwcveTHeX9XdaNjSKbnGlCRKruOsuUfpFL+r5gx7IbpgnJApAMpl
         IX/CqpWrwHTUMZKIaaDw9tZNwkPeR1pFrgXdyBzNa96OB5P7L7Z/Z+TEEDC9Ksv2EAD7
         h6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hU3wq9qp5hLGsZ3tPGqiD3vd3fWw/bX5kI+FtZ2HznQ=;
        b=mMoAQrcE2AxgCEwWqpV1JR3NlYjhoRHOwBvEyZai+vqf8Ojq+eVmwALOFkeI3L8Y2+
         n+Unrp/a7ThGAGZZ0tBNcFyoxl6IhC7KdwJFCy06AtN3jb6wD1+bRkXMXx+G2jlcm8XO
         6ykBgg19c+uNIIMfV8GKSD+0rM6wibKUu+3wvWqqUrQbDLMnQCaA6B+js5wCXvL6Ec2E
         5EQfsw4Z5kYpeLaqYJ76fXN4+k7BcnAS1fVrT0K+w9JkUxMAAcdnPj6GKAUKZIdThPCs
         l+WPLbIGIX+dm2FFHhFKvuALwBNEBtXNFqPXlEZ4vCZSgQozGpr8v9Z7sdh4FzITBA+F
         7E6w==
X-Gm-Message-State: ABuFfojugI9EAWN/msslEq3WfYAmKehviLwzqDGMMoCmORdFB4PnWU7t
        NQ1Jt79EjuuTXlf+x5wq2k8=
X-Google-Smtp-Source: ACcGV60sZI4xSpgE8xZd/7uljw9kDNSGH5VUnS0Wfh7ZZwEtPrpqDdtU/odYwdIPDmYCJ2+9qA1tXA==
X-Received: by 2002:a63:d256:: with SMTP id t22-v6mr7429441pgi.335.1538691796518;
        Thu, 04 Oct 2018 15:23:16 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:2803])
        by smtp.gmail.com with ESMTPSA id j14-v6sm6120145pgh.52.2018.10.04.15.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 15:23:15 -0700 (PDT)
Date:   Thu, 4 Oct 2018 15:23:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Roman Gushchin <guro@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181004222312.3vvyvibx6dc4vqwt@ast-mbp.dhcp.thefacebook.com>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
 <20181004194123.GA12697@castle.DHCP.thefacebook.com>
 <CALCETrUp69Y01v628KydCNxEqzGHSgs6dQQJxrzVAgs7DhPMxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUp69Y01v628KydCNxEqzGHSgs6dQQJxrzVAgs7DhPMxA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 12:51:00PM -0700, Andy Lutomirski wrote:
> On Thu, Oct 4, 2018 at 12:41 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Wed, Oct 03, 2018 at 07:57:45PM -0700, Alexei Starovoitov wrote:
> > > Similar to networking sandboxing programs and cgroup-v2 based hooks
> > > (BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], etc)
> > > introduce basic per-container sandboxing for file access via
> > > new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
> > > security_file_open() LSM hook and works as additional file_open filter.
> > > The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.
> > >
> > > Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
> > > is only available to root.
> > >
> > > This program type has access to single argument 'struct bpf_file_info'
> > > that contains standard sys_stat fields:
> > > struct bpf_file_info {
> > >         __u64 inode;
> > >         __u32 dev_major;
> > >         __u32 dev_minor;
> > >         __u32 fs_magic;
> > >         __u32 mnt_id;
> > >         __u32 nlink;
> > >         __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
> > >         __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
> > > };
> >
> > It's probably nice to have file uid/gid as well.
> 
> And an indication of which mount namespace we're looking at.

Both certainly can be added in the future without breaking progs.
I didn't want to add too much all at once.
For file uid/gid I prototyped 
bpf_get_statx(struct bpf_file_info *file, int flags, int mask, struct statx *sx, int size);
helper that calls normal statx underneath.
But it's not fast, since sizeof(struct statx) == 256 and it has to be fully
inited by the helper or by the bpf prog (since bpf doesn't allow uninited memory anywhere).
Then I thought about going back to older sys_stat helper (without x), since structs
are smaller, but that didn't look as good either. So I've decied to table it for now
and get the basic support via 'struct bpf_file_info' first.
Then extend it later via new fields and new helpers.

