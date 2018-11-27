Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D32C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7196120659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT/lTESE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7196120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbeK1DLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:11:39 -0500
Received: from mail-yw1-f45.google.com ([209.85.161.45]:43979 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbeK1DLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:11:38 -0500
Received: by mail-yw1-f45.google.com with SMTP id l200so9349883ywe.10;
        Tue, 27 Nov 2018 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SjhL4qRVC+Mest7RQXv2ES6uVhl8yrirettrMw3rj0Y=;
        b=XT/lTESERXIzU/wj9XMhoRy4/z9oZxRjCHmCyi90IHs6ytRJ/ijohrSqmx1MVmuHJ7
         irwyqQ2h7JYl8JAYUAvl0fDAkC0cjheXQsJOBdtfiH+D3b7fzsXuYG8ifzRQg35R38Ut
         bXU60xzWwXvzbhPSvaSm3dYu7baSm2R+QFwjQ9GyfCzjnP8kVuleUoOnkJ4ukDdzSKVd
         ndUYM/wQj3InKiySKU82NA3rTGVMMtd4zaG6DTiUggmCX+Rk7FlyrteB382Yqos/bwLh
         j8CDOcQO4ImdJ5qQGvWOp10al5AcR/nB5Lz/lNo8znXSJm5MftnAs8FdYrA2ucuhu9Ge
         L/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SjhL4qRVC+Mest7RQXv2ES6uVhl8yrirettrMw3rj0Y=;
        b=ZiPIhJYA6lE3Q0Us7peFlGvHwcVLeuVsnN11LZMPt5u+OG9WWrVgP9n0EKiUS2S/0Y
         ztF1VEpquCARaQRQfN0QmZbDjY33WQdTpDKaIY5xGv97YhzXgOJYaKd7PcedemZyKB5o
         o7wFxlOLnJlOEP/P0BmV0FNnvOXTfrsXXtU3MR8s17RVc+ALpiB7uhbOCGlXXS9XDANE
         /vuDlmFcBg9lpKfraLly3JQH0UmscS+4G0FrItRzw/+4hMOfVklgxjzs/4G3mIHOrV/1
         B20inPAu3WzqjRPYt1X1MsSgT9YVGBaFQi+u1IIrzFRdtZaQ4/Cdh0Ge+EuAc+Gaebdl
         nqoQ==
X-Gm-Message-State: AGRZ1gIfw+ztwR1/8WLhhCb/cUhqjS04D6mJOqc3ZpyD7r9VAGUG7nTN
        np0i5emfw/2oxCnlrm9WjMpQKx8npZhvhB6CVj0=
X-Google-Smtp-Source: AJdET5e0cp2DbM/0ARB7A8i1/lcJx4zz8EBtRyya5US7is994JA/cGyV3FpiU3FURwWYG80CzQKLcRQsFOO79pws98A=
X-Received: by 2002:a81:6fc5:: with SMTP id k188mr33341763ywc.211.1543335194942;
 Tue, 27 Nov 2018 08:13:14 -0800 (PST)
MIME-Version: 1.0
References: <00000000000074e10d0576cc48f1@google.com> <0000000000001ec857057ba01589@google.com>
 <CAOQ4uxgiERNAyX4PDHf1DQLBg56rBANWLe575TGkz_WpbxaoCg@mail.gmail.com> <CACT4Y+bkAcCcy3p-iKe4jAzA=ZOk-WmbZrD0yOG96sjA7o-cXA@mail.gmail.com>
In-Reply-To: <CACT4Y+bkAcCcy3p-iKe4jAzA=ZOk-WmbZrD0yOG96sjA7o-cXA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Nov 2018 18:13:03 +0200
Message-ID: <CAOQ4uxhjFjeQ6m6c84Hv9V73brMKEOFNsg3Q1Kjb3resSdDjyA@mail.gmail.com>
Subject: Re: possible deadlock in ovl_write_iter
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+695726bc473f9c36a4b6@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This looks like a false positive because lockdep is not aware of
> > s_stack_depth of the file (fs) associated with the pipe.
>
> There must be some annotation to tell lockdep about this.
>

It's a long story that can be summed up as "not simple":
https://lkml.org/lkml/2017/9/21/63

Overlayfs annotates inode mutex in lockdep friendly manner.
This is why you see:
 (&ovl_i_mutex_key[depth]){+.+.}, at: inode_lock

But this does not extend to other locks that may be associated
with filesystem or blockdev objects (e.g. pipe_lock()) and does
not cover the case of stacked blockdev (e.g. loop).

Thanks,
Amir.
