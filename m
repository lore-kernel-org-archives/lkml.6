Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D20C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C87320827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efilHdXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C87320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbeKHBcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:32:20 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36865 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbeKHBcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:32:20 -0500
Received: by mail-vs1-f67.google.com with SMTP id h18so9723579vsj.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WS9zibSB4iZWTedBoRMKnZJf+/qsJfvPY26Ky9zapvc=;
        b=efilHdXx/NjzFvFQPQOyQkmg+ZtlnQw58eJVkWu5P6MFx43vJmPJURAgVzEfihVXzJ
         J43UgV+MpGQSAtJdCdSSPoWJU+dJHWx2VvBeDHP8Q8PztIOfmDQ9HdwcVpUhTYT10NNq
         xUlLjSUDGQGKFulIzDimMGzVtzI1JwyPI6DK3cfhfazbkuNnkZqEyGhUiiQ7z7YS6yJQ
         2QcyCrQF+b8lmCGQZ0wtwHpjsF629pwr43IaRDBgn+6SbxMlOOYQ690MddYgnIXFaf3T
         vHrk2oYmsbnBFZEeqRbTja5isxWxj2Hxp2vxjmsaTwjlNGGkWVWjRpn6HwjyR7ahcp4H
         WO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WS9zibSB4iZWTedBoRMKnZJf+/qsJfvPY26Ky9zapvc=;
        b=PXDSE5BTAEZK8ddFFqKXxEAZ2j17InZikoXrp0BN6lvsvyey5WpIjvzFs1PMyr5uuF
         B8oFvKstCNu/4wWJcRZD0VUIR3XmmYZNkRYje+UXDZzTjk5t76P4IgcO7D158wIYD5ZI
         A3ykSXB27tXtMP8u3dhDNoQhgxC4q58BkGVM18beNoxYlxTFEugtFfJLJF/PDNAx4SZ8
         KNbF+X3UtI+por3iCvZ1YJGNoefi3UlsIQ14s4v7vuOfCWm5khdIL8hqBaoPE40EAfvP
         AQCRuzu9iuw7+2We0zew2k/ILee6FXgGLzmM+FNaii87Ri6XPtwGBZjN04XpfnJbSxIC
         ux5g==
X-Gm-Message-State: AGRZ1gKOVe/WppT4IyVnSXkopsDH9rEKpOj5w2hJRyFFZ24gMGxkac0+
        AWwsfrMF143YUFOpsTA3KL/IPab5twxRp4dCbkyOaw==
X-Google-Smtp-Source: AJdET5dC6KTECzi2AAeJXVf/TI2TFYx1BFA20CY5Oma6nUhDVjy/a3y0HDAhub0ALrsRU0EFJpb8MxsqmE7iqgygyqU=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr304932vsc.149.1541606481350;
 Wed, 07 Nov 2018 08:01:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 08:01:20 -0800 (PST)
In-Reply-To: <CAJfpegvs4hafbe9XSgU175+26_ks9oh6iUo5m2tYLA=6MMvMrQ@mail.gmail.com>
References: <20181029192521.23059-1-dave@stgolabs.net> <CAKOZuevx9beEB-KWz0gRNaJQLfzu0cu7nuMYaB5ZT1O_ooQYAA@mail.gmail.com>
 <20181106154840.3b448356214afa63dc8cb28c@linux-foundation.org>
 <CAJfpegsdFiM6QWt3VBEDvGdKHfvsvUnm06MC-ha7z_WPTP9znA@mail.gmail.com>
 <CAKOZueu=zM_HjeET6SBJaP2zHD6+w7K8ewtk6B8C38Gkm4g0LA@mail.gmail.com> <CAJfpegvs4hafbe9XSgU175+26_ks9oh6iUo5m2tYLA=6MMvMrQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 7 Nov 2018 16:01:20 +0000
Message-ID: <CAKOZuesWpDJqqtyMxpVWBhe0ZnS3e=NOm6ZOeizuxX37tk2BbA@mail.gmail.com>
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, longman@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 3:54 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Wed, Nov 7, 2018 at 4:42 PM, Daniel Colascione <dancol@google.com> wrote:
>
>> configuration!" is something I've heard more than once. Who's to say
>> that sysfs is for exposing /proc/pid/stat,
>
> Patch is about /proc/stat not /proc/PID/stat.  Please revise your
> arguments based on that.

My argument stands. The considerations I'm discussing apply to both
process-specific and system-global information files.
