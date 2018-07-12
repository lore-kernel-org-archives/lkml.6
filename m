Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E0320875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fBCpuvNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E0320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeGLPPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:15:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39521 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbeGLPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:15:35 -0400
Received: by mail-it0-f65.google.com with SMTP id p185-v6so7205424itp.4;
        Thu, 12 Jul 2018 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1ElSPXk0lCOjy87h7DmQpMtFH9fS6IHCrcFtfFfRWY=;
        b=fBCpuvNLZ2tvvvRM4RbClwdsxm1TdobBsXcv9krya4dbS7ik88b8aaJ1A1S/OrSHzz
         /BTRzM0nTeDVtseyDETDBjkQOUDA38uVP+HfeHz5z1ZwibXImZcwoBddbVPOeELoVzEE
         NnGe5x+izDOA1tzKUmlwqBceOFKXSbHcUoTMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1ElSPXk0lCOjy87h7DmQpMtFH9fS6IHCrcFtfFfRWY=;
        b=SGFdjyJDoY4dn8oFG+dSGBuLl0RIBH2NYiaa8+CA2BUf+g+3h5uymqevBw69BlKNp4
         HdGL0JxtT+NLLZuQ/RiRuIKxr3Pax2B2rZClq9KTCxJwyP+ka8qrUDE5cNfL4INjs4dF
         ZffUNhDwRRdHgeNGxKqHW2bI1OAg6noA3Za5IKjggehCnOGsz8CXDH3q0j5xBdYceAKa
         XoGjuU/npF8eWpjtxOiwNyTbQP3dcGvolvzCrgSvORxmbJ1GgpoBsWCZs/zv+6MPhN+0
         UzhwQkd/Sf2MlPGvwJ0lbAsUPUuNAKzvIaEqtM+loD5VzwXt/l3gm+M0oCLK/urb/vwY
         gcPA==
X-Gm-Message-State: AOUpUlGyruNqoZYz+1OA7PTQqDZQIrKmjsRqwJ4iIG5x87tJJOejedk+
        A9rX/keBS6s5/WQqmr1p6utbJVE4C144h4BOiVE=
X-Google-Smtp-Source: AAOMgpfWpAS814TplAfqFfk7wd5w/W/i4vJusixfjDiaWU4tbm8Pa8cS374u0gNGLZPnkKDMW9BLPNHE2I/qUiOD2jk=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr1588382itb.16.1531407938373;
 Thu, 12 Jul 2018 08:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180711021136.GN30522@ZenIV.linux.org.uk> <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
 <CA+55aFxc7M9g+jqVnMHAsK350Ty1tQ9AghuJhBug+FPA6=XQrw@mail.gmail.com>
 <20180711152555.GR30522@ZenIV.linux.org.uk> <20180711161540.GS30522@ZenIV.linux.org.uk>
 <20180712124326.GA19272@ZenIV.linux.org.uk>
In-Reply-To: <20180712124326.GA19272@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 08:05:26 -0700
Message-ID: <CA+55aFwyOHvwV4qkmM1kRYQ+4brWbLSHaXE8GPV41u5Sj-AG4Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/42] drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:43 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> A question regarding the customs in such situations - are previous
> Reviewed-by/Acked-by normally kept across rebases like that?

Yeah, unless there were big changes, keep the reviewed/acked-by lines.

Otherwise you'd never be able to handle different people giving
slightly different feedback about separate issues.

              Linus
