Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12805C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3C62086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvQj4EyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3C62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeKSCX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:23:56 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39295 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeKSCX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:23:56 -0500
Received: by mail-ua1-f65.google.com with SMTP id k10so9887079ual.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gRfyDfiiU8nLoSYxo7HvgBdNLY/gqZEp2pdSSXhnYbg=;
        b=bvQj4EyP2MeBuJTOYfXrOGP2M4G0MoXjLadOTCYVzVUds02wtiEm74DGc94bq+zyj+
         DzSRwaREiDGvGWs7RpavnORb5sDSvOZLzXvAD6vY2oWGfiM5gjrpnShfWY5TMXDkp6dg
         Hv1lbPrioAnOgQPZG+z2gwwcbISipsGU7K0QoKJl8Q2I18orU0iANBEI9aShx2VLuHqj
         J9i2Z1jdJd4Ng5L/Jfvxx3KWQwEZdKf8hzYAxvVMFbjDfyQXA1/Mwci5e6ztZorKm7fr
         6G5q4fnzzYfCzbwgtIzl5olUC+X9IRsNXXeTYxpIQM1F+a3wIK0wjrlQcAmzeVDL+y53
         XJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gRfyDfiiU8nLoSYxo7HvgBdNLY/gqZEp2pdSSXhnYbg=;
        b=WHKLGBnnnkjucY3f9TNebBXrtuZMUBeqr1NUuMRJdFGdUB88AhWy75WJBhr6lGTuF7
         8QjY/Ab6DZJ32GKrUAZRjelKdNTnbCV6PFlupO/W51yvf1IXSv3PRvjCowY0+VQOei84
         2g8UoKO6OI7GaLr9x8L+4pRTufQ2cGBmtx1xtmnAuwDLSCn6PspU+DIqzCNhHXGPqoHB
         567sAadC60tXEC2ObYFHbP8a1QvWJVfj0CaOfA2qDiXCq3Q15wgwyI/oGezFzj759BjD
         W69RSQmK2xTTnMMkM5jA7uV4Hx04pYITpA3h94sj/zM1Hplpr4w/jsikZmFp37Bl5eti
         k0ew==
X-Gm-Message-State: AGRZ1gLeVG4n17BqpI+jpmLdHqZv4SgtTdg87I+4aXOr16ihOjZ96mIN
        jdJnHG6q3rC4VJ5plAVZwMWVGchLpP4r8WF0xXKlEQ==
X-Google-Smtp-Source: AJdET5cgpDxk+GREMOwggztRRwS7d7lH143iwJnq3FBVpvtMtmsSFZuOQ+XXJ6sOsstqoTD8GPrng276Joq00nOHyyE=
X-Received: by 2002:a9f:2b44:: with SMTP id q4mr5431609uaj.126.1542556996603;
 Sun, 18 Nov 2018 08:03:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 08:03:15
 -0800 (PST)
In-Reply-To: <20181118111751.6142-1-christian@brauner.io>
References: <20181118111751.6142-1-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 08:03:15 -0800
Message-ID: <CAKOZuet2E8fwwx1kQftjCGJ2w5T4LS38yfr1kbMUK_PG3ffNHg@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 3:17 AM, Christian Brauner <christian@brauner.io> wrote:
> +static int proc_tgid_open(struct inode *inode, struct file *file)
> +{
> +       /* grab reference to struct pid */
> +       file->private_data = get_pid(proc_pid(inode));

Why grab another reference to the struct pid when the inode already has one?
