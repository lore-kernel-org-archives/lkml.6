Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E432087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN8W1PAG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E432087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeH1WdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:33:18 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44518 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1WdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:33:18 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so987475ybk.11;
        Tue, 28 Aug 2018 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kssQ/fVX4Mt4Z/D8+giv1IASl4n+kflYnJDu+1iEhnI=;
        b=jN8W1PAGslPJiaxWwjB82AfNyCVcpNiqUQrNoD4GzybgV/l86GpjlmTNrPcYTEdS+b
         fNZOSpzdugiptAPOuEfktQJR8EsRmzunS9KD66s4Ey3ya/+hDa09KrsbMjiV1Ztcp7US
         oPOF+D7SIcJj5MD8LvCtRXfFMqbWmUER8nOCE4OmUtQrSAwShrveBWrQ1x9WMIq/pJ4e
         nsVtZWdPh56BPQ+4DhTbUp5LNR9DJHJhUl7Ll1VMWTFnmyfKUli1x8YsPiHwjlOUa8DX
         b2ZpjHb51H+44m1+cZ952M2ae73oFk/lolkzlr/iaymziTVJmjnnkS4ltiZpV+OGT/vD
         e3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kssQ/fVX4Mt4Z/D8+giv1IASl4n+kflYnJDu+1iEhnI=;
        b=eq9C4UmSc/TgiyZnvpnQyhwRB+FdZi9zGADT4niwoyhHWC9t4Q/N+bzAwZYhnaBuoC
         f8E6uegprz26v+F9UT1fHD+wCl44K1xE/h+/+S7AJzZ6PZbN3OmMabkicWFkSnc0GNtI
         Ip1miu0c31pTeJxtumC7jUbl0slJ5dNAcbED+WNm9f+293n320oYpfcxYHOmQPlc5fig
         Fa251zeUjrCY6sewTqmu6ciEezjhUjos50ZplMEqr22/z1M8aPLpPioaUCxCoy6fEI5p
         sdKqRHZsQKukJ/eP3v5sZ5M9LMeTI0CJT7Tf1qMe0MSgiv1pfAFsMWweZuPoHPFSiylC
         dYWg==
X-Gm-Message-State: APzg51DY2Kc6D6w5vb9kSUZz2PwhWOxJJPaK1Lz4/qJH+qIpo6hTjH0P
        9rozLj7HgFcC/9Gyjy5FbIrVtjxZ367cxuGMlWY=
X-Google-Smtp-Source: ANB0VdZ+oPykhCgcCt+oyu/JCHw1ZXTPnnJJqQ3lfSTJaSbabgWw5yZXhubkid4Sem4A4AI5ZaObVOI1PwstgBMab3E=
X-Received: by 2002:a25:ddc5:: with SMTP id u188-v6mr1533733ybg.32.1535481622087;
 Tue, 28 Aug 2018 11:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180828165259.211474-1-salyzyn@android.com> <CAOQ4uxgwKe7_QC7Rg=BTQ_WvnAm+-kSh0LXWGVOoHHAqJt3aXA@mail.gmail.com>
 <7998ae36-662b-91f7-c42a-8a4d35d333c1@android.com>
In-Reply-To: <7998ae36-662b-91f7-c42a-8a4d35d333c1@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Aug 2018 21:40:10 +0300
Message-ID: <CAOQ4uxjU3imdxZhOS_7qCM58tFGbcBs2y2t79_owy_w8oxnnzA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] overlayfs: check CAP_DAC_READ_SEARCH before
 issuing exportfs_decode_fh
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

On Tue, Aug 28, 2018 at 8:44 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 08/28/2018 10:34 AM, Amir Goldstein wrote:
> > On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> Assumption never checked, should fail if the mounter creds are not
> >> sufficient.
> >>
> >> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> >> Cc: Miklos Szeredi <miklos@szeredi.hu>
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Vivek Goyal <vgoyal@redhat.com>
> >> Cc: Eric W. Biederman <ebiederm@xmission.com>
> >> Cc: Amir Goldstein <amir73il@gmail.com>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> >> Cc: linux-unionfs@vger.kernel.org
> >> Cc: linux-doc@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >>
> >> v5:
> >> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
> >> ---
> >>   fs/overlayfs/namei.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> >> index c993dd8db739..84982b6525fb 100644
> >> --- a/fs/overlayfs/namei.c
> >> +++ b/fs/overlayfs/namei.c
> >> @@ -193,6 +193,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
> >>          if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
> >>                  return NULL;
> >>
> >> +       if (!capable(CAP_DAC_READ_SEARCH)) {
> >> +               origin = ERR_PTR(-EPERM);
> >> +               goto out;
> > Which branch is this works based on?
> > I don't see any out label in current code.
>
> <sigh> I can only truly test this on 4.14 (android's current top of
> tree) and on Hikey with that. Lack of due diligence for Top of Linux.

Well, not sure how that review is going to work out.
anyway, this case should not return an error.
returning NULL should be just fine.

> >
> >> +       }
> >> +
> >>          bytes = (fh->len - offsetof(struct ovl_fh, fid));
> >>          real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
> >>                                    bytes >> 2, (int)fh->type,
> >> --
> > Please add same test in ovl_can_decode_fh().
>
> Ahhhh
> > Problem: none of the ovl_export_operations functions override creds.
> > I guess things are working now because nfsd is privileged enough.
> > IOW, the capability check you added doesn't check mounter creds
> > when coming from nfs export ops - I guess that is not what you want
> > although you probably don'r enable nfs export.
> NFS export/import blocked on Android devices.
> > Thanks,
> > Amir.
>
>
