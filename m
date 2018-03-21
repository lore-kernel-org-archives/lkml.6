Return-Path: <dvyukov@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521648702; cv=none;
        d=google.com; s=arc-20160816;
        b=A1LlvzrawlMJou6WmMJsvl/L5UYAmd33xJSF4NG08KBIUWlU51dc+0ZgHBmr9or1Mx
         wN4RSECt7TUAOE8yaVCeWyN8Ui5nNQkasnfZcLwT5mlzJTStBRR0/CWBz6V6IdVQOlYb
         sMucQrRLko/+sZWOjyfIu/oMh3t/4gMVO6gfUjvQrEZQMbyaIcS885jo/yCfCzneMFPT
         Pkho6xtU6EuzmCapnfira1zIEwbDqnwwyvcEv8fClWOmN/T3ZnzeyS1JxI/RDwVnleUs
         KAGopJWAdEK+Vo4hvMVwqcCk2zSQMJaLqA0+d7fMjvHOkDNGE8BUxd1r2UhJGa3+T3PE
         hD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=ulgSdR2tMUTOmFWhSLAuvRRAYFeU5RJiGVv1/3Fdye8=;
        b=hDtlo+GrH3/WGNbxTcmrH86/LDSDJIgEq162Amuq+xbWsTtxN39eehZI+th8aNYffs
         gdBnsVtKAv/OV16lW6waEKL7nHoKO0RE47VYbEwg+ArQmoO996N34eDkZAOLq3QzNiIP
         Xy/79l6rgGLgvUtcc75f1ZiMcQsoVDrDcqc+ij+UJS/qpFzgJ2BIw5NOUPVmg0xZU3Ti
         T8F7xXjmzEC9WFf+bYc6AXNmR+JUw91LOo+HEEuMA0v5eZsXxuf3+ZL1Xx8eKPUzu8Xy
         fqTenCq9L6k4qga3ZpQKY3JxQNa1zmo14A/hiH7qCpNV3lXQaRwcoLgt2d4FS/EDPhIf
         4zeg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WJq3GRTy;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=WJq3GRTy;
       spf=pass (google.com: domain of dvyukov@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dvyukov@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtJhEyqGUKYE7PXddg50m5RyRLpCHAwUOzYqhNCuJCpnE0kW0l7axmDTGKT5BbtR9i8pfXBKp4m0iNNGK8ylDw=
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 21 Mar 2018 17:11:21 +0100
Message-ID: <CACT4Y+babw_2NJa+oym2VN7-Z4Bt_rZx2sMi68AD+1KzNpr=KQ@mail.gmail.com>
Subject: syzbot dashboard
To: LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Bcc: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595564310340162246?=
X-GMAIL-MSGID: =?utf-8?q?1595564310340162246?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

syzkaller/syzbot dashboard is now live at:
https://syzkaller.appspot.com

syzbot is continuous fuzzing/reporting system based on syzkaller
fuzzer, currently it tests mainline tree and well as net-next and
bpf-next trees.

The dashboard shows info about active bugs reported by syzbot. There
are ~130 active bugs and I think ~2/3 of them are actionable (still
happen and have a reproducer or are simple enough to debug). For
active bugs you can see a bunch of additional info (when it started
happening, when it last happened, how frequently, on what
branches/commits and more crash reports, reproducers and duplicates).
For example:
https://syzkaller.appspot.com/bug?id=26cb120b31cd24d984fc16da67f50fb375c432a7
The report is now probably lost on LKML, but the crash still happens
and have a reproducer.

There are bugs in various pars of net subsystem, some in KVM, crypto,
keys, perf, tty, block, android drivers, loop device and a long tail
in other subsystems. If you are interested in health of a particular
subsystem, take a look for relevant bugs.

Some of the active bugs can be in fact already fixed. If so it makes
sense to tell syzbot about fixes to keep dashboard clean and enable
discovery of new similar bugs. syzbot uses Reported-by tags in commits
and #syz directives in emails to track these statuses. More details
are available at
https://github.com/google/syzkaller/blob/master/docs/syzbot.md

If syzkaller is not finding bugs in your subsystem, that's most likely
because it's not testing it. To test a particular subsystem syzkaller
needs some help in the form of interface descriptions (which are not
too hard to write, e.g.
https://github.com/google/syzkaller/blob/master/sys/linux/ipc.txt).
There is also source coverage report available at
https://storage.googleapis.com/syzkaller/cover/upstream.html (50MB),
so you can check if syzkaller currently covers your code or not and
how well.

And there is also a list of all fixed bugs so far:
https://syzkaller.appspot.com/?fixed=upstream

Thanks
