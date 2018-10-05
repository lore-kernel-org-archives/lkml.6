Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DBF21473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7nvxWu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DBF21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeJFFGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:06:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35049 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJFFGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:06:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id f8-v6so7420193plb.2;
        Fri, 05 Oct 2018 15:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PVEJtjXI2NaRGaZjIWcz0ezrWOGuYSY5NnsmnlZ+Xaw=;
        b=Y7nvxWu2Vjr5QG6zovxKZITKV397w2F+DEHzf6WQ4cMrD6K0JO8LIDjwtI5KuzGz00
         p+glJfGMcTnN4MSHxh44OnFnYvrCVB+hF3xI10RGmMQegn8a9XAv6dVANIyVel9zleqh
         CSTGH4oTQAt1EGU4K7QA2CdYftReAD6/xFUJyWV3Mi6X9A8S7+ywtWQYbPjT2ZosDEUh
         Pe60yWT3PNyBFyv/ofipAboNYUA1mKr7xWf/mMj6UKXwMG6GWXpfd7sTem3PyYJA/8Kc
         3nykfD+lb9yvAc6RXIvFhDwzx6acwv5LsYvp13JLUpFpEOGyncwEkArCEvp9oK1DknEU
         1O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PVEJtjXI2NaRGaZjIWcz0ezrWOGuYSY5NnsmnlZ+Xaw=;
        b=Y3/v+v4U0eNtJEW2l0Bn2egmgAUa5fDxUqmn2PzduGRMO2qdO5NJRDj4bzwIa5buMx
         84vcPIQC+qEyCcoIlRTmcLvXwbA8yXL+t+k37TzzKykYy8MlES8lnz6U3cJLf11HxrQZ
         ErdI9+CWbwfH3p8s9ddEGq87ZFMOVw4sLE7cCgwUkZWzf63F4H0Bzt/LTXUUPaSp3rRJ
         RpkH36TRfPt+9fcVSjmD8RUj4W0qRaEmZbdn027Fh3S4oyg55YPEf6jn+CO06Km1HPfA
         YHAQAvmJlenG3pubzffhCmXYd1TTPtotLnkYkDMW60Lm9IgjGfD6cZI7/7sa4+TJ1urZ
         algA==
X-Gm-Message-State: ABuFfoh2scFWrJ1AHJNG69ZIJ3nIC2f//FmR6d6Ut65ja3oPyvgE4Yhc
        yq1k+sc3XlkFwSHlsOT5GgQ=
X-Google-Smtp-Source: ACcGV60b4PH2MfGcr9848s5Yz2uEMhmZTfUrK0Fr5TJwbcxAAvDzSUw2fNuxjehyvTW79iyCi12P7w==
X-Received: by 2002:a17:902:4583:: with SMTP id n3-v6mr13610062pld.255.1538777122621;
        Fri, 05 Oct 2018 15:05:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:fc91])
        by smtp.gmail.com with ESMTPSA id z70-v6sm11622239pgd.64.2018.10.05.15.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 15:05:21 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:05:20 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, daniel@iogearbox.net,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
 <20181005044659.GU32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005044659.GU32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 05:46:59AM +0100, Al Viro wrote:
> On Wed, Oct 03, 2018 at 07:57:45PM -0700, Alexei Starovoitov wrote:
>  
> > @@ -15,6 +15,7 @@
> >  #include <linux/bpf.h>
> >  #include <linux/bpf-cgroup.h>
> >  #include <net/sock.h>
> > +#include <../fs/mount.h>
> 
> No.

I've considered splitting cgroup_file_filter_ctx_access() into
separate .c inside fs/ directory, but it felt odd to move just that
function whereas the rest of the bpf bits are in kernel/bpf/
only to avoid doing this "../fs/" hack.
How about calling this new file fs/bpf_file_filter.c ?

> > +	struct file *file = NULL;
> > +	struct inode *inode;
> > +	struct super_block *sb;
> > +	struct mount *mnt;
> 
> Fuck, no.
> 
> > +	case offsetof(struct bpf_file_info, mnt_id):
> > +		/* dst = real_mount(file->f_path.mnt)->mnt_id */
> > +		mnt = real_mount(LD_1(file->f_path.mnt));
> > +		LD_n(mnt->mnt_id);
> 
> NAK.  Anything in struct mount is private to just a couple of
> files in fs/*.c.  Don't do that.  And keep in mind that internal
> details can and will be changed at zero notice, so be careful
> with adding such stuff.

yes. The internal details of file and inode structs can and will change.
Just like all the sk_buff internals that are exposed to bpf
via the same context rewriting mechanism.
See commit 9bac3d6d548e ("bpf: allow extended BPF programs access skb fields")
that exposed first 4 fields out of sk_buff to bpf progs via
'struct __sk_buff'.
Other fields were exposed later. Some of them are not even from sk_buff.
For networking programs 'struct __sk_buff' is the context.
For this new file_filter programs 'struct bpf_file_info' is the context.
That's the only thing bpf side can see.

> Another problem is your direct poking in ->i_ino.  It's not
> something directly exposed to userland at the moment and it should
> not become such.

The patch is not making i_ino directly exposed.
Only 'struct bpf_file_info' is exposed to user space / bpf programs.

In 'struct bpf_file_info' the field is called '__u64 inode'.
That is the abi.
The kernel side stays with 'unsigned long i_ino;' field.
Its size is different on 32/64 architectures, but to bpf progs
it's always seen as '__u64 inode'.
If in the future the kernel decides to change 'i_ino' to be u64,
nothing will change on bpf side.

> Filesystem has every right to have ->getattr()
> set ->ino (== ->st_ino value) in whichever way it likes; 

Essentially what cgroup_file_filter_ctx_access() is doing
is the same as generic_fillattr() + cp_statx() work, but via
on the fly rewriting of bpf instructions during
loading of bpf program.

See my other reply to Andy where I argued that certain
fields like uid/gid probably don't make sense to expose
to bpf via ctx rewriter mechanism and instead they can be
done via new bpf_get_file_statx() helper.
That's future work.

> the same
> goes for ->dev.

Notice how single kernel field file->f_inode->i_sb->s_dev
is exposed to bpf via two fields dev_major and dev_minor
inside 'struct bpf_file_info'.
For dev_minor the ctx rewriting is done as:
+       case offsetof(struct bpf_file_info, dev_minor):
+               /* dst = file->f_inode->i_sb->s_dev */
+               inode = LD_1(file->f_inode);
+               sb = LD_n(inode->i_sb);
+               LD_n(sb->s_dev);
+               *insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, MINORMASK);
+               break;

If the last AND instruction was not there, the whole 's_dev' field
would have been exposed to bpf side and that would be questionable
design choice, since s_dev has kernel internal encoding of major/minor.
Instead the AND instruction is masking minor bits.
So above ctx rewriting for 'dev_minor' field is equivalent
to line
  stat->dev = inode->i_sb->s_dev;
from generic_fillattr()
plus another line
  tmp.stx_dev_minor = MINOR(stat->dev);
from cp_statx()

This way the kernel internal field 's_dev' is split into
two dev_major/dev_minor bpf visible fields.

The end result is that no new kernel information is exposed.
The same information is seen via statx.

