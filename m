Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6260FC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D361205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d20+q73u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D361205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeG3Tir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:38:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55724 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbeG3Tir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:38:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so299330wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iA49bsGEYWaVednDy8fMlMTrm9jlxQiKn4iQ+EJVW/k=;
        b=d20+q73uJgdCy2I6HOSHfVR2WTE8BShmJKHdkE/5feu4Us2PaIYGqZYdhkjQFR4Wpe
         /S8WLbPhbYbD6CBzp/Qj2LiTBQsfLWKQcCL7LN5Toxuf2yN6qrUthmuw+3p1LPX7oxId
         Keb95Z89tDOD/SPsZSsZE5Jh94dhPux9S+rgEOCJPFwAA/VTQlpSYQh5VDI2wLx4qxV6
         gtp9Bj3828ccfJ6XoDzQbKMq7p3/CcjhUH4Ci5Zavu0JZHploGmVIsDR3J8KIbNFSF/m
         0lhKJ1e+8LDF2iRe9TXkI9IMzoAlNsfg8pTp47Rl95vbO9vxwW79TSDpes1qvF07O9I8
         X2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iA49bsGEYWaVednDy8fMlMTrm9jlxQiKn4iQ+EJVW/k=;
        b=IHWTu8pxsnQcesytjH0pnp39Ke72vvP/1xw3bzTlM2QDuMRg5qBQmuNMUNtDCDOWDm
         ctbzIGzrdG9pHMFI06hk3XG44QzU85/KTiRJw+Nkr4QkzlKZVX+/BayX8uNQqIpZ5Fma
         RsItzW4+vMYJG2o0zXJLv/wtCfXEbVbzNIwQvbBATcw7qQZowV29qOwjMA+R8JxGLuix
         xOfrkl6mClPTnv73IjI/+4KoTIamEaIEY4MMVRTwuPaa2vVQh5hwxTJO+eGrE38PWF5U
         LoKaCIEKh+OQYuZDrI/RTGY96XdhofNJzszxTxYL1myjD0Unler9C6LrtJMYB00UAIbd
         T/+g==
X-Gm-Message-State: AOUpUlH9zPwG48nY6ScAdQupMG7epbDRq0WKRQMZ3EVnOtO9XTazwvF9
        /koedI9DVc1H+oDrbbTzY8DNCpzrTJIOBLn8maHIGQ==
X-Google-Smtp-Source: AAOMgperA//O5S2jHAshnBaAJm00w1GmC+/uUEWVxv09Z1h9lTU+iRkNR83z8YDpf7YgsdtJMqddCzNo2icCYEMiJSE=
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr211526wmd.142.1532973756539;
 Mon, 30 Jul 2018 11:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180729193646.201721-1-toddpoynor@gmail.com> <20180729193646.201721-5-toddpoynor@gmail.com>
 <CAE_wzQ_vRx6BbidM==ryBh0+4t+FHJg4-55XDHJjm1=2VfMDMg@mail.gmail.com>
In-Reply-To: <CAE_wzQ_vRx6BbidM==ryBh0+4t+FHJg4-55XDHJjm1=2VfMDMg@mail.gmail.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Mon, 30 Jul 2018 11:02:24 -0700
Message-ID: <CAAW3YpZMb3GkUBZ2ytN+KhUYDZOB44upCmWs2frYQ30RkDCLbA@mail.gmail.com>
Subject: Re: [PATCH 04/13] staging: gasket: core: allow root access based on
 user namespace
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,
On Mon, Jul 30, 2018 at 10:57 AM Dmitry Torokhov <dtor@chromium.org> wrote:
>
> Hi Todd,
>
> On Sun, Jul 29, 2018 at 12:37 PM Todd Poynor <toddpoynor@gmail.com> wrote:
> > @@ -1064,7 +1067,8 @@ static int gasket_open(struct inode *inode, struct file *filp)
> >         char task_name[TASK_COMM_LEN];
> >         struct gasket_cdev_info *dev_info =
> >             container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
> > -       int is_root = capable(CAP_SYS_ADMIN);
> > +       struct pid_namespace *pid_ns = task_active_pid_ns(current);
> > +       int is_root = ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN);
>
> ns_capable() returns bool, why did you make is_root an integer?

Gaah, I forgot to change the type of the existing var.  Will fix, thanks -- Todd

>
> Thanks,
> Dmitry
