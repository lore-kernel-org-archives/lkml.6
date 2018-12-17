Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC142133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="Q1QhirB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbeLQOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:06:24 -0500
Received: from mxout1.mail.janestreet.com ([38.105.200.78]:48252 "EHLO
        mxout1.mail.janestreet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732411AbeLQOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:06:23 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 09:06:22 EST
X-JS-Received: from [30.32.81.38] (helo=igm-qpr-mailcore1)
        by mxout1.mail.janestreet.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <cperl@janestreet.com>)
        id 1gYtRj-0006Ww-Og
        for linux-kernel@vger.kernel.org; Mon, 17 Dec 2018 09:00:35 -0500
X-JS-Flow: external
X-JS-Received: by igm-qpr-mailcore1 with ocaml/mailcore/main_production (71f307ccacc9)
        (envelope-from <cperl@janestreet.com>)
        id BcF6wD-USseQA-XS; 2018-12-17 09:00:35.755206-05:00
X-JS-Scanner-attachment: No attachments
X-JS-Scanner-esets: Not scanned (internal mail)
Received: from mail-it1-f197.google.com ([209.85.166.197])
        by mxgoog1.mail.janestreet.com with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        id 1gYtRj-0008PA-MC
        for linux-kernel@vger.kernel.org; Mon, 17 Dec 2018 09:00:35 -0500
Received: by mail-it1-f197.google.com with SMTP id w15so14802486ita.1
         for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=janestreet.com; s=google;
         h=mime-version:references:in-reply-to:from:date:message-id:subject:to
          :cc;
         bh=019V1mpopS8WJr8aJzk2ltcywzun5LHzLWW2me9IeaE=;
         b=Q1QhirB4O/0f+w2W+SedMUISkga5TAJd7j5WWPmuBv2dQISm8qmDx3Zq8JSQoniydq
          R/kCrKfB0JTHT6/zNCrOqdXSe8fen7EVP9UkJrZ98a7ElDJ7ofForQx/+3j1nsS9GqME
          YN3PspKguuLQ3aKva65qWTFLu3UXMosRQy7hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
         d=1e100.net; s=20161025;
         h=x-gm-message-state:mime-version:references:in-reply-to:from:date
          :message-id:subject:to:cc;
         bh=019V1mpopS8WJr8aJzk2ltcywzun5LHzLWW2me9IeaE=;
         b=aF2XE8GEofVfIStkDNRuiK8FoyYTSlNCb+W5YMmMEuo0hUTbI5qQ1jYd6i/PXPDhcF
          rFF3t/ts4Zjuu+dG/MYpLRDa/fFqCc0i9k6ioyyZKviduO1dXMBX7rUKRC/mK+lygIig
          flhJaoMIBzqqFzkJZU8QxKXFLaEGPnlmHv77IRwZKRzom+8v4EH6wttLKnQLf5wz2mfa
          Qsy7bpQytb4FKqJvp23Q5bBV+ZCQAik7BfnaqRsWPkfXUHZ/Ei72jL5/9atzSctHkHda
          0XMVBxj+dypCx7JVVweV/C5J5LEg10CwKW+uQn7PMf31lRirRVFrF5zMOZkc71njXvPx
          bxOQ==
X-Gm-Message-State: AA+aEWYKhg7q2b53LFzRY0y9pP/w+3D4iLbpI+4iQMmXWKWd60MiR+L1
        bDp+xpQwte3cPxd/iiDdRqNYHAjEDd9fky6QMcX2KPlcP0zXfyiuWkRi/7nN3MjK0K7CEJIXwUW
        mosZoIUOacUjgWrZI9twLOl3Od2fdOBzvkJKeT3Y=
X-Received: by 2002:a24:eb0b:: with SMTP id h11mr12115560itj.138.1545055235206;
         Mon, 17 Dec 2018 06:00:35 -0800 (PST)
X-Google-Smtp-Source: AFSGD/USQvfWKbddzDTje+CUzwIO0bk7HgDUKibRRw//G8Ph6sDyR5GOiMggZvigq/zoC4M/oor+c/1+rj5CZHAINSA=
X-Received: by 2002:a24:eb0b:: with SMTP id h11mr12115527itj.138.1545055234848;
  Mon, 17 Dec 2018 06:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20181216171933.2e4f5be6@canb.auug.org.au>
In-Reply-To: <20181216171933.2e4f5be6@canb.auug.org.au>
From:   Chris Perl <cperl@janestreet.com>
Date:   Mon, 17 Dec 2018 08:59:58 -0500
Message-ID: <CAAih9mj+u8Ec6=3K53_x8S-tHz_dXHORMfqZWsAnMS1WLzgz-w@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the nfs-anna tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-JS-Exim-Data-Received: 2018-12-17 09:00:35-0500
X-JS-Processed-by: mailcore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 1:19 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
> Commit
>
>   748d6fd8d297 ("NFS: nfs_compare_mount_options always compare auth flavors.")
>
> is missing a Signed-off-by from its author.

Whoops.  Sorry about that (I forgot to run it through checkpatch.pl).

Should I resend a fresh patch with the Signed-off-by included or is it
enough to just assert in this email that I wrote it and have the right
to pass it on?  If the latter is sufficient, then I do assert those
things.  If not, I'm happy to resend.
