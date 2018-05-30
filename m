Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4130476-1527697701-2-9736548339231531469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527697700; b=BICOGn3lHP4yWBN2R6qIlKuXjMV044qwAtgazspgJqYlD4mGb7
    1HAL+pzUuwtXLFxGlsSei6VJLIIXknRMKm0vFlBpuzONJVA53nSafSsDpAKOyNqc
    Cmk/KMHorw7g4+uxeR1A3Z8FSJAPC/3Eqck+H1ZRE9e8IX6/Eq0iwy81yirdijK9
    jPOR2h/caS8bw0nYQnFrDoVd9wRiuXmHt5mfxpaj20Nvv4NK2D0pF/5bipg13Mj+
    2BmxlPe/sLcl7AiBGTu+B1uva/aV8YbTj+RgXFOk7WHTr9x5pv6ek4N4yqwvlXxm
    zIxZnRM6Dy0x374Q6bgaBFE8690cHMHhbIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1527697700; bh=vihL
    poHqWEDDVJLkXfxXLgb8KIGeGnj8GGYFUO5b7Xc=; b=d4U3K29tKL2oss0mMCmC
    efGN152l4k/L+rGN9JQ+b6LSuwoQZybAiY4qerJsE2u0UuIr1/p4imEP2wrepOjq
    /OSC3GCZo/0caDRPjsidiA46RqSYwsTdh1A8v0coS91n/tNTA5T67cNJ+3AyE4Yl
    qB+muNCdQ2ZmGa1gpXTmSSgG4AlrIhDn2bZYgzFaVC5YFBb07NGIPXkTsGQLxMH7
    P27DqfMed2q6iCMwKdwbKypQVRUVhUF78avQWq4W6nrgwP20kDkTic+sNkI3/ree
    Z1p068lA/xoBZE9bdYVp7QofnPNRzb/rdgcEyeozgpzvchGfJ6l4GdPidjIsvqQC
    LA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=hg+43lOE
    header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=bjyQsaA3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=hg+43lOE
      header.a=rsa-sha256 header.s=20150623 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=bjyQsaA3;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKCyrJ+Ge+lpC5gf6bdBlkhAk4O7bnCgEVCp+8f3c911B+y4ScwlD1rAk2Rm2kmSnxqPNSsmeW+FixxMX9hpnssag89N+i+Mx0qfH4rT1n1FpuZHWpAg
    iKXkEJ6pKqJAX3PHJouKMOV5PLRTbmpVXMSav+MhGT4qaW25ZRjXMt0K6HrXYoYnYXiTXZtiCm/y6h9oEIgg6K2NzXk/iCQFfehNI9X7w8xLGtQ+3OYe1lXX
    pBCqk7lgZyjAoaz8tH70Rw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=xVhDTqbCAAAA:8
    a=CviiR3QUrGmdVjqoa84A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=GrmWmAYt4dzCMttCBZOh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753758AbeE3Q2R (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 12:28:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:32779 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeE3Q2R (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 12:28:17 -0400
X-Google-Smtp-Source: ADUXVKJW/EKbdI2n9pj9A0iKYWjVjRbmI8d4tjD/H/WTEHVk8FNNbHdYaycQkVsAZyIStQFjOMkVxjk3BrqftK+0SFo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 May 2018 12:28:14 -0400
Message-ID: <CAHC9VhT3tXt3PaUHtt9MmocVocXu7t3A-zey=UOVufi8vZ_=LA@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.17 (#2)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

One more small fix for SELinux: a small string length fix found by
KASAN.  I dislike sending patches this late in the release cycle, but
this patch fixes a legitimate problem, is very small, limited in
scope, and well understood.  There are two threads with more
information on the problem, the latest is linked below:

* https://marc.info/?t=152723737400001&r=1&w=2

If you're hesitant to pull this into v4.17 at such a late stage, it
probably isn't going to cause major problems as Stephen points out in
the thread linked above:

 "Such a setxattr() call can only be performed by a process
  with CAP_MAC_ADMIN that is also allowed mac_admin permission
  in SELinux policy. Consequently, this is never possible on
  Android (no process is allowed mac_admin permission, always
  enforcing) and is only possible in Fedora/RHEL for a few
  domains (if enforcing)."

Thanks,
-Paul

--
The following changes since commit 4152dc91b5932e7fe49a5afed62a068b2f31d196:

 selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()
   (2018-05-14 15:20:59 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180530

for you to fetch changes up to efe3de79e0b52ca281ef6691480c8c68c82a4657:

 selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
   (2018-05-29 20:11:19 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180530

----------------------------------------------------------------
Sachin Grover (1):
     selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

security/selinux/ss/services.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
www.paul-moore.com
