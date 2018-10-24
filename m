Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C4C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D5E2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y2yOVTTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D5E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJXRij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:38:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:38:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O92wPf056985;
        Wed, 24 Oct 2018 09:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=UTL8pbl0a4qNrkiuusDn/mNd2iIiZNOtSBgCREAVXpU=;
 b=y2yOVTThnK1HPWERVWaMHk373a8xhtkuKCdPCzHlrCEdnj1aNSybxCMkULkTuvcR9PHw
 30NXrDmmFKMfEgKCFxy+5J/RUiAH4peiXI2LWj0KmiylAjERqvde94G0Vwclnl493NWD
 AQf5JLweix2MRFHR93CPSm2PvhO3ph1lZzolpIkLqUTfrsBAWGWV8fWINgTlaRNjypKY
 xC4lgKbfixGPl1T8KbSDesGjzX1tXz9o38FnB8SOkFkMFVQubKDW4iJsmiZ7pN4rtm74
 5qajjWiwNaIM/eHeptd/4pMtHaxBU8OHrTvKZeq4YMMIFBxqRieWPcb7FHbP8zEKGeKq 4w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq29wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 09:10:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9O9AIva018275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 09:10:19 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9O9AGm9014240;
        Wed, 24 Oct 2018 09:10:16 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 02:10:16 -0700
Date:   Wed, 24 Oct 2018 12:09:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     dvyukov@google.com,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, pmladek@suse.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        sergey.senozhatsky@gmail.com, syzkaller-bugs@googlegroups.com,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Jeff Layton <jlayton@kernel.org>, Mark Fasheh <mark@fasheh.com>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
Message-ID: <20181024090959.s5y3azpsmtswjyn5@mwanda>
References: <0000000000003852440576ef80b2@google.com>
 <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
 <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amir,

Thanks so much for this idea.

On Fri, Sep 28, 2018 at 08:39:15PM +0300, Amir Goldstein wrote:
> On Fri, Sep 28, 2018 at 5:55 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Sep 28, 2018 at 4:45 PM, syzbot
> > <syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com> wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    c127e59bee3e Merge tag 'for_v4.19-rc6' of git://git.kernel..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13b2f32a400000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=376cea2b0ef340db3dd4
> > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com
> >
> > I guess this is overlayfs rather than printk. +overlayfs maintainers
> > In future syzbot will avoid attributing crashes to printk, because I
> > think it's not the first time crashes are mis-attributed to printk:
> > https://github.com/google/syzkaller/commit/41e4b32952f4590341ae872db0abf819b4004713
> >
> >
> > > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000140
> > > RBP: 000000000072bf00 R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0e714a76d4
> > > R13: 00000000004c32cb R14: 00000000004d4ef0 R15: 0000000000000004
> > > ==================================================================
> > > BUG: KASAN: slab-out-of-bounds in string+0x298/0x2d0 lib/vsprintf.c:604
> > > Read of size 1 at addr ffff8801c36c66ba by task syz-executor2/27811
> > >
> > > CPU: 0 PID: 27811 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #36
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:77 [inline]
> > >  dump_stack+0x1c4/0x2b4 lib/dump_stack.c:113
> > >  print_address_description.cold.8+0x9/0x1ff mm/kasan/report.c:256
> > >  kasan_report_error mm/kasan/report.c:354 [inline]
> > >  kasan_report.cold.9+0x242/0x309 mm/kasan/report.c:412
> > >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/report.c:430
> > >  string+0x298/0x2d0 lib/vsprintf.c:604
> > >  vsnprintf+0x48e/0x1b60 lib/vsprintf.c:2293
> > >  vscnprintf+0x2d/0x80 lib/vsprintf.c:2396
> > >  vprintk_store+0x43/0x510 kernel/printk/printk.c:1847
> > >  vprintk_emit+0x1c1/0x930 kernel/printk/printk.c:1905
> > >  vprintk_default+0x28/0x30 kernel/printk/printk.c:1963
> > >  vprintk_func+0x7e/0x181 kernel/printk/printk_safe.c:398
> > >  printk+0xa7/0xcf kernel/printk/printk.c:1996
> > >  ovl_lookup_index.cold.15+0xe8/0x1f8 fs/overlayfs/namei.c:689
> 
> Doh!
> I used %*s instead of %.s
> Look how common this mistake is! and I only checked under fs/
> 
> [CC: Dan Carpenter and other fs maintainers]
> Idea for static code analyzers:
> A variable named *len* is probably not what someone wants to describe
> the width of %*s field and in most cases I found were %*s is used correctly
> the string value is a compiler constant (often "").
> 
> Thanks,
> Amir.
> 
> ---
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index 00876ddadb43..23ee5de8b4be 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -47,7 +47,7 @@ static struct dentry *coda_lookup(struct inode *dir,
> struct dentry *entry, unsig
>         int type = 0;
> 
>         if (length > CODA_MAXNAMLEN) {
> -               pr_err("name too long: lookup, %s (%*s)\n",
> +               pr_err("name too long: lookup, %s (%.*s)\n",

This isn't the right fix because "length" is invalid.

>                        coda_i2s(dir), (int)length, name);
>                 return ERR_PTR(-ENAMETOOLONG);
>         }
> diff --git a/fs/lockd/host.c b/fs/lockd/host.c
> index d35cd6be0675..93fb7cf0b92b 100644
> --- a/fs/lockd/host.c
> +++ b/fs/lockd/host.c
> @@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct
> svc_rqst *rqstp,
>         };
>         struct lockd_net *ln = net_generic(net, lockd_net_id);
> 
> -       dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
> +       dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
>                         (int)hostname_len, hostname, rqstp->rq_vers,
>                         (rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
> 

Why wasn't this one applied?  It looks correct to me.  The rest seem to
have been fixed already.

I did find one other bug in wireless and I CC'd you on that.  I'm going
to do a little bit more testing on the check and then push it soon.
Thanks again!

regards,
dan carpenter

