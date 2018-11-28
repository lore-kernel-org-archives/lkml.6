Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D329720863
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLScsofi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeK2IQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:16:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53040 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeK2IQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:16:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so120537wmb.2;
        Wed, 28 Nov 2018 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PhTpytIS/6/ulDRcXJwd8HHp+22L6NFXZJbOrAbrJzk=;
        b=dLScsofiATzQ3cerjmdLkORhCPUiH50j53gCdBqDuQDMXC1wfv9s1gjiJN+MsiiAp3
         5rdqHBWs22aZ2SdF79pJMdPwnqBod0iOYXZhGi95PugyaxeQH+kV9ZLbr64jGd65quIY
         F4/6EPSD9tZBMLQiQ6DZ7KS39deZbyTL2l3SXXm0xpWMuBldm6wK1oekeHFE21jHtsJU
         +Qjes0UfR8EYHel4lB858lvC21PekgJW9kbnkBT2Rz+8XJXkh5K8VXrjLp7kTcNVmt5M
         EHZUZkliwGqJa9pPUipKCmmDvgEn87cbbV+DXMa9b/csIV0tIi9ItxKcdy6uLD2/WTJY
         B55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhTpytIS/6/ulDRcXJwd8HHp+22L6NFXZJbOrAbrJzk=;
        b=CdQLFeuAJSBU0Mmi/iOnXwgKp3+PoVYgePAs4u2u9plMiNS0MARTsZwlYiYVG7iyK6
         5mneRWKU/0wLuHORVdGllUPOXViQF5ayZOgKZy4uTOnnGO8gSzhIj1f8szg/IJln8rO8
         nXWcuLWkuPtHnNpPkHtc7xutp5xA2limR9roVXt0xEKdBfLDB9HObrUQ11u8ALnvE/43
         NjQtidIaJo40Nb7qk+cbLFzOhY/pGGW0/gFCNDfeM0ZbfU9sRrWcgqSoSUS1D7DGCiBQ
         c02RDHVU3MRABPJ2Tafjex2wi3V/x/zI7CkchURyUi9T7qaUxQXbdtg6wbhETQ8vaKkj
         TIKA==
X-Gm-Message-State: AA+aEWbkRb54PrcQdQLuhFVQzwSfeDL4jSgtpLNKZ3nht4JNrG1NS7Qj
        PTntzcrIUx2GsDtb/bHW2xp+6G/UCY/+MOX98FI=
X-Google-Smtp-Source: AFSGD/Uya8chaz07J2AkAsQWLj6e/HykfwMl5Zin+YJXmp3IYz6mpcAeOQ7kBjyc8lk2q9ogjHBctFuHbx7vyUABuYk=
X-Received: by 2002:a1c:9e90:: with SMTP id h138mr3938414wme.17.1543439613223;
 Wed, 28 Nov 2018 13:13:33 -0800 (PST)
MIME-Version: 1.0
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <20181128041555.GE31885@thunk.org> <en52df-5dh.ln1@banana.localnet> <2547416.7Vy7A2kRpU@siriux>
In-Reply-To: <2547416.7Vy7A2kRpU@siriux>
From:   Andrey Melnikov <temnota.am@gmail.com>
Date:   Thu, 29 Nov 2018 00:13:21 +0300
Message-ID: <CA+PODjo-da79FKQCmpcH9Z9CBq35HbWu2m+nB3si7WgD9w-kGA@mail.gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     jrf@mailbox.org
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 28 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 18:55, Raine=
r Fiebig <jrf@mailbox.org>:
>
> Am Mittwoch, 28. November 2018, 13:02:56 schrieb Andrey Jr. Melnikov:
> > In gmane.comp.file-systems.ext4 Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
> > > > Corrupted inodes - always directory, not touched at least year or
> > > > more for writing. Something wrong when updating atime?
> > >
> > > We're not sure.  The frustrating thing is that it's not reproducing
> > > for me.  I run extensive regression tests, and I'm using 4.19 on my
> > > development laptop without notcing any problems.  If I could reproduc=
e
> > > it, I could debug it, but since I can't, I need to rely on those who
> > > are seeing the problem to help pinpoint the problem.
> >
> > My workstation hit this bug every time after boot. If you have an idea =
- I
> > may test it.
> >
> > > I'm trying to figure out common factors from those people who are
> > > reporting problems.
> > >
> > > (a) What distribution are you running (it appears that many people
> > > reporting problems are running Ubuntu, but this may be a sampling
> > > issue; lots of people run Ubuntu)?  (For the record, I'm using Debian
> > > Testing.)
> >
> > Debian sid but self-build kernel from ubuntu mainline-ppa.
>
> You could try a vanilla 4.19.5 from https://www.kernel.org/
> and compile it with your current .config.

mainline-ppa use vanilla kernel. Patches only adds debian specific
build infrastructure.

> If you still see the errors, at least the Ubuntu-kernel could be ruled ou=
t.
>
> In addition, if you still see the errors:
>
> - backup your .config in a *different* folder (so that you can later re-u=
se
> it)
> - do a "make mrproper" (deletes the .config, see above)
> - do a "make defconfig"
> - and compile the kernel with that new .config

defconfig is great - for abstract hardware in vacuum.

> If you still have the problem after that, you may want to learn how to bi=
sect.
> ;)
I'm already know how-to bisect. From kernel 2.0 era. Without git ;)

This problem simply non-bisectable, when same kernel corrupt FS on my
workstation but normally working on other servers.
And now - FS corrupted again with disabled CONFIG_EXT4_ENCRYPTION. Great.

> So long!
>
> Rainer Fiebig
>
>
> >
> > > (b) What hardware are you using?  (SSD?  SATA-attached?
> > > NVMe-attached?)
> >
> > SATA HDD WDC WD20EZRZ-00Z5HB0.
> >
> > > (c) Are you using LVM?  LUKS (e.g., disk encrypted)?
> >
> > No and no. Plain ext4.
> > -- cut --
> > debugfs:  features
> > Filesystem features: has_journal ext_attr resize_inode dir_index filety=
pe
> > needs_recovery extent 64bit flex_bg sparse_super large_file huge_file
> > dir_nlink extra_isize metadata_csum
> > -- cut --
> >
> > > (d) are you using discard?  One theory is a recent discard change may
> > > be in play.   How do you use discard?   (mount option, fstrim, etc.)
> >
> > no
>
> --
> The truth always turns out to be simpler than you thought.
> Richard Feynman
