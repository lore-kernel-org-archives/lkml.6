Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8E697C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBD92089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="UJZB6uOp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mq8wFpoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBD92089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbeFLWwW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:52:22 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33927 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbeFLWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:52:21 -0400
Received: by mail-yb0-f196.google.com with SMTP id n23-v6so235379ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gDNDBIenLbV8PGNVV8GjtgxrPeGVtRQFwPHBOMiPlMs=;
        b=UJZB6uOpfJU7LdOXb8zklhrtHyYi4QA4Syd6u+9PeImzEySLplGtVesMagb/y60UKA
         k7yFoj3zKz7mSERZhTgRCy92Nf8T1so9O90MULyVFsQOvsA92zpQ43J5Ny2CVoupaa/c
         cNB0CK+LFXAWVjBRCscaI9n6MTYp5tqRqnwieJDGJqZVG+RKFI5VfZZC7BKOKHMHowOx
         5d+FLyigUr6zKHc9n6xhF1CMZBEDzUydcY3r1AIxorGvi/DCLTLm1Kjlqdc4D/bGx95h
         PnJ990ZBnNVOG0uZAyM43Xo0DEF277jovWiAZN7+xZNm2vyW47Qg8/lsYIdFrlN2H/gz
         lZZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gDNDBIenLbV8PGNVV8GjtgxrPeGVtRQFwPHBOMiPlMs=;
        b=mq8wFpooaIJQiWwKZX9yR/oXboPAxD2dDCLZ9MJEUHx2frB/t4eyzEECAQWt6P/OHU
         jAyCacScMpd2iEaJPbMjcJR7ZiGYwFQdpDr1FFEkQN1duo4carlZ/hJBB2M+kMMQ33V0
         9e9S6PSpM1UZ7lCkAbnWZCaKQVdRovOv6Dl1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gDNDBIenLbV8PGNVV8GjtgxrPeGVtRQFwPHBOMiPlMs=;
        b=azccvYkoet85wdMJtl+u8BZjnRutAVRMoEUarNeSPa6F4jEcbT6nOyqqDUA1z/IbkF
         442g06MALfVmOH4veS3VE53Ey0DcEy3+RydeR9RNjZQVRtR/2ZXHxmXiZUTpoznsRdZ6
         Jdo7rgfTrBfvAiBF0MelIQc293QiBB0nD/TX9lfvlelvW9mwdgzgx+JCs2GRQqQU5Po4
         lKVwl0VvaW2kPIymxfpXQKchmxDwuAR2Mb9qJasdfFzg4w6/NgHbyFbFeW36+YNRSubr
         nxrYkmoBnXdsrQ8YCZY/o/awUAvBKwVjaCu5r6DOTjeq5CbDv5//qacKudcQ3MqyjHiH
         M3zA==
X-Gm-Message-State: APt69E198mJITEc4LQqRn8nyqruIupofL/Lvxvcnlaiwlcu2JHcTeAwH
        rG93JzqgVCuuLeLOwq7dxESNi8u2AQ6Z1vAqUg8V8A==
X-Google-Smtp-Source: ADUXVKJ1ei6c81Gcd8blZ+vP+jpHo3nwF3e6F+/eFbUP73p33Rv4r2P50zHBTCPu1uuFvRtru1xKrucAo9JBOSkkv/4=
X-Received: by 2002:a25:8b05:: with SMTP id i5-v6mr1232117ybl.484.1528843940454;
 Tue, 12 Jun 2018 15:52:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:52:19
 -0700 (PDT)
In-Reply-To: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
References: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Jun 2018 15:52:19 -0700
X-Google-Sender-Auth: fWDRJqH2C-3xXkYUwj44dRHO6VQ
Message-ID: <CAGXu5jJe5dy65OqmSUr6vdfsZJfoPHLH7z+Uuk3MRy+VQoSydA@mail.gmail.com>
Subject: Re: REGRESSION?: debugfs: inode: debugfs_create_dir uses mode
 permission from parent
To:     John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:40 PM, John Stultz <john.stultz@linaro.org> wrote:
> Hey all,
>   I noticed recently that linus/master (plus patches) stopped booting
> to UI on HiKey960, and I bisected the issue down to:
> 92170b62f1c1 ("debugfs: inode: debugfs_create_dir uses mode permission
> from parent")
>
> On the HiKey960 board, we mount debugfs via:
>    mount debugfs /sys/kernel/debug /sys/kernel/debug mode=755
>
> But since the change, it seems most of the nodes in /sys/kernel/debug
> are: drwx------
>
> Which ends up breaking the egl library, keeping it from loading.
>
> This seems to be the expected behavior of the patch, but I'm surprised
> the mode override is now ignored. It seems like the potential fix here
> would be to set the /sys/kernel/debug dir to 755 prior to mounting? Or
> is there some other advised solution?

This change has already be reverted from other people reporting the
problem. Perhaps the root cause is the lack of propagation of the
mode= value?

-Kees

-- 
Kees Cook
Pixel Security
