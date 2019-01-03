Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149BE208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="nuPYAG6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfACULN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:11:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37788 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfACULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:11:12 -0500
Received: by mail-lj1-f195.google.com with SMTP id t18-v6so30720473ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Icmrvv+eKc7JLYOfSGTy5gIRSh1Zgg8phieU1RcmUvk=;
        b=nuPYAG6e4vM53NHwsQtElxvXantHSWxLvCWX39nFidQGVZtMu19E06KWMp0Xpav40y
         VcBQPC2NAJvaW+6G7ZRX6kkEPEssdp8vfph1endclYSa5MAnKIRBGaYFHAqR/2wkC/Zd
         snbcqEWGOlk1N1tDMmEn3JKo/BH5kW1sy42QNOZrV7iOlj6USElD+wJwdWbTj/1EAu3+
         3+GihmFs4HIUA6vzRXSodXXCwg7RynVzXaV6r2vRvmmovBd0qtGmGlikhT4cHly9UEad
         UXp1Y2ErP7M49Z4eMKoz5WhgHdOrgq3T30noaEyhomNqHtv9OWfpL/W3TpMSWkUtEC5h
         1ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Icmrvv+eKc7JLYOfSGTy5gIRSh1Zgg8phieU1RcmUvk=;
        b=KjAIcetsnoh/mtfzMtz2yb8QEDQ0PlJVN7wnYQTJp2HcfInmXlxmGyzoz0jGMQ1G4V
         BdaxB8W8mpm1LZobmuwOtySUlon7lHMFCUmVXUD5OvtjYN8vfaf3ai7ijhVuo1nBXTCn
         TcOnoWVbtfZ+AOjmSYfAfemVbyExMdPD5FRw1G5U+mca3qFsGrNmuDMUTcY3nbQxufLe
         Zaz37wKzj8J9gS3jlVArnTTrPAZ/fZ5dIJcFVdE9CXJZxgkhtBqB9/tvCavEqRQC5OAy
         +Jmq9QoDz8PdkRSz5WAgklil5BbpjgHMFzNV4UanDaWXUqfoXHnq5mzNxeX5bV4wxDm7
         a8mw==
X-Gm-Message-State: AJcUukdwUQ0zRsSM0rEA0xZDud55ANEiaxPpMHxC+ATuFDgJmjGWYmj3
        1l2wenPgYqlrRSD+NhRrsHaco+BeR1qSyq6BF4hiqMFadA==
X-Google-Smtp-Source: ALg8bN4eox9Yd4DfGbmSnTS0ioMJg2JW3vBV7K/5xyvbyguKmu0IKLZvjTfF8HqUMkax6yqrBn2mtvS41ayiwEpm+eU=
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr24858054lji.145.1546546270277;
 Thu, 03 Jan 2019 12:11:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <2827530000d6b4972d446b0226adab153ff3b5c5.1533065887.git.rgb@redhat.com>
 <CAHC9VhSG3Hk2zrNP3w=CfEBXN7_LcywiTpvhGp48661xYhRq2A@mail.gmail.com> <20181101184853.vxel3dfdntzmhcnq@madcap2.tricolour.ca>
In-Reply-To: <20181101184853.vxel3dfdntzmhcnq@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 3 Jan 2019 15:10:59 -0500
Message-ID: <CAHC9VhSutzkgmUyp9NeWVL8CFpCgJ5XNTtj1SxOWHST-6oz+4g@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 05/10] audit: add support for
 non-syscall auxiliary records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, carlos@redhat.com,
        dhowells@redhat.com, viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:49 PM Richard Guy Briggs <rgb@redhat.com> wrote:
&gt; On 2018-10-19 19:17, Paul Moore wrote:
&gt; &gt; On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs
<rgb@redhat.com> wrote:
&gt; &gt; &gt; Standalone audit records have the timestamp and serial
number generated
&gt; &gt; &gt; on the fly and as such are unique, making them
standalone.  This new
&gt; &gt; &gt; function audit_alloc_local() generates a local audit
context that will
&gt; &gt; &gt; be used only for a standalone record and its auxiliary
record(s).  The
&gt; &gt; &gt; context is discarded immediately after the local
associated records are
&gt; &gt; &gt; produced.
&gt; &gt; &gt;
&gt; &gt; &gt; Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
&gt; &gt; &gt; Acked-by: Serge Hallyn <serge@hallyn.com>
&gt; &gt; &gt; ---
&gt; &gt; &gt;  include/linux/audit.h |  8 ++++++++
&gt; &gt; &gt;  kernel/audit.h        |  1 +
&gt; &gt; &gt;  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
&gt; &gt; &gt;  3 files changed, 37 insertions(+), 5 deletions(-)
&gt; &gt;
&gt; &gt; I'm not in love with the local flag, and the whole local context in
&gt; &gt; general, but that's a larger discussion and not something I want to
&gt; &gt; force on this patchset; we can fix it later.
&gt;
&gt; I understand your reasoning to combine it so that if one patch gets
&gt; backported then both do, or if one gets reverted both do, but I really
&gt; prefer them seperate for similar reasons if there is more than one user.

The key is "more than one user".  As I mentioned below, assuming that
the only user is the networking bits (we can continue to discuss the
tty caller in the tty patch), this should live with the networking
bits; it makes no sense to keep it separate in that case.  Of course,
if there is more than one user, then keeping this change separate is
reasonable.

> > I think this patch looks fine, but it seems a bit odd standalone; it's
> > almost always better to include new capabilities/functions in the same
> > patch as the user.  Since the only user is the networking bits, it
> > might make more sense to fold this patch into that one.
>
> It was kept seperate due to tty_audit usage.  See my reasoning for patch
> 6, but I'm willing to negotiate if that merits an exception like the
> USER records do.

--
paul moore
www.paul-moore.com
