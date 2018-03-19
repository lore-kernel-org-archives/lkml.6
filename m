Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497820-2-1072437369543741771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497819; b=K4Wh3Zwk5drEX8Rw4IRBtUS11sMtVmXp9Sb6w0ty9cHz6SL
    RDiP62LzGmDv2lw1mITMVFoe8WfjukQNEvNiM0A0ud0HT1ixgyVjTMsr8xGUbqbj
    ygyk9P97FbY3PFsF73M2yqNlRQ/gGgm18KQy0Z2BxIVY3YIZdbSHVG6hP0NxrFrw
    kRnK9/FRCZ5Pv/sfd4AIHSSQwoQBdjNVX8PpUjxAP/xy8/eEOfHpHpUrIn+KtDPY
    vk+9Hfkua4Ev+i6dKmqfuRup+WAhFeDmyabbMlfG8EXFK+u8e5TWOxLYKFNvVGm3
    jGBr5QR2vGfnv5C3ERRCZUd/GZvWEL55WsthYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521497819; bh=g
    9Wg8Km+cbzqVu0ifMDAiwXwqBuQAhjp6FBaxCOVkHw=; b=CyK1vjyI0fOclXNZ9
    uGsMgESYEZiaRtbH83OQjov6naX6Kuq0VraoA/YrIZOrRbBnK8WAoFLxCJoSgeqm
    V2oLkLiipbKaEr8+qF9SetwqMHSYqzC4Bgy83vXq/2Qn2CA/R0Lg14scuX2eyJ0Q
    pxklHKNiTy2Ata7spZiAqlbnywJGAr1WMQdvTLEypK4TEbgN3YQBuZogWO5lAhNo
    gVy5FgLY5pIDOOmVbSxyA/hxcOqt4BIMzMsoP4Dy5taOeZ46gOaQEEYbY/EB8LTn
    nReRaKHqxW7HpPCsrGeNz/3wVfHqaRAD4NXhgXcLJneMsXwEQ9BcGs7V2IHQvpd9
    Lh1Nw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G0K4L48s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvphejjfegudeftdgtgfgvshesthejredttddtvdenucfhrhhomhepfdflohgvlhcuhfgvrhhnrghnuggvshculdfiohhoghhlvgdmfdcuoehjohgvlhdrohhpvghnshhrtgesghhmrghilhdrtghomheqnecuffhomhgrihhnpehsphhinhhitghsrdhnvghtpdhlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpvddtledrkeehrddvvdefrdduleehnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeefpdhhvghlohephhgvmhhlohgtkhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepieefjedvuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dCVlV2Ib;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=G0K4L48s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduiedtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegjfhfhfffkuffvphejjfegudeftdgtgfgvshesthejredttddtvdenucfhrhhomhepfdflohgvlhcuhfgvrhhnrghnuggvshculdfiohhoghhlvgdmfdcuoehjohgvlhdrohhpvghnshhrtgesghhmrghilhdrtghomheqnecuffhomhgrihhnpehsphhinhhitghsrdhnvghtpdhlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpvddtledrkeehrddvvdefrdduleehnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeefpdhhvghlohephhgvmhhlohgtkhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepieefjedvuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dCVlV2Ib;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvCm5O21t+irzjZmd/97SOq6oXq+mM97s6zv5oU7vA9a1uvvQhXx+8pgW255jWbZE25+jnSF0DESOAAzOhb2/U=
MIME-Version: 1.0
In-Reply-To: <1519801162-52182-1-git-send-email-xieyisheng1@huawei.com>
References: <1519801162-52182-1-git-send-email-xieyisheng1@huawei.com>
From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Date: Mon, 19 Mar 2018 15:16:51 -0700
Message-ID: <CAEi0qN=BTpY0hZQe=r_dZkmX1K0MaHQOw1O3RoXF=xVygCa8yQ@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ashmem: Fix possible deadlock in
 ashmem_ioctl
To: Yisheng Xie <xieyisheng1@huawei.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arve@android.com,
 syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com, ben@decadent.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:59 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> ashmem_mutex may create a chain of dependencies like:
>
> CPU0                                    CPU1
>  mmap syscall                           ioctl syscall
>  -> mmap_sem (acquired)                 -> ashmem_ioctl
>  -> ashmem_mmap                            -> ashmem_mutex (acquired)
>     -> ashmem_mutex (try to acquire)       -> copy_from_user
>                                               -> mmap_sem (try to acquire)
>
> There is a lock odering problem between mmap_sem and ashmem_mutex causing
> a lockdep splat[1] during a syzcaller test. This patch fixes the problem
> by move copy_from_user out of ashmem_mutex.
>
> [1] https://www.spinics.net/lists/kernel/msg2733200.html
>
> Fixes: ce8a3a9e76d0 (staging: android: ashmem: Fix a race condition in pin ioctls)
> Reported-by: syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Greg,
Could you take this patch for the stable trees? I do see it in staging
already. I couldn't find it in stable so wanted to bring it to your
attention. If you already aware of it, please ignore my note.

Thanks,
- Joel
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
