Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E580BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8858A208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psnzJ+k1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8858A208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756282AbeFORC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:02:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44373 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbeFORC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:02:56 -0400
Received: by mail-oi0-f65.google.com with SMTP id c128-v6so9386389oig.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRl2Fgx/Y865bWO6X/pDMIZgVKps8TK7GnU+XZooaHs=;
        b=psnzJ+k1ktGfoIh7S9p5VdQY+IVfMmpd5mGh9o6+6oP75sDYnwQBZf138AqSI0vlTD
         Sv2na0qusiCufw9aoWWK1E4HwAOOAqNd2CM8JWHRzHFw76tTzonvrTjuCY86Ox59xpRN
         bHhbKbZfNHZvzflkK8o9qsc77qa60t9gbgTH3cwcldb9H5xU1fcEDUGZYcQJbIa2pvl4
         kS5ri99G0/s7ZCojBGaiviQnl6IpU39uZgT/XMxKdKAdR3Lkt4/yziJmsQd+bH1EFYIF
         lbu3DhyXxOvO73TdmGQAI1tp4KH5KlipI+HOzyz/48LkgbXClNDyat5RAJPzIUxi608q
         u6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRl2Fgx/Y865bWO6X/pDMIZgVKps8TK7GnU+XZooaHs=;
        b=rj74lwaXlCvkYejq1OtnJZ6x4X+RB+nkM5rh4yNhj4j6ia5tb4P8hMte7D7fg3NkoL
         Y+IP5sIv7nTlYdUDV7lDPBQQ3okX83cEXagbhUsnQ7g5dE4leeqBBov6T9I9YtW5GTC8
         5ACthH1jTdKpnou2gwaqUn+xVcT4L8ty0l/xN0RfjcB3/S05cy/ioaj3zSk8Y8gbOzs3
         We8VAQKJmUKKETnjfn86fbYvRPXcD+N2O8lJQ1y/5w3nFWXKYSwmIO7kRHIw9/qGCAWB
         Rujc+Am17+RF0k8e46RUixmBqdGmj0x9ANx0JosjRLAJnzpMYHsRe7SJWUh4EuMq+q7w
         SULg==
X-Gm-Message-State: APt69E1pafWFRSKWyaIX01/VudhuQNGBDPR3o5S9p3i4yTks/liVs6LR
        WhZ9DfPPM4qzF2av+cdRPDeCeBnhsOQH4dlBQdlV1w==
X-Google-Smtp-Source: ADUXVKJI6oWxExf7fWoYO1HXj1nC72XsCBWClNnb8CnqfdHRHV7V/ys1UZDlHNAzGozs9cEBSbVzGjJtzfFS5aH43uc=
X-Received: by 2002:aca:6b03:: with SMTP id g3-v6mr1246948oic.219.1529082175956;
 Fri, 15 Jun 2018 10:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180615152335.208202-1-jannh@google.com> <20180615164930.GE30522@ZenIV.linux.org.uk>
 <CAG48ez0x+d78yUc3FxHcQOtJRCF1j3Af+iR=UojnDrqqYzzTcg@mail.gmail.com>
In-Reply-To: <CAG48ez0x+d78yUc3FxHcQOtJRCF1j3Af+iR=UojnDrqqYzzTcg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 15 Jun 2018 19:02:44 +0200
Message-ID: <CAG48ez1G84FsGOSp_R89Fn8W1q4fNj1REiEVvfiQZO-cE18Z9Q@mail.gmail.com>
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        dgilbert@interlog.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 6:58 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jun 15, 2018 at 6:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> > > As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
> > > to be called under KERNEL_DS"), sg and bsg improperly access userspace
> > > memory outside the provided buffer, permitting kernel memory corruption via
> > > splice().
> > > But they don't just do it on ->write(), also on ->read() and (in the case
> > > of bsg) even on ->release().
> > >
> > > As a band-aid, make sure that the ->read() and ->write() handlers can not
> > > be called in weird contexts (kernel context or credentials different from
> > > file opener), like for ib_safe_file_access().
> > > Also, completely prevent user memory accesses from ->release().
> >
> > Band-aid it is, and a bloody awful one, at that.  What the hell is going on
> > in bsg_put_device() and can it _ever_ hit that call chain?  I.e.
> >         bsg_release()
> >                 bsg_put_device()
> >                         blk_complete_sgv4_hdr_rq()
> >                                 ->complete_rq()
> >                                         copy_to_user()
> > If it can, the whole thing is FUBAR by design - ->release() may bloody well
> > be called in a context that has no userspace at all.
> >
> > This is completely insane; what's going on there?
>
> Perhaps I should have split my patch into two parts; it consists of
> two somewhat related changes.
>
> The first change is that ->read() and ->write() violate the normal
> contract and, as a band-aid, should not be called in uaccess_kernel()
> context or with changed creds.
>
> The second change is an actual fix: AFAICS ->release() accidentally
> accessed userspace, which I've fixed using the added "cleaning_up"
> parameter.

FWIW, the demo code I'm using to test this in a QEMU VM:

$ cat test.c
#define _GNU_SOURCE
#include <fcntl.h>
#include <unistd.h>
#include <linux/bsg.h>
#include <string.h>
#include <err.h>
#include <stdio.h>

int main(void) {
  int fd = open("/dev/bsg/0:0:0:0", O_RDWR);
  if (fd == -1)
    err(1, "foo");
  __u8 buf1[255];
  __u8 request[10] = {
    [0] = 0x5a, // MODE_SENSE_10
    [2] = 0x41,
    [8] = 0x10
  };
  __u8 sense[32];
  memset(sense, 'A', sizeof(sense));
  memset(buf1, 'A', sizeof(buf1));
  struct sg_io_v4 req = {
    .guard = 'Q',
    .protocol = BSG_PROTOCOL_SCSI,
    .subprotocol = BSG_SUB_PROTOCOL_SCSI_CMD,
    .request_len = sizeof(request),
    .request = (__u64)request,
    .max_response_len = sizeof(sense),
    .response = (__u64)sense,
    .din_xfer_len = sizeof(buf1),
    .din_xferp = (__u64)buf1,
    .timeout = 1000
  };
  if (write(fd, &req, sizeof(req)) != sizeof(req))
    err(1, "write");
  printf("sense[0] after write: 0x%02hhx\n", sense[0]);

  /*
  struct sg_io_v4 resp;
  if (splice(fd, NULL, pipe_fds[1], NULL, sizeof(struct sg_io_v4), 0)
!= sizeof(struct sg_io_v4))
    err(1, "splice");
    */

  sleep(1);
  printf("sense[0] after sleep: 0x%02hhx\n", sense[0]);
  close(fd);
  printf("sense[0] after close: 0x%02hhx\n", sense[0]);
}
$ gcc -o test test.c -Wall && sudo ./test
sense[0] after write: 0x41
sense[0] after sleep: 0x41
sense[0] after close: 0xf0
$ uname -a
Linux debian 4.17.0+ #10 SMP Fri Jun 15 14:48:42 CEST 2018 x86_64 GNU/Linux
