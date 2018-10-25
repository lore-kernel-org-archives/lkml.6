Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403A72084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOy0OhnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403A72084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJZCrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:47:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47013 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeJZCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:47:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so4571488pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=qZyfnaf9kAFxXv7pEaC3keGLFV2OMkwYcBPWGebAtWA=;
        b=JOy0OhnOQqCWNsDe60GeBW1/8pIAJHF25ZgkruQT6zDsd4FMKkY9yT5g3vfQpiA33O
         8e+JoQywsa9mHALBGkfZwAKbaSnw2OP1h4IGF6GIJHL1bMBl5g6Eok58hR335suka4gK
         bGxYNaVjkYtzEgj9WR+nTuuAQXTWXu+bcNbBY7wZyIgLf152149apG1YqMR37ojc2bnt
         w3PxAitPPGasz5AbU+W1gotV6tGv0/I82Dw7M6YigOJQR0W/jpK5UREC7kDJX9fD9nC3
         0TNhWQMOYawul64kBeXHF/GvCro0OkSztnmDmVW3lY0CuxO0VpmHyx0quVZGIvgggS6n
         RNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qZyfnaf9kAFxXv7pEaC3keGLFV2OMkwYcBPWGebAtWA=;
        b=M03miU32JYbV9DKsALmT4AAgLecI1/cdVxDc+ncAaDOrc88+TmU82tJXg1VPAqVtxj
         kSgngTWJQq0TH7DO7cS6ZX/I6n9r9VbBLZ3ul6MNg57GX8DkM6/PC9s9ScVXCrO1oAHu
         ZXtSTRhcSiMajRynAM3BjQbQEWmUlZwxHTFuQ+9aNlkDlVqTjoL3I/mMhJtVSerLAUb7
         kqyuNiqOBVhE/HZa36xhj4jPh6KvmwYQrjIA9iF+iey3IYd/UcOJiG2IuZo1KlIiiZyi
         SfZuMOEw7XmZwwPbNMs8kdk7DOQGho2dqskm05hSANLZ3dTk7r5/9ZYR0OW9sjF5y42x
         6Tug==
X-Gm-Message-State: AGRZ1gIGCxDkGUBd2JXd65pO6GA2MRc/Ky0gEFA8zHrJRviA4SY5pWvH
        Q/ZoCI88LMhoWOF0t8GYGLpOOg==
X-Google-Smtp-Source: AJdET5dAYCs5HNK+RjxYDVBztYQZ84H2WKtaLuKQcDcx10qRxh9sh2xOW22z8lTlkTK55BG6AxDrTA==
X-Received: by 2002:a62:640c:: with SMTP id y12-v6mr236871pfb.249.1540491200852;
        Thu, 25 Oct 2018 11:13:20 -0700 (PDT)
Received: from paullawrence.mtv.corp.google.com ([2620:0:1000:1601:da51:dc8c:708a:5253])
        by smtp.gmail.com with ESMTPSA id v83-v6sm18528552pfa.103.2018.10.25.11.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:13:20 -0700 (PDT)
Subject: Re: [RFC] dm-bow working prototype
To:     MegaBrutal <megabrutal@gmail.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        corbet@lwn.net, shli@kernel.org, linux-doc@vger.kernel.org,
        Linux kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
References: <20181023212358.60292-1-paullawrence@google.com>
 <CAE8gLhmtrfprc93-XfomNEK5ZgxA_RFA0DnFrEnHjB0q31wkyg@mail.gmail.com>
From:   Paul Lawrence <paullawrence@google.com>
Message-ID: <d00e361b-b849-3139-7e7a-02f05f3794c3@google.com>
Date:   Thu, 25 Oct 2018 11:13:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE8gLhmtrfprc93-XfomNEK5ZgxA_RFA0DnFrEnHjB0q31wkyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The concept intrigued me, so I actually went on to try your prototype.
> I could apply it on v4.12 mainline (newer kernel versions introduce
> changes in "struct bio" in "include/linux/blk_types.h" those don't let
> the module compile – I think minor changes would be necessary to adapt
> to the new struct, though I didn't go into that).
>
> My test scenario:
> On a KVM, I created a 64M partition and formatted it to ext4, then put
> some random files on it and unmounted the FS. I then called "dmsetup
> create bowdev --table "0 131072 bow /dev/vdb1"". The
> "/dev/mapper/bowdev" file appeared as expected. I mounted it in
> read-only mode ("mount -vo ro /dev/mapper/bowdev /mnt") and run
> "fstrim -v /mnt". At this point, I tried to advance to STATE 1 ("echo
> 1 > /sys/block/dm-2/bow/state"), but I got a kernel BUG alert. The
> STATE did not change. I unmounted bowdev and removed the device
> ("dmsetup remove bowdev") which resulted in 2 subsequent kernel
> alerts. The device disappeared but it brought the kernel to an
> unstable state (various actions, like sync or trying to recreate the
> bow device, resulted in a hang). I could not get any further than
> this. I attached all the 3 kernel alerts in "dm-bow.dmesg.log".
This BUG_ON is caused if your file system writes blocks in sizes less 
than your page size. I will fix that before I attempt to upstream this 
driver assuming it gets accepted. If you can make your file system have 
4k blocks, you should be able to proceed (I hit this when I created a 
16MB ext4 fs on a loopback device)
> I have some questions about dm-bow:
> – How file system agnostic this feature is planned to be? While it is
> designed with ext4 in mind, is it going to work when used over other
> file systems, like FAT or BTRFS for example?
So long as the file system supports fstrim, it should work. If the file 
system creates a lot of churn say by running garbage collection, I'd not 
recommend it. And I really don't see the use case if the file system has 
any sort of snapshot capability - that will always be a superior 
solution to a block level one IMO.
> – Especially that BTRFS uses a CoW mechanism for even overwriting
> files (overwritten segments are written to a free area and only then
> gets the old data freed – except some specific conditions when
> NO_COW/nodatacow is involved). Won't BTRFS CoW mechanism confuse BoW,
> e.g. BTRFS will try to use space that BoW wants to use for backups?
> Note however, using BoW on BTRFS wouldn't have much point, since BTRFS
> has built-in features for snapshots. This leads me to my next
> question.
> – Why don't you just use BTRFS on Android? It basically provides a
> similar feature like BoW, and it is matured enough, switching
> snapshots are easy, etc.. However I see why it wouldn't be feasible
> for you, e.g. it is slower than ext4, which would matter for an
> Android device.
I'm not the ideal person to answer that question, but yes, I believe 
performance is an issue, along with the lack of file based encryption.
> – What if you run out of free disk space while updating? I guess you
> can just revert to the original state with BoW, but an update might
> require more disk space with BoW (and this is a thing, my Android
> always complains about not having enough space).
Well this question remains with any snapshot system, and indeed is there 
even before you have snapshots. There are really only two choices - 
throw away the snapshot and keep going, or fail the update and revert 
(with presumably the intent of freeing up more space and trying again.) 
Which we choose would be a policy decision - my goal would be to make 
sure either option is possible.
> – Can I really expect dm-bow to work on non-Android systems (like I
> tried it on an Ubuntu KVM)?
Yes, absolutely, but for the moment it's a work in progress and it 
contains an assumption about IO accesses being page aligned that is the 
reason for the failure you are seeing.
> – Do you have any prototype for the command line utility to be used
> for recovery?
Yes, and I will be uploading that. For the moment it is embedded in some 
Android specific code. It won't take long to extricate it though. It's 
actually very simple.

Paul
