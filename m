Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7802AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E35208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0hw6lIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E35208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933808AbeFLOBj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:01:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35647 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933295AbeFLOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:01:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so6038011plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=JNBKUM4Tz/CwiHqCwbCjYcn0+R6qgjM0VDTm+6Ih/48=;
        b=E0hw6lIvtLMMuXhKnM8PHcnc5WO6RrHoPgBLhePAxHXML2sQrSbfRrnDI9QUebjGFC
         JZU82zpCj6RhNczdqrg/L+nvIRusDU0F4+I/pIqUvsQKiQhRTMluvM6ka0SZhn0M3ABV
         tHYnejCIBVz9K/5yt5aeFG7w0q+VETBesU5K26qhWyb238x+nBhhXpNTs0xBqYihUHGF
         dvR38hkNHIBRPBDcWK73IJeEBXgwImNgqPmE+WEQbmcYyP3QwPEmtePyC+WTL6vfdmZX
         l72GuPBcfQSgOu9qzioCwwGN8M06uiv+FTg4G5RI2bT41DAWM9bdoYnRRci0L2jkeNGO
         56Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=JNBKUM4Tz/CwiHqCwbCjYcn0+R6qgjM0VDTm+6Ih/48=;
        b=Gdt/AHJHcx2Nm7DbFKbyAXhe4km8Lkr+OglSPepxNX2hP1rw0vtznsuimyFoiJ6kzK
         SLJOT0sUofBlHMTi3EO+4v5mrb5FCXwo7QNdr4usti3cn4Be4NWKGUpp/t5XJH0XFaOk
         5ih8OvEi5VDu9wZVKQR7wq4ChGEIIH+SqvE3mIxWL5CftZPJhh1e6uV1l2yfGddM8z52
         W3YpgseglUYCI6dfBY1f+wj6I1nitQLo2/TN/mC8TA/ulAx1u6K56pQxzkchTqrsxkmQ
         1IEhi+RZOZfJgG/BjULGX1nbESIi+aWJbeK7NCLUbTZI8vls0nbk0Duyz2pBSbdFvwZI
         zR9Q==
X-Gm-Message-State: APt69E3bYlk0ddStecRA91bacmI63HxtktCZlD7TZlYyeSLTCAPHT8nM
        KYtPLscBGP01d78m8MfHwxwaeyGJ6gOhVzWxZzXBbw==
X-Google-Smtp-Source: ADUXVKJnDVTExQ+i5F60XdndzY9czKMgIG5RqKRidFvhGd2anBuJWjEe7dx8js9AgrtcmNtdkpCcw0GYIdSG7qkoz7o=
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr567447plm.85.1528812096550;
 Tue, 12 Jun 2018 07:01:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Tue, 12 Jun 2018 07:01:15
 -0700 (PDT)
In-Reply-To: <CACT4Y+YhpkZt2ufQo+hBV8FkAPE+wzxM1PUhQSZbQFWFR9bW_Q@mail.gmail.com>
References: <000000000000019f50056b7f0890@google.com> <20180506022428.GQ29205@thunk.org>
 <d295f575-ba4b-b0ba-a856-405f9d393c9d@I-love.SAKURA.ne.jp>
 <20180506133154.GS29205@thunk.org> <201805062340.HFC78625.VFFFOHSOtQMOJL@I-love.SAKURA.ne.jp>
 <20180506203046.GV29205@thunk.org> <CACT4Y+YhpkZt2ufQo+hBV8FkAPE+wzxM1PUhQSZbQFWFR9bW_Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Jun 2018 16:01:15 +0200
Message-ID: <CACT4Y+Z+2YW_VALJzzQr6hLsviA=dXk3iFqwVf+P5zqojeC9Zg@mail.gmail.com>
Subject: Re: kernel panic: EXT4-fs (device loop0): panic forced after error
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:12 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sun, May 6, 2018 at 10:30 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> On Sun, May 06, 2018 at 11:40:10PM +0900, Tetsuo Handa wrote:
>>> > We could add a full kernel-mode fsck which gets run before mount ---
>>> > the question is how much complexity we want to add.  If SELinux is
>>> > enabled, then we have to check xattr consinsistency, etc., etc.
>>>
>>> You are thinking too complicated. I'm not asking for kernel-mode fsck.
>>
>> That is the logical outcome of what you are asking for.  There will
>> *always* be a point after which where we can't atomically unwind the
>> mount, and we have to proceed.  And after that point, when we detect
>> an inconsistency all we can do is what the system administrator
>> requested that we do.  Sure, for this particular case, we can
>> significantly add more complexity and decrease the maintainability of
>> the code paths involved.  But there will always be another case
>> (e.g,. xattr's being read by SELinux or IMA) that will happen during
>> the mount, and are we expected to catch all of those cases?
>>
>> We do catch a lot of cases where we refuse the mount and complain that
>> the file system is badly corrupted.  This just doesn't happen to be
>> one of them.
>>
>>> I'm just suggesting that mount() request returns an error to the caller
>>> (and the administrator invokes fsck etc. as needed).
>>>
>>> We are fixing bugs which occur during mount operation (e.g.
>>>
>>>   https://groups.google.com/d/msg/syzkaller-bugs/Yp4q8n-MijM/yDX3zl1XBQAJ
>>>   https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/W6pi8NdbBgAJ
>>>   https://groups.google.com/d/msg/syzkaller-bugs/QBnHAQBy2pI/ccf-yL5bBgAJ
>>
>> These are different because there are kernel OOPS or warning messages.
>> This is neither a kernel OOPS or a WARN_ON or BUG_ON.
>>
>>> And extX filesystem is different from other filesystems that it invokes
>>> error action specified by errors= parameter rather than return an error to
>>> the caller.
>>
>> Syzkaller (or anyone else) can mount the file system with
>> errors=continue or errors=remount-ro if it wants to override the
>> requested behavior of the flag in the superblock which is manipulated
>> by tune2fs.
>
>
> Filed https://github.com/google/syzkaller/issues/599 to always pass
> errors=remount-ro when mounting ext4.

This was fixed in syzkaller. With this commit:
https://github.com/google/syzkaller/commit/deb0e69e1028ba3152631c3f1d2fac98c12e33a5
syzkaller should always pass errors=continue when mounting ext2/3/4.

#syz invalid
