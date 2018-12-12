Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C26C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368C920849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ryM1XAhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368C920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeLLNEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:04:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36511 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLLNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:04:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so13473579lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFPOOo4N1Ymi2R/6kUHq8h0ylx9W3wbhBSYt0UWRTLs=;
        b=ryM1XAhgRdMnRywaFP2Pm+4PDxrBEr5zIFrvuMmjvJlVzkOWmJhhSx8oxg8l+1ThHE
         m53mBrYjrNsORs9ii0otT3DvE3o/QIt3sUzlca3C1dVWsFBIDjFHeg4Zlnq54EEyloB/
         KvJ8gSj1cY5VDPU6XFRKq5PDtY/ByFv1MQ8OevF3V0c5T+IgZqhceRCSy3T6UpD2pdVg
         bkF/GI+m8xUSCgwqgqkojZlhTlsgC5lQldVaqEH/xvXphijlLqPzrm0pcim7ZSV2Dboc
         P7zJcvgF7TqE0K8Vzw0a7ivpyjsXyBmrSBbMjuB9Pqcri+FdGAAEI2ypcMSR14P/nGOJ
         1+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFPOOo4N1Ymi2R/6kUHq8h0ylx9W3wbhBSYt0UWRTLs=;
        b=kLSSxAuzCpl2zdDh4UwqNpP2v0z/x/82MKDBcHHXhBZmuIEltvf4JxLKlfrmcz347l
         oCTbRNkNxYgCdA9OYC3BmKg+ZKOfc6zQYan2mQtB48OmRfPNzL1XkfHlF02dbPZnrHrM
         sNiPN1DBJ44uYCKjGHnKuJ2dVeg/4KpxaxZNLcdmi72uwv5ig+jlIU9JFSaMOXoCqfQ2
         E0vkzEDQxbl8e9aed5zCEcKnbXViDPkQfJ7ewKUSf/iRYMwvt+6s0TgWkC0JHaDAMuiO
         uw92kH3lzo59Od0zV6a+5WCuVFfNmX7asAowY+MuOqYZzn0e8kU8IUfTJGXmCYKN7ske
         zRVQ==
X-Gm-Message-State: AA+aEWbbVa82WYXLAz6rbmA08hX9ogmwCTU1Xj1T8jEVBYehUv0z1a4J
        zkOlaFPyZmgOtJq7cwTjLSFLI99Vl57xuTfoBuR3
X-Google-Smtp-Source: AFSGD/WPx/aDZZHU3dsFIRiu+zo5QSfc9IajCtBI2PrqgvOH3h9O+996T+wQQX4RhC/T5ux+BrqmS+BvXLWDkE7y6/o=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr11025591lfe.4.1544619839305;
 Wed, 12 Dec 2018 05:03:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542149969.git.rgb@redhat.com>
In-Reply-To: <cover.1542149969.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Dec 2018 08:03:48 -0500
Message-ID: <CAHC9VhT8iFLSXJBvocg_aPeveBy0hZ4bxZ547ufbUsTnkONpZg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak100 V1 0/2] audit: avoid umount hangs on missing mount
To:     rgb@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On user and remote filesystems, a forced umount can still hang due to
> attemting to fetch the fcaps of a mounted filesystem that is no longer
> available.
>
> These two patches take different approaches to address this, one by
> avoiding the lookup when the MNT_FORCE flag is included, the other by
> providing a method to filter out auditing specified types of filesystems.
>
> This can happen on ceph, cifs, 9p, lustre, fuse (gluster) or NFS.
>
> Arguably the better way to address this issue is to disable auditing
> processes that touch removable filesystems.
> Please see the github issue tracker
> https://github.com/linux-audit/audit-kernel/issues/100
>
> Richard Guy Briggs (2):
>   audit: avoid fcaps on MNT_FORCE
>   audit: moar filter PATH records keyed on filesystem magic
>
>  fs/namei.c            |  2 +-
>  fs/namespace.c        |  3 +++
>  include/linux/audit.h |  8 ++++++--
>  kernel/audit.c        |  5 +++--
>  kernel/audit.h        |  2 +-
>  kernel/auditsc.c      | 29 ++++++++++++++++++++++++++---
>  6 files changed, 40 insertions(+), 9 deletions(-)

Just to get this out of the way, don't use "moar", spell it properly.

Beyond that, it's not clear to me from your cover letter if you are
proposing these patches as an "or" or as an "and"; assuming the
patch(es) are reasonable, do you want us to merge both of these
patches, or only the one we like the most?

-- 
paul moore
www.paul-moore.com
