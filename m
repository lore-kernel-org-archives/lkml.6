Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2302194-1527608456-2-11643566342764516765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527608455; b=GkkMFzDu2BYt4P90RvH3bHzWwlXTIN6rsQRE3jr5qgbPtkvV1m
    lzdPXmemBpkw5WT2mlIKjBIJ0hAu6kZFP42IAqaMLmPRd+HESyKM06HOmVF1kDke
    a+j0IeyHx6YFZ1zkR5UjyI9K6hVowQL134AhL+5/CZUAU8wBzRkKBhtWwcOxwl4K
    hgzF536+NyzJ8U4yQdvg/DuS5SgdAfpHBferkzIpDuDGs67vJadfTqIcY5rZ2Gfr
    Q0y4meRpr7aUhaClK9vljqRlp+mjnpJO07F7dzC39Uuq9sSobfjuchyXDjlzf38l
    +C9383MDzMXKiD+eKosYXHiv2sMESOcT0lRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527608455; bh=1QHomPqwz94oSov/7MO/6iTWv2mVoqI63XiMoVg5BI
    o=; b=KFUS6e6ldPX7KvlB5lGZxst0Lase5me81EB6Tn8ptvNX97rbpGcsRr5HOd
    BviFGSYNyHG9MYKXd6sXMr3FM9YggAyPSnRZ72LpxSfQhiIx6mdT+5X7gBS1h5PQ
    UWWdrF8b/IjdejrhceCWuwYkcsm0txjx8d4F+gzB7Km7ILs6Gmt8QD0qSO47Z+Kv
    X8z4j9OHo7NWC4gUux+3tqPHXKdKRRz7qML7nnG3ezRb5KHu/motTiXptGNw7Cjt
    36qkCOQhg0UEng47liREnl8oS4FxdCbiA7gSJh3AV2k08boWs+qo2KISzrCZt6is
    ByOQqJvXC63Hc65N5QhePjF8XJSg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kinvolk.io
    header.i=@kinvolk.io header.b=Jda0AN+9 header.a=rsa-sha256
    header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kinvolk.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=BonKth8C;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kinvolk.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kinvolk.io
      header.i=@kinvolk.io header.b=Jda0AN+9 header.a=rsa-sha256
      header.s=google x-bits=1024;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kinvolk.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=BonKth8C;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kinvolk.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMG4kpQNLlfCG7vnRcetof9xOJkLxKHuknByZortUar980WavTuLAfOL4glTmkXtfviDTSweXOx6kodzmvGYA0MI2Os/kEBQ5r7A7/qr0nZlyy5fm34j
    DVCO+3RScr7Eozh0C5NdgqWsCNcp2uv+/ImQ6rB288rXA5CBLD3VfkdJ5ZQbnzIwcDoYIr53+py7RfKWf86G7EUfSaBQfB2ECHyLrg9XfVSblIW8skT5pRWz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=PtDNVHqPAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8
    a=ag1SF4gXAAAA:8 a=L2i-6bQ3sLBWRfcJRRIA:9 a=QEXdDO2ut3YA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935090AbeE2Pkw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 11:40:52 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34273 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934860AbeE2Pkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 11:40:51 -0400
X-Google-Smtp-Source: ADUXVKKjdUENhfxDFgWevGvOsNha/CdGBVBkUUl8jtT/MtuG/TqFHe0xQxS1QHwv2FeBAVrI7FCiU1yxTEpml/s0Fjo=
MIME-Version: 1.0
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
From: Dongsu Park <dongsu@kinvolk.io>
Date: Tue, 29 May 2018 17:40:50 +0200
Message-ID: <CANxcAMt5f7=TV3Yqc6iavos=saGFOPKC4R4Yr9yGbKoVwq3YGw@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 0/6] Wrapping up the vfs support for unprivileged mounts
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, May 24, 2018 at 1:22 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Very slowly the work has been progressing to ensure the vfs has the
> necessary support for mounting filesystems without privilege.
>
> This patchset contains one more core piece of that work, ensuring a few
> more operations that would write back an inode and confuse an exisiting
> filesystem are denied.
>
> The rest of the changes actually enable userns root to do things with
> filesystems that the userns root has mounted.  Most of these have been
> waiting in the wings a long time, held back because I wanted the core
> of the patchset to be solid before I started allowing additional
> behavor.
>
> It is definitely time for these changes so the effect of s_user_ns
> becomes less theoretical.
>
> The change to allow mknod is new, but consistent with everything else
> and harmless as device nodes on filesystems mounted without privilege
> are ignored.
>
> Unless problems show up in the during review I plan to merge these changes.

Thank you for the great work. I have been looking forward to seeing it.
I have just gathered available relevant patches in my branch:

https://github.com/kinvolk/linux/tree/dongsu/fuse-userns-for-4.18

With this branch, I tested sshfs/fuse from non-init user namespace.
It works fine as expected. So you can add:

Tested-by: Dongsu Park <dongsu@kinvolk.io>

Thanks!
Dongsu

> These changes are also available at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git userns-test
>
> Eric W. Biederman (5):
>       vfs: Don't allow changing the link count of an inode with an invalid uid or gid
>       vfs: Allow userns root to call mknod on owned filesystems.
>       fs: Allow superblock owner to replace invalid owners of inodes
>       fs: Allow superblock owner to access do_remount_sb()
>       capabilities: Allow privileged user in s_user_ns to set security.* xattrs
>
> Seth Forshee (1):
>       fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems
>
>  fs/attr.c            | 36 ++++++++++++++++++++++++++++--------
>  fs/ioctl.c           |  4 ++--
>  fs/namei.c           | 16 ++++++++++++----
>  fs/namespace.c       |  4 ++--
>  security/commoncap.c |  8 ++++++--
>  5 files changed, 50 insertions(+), 18 deletions(-)
>
> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers
