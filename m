Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E40C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9405C20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLFV1x9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9405C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeKFEQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:16:53 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33298 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFEQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:16:53 -0500
Received: by mail-yw1-f67.google.com with SMTP id z72-v6so4115604ywa.0;
        Mon, 05 Nov 2018 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYpnT5Aw/voFUXbalJP+VVpRDZL5f+GJ6XVIUU0XzQc=;
        b=uLFV1x9bqKSkn8wx99aKsCtKj43N0txg0Ci7cJaXBZ2Ze4x0i7HveORSMKHuP0v9Sl
         /YjUFpTeAnq/Q6Ze9Hvg79vNCUzI2KC/ZtFYYI3hB00Cu4AFksUlvSJxYVuu9iD+xW9R
         arERh53lCBYFauD+S9lqL7hm1PspfpOC0Zewu1ykA0vvPd+IlqJqIn1+w+T5GULvEgWA
         gFApzwh1hbtZ2b4w3QTbGSovpN6BL0jzqhFg4SbsjmBD9qyhIzSGCvt+yfskBTimSjD0
         6sVqXTUCn1O4O/XFGQlT/8k6WRrvYo8/HhiGXXoRiu8/JbnEaW/FX2jgB1sOaML1MBWu
         kn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYpnT5Aw/voFUXbalJP+VVpRDZL5f+GJ6XVIUU0XzQc=;
        b=XCTwcBb1/N5PXeY+QgYpgkir9pl7hNhlRaq8lBfy9WfnSaIgDWik3eTzuwtFKoSz8u
         srNy03Otk8BYX/u53aNoqpVvsmi762dGiBnEw0JCtfrO2N55FWOzJFtEP9a2w2aCaO1c
         tCVYh+ab+NEn2pSJj5NBkBWV37bDmToHSaktrLJmtgdgbPZQi3lxTVVWO5/SFesw5sBr
         tkpJypQXIPZZh6QmRLHx8tP0j78eZ3ivWT6mRqe2UU6VyFKtOSglxC4AxqFrOHbo6AaO
         sDq91ri7SeMbcWpoRqpzuGxXAaRLpSbj5EESkLXv4pnUqkfi9qOdwZnmv0+FQBHRz87c
         sj0g==
X-Gm-Message-State: AGRZ1gJfsGmc3h6c1kOW7YXSrBlpr49+jOm0QL0LNtG0uxdeib2A64ug
        +iSV4gNvvPdQVf+vAwpbunRVa01tbG6kOZFfCG4=
X-Google-Smtp-Source: AJdET5fIqmYiOj2DewMIgmRJjStddlFbD3rOAV0xSVUFvtipi1LragSFkunx0wqj8Gu5whEljwhuALYKCDGwJ6J66nI=
X-Received: by 2002:a81:ac1f:: with SMTP id k31-v6mr22022192ywh.248.1541444150476;
 Mon, 05 Nov 2018 10:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20181105182146.233025-1-salyzyn@android.com>
In-Reply-To: <20181105182146.233025-1-salyzyn@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 5 Nov 2018 20:55:39 +0200
Message-ID: <CAOQ4uxiwxWDyz2yEfjcKdWK+iUEGKW4W=zoDKy2Z1xO0o7Zt9g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2]
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 8:22 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh
>
> Assumption never checked, should fail if the mounter creds are not
> sufficient.
>
> overlayfs: override_creds=off option bypass creator_cred
>
> By default, all access to the upper, lower and work directories is the
> recorded mounter's MAC and DAC credentials.  The incoming accesses are
> checked against the caller's credentials.
>
> If the principles of least privilege are applied, the mounter's
> credentials might not overlap the credentials of the caller's when
> accessing the overlayfs filesystem.  For example, a file that a lower
> DAC privileged caller can execute, is MAC denied to the generally
> higher DAC privileged mounter, to prevent an attack vector.
>
> We add the option to turn off override_creds in the mount options; all
> subsequent operations after mount on the filesystem will be only the
> caller's credentials.  The module boolean parameter and mount option
> override_creds is also added as a presence check for this "feature",
> existence of /sys/module/overlay/parameters/overlay_creds
>
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> v2:
> - Forward port changed attr to stat, resulting in a build error.
> - altered commit message.
>
> v3:
> - Change name from caller_credentials / creator_credentials to the
>   boolean override_creds.
> - Changed from creator to mounter credentials.
> - Updated and fortified the documentation.
> - Added CONFIG_OVERLAY_FS_OVERRIDE_CREDS
>
> v4:
> - spelling and grammar errors in text
>
> v5:
> - beefed up the caveats in the Documentation
> - Is dependent on
>   "overlayfs: check CAP_DAC_READ_SEARCH before issuing exportfs_decode_fh"
>   "overlayfs: check CAP_MKNOD before issuing vfs_whiteout"
> - Added prwarn when override_creds=off
>
> v6:
> - Drop CONFIG_OVERLAY_FS_OVERRIDE_CREDS.
> - Do better with the documentation, drop rationalizations.
> - pr_warn message adjusted to report consequences.

For future reference, the cover letter is meant for introduction,
not for concatenating all commit messages...
Not sure how you generated this text.
I think you were looking for git format-patch --cover.
Anyway, IMO, having the patch revision in the cover letter is sufficient
and you needn't bother with patch revision in every single patch, unless
there is a good reason.

Thanks,
Amir.
