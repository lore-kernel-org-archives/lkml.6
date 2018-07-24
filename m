Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A1C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FB520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNJtS9MV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FB520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbeGXXb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:31:58 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39835 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388769AbeGXXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:31:58 -0400
Received: by mail-it0-f66.google.com with SMTP id g141-v6so6004984ita.4;
        Tue, 24 Jul 2018 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xUDpSBM2EdFxS9dHlUcgbHy5cIdVX2aicOwRIlVd034=;
        b=sNJtS9MVsrcM/oJLHB1OSBMpo+nANTiVXAlOAbsrip8mJtzvfr4nxLQMKvH/QADX3T
         J4tJP/gUNvKtjZ6sintjw2LJczHhzLG7C5a0v/pgDTln1HAvybPJ7ZKejN3//rbXzF6+
         S2g6ONG/iUD7DZrI9W1tOrVvBBqzAydtPedUqh0hGzAwqPvkAwt3UoKxosxfrt9CmID9
         MSbGaQeFPg/qcJE0pVvrnzLV0/KkduOctaC6wqr9SrhsIVzJgKEuSIfZAV33Rdq6+6zW
         WwqGzsJRsW90xpRJ1DSKPYEJKYIn+WuvzCRF0lDDcib6Qz5R+1hRA2SeinuOEI6G6CJP
         HrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xUDpSBM2EdFxS9dHlUcgbHy5cIdVX2aicOwRIlVd034=;
        b=MYaUJXiGRmDpGBBJftkeGRbpsOhXA53Hzt6hyRboNB3lqcj+yfwLeFC6LqtNnxLD9/
         oml9LPXAUb8SRCRDqy+JumVdwYhhI+4Y64zvEO5qXetx3RoGCFqtY7Y9QtBaeUfSQyq/
         30Bp3V4lzdrWAzp9Blj9yfUXHi6VoRBqxfzJwvTcnySACEboljf9UzUAinMVgqttwvOH
         aqMwxJ/KxoHc+VjFUeTSp+ZGd6O1EaqhSzuSDc96K8Rj15ZdYf4ceAv/6b7/UwAwcKGm
         SVmjJMso2t3GV/xqMZ62jRl3T2SfpSziWwmiKY4hwA66YlJBnbzJUSn8J9/IV4I8GS99
         OHSg==
X-Gm-Message-State: AOUpUlHCb7LDphzS8cbSAHSQHVFk5kZbAJ/p8TfxtK2L4Y0Zx8xPxsnw
        f9ABMzVFIQnwIOxwpwCcXWK5uUvoJqzHiBJUjJ0=
X-Google-Smtp-Source: AAOMgpcSrHvKmTjOlk3HI6CsMPawVaFoeyeF/cqDzxUZgJzgapqWvlWsyfHEHWZFmwAFUVnKh286aZUG4kBCm1cAjvI=
X-Received: by 2002:a24:130c:: with SMTP id 12-v6mr4475602itz.35.1532471002431;
 Tue, 24 Jul 2018 15:23:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:a887:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 15:23:22
 -0700 (PDT)
In-Reply-To: <20180725080130.314f62bb@canb.auug.org.au>
References: <20180725080130.314f62bb@canb.auug.org.au>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 25 Jul 2018 00:23:22 +0200
Message-ID: <CAHpGcM+WkOKkd+GLMiTWsvnLA_daY_5pBfSQp_KYoPVcRQQHGg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

2018-07-25 0:01 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
>
> Commit
>
>   b6fbc2f6a686 ("GFS2: Fix recovery issues for spectators")
>
> is missing a Signed-off-by from its committer.  It was rebased.

thanks, I've fixed it now but this is getting rather annoying -- and
it must happen to others as well. Do you happen to have git hooks that
prevent this from happening?

Thanks,
Andreas
