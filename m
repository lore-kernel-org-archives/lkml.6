Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAFBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F8020657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8O1/dAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F8020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeI2AER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:04:17 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42967 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI2AER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:04:17 -0400
Received: by mail-yw1-f66.google.com with SMTP id h134-v6so2950517ywc.9;
        Fri, 28 Sep 2018 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBkQjBuzFw0gUnm3c9RQkCRmNuLPy/3DcN/5WF0zMd4=;
        b=T8O1/dANYjOF0mzrlD2wuv8DtlsD1o1sUW7ikvBapac9lNMV2x/F/GjfSU0pZf/4OP
         YzP4Y7Tbf1jyoSHslDFRk4LbBQdl5ZuWG+Yx+lUoAR4xRE2VIvmP1ryOuxISVKNuqh+M
         aDMnOY2ixKc6GvW4GnkGUZsvCcXvZ0GpUMf5aBcH+gh6mcKzeqK42ahh5r5CgA9opQkG
         Gzt/WL8Z9ZDyPYZikVZDo02RH4kA3D/K4iF4UiYsYsnUOTeHDw5JiXA4hqLzqnzgywAW
         V0Evh3UMkBk8vX/Y3CxgqxBmcPNfUJ1BfFnRhmo7V/8j+rAdiIoW5k4AAQCvJlf+kKVt
         0J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBkQjBuzFw0gUnm3c9RQkCRmNuLPy/3DcN/5WF0zMd4=;
        b=H+y1Gb9JT2bnD/jA2NP823MzwYHwKZf6stk8S/rg892GWQ39ap/ZoxICwPRDC/ywi5
         1fPTFpSx2agMgwre8DYSpGJle5hYYHGEr0eRCsHjnarx8sNivPyluIEz9SnxamVynbTD
         1c0jSbFVIR+OmQVsp+7Wg8o67l9zP/kIVXP80qI88uTe1PGB0VyR6vFJuVOtltxocHMC
         WB51PZvh+MuxDmL9Si1sPSPPBk9HHRzFajbQwkgAey0Ma8zzSNPbA4WiY5cSLms7tI0C
         B+cj2dJf1zTVx5be4KnW4APm1kNheuTO9B+3j4BFv2dSIgdB3cnxERkGyNlhue+RlaQo
         BojA==
X-Gm-Message-State: ABuFfohiYRVGUcHvuxYlK3Rm/42cPj8BRVTBHEJxJ+AqgtAgRzV/BvYT
        KeFyP/4BMIr/+AYzJkBQy4CgF0Tr3cvK6sEN7W4=
X-Google-Smtp-Source: ACcGV62cAg6tSvDsmstuFn6yTmDNrrD4D63nc09s1yfZ2tm/HDN+LxYRYhORTkup4UVCScLfrzPinypIC7JD8TCyaMg=
X-Received: by 2002:a0d:d181:: with SMTP id t123-v6mr8773321ywd.241.1538156366446;
 Fri, 28 Sep 2018 10:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003852440576ef80b2@google.com> <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
In-Reply-To: <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Sep 2018 20:39:15 +0300
Message-ID: <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
To:     dvyukov@google.com
Cc:     syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, pmladek@suse.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 5:55 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 28, 2018 at 4:45 PM, syzbot
> <syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com> wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c127e59bee3e Merge tag 'for_v4.19-rc6' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13b2f32a400000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=376cea2b0ef340db3dd4
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com
>
> I guess this is overlayfs rather than printk. +overlayfs maintainers
> In future syzbot will avoid attributing crashes to printk, because I
> think it's not the first time crashes are mis-attributed to printk:
> https://github.com/google/syzkaller/commit/41e4b32952f4590341ae872db0abf819b4004713
>
>
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
> > RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0e714a76d4
> > R13: 00000000004c32cb R14: 00000000004d4ef0 R15: 0000000000000004
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in string+0x298/0x2d0 lib/vsprintf.c:604
> > Read of size 1 at addr ffff8801c36c66ba by task syz-executor2/27811
> >
> > CPU: 0 PID: 27811 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #36
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> >  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> >  kasan_report_error mm/kasan/report.c:354 [inline]
> >  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
> >  string+0x298/0x2d0 lib/vsprintf.c:604
> >  vsnprintf+0x48e/0x1b60 lib/vsprintf.c:2293
> >  vscnprintf+0x2d/0x80 lib/vsprintf.c:2396
> >  vprintk_store+0x43/0x510 kernel/printk/printk.c:1847
> >  vprintk_emit+0x1c1/0x930 kernel/printk/printk.c:1905
> >  vprintk_default+0x28/0x30 kernel/printk/printk.c:1963
> >  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
> >  printk+0xa7/0xcf kernel/printk/printk.c:1996
> >  ovl_lookup_index.cold.15+0xe8/0x1f8 fs/overlayfs/namei.c:689

Doh!
I used %*s instead of %.s
Look how common this mistake is! and I only checked under fs/

[CC: Dan Carpenter and other fs maintainers]
Idea for static code analyzers:
A variable named *len* is probably not what someone wants to describe
the width of %*s field and in most cases I found were %*s is used correctly
the string value is a compiler constant (often "").

Thanks,
Amir.

---
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876ddadb43..23ee5de8b4be 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -47,7 +47,7 @@ static struct dentry *coda_lookup(struct inode *dir,
struct dentry *entry, unsig
        int type = 0;

        if (length > CODA_MAXNAMLEN) {
-               pr_err("name too long: lookup, %s (%*s)\n",
+               pr_err("name too long: lookup, %s (%.*s)\n",
                       coda_i2s(dir), (int)length, name);
                return ERR_PTR(-ENAMETOOLONG);
        }
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index d35cd6be0675..93fb7cf0b92b 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct
svc_rqst *rqstp,
        };
        struct lockd_net *ln = net_generic(net, lockd_net_id);

-       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
+       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
                        (int)hostname_len, hostname, rqstp->rq_vers,
                        (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3415e0b09398..b74435dc85fd 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -259,7 +259,7 @@ static int ocfs2_osb_dump(struct ocfs2_super *osb,
char *buf, int len)

        if (cconn) {
                out += snprintf(buf + out, len - out,
-                               "%10s => Stack: %s  Name: %*s  "
+                               "%10s => Stack: %s  Name: %.*s  "
                                "Version: %d.%d\n", "Cluster",
                                (*osb->osb_cluster_stack == '\0' ?
                                 "o2cb" : osb->osb_cluster_stack),
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index f28711846dd6..9c0ca6a7becf 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -686,7 +686,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs
*ofs, struct dentry *upper,
                        index = NULL;
                        goto out;
                }
-               pr_warn_ratelimited("overlayfs: failed inode index
lookup (ino=%lu, key=%*s, err=%i);\n"
+               pr_warn_ratelimited("overlayfs: failed inode index
lookup (ino=%lu, key=%.*s, err=%i);\n"
                                    "overlayfs: mount with '-o
index=off' to disable inodes index.\n",
                                    d_inode(origin)->i_ino, name.len, name.name,
                                    err);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f61839e1054c..c096f12657cd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -152,7 +152,7 @@ static inline int ovl_do_setxattr(struct dentry
*dentry, const char *name,
                                  const void *value, size_t size, int flags)
 {
        int err = vfs_setxattr(dentry, name, value, size, flags);
-       pr_debug("setxattr(%pd2, \"%s\", \"%*s\", 0x%x) = %i\n",
+       pr_debug("setxattr(%pd2, \"%s\", \"%.*s\", 0x%x) = %i\n",
                 dentry, name, (int) size, (char *) value, flags, err);
        return err;
 }
