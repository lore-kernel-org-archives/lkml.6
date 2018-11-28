Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240B4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D725620660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNNFVZyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D725620660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeK2AaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:30:03 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35938 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeK2AaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:30:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id t3so26297654wrr.3;
        Wed, 28 Nov 2018 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9NkcTKRksPGYUJMIlXRI8RDdOouKGlby2xtegxMOhq4=;
        b=hNNFVZyYHQZml2ZrY8epe6F3D6SSVKCn3XThrtFRKHNmjXZ1bl+lSWLgRiQTVmc4Jh
         RxfJWrLQr/jshpGXcUryYuEN+1lnvtCUBGOsFvxx9tJShZ0CK1arDAsZNDJDt/wfcSgu
         AdUZtoScGxEIG9S9QCOrvnH6tPg+66iQXHZjaiL3eY6YucveXfbMvRa9Dzl2qGZlvWsV
         oWnN1v+OcwPlJcONJuS+wHa+t/esHa5YEb7F+esYpjZHtiramExtRHnKLDNN97sHfAe1
         kltnaroF4T613aIvC1IieAv1cezyPLmiElMd6QdaO+/QsM/l55iDkzwCSeV3a/qMcPhb
         ovaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=9NkcTKRksPGYUJMIlXRI8RDdOouKGlby2xtegxMOhq4=;
        b=KakHtq8O3S2tOZ18mmEqdeZ4kNz/aHnYR/sC3a89v9D26uySs6ri0L2fY1j8GKFxpX
         DCoxidTaiyO6EonYcrqQLzYII2cvnbMNx6hdsuvPk+amdNswzjo5i2CBDRCslVi+ZpA6
         F1L9sUMz1bT4CX/7SG+3LlIVfQ+IN+TurAWa+8Ae1aYa9t4UevMDpG1sBtwaqCF9eCEE
         t74uQ6Z+TSVyk671GAyoT4P2cknxaTveeNAG2FeFrhXboMRjhXj8Lt4X+aElXZK0N43v
         cU2IODSdB9nBqtYUp5AN91zmRGvph17/6oNLHyLmetSvEwhWkLntp7beZfrDi8L7DdV/
         6ezg==
X-Gm-Message-State: AA+aEWZ3EGHBIQSg6vv6gkKOdYAbqah3sgiv8XvDkbIlWg/YvApaGwnV
        YyD258aSglBmjElwORGTKmQXNU9GCdeVguasEw8AJvNdAZ0=
X-Google-Smtp-Source: AFSGD/URO8XVNpj5lhq9B+uTKpBjdC0jLE9+DS4ttogLIj3z/j3uAhqDvfEiez3nXiHh9mE8FEev/UiuCXeYSmiuGnM=
X-Received: by 2002:a5d:5111:: with SMTP id s17mr30447329wrt.43.1543411701989;
 Wed, 28 Nov 2018 05:28:21 -0800 (PST)
MIME-Version: 1.0
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net> <vb31df-25g.ln1@banana.localnet>
 <20181128041555.GE31885@thunk.org>
In-Reply-To: <20181128041555.GE31885@thunk.org>
From:   Andrey Melnikov <temnota.am@gmail.com>
Date:   Wed, 28 Nov 2018 16:28:10 +0300
Message-ID: <CA+PODjrow+vYB8JiGK0LatjkSU4JA9zM+rt2SriNEtfLNfcSaA@mail.gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 28 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 07:15, Theod=
ore Y. Ts'o <tytso@mit.edu>:
>
> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
> > Corrupted inodes - always directory, not touched at least year or
> > more for writing. Something wrong when updating atime?
>
> We're not sure.  The frustrating thing is that it's not reproducing
> for me.  I run extensive regression tests, and I'm using 4.19 on my
> development laptop without notcing any problems.  If I could reproduce
> it, I could debug it, but since I can't, I need to rely on those who
> are seeing the problem to help pinpoint the problem.
>
> I'm trying to figure out common factors from those people who are
> reporting problems.

For me - switching off CONFIG_EXT4_ENCRYPTION helps. machine survive
run updatedb & kernel compile. Switch it back to ON - crashed again:

[  118.204547] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155777: comm updatedb: bad extra_isize 13898 (inode size 256)
[  118.248928] Aborting journal on device sde2-8.
[  118.272239] EXT4-fs (sde2): Remounting filesystem read-only
[  118.293364] EXT4-fs error (device sde2):
ext4_journal_check_start:61: Detected aborted journal
[  118.315146] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155778: comm updatedb: bad extra_isize 38198 (inode size 256)
[  118.326760] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155780: comm updatedb: bad extra_isize 5023 (inode size 256)
[  118.337916] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155782: comm updatedb: bad extra_isize 44080 (inode size 256)
[  118.349149] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155784: comm updatedb: bad extra_isize 56093 (inode size 256)
[  118.360336] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155786: comm updatedb: bad extra_isize 13308 (inode size 256)
[  118.387113] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155788: comm updatedb: bad extra_isize 38399 (inode size 256)
[  118.422779] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155790: comm updatedb: bad extra_isize 24014 (inode size 256)
[  118.438124] EXT4-fs error (device sde2): ext4_iget:4831: inode
#14155792: comm updatedb: bad extra_isize 23262 (inode size 256)

CONFIG_SCSI_MQ_DEFAULT=3Dy in both cases.

Any ideas?
