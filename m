Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B453820883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzgDnZQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfAHRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:46:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38914 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfAHRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:46:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so2266779pfc.6;
        Tue, 08 Jan 2019 09:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/L9ECOJ+gNVi0fZmY/qUbjZOZMDvIrDn1W0N0mBT8k=;
        b=ZzgDnZQtTTbfAFlh4Fj8/fXqYdu8R/tn5lCf3iPAbgqot9QnTJ3jiK2BiYOl7AV/lv
         +zxUQTljv8iomevul5pmfrMntq97P7N4tHT92PUCiKZh8mJwylmAHbByqn/JEuDoi6eV
         lBCPtI6wDhiE3Pt14va2xQFYBSR+chYTxDZQJuKTl/9lG6d/ZuEGctxc7ATBW892SbDt
         VM4DymMH4S6J4MeTSyGM4j7p776JVXgqnAid0dDI/32r9WbHyPhYvV2kLSDDgnwnm1Zo
         WkQT39EwYSOpHqwaJ6gEZy9obY6lwVjdK/x2qewdAVa0dd3GbZgjPzWEsCu3Xg0Tkapi
         xc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/L9ECOJ+gNVi0fZmY/qUbjZOZMDvIrDn1W0N0mBT8k=;
        b=rK7pGa3oogAiNSt811aYCeQsaFG8SP7ktqvhBYaCPWy3LV7OOXv73TPvuhj9A/CCpg
         NKmCUh56lCmJ2vw9C1sHzwpxtPvv8ZALrtgLm0CzdSRReR5e9bPs3LcXEQHMXJ9pC9WA
         KSQMAAFp6RCkF28N7AyEmZ3sUhofvtNvKojezr/5fFDWsyAE2+VSzUpXxXF3v8247xB3
         PZ6Q09azbMwksK65mCf8Ezd4jox/bdf4pxG1niuUvxGl+GZXZibeeED8QjpDhY4mCII1
         wcO6R1k7+xcMkC/e4ZOhB0Z3aCNkYvr9zAKOWJGAvxj4EC9qQQakHtlTDRsQQFwIH/fb
         /5IQ==
X-Gm-Message-State: AJcUuketwlsfKLZKW8e909hpBBncE6+sGEqZQ6Ci9S5OcH0dGrMoy0qz
        ejrNSTqSbVTDt+cUgd9W9zb9xOiB8s289J8j5/4=
X-Google-Smtp-Source: ALg8bN6+q3ztn4hEo3se6tgbt7vajJ4ITl+PgRK/nhOctnWF/alxP/cdjYKzrXg32YNtIE2p4hHEIr05TNq1mzfqeQw=
X-Received: by 2002:a62:8985:: with SMTP id n5mr2668133pfk.255.1546969572046;
 Tue, 08 Jan 2019 09:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20190107171515.4537-1-colin.king@canonical.com>
 <20190108094249.GF3200@kadam> <2f01add7-06f0-e312-2018-18b056405d6a@canonical.com>
In-Reply-To: <2f01add7-06f0-e312-2018-18b056405d6a@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 8 Jan 2019 11:46:00 -0600
Message-ID: <CAH2r5mtR_uoe8ovH=+RBSbS0oRFO7OS-kGwG6n6RBvQfgXaKGw@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix memory leak of an allocated cifs_ntsd structure
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes - good point.  Will back this out temporarily, and also update
Aurelien's (unrelated patch) to the later version

On Tue, Jan 8, 2019 at 3:52 AM Colin Ian King <colin.king@canonical.com> wrote:
>
> On 08/01/2019 09:42, Dan Carpenter wrote:
> > On Mon, Jan 07, 2019 at 05:15:15PM +0000, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The call to SMB2_queary_acl can allocate memory to pntsd and also
> >> return a failure via a call to SMB2_query_acl (and then query_info).
> >> This occurs when query_info allocates the structure and then in
> >> query_info the call to smb2_validate_and_copy_iov fails. Currently the
> >> failure just returns without kfree'ing pntsd hence causing a memory
> >> leak.  Fix this by kfree'ing pntsd before returning.
> >>
> >> Detected by CoverityScan, CID#1457059 ("Resource Leak")
> >>
> >> Fixes: 2f1afe25997f ("cifs: Use smb 2 - 3 and cifsacl mount options getacl functions")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  fs/cifs/smb2ops.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> >> index cf7eb891804f..6d71958ad2cb 100644
> >> --- a/fs/cifs/smb2ops.c
> >> +++ b/fs/cifs/smb2ops.c
> >> @@ -2238,8 +2238,10 @@ get_smb2_acl_by_fid(struct cifs_sb_info *cifs_sb,
> >>      cifs_put_tlink(tlink);
> >>
> >>      cifs_dbg(FYI, "%s: rc = %d ACL len %d\n", __func__, rc, *pacllen);
> >> -    if (rc)
> >> +    if (rc) {
> >> +            kfree(pntsd);
> >>              return ERR_PTR(rc);
> >> +    }
> >
> > This is a layering violation.  The memory was allocated in query_info()
> > so it should be freed there instead.  Also if the kmalloc() fails in
> > query_info() then it should return -ENOMEM instead of success.
> >
> > This only affects code which calls SMB2_query_acl().  There are two
> > callers.  You have fixed one but the other is also buggy because we're
> > returning uninitialized memory in get_smb2_acl_by_path().
> >
> > regards,
> > dan carpenter
> >
>
> Eep. very true. NACK to my fixes and I'll sort out a correct fix later.
>
> Colin



-- 
Thanks,

Steve
