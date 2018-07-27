Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C692C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF4920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CYGaFpgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF4920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbeG0U6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:58:49 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33888 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbeG0U6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:58:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so2845247wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FRrt3Eb9q0HJXqQIZQCu4+ypGNmZua9eN5JHC4IWILo=;
        b=CYGaFpgUmhkuaLrl9ISVT0OoR8rDDgg33D3iUDfI3r2QkwowkLksYvO54+mYYCxYkf
         ++Ta2KvzN/zuD0SEFZ7dGOppbU3t3AsBEDDYe0U1jGbgrDh3XaTurpWTJ40dQjtVsDWt
         oP+fE5uzdcAFESyN1fcOr8g7Gs+E8OwUU5V3ExqES/1ew18aDuT5omvir9Jpq5ElMOqM
         ih2IUsZkpoad6zg9tLOR5xtATVVWNyszaW32B0upjqedPeZq4scbKSg6Kfjr5x6mWjPH
         VmH8X34LTYt9/zifm9ZbmK2ou60bWlFFJkrLXlU6vaOUtWHWhAzG1dN3OPEK4eGxBw7v
         7wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FRrt3Eb9q0HJXqQIZQCu4+ypGNmZua9eN5JHC4IWILo=;
        b=fnu5l+NxnNtyAgz9xNreKNWezTA8eyskbXEwy03FmNz7+BMsvyCkSmdwx0o5es0lj3
         jJT92wN9/Im2SlOkA04I+GkjQ6FKf833gi5AHxrE/J2DaVuHWPejxcDGVNpAbS2RwR4y
         /yB8paGJmEwpMflLNY76l0x61Z/IQ0wYU19KRzTqmEh+JIMX8i7urFJk4YgbbwNLwHfe
         Q6PUOWwNSaIzhsgqJwsK5dMEMkN5C92VPyDyuX1Boi42O/Rz5ZVvSXi/9/2z2zX1XDAs
         9U9dTuBifnnRZpT/yeQICrNL8JqzkKj15ahbf5PGfRNOTgh28UW35RRWtYk/HkqXaATg
         fg1g==
X-Gm-Message-State: AOUpUlHMKGoXD1qnw7Zt5FfKjJNOyzFeH/j70vDcrPdnlTuLHQl59gRQ
        W8saHllpTwL6YjKxrvKw/gcCdW4v7tm3t7GNXABDAg==
X-Google-Smtp-Source: AAOMgpfNUbznR0XO45JCGID709btBGUM9YHnT4bM9lLXxl2qiwtkgZfmIAIjmtsBAGYj+PRvuY3OFCydDFKBpvFdoPo=
X-Received: by 2002:a1c:3413:: with SMTP id b19-v6mr5682197wma.21.1532720129013;
 Fri, 27 Jul 2018 12:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 12:35:08 -0700 (PDT)
In-Reply-To: <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jul 2018 12:35:08 -0700
Message-ID: <CALCETrW6HQnGnnmzNrNAeEyRZZv9uJFcH92jjofR1Rx5NQTxDQ@mail.gmail.com>
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:35 AM, David Howells <dhowells@redhat.com> wrote:
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.

Has anyone seriously reviewed this?  It might make sense to defer this
to a followup patch set.  Also:

> params->request indicates the attribute/attributes to be queried.  This can
> be one of:
>
>         fsinfo_attr_statfs              - statfs-style info
>         fsinfo_attr_fsinfo              - Information about fsinfo()

Constants are almost always all caps.  Is there any reason these are lowercase?
