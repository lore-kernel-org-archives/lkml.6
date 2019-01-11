Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D0420874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJ7W4Kfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfAKGNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:13:24 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:42586 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbfAKGNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:13:23 -0500
Received: by mail-pf1-f175.google.com with SMTP id 64so6453462pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 22:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Y+hx95wNwvvnHrz1TzVAbOiSXn47Osrjx4hOYYqb5z4=;
        b=kJ7W4KfyAWwkPECg+/UQ4InOjfWsTWRJQR00VfZc5I27/3/U6E46KzTfTXpNks+Akp
         B+rF+ZX14p3yYQsuVlWMWPVIUWl8as2XAE4LGyvRxUxpjyL0neU4dsgX7BhHMf/4VohB
         NYzZP5iJw0JWL8RqXoV1st+WMGIi8idoSY9HFDQIza8iZcMCJxTEh0njybMYGqv892AU
         8eYEg5uXfnmhgutY7qoFfYkJP3F6Tqh13/4g7qxKwDiEvYKaW80GA6ANDsHe7aUc4oHp
         J+Y8FII7p0bKBwcV3H7wSbAT1qjSh8BVbOt9DAsb5EhrIQhW147GCpk6nGTVDwgk0kw0
         5iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Y+hx95wNwvvnHrz1TzVAbOiSXn47Osrjx4hOYYqb5z4=;
        b=YDABKLtsOdMOkNmzke5st6I+BIocT34IWvG7XM7O3bjbsGDgUP49w4kPphg+iHj9rq
         uxpWXp0Nkp3srRWiU1SqA3gvg8HpYxZNuD6piwPH+fIv8mhfOjktMvWZfQvhSZBwJvpH
         hOp+FHt4ymJI5GrHJpeFerh5vVCWpbc/KcyJoVlBdzpvQoyV3FdqKAx8Cy3R1fbDDP2Y
         iPBQbKtu/dcKvGHoC6i6InjM+W5O2oeu+I6GzYwJuX66iH36Yg/BfHQi3nKEVADmwjNF
         H+4MJQOxR4hpWb5RREX4sM9rJp/+mB7NlbIzPFyTuzTwBQwqmuL6PtJJmVBPu5iSU1my
         p6GA==
X-Gm-Message-State: AJcUukdEtofH3lzgNmIKJMp11tqR1MjFswVJ7CHPvpfHYcwE0ycQIwFu
        TNvX9eVBAP8kJRZYObQLmsA69EwEiaTXqe+rLovafA==
X-Google-Smtp-Source: ALg8bN75f/x1zJNLoct+z9jfEYWsXHsefB6YB2Hhy6XgIVLy/m8dtcI6x0aphLYI7EBqmqRARkh5pnRRhUSGgfGNeYs=
X-Received: by 2002:a62:528e:: with SMTP id g136mr13885239pfb.111.1547187201753;
 Thu, 10 Jan 2019 22:13:21 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtQTu1mwh0Zpep71A5oHHYboLv5qD=8n_LeASzmncNx4g@mail.gmail.com>
In-Reply-To: <CAH2r5mtQTu1mwh0Zpep71A5oHHYboLv5qD=8n_LeASzmncNx4g@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 11 Jan 2019 00:13:10 -0600
Message-ID: <CAH2r5mv6KN+3_wjfAjawA8yfqGefA2fa_HkbU7YMovGg_jkYEQ@mail.gmail.com>
Subject: Fwd: scp bug due to progress indicator when copying from remote to
 local on Linux
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Steve French <smfrench@gmail.com>
Date: Fri, Jan 11, 2019 at 12:11 AM
Subject: scp bug due to progress indicator when copying from remote to
local on Linux
To: CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel
<linux-fsdevel@vger.kernel.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, Pavel Shilovsky <piastryyy@gmail.com>


In discussing an interesting problem with scp recently with Pavel, we
found a fairly obvious bug in scp when it is run with a progress
indicator (which is the default when the source file is remote).

scp triggers "SIGALRM" probably from update_progress_meter() in
progressmeter.c when executed with "scp localhost:somelargefile /mnt"
ie with an ssh source path but a local path for the target, as long as
the flush of the large amount of cached data to disk (which seems to
be triggered by the ftruncate call in scp.c) takes more than a few
seconds (which can be common depending on disk or network speed).

It is interesting that this can be avoided easily by running in quiet
mode ("-q") which disables the progress meter in scp, but it seems
very, very broken that scp of a large file can 'fail' when using a
progress meter (unless caching were disabled on the file system) due
to the slight delay in ftruncate due to triggering a flush of a large
amount of cached data to disk sequentially.

Any thoughts of whether scp is actively maintained and best approach
to fix progressmeter.c so it doesn't break on Linux?

--
Thanks,

Steve


-- 
Thanks,

Steve
