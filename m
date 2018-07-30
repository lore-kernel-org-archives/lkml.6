Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0020892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 05:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxc+iWSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F0020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeG3Gmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 02:42:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43709 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbeG3Gmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 02:42:31 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so3921682ywb.10;
        Sun, 29 Jul 2018 22:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DDbeRSdBESC4S6XI8kZ5Hr6zRe/i29V2TAVsg1s+3Ak=;
        b=Jxc+iWSFmGKzNUz9NlvjFtijk6mGeUIaxmgrMRia0uLGaabL+xlsvOtGKGmBMdjuZj
         3OG3xW3guHJs+TbjRrdZLNB/V9be01z87zOg2q47hL8LIurOpvv6bNnavmUx6I4kO/MW
         JDK+9HcbgbGcxoHsumYSDQDueKgjRfDVKXHCIgUoUnWTuT0FHfZBl0cbA9rzh3RjB1S1
         Now3zlBdnXTb1MlUshzoMpzBWJkXb7vIX2F7tBWbALQJ5lTaZ2kX0E1QHHEuZ+S2mz6I
         3shuThtwhHW/tvWotbxXtIaO3Qm5UiFjI43TtEFDpYrYPPTldDDximoM0iDgxMLwBo1s
         bfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DDbeRSdBESC4S6XI8kZ5Hr6zRe/i29V2TAVsg1s+3Ak=;
        b=t1PboJHGDGl4g4GEipNajAwZA5c0HjX37hDBi6BJ/RYpjkuCGcnVMDvnZRa6kz8lQd
         Z357NK41LTMRUbnYyJSFtm7377Mwc8zbOvitw/DJSUht31d3g+okvbROTXrIFU8HgPvP
         CDBOSrqaws2OpWSx4uOvYt9AAP+qGRU+i6elPDWUjamyaBxoRgma+mhdRgf/s7EU3SFA
         ItiTJvaru0bEedSx6xce1KiSBevd4R/ly3rtzG3DSFVRMYWsxsfKy4JFSV7fxx3evVB2
         zriGlWTiCOPGk0OCaLTXAm5EflVe7hDm00O2OEV8G13fbuoxZona7gKqlF3lzUkYVhwb
         1ZrA==
X-Gm-Message-State: AOUpUlH8pEPL2hCK486lwvQRJ7fFTkCEck8wKfxNPbkP+OtOM050Zkdy
        yiT7ivUm/6ei1GNl4hc2c1egSBTPCUhMmb2M0Rg=
X-Google-Smtp-Source: AAOMgpdW4MngN1IsXa6qv/F2gUsmk6DmSSn6T1S1Kn8nousQQAoW4ZlxvxR7IeLpyE3Pt1T/UGK6PI/ADcP21QmwjAg=
X-Received: by 2002:a81:2cd4:: with SMTP id s203-v6mr8300444yws.294.1532927360030;
 Sun, 29 Jul 2018 22:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:7dc5:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 22:09:19
 -0700 (PDT)
In-Reply-To: <20180729220453.13431-3-viro@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk> <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
 <20180729220453.13431-3-viro@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 30 Jul 2018 08:09:19 +0300
Message-ID: <CAOQ4uxgOLEpaZ=UwA_CG6CzYbsJBPV4unEV9D5mXrooLXO0+0w@mail.gmail.com>
Subject: Re: [PATCH 03/16] vfs: don't evict uninitialized inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 1:04 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> iput() ends up calling ->evict() on new inode, which is not yet initialized
> by owning fs.  So use destroy_inode() instead.
>
> Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
> that it wasn't allocated with new_inode(), which already does the
> insertion).
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")

Backport hint: this patch depends on the patch ("new primitive:
discard_new_inode()") currently commit 22dc9a168272 in Al's for-next.

Still trying to figure out the best format to channel this information to
stable maintainers...

Thanks,
Amir.
