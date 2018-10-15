Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F86C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D22086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJWW8B2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeJOJ4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 05:56:52 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39564 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 05:56:52 -0400
Received: by mail-ot1-f42.google.com with SMTP id l58so17440346otd.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xVB/ia5jGEYYZ4VTMB0l2eSHh3OODBcnPMpiXTE8fpo=;
        b=pJWW8B2QrAhlH3zOpYOt9nUtRIYtxmyCLCY4Cch3/0IMdW2XQLt/ei+GTiWYT0DdBC
         zktBWyaAd0HlzUDgofymia0rPe7yLkROuCI6xmDFj/gLZa+EwCTfho3K+jg+NIQ4Mz/e
         fVPrBzTUK+/XKxFtpzFnlRJTLM/Qkft/OIYJkCGhYLU5SUkBldlRitdHJqJYJNx0prBV
         59O6MZqMou5lUkLRiHZHi8UK067XEfrjKHRJ8KK09S/vO2m3Tap2eQerRSfIoLbH6sWL
         4priiBApUfRqwWFsG6YFukl/Wph9RQfcCO12Io8veCG8UaSb886wL7ZSRMQ7reUJc4+7
         59SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xVB/ia5jGEYYZ4VTMB0l2eSHh3OODBcnPMpiXTE8fpo=;
        b=MqwzQKVD75De2v9vnSOgj+5KvERjaP/80kY/O1Vq5uhr8bLXnSpr4V8dylEfdKtc/j
         4VxT0lT1EsfvKOs2PcWeFFecwjyUKs/nNKnpSq5TPG32jX23WTGxD2RtGr1DvryNwsbp
         4qBTB9ePlsWsuMfRhwNSam6Ea9AB5dfQQuu8gM94GbE1BsoEfkgn+AcqxCmFO1J5lKlt
         +GlrIIyulwqYgzXFUGNo9dAowG29PZbniYiGCAJDDAZZQxSIouZDHoJHlwy2UFZuVXDI
         FxUuVYXwCYum4EVr6+a7InTEjiTnOvitQe6llwLEe7adwpdCjD+3Gk0OM55SjOxqg7/T
         bKsA==
X-Gm-Message-State: ABuFfoguzcdyNfKIKDh+lwhFym8ExspcLruCWkW2PXb1GVaefKTmgBQA
        kbQ3somG2Mm4kYmf1AgZRIT1TaHE20aLoo6UvxKa8uV26Lcn0w==
X-Google-Smtp-Source: ACcGV60LW27LuyUdhrhaiXZWoFXfokvdIioU9A16tNKPsPVmNgIyILjIHnUFgbbkp5PzuQkrMBQTpgGjGDm2XpIOA/M=
X-Received: by 2002:a9d:4917:: with SMTP id e23mr10560872otf.73.1539569625426;
 Sun, 14 Oct 2018 19:13:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Oct 2018 04:13:19 +0200
Message-ID: <CAG48ez1wN=oC_uWkHHhboDvfVt8p9O98ZMFZyh=AK6D=eHU7MA@mail.gmail.com>
Subject: sys_tee() bug: after tee() of partial page, both pipes can merge,
 clobbering each other's data
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed the following behavior; basically, after copying part of a
normal pipe buffer (anon_pipe_buf_ops) from pipe A to pipe B, both
pipe A and pipe B can merge new writes into the existing page,
clobbering each other's data:

============
$ cat tee_test.c
#define _GNU_SOURCE
#include <fcntl.h>
#include <unistd.h>
#include <err.h>
#include <stdio.h>

int main(void) {
  int pipe_a[2];
  if (pipe(pipe_a)) err(1, "pipe");
  int pipe_b[2];
  if (pipe(pipe_b)) err(1, "pipe");
  if (write(pipe_a[1], "abcd", 4) != 4) err(1, "write");
  if (tee(pipe_a[0], pipe_b[1], 2, 0) != 2) err(1, "tee");
  if (write(pipe_b[1], "xx", 2) != 2) err(1, "write");

  char buf[5];
  if (read(pipe_a[0], buf, 4) != 4) err(1, "read");
  buf[4] = 0;
  printf("got back: '%s'\n", buf);
}
$ gcc -o tee_test tee_test.c
$ ./tee_test
got back: 'abxx'
$
============

splice_pipe_to_pipe() probably has the same problem?

I'm not sure what the cleanest way to fix this would be. Replace
anon_pipe_buf_ops with packet_pipe_buf_ops when copying a buffer? Or
add a new buffer flag for marking a buffer as mergeable, and get rid
of buf->ops->can_merge?
