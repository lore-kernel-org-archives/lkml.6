Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pbBhJ3RlGVu2CAAAmS7hNA
	; Thu, 07 Jun 2018 17:03:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 874DB6074D; Thu,  7 Jun 2018 17:03:48 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvgAjqN4"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F34B460590;
	Thu,  7 Jun 2018 17:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F34B460590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbeFGRDq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:03:46 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46466 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbeFGRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:03:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so6500320pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xsjoZgRXjxQ8GyaM/oIN55sRv5uHuoBSO16j0HE09Qo=;
        b=VvgAjqN46h/XmFNbWGBhnnWO5j1LZNnI2HV+dvcKNj713tiQOtgEXhU+Tdsrdhnub9
         XO+Bbcr1a653P/5rRtZYsZlbaXYF7FC77nQetKJ3PkUEmG+ch+QuluaN5pXm19z1tHv4
         rT+JLKbSk5YYkrjJhqin09gqDLaClENP6Rbq/nthg6/1g+8thEflJW3WOrihGrhqswhI
         HJz3a+pamG7EJ+7Ay6FY4pT1WjNW6HTlZ4rQm/Uvl3Ulm1NQJDnWo2DW3QvD+gSrNUCA
         lKUj3/f94zB4XBBAFDzTu2RESEOq83oDXGOf34asITHQZWJKyQJC6sZOeMJbW+3TPPrc
         n2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xsjoZgRXjxQ8GyaM/oIN55sRv5uHuoBSO16j0HE09Qo=;
        b=CfX9AqUNL9U++QR8Fu2yQJQ0OHGngeu3yz8xK9OTd6Ur85SE3IlKB7EfniorTZ+9T+
         xxErGg1rtRkVrENphaO1Y5guFgM4HIYUtG+Xg2XJrk7feSvC2AT6rUKpNVRaZnYSiIHp
         lltkTKXi5EvpJ8hxB5UxMWNrsrN1eAZQaIYZ4pTPBw34AIUPmigBl+zfPwYSWp4iHFS7
         lvKYxgzqLlPlOMgMOTcQHFv9L+Ml9UhoLQdkBDtbgV062J9GVmn0Emvgtp7zpWM8Gw8K
         FDjRoAynWLJ+CSnHyYkekjNsol0HZ1MquV5w6dvtNDV5SSTPUOeHY3DArVQv2uUa5ci1
         3GDQ==
X-Gm-Message-State: APt69E32utktx3CFb+6OMJcawo7V3taXAgv1YVZjQaaHYX9z2it3aJu6
        gupV1VzI0WVQHEOyxpmqS2Vd7rLZfoWTmNFy2+SIIA==
X-Google-Smtp-Source: ADUXVKLpYr9y7wfRkCI2BeZV84WNOOe4Dr9ChLqQm2Edw/iwqGIBAX0hqJI8Vp1jAjm86Zont6T2E+I9AHVjse9ofS8=
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr2804261plc.341.1528391023949;
 Thu, 07 Jun 2018 10:03:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:d42:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:03:23
 -0700 (PDT)
In-Reply-To: <0dff7b42-65d2-a29e-2086-938031859004@oracle.com>
References: <000000000000832e70056df8fb38@google.com> <0dff7b42-65d2-a29e-2086-938031859004@oracle.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 7 Jun 2018 19:03:23 +0200
Message-ID: <CACT4Y+Yv4_TjyJtNxso9CLBZPXCUkYZy_1RG_o6ASJdTsLO2Ng@mail.gmail.com>
Subject: Re: general protection fault in open_fs_devices
To: Anand Jain <anand.jain@oracle.com>
Cc: syzbot <syzbot+909a5177749d7990ffa4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, Josef Bacik <jbacik@fb.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 6:28 PM, Anand Jain <anand.jain@oracle.com> wrote:
>
>
> On 06/06/2018 09:17 PM, syzbot wrote:
>
>
>
>  Which means there was some other thread which freed our %fs_devices.
>  As this thread is still in open_ctree() so the contending thread can't
>  be the ioctl(). So btrfs_free_stale_devices() is the only thread which
>  can free our %fs_devices in this case.
>
>  This is fixed in [1] in the mailing list.
>
>  [1]
>    [PATCH 3/3] btrfs: fix race between mkfs and mount


Let's tell about this syzbot:

#syz fix: btrfs: fix race between mkfs and mount
