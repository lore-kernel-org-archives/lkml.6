Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB98C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AF12083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WWgB7Eg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AF12083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeFTUAZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:00:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45477 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbeFTUAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:00:23 -0400
Received: by mail-lf0-f67.google.com with SMTP id a13-v6so1104016lfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhOkRFVS9GKT9E48ZH6LER/vfrvlJSIaqj1/KIFVIGI=;
        b=WWgB7Eg9zFN5tsb+z9uzRk+JDyJTEHLcXdHO3Cmko2hWKj+14zGv/JB7OF3ONT/8Ji
         dGRTqQExQ6yY2YkGK5FIDVsZMA3TWGlQRqqD6MP8KO994x3KOMp29S6RF1A29nfWpEF8
         4m9ob7W2jOakHBIK+deHjorSkVngNTDPjMGogw90KMTdG8EqaqcKbeYuA8q//Yw7Xc+q
         fUFwvjK5NuRRZ0k5qDScwF9ZoqsVRjh4Qp6zOZAnPtq69Pswy1qL3zWArEPk1WnR5BYd
         Yve1fs6C9x8yI0rP8kvo/9F85CqF7cqkR/tusd2lfkVgl3EUWSOiH0GutQbrvwjRYmmu
         nTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhOkRFVS9GKT9E48ZH6LER/vfrvlJSIaqj1/KIFVIGI=;
        b=BwTk0r9AhZ5e4Hf6+BXZ/xKsNl4Xe574cinQwOZHDPbSjYUUIc1WMnddQh3ZMD+cNc
         pLllykR+qudsfPqFSgl4MOCHb/iKmQwxBtbIyhf60DViM/jzxKArCnkgVIETUQZDtV8j
         m4yqdKO97S+RkgylVgjMK6qgORI69E88pncIth16JbsgaCYp0AsOphERBJON7NWDOeWA
         QdCgpELMtX7NeE8Gzd+K1ca5lweraaZoBBA6DvTx7Z1v6CMnb2dNebv0oJGwrd90hLEW
         i4kAfYildXVRcRr+Da40GqX9zOcap2TaghQn8Om0+rz0WKZX4UcbfeERXhLaisR4vxaM
         fCeQ==
X-Gm-Message-State: APt69E18I+Z5hgAn2DatkxfDuOF4Nz+RUHrjpMX3u3oEaFrXXhh/LKcv
        WgiPxdVdhBEPEmzFvKqYnFxMY9GuL/oPwAh2T2YV
X-Google-Smtp-Source: ADUXVKLgjf6K1nb5Otcnc7czYnhCzuFoZzdSMqReHM4GoFDI9oXWeR3AW2nzPpBtXvf4mYzVqXcPz/x0hGQtcvjWdrQ=
X-Received: by 2002:a2e:18b:: with SMTP id f11-v6mr15041045lji.83.1529524821827;
 Wed, 20 Jun 2018 13:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180620144227.18bab881@canb.auug.org.au> <8e17ad17-db3b-7588-b04e-3bd8b54060c0@infradead.org>
In-Reply-To: <8e17ad17-db3b-7588-b04e-3bd8b54060c0@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Jun 2018 16:00:10 -0400
Message-ID: <CAHC9VhQv26uPWSYmhNdhJ4QM+AMKK=JFkMmDftLb1WpvOUyN8Q@mail.gmail.com>
Subject: Re: linux-next: Tree for Jun 20 (kernel/auditsc.c)
To:     rdunlap@infradead.org, omosnace@redhat.com
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 06/19/2018 09:42 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20180619:
> >
>
> on x86_64:
>
> kernel/auditsc.o: In function `audit_filter_rules.isra.20':
> auditsc.c:(.text+0x8c5): undefined reference to `groups_search'
> auditsc.c:(.text+0x909): undefined reference to `groups_search'
>
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>
> Full randconfig file is attached.

Thanks Randy.

I believe the issue is that when CONFIG_MULTIUSER is not enabled
groups.{c.o} is not included.  Ondrej, please look into this and
submit a fix as soon as possible, thank you.

-- 
paul moore
www.paul-moore.com
