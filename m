Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92747C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8B420838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 03:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="g4pJdXpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8B420838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIYJwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 05:52:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39673 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbeIYJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 05:52:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so4666844lff.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 20:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z87e5uFX/admB8csiuT3JJaS7hI0OOVcYvhRJ8aoDy0=;
        b=g4pJdXpihRh68QY6rx8hMDtCxSn6x3LOM5gV2vx6Ts8MyvfsmkGO86t4GdPlbWkuAw
         fw/V2S1GaL23VORKGuOTZVvOjyp5CtnIx5MKtCb9w7MaDuRvN6Pih+JzPErRYyNobSPb
         axDcN2M/VUmc5AyVodPoz6j2db1GzV3FFi/hl+Nti8a0piU6csnjlHA+cmsaY18jJcJD
         mEzhmG2IMF5Y/kT8ZzLnw6oFLOVIDhuJusav5aMlGEC5cywVeivC1PpPCfdvFdV3xnzE
         5dx6Mu6f7kNg3r2K0VRmYasbTjrZQB+yOWXOKIunoep+aVxIXkGRBAjriFgM6u3AqCw6
         3EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z87e5uFX/admB8csiuT3JJaS7hI0OOVcYvhRJ8aoDy0=;
        b=Gr637L4ljZ2f5X+anN5sbn62bKIi5Rti/JkNMFoV4UTXfvzajh4KiVFKoEIQ+JP+8F
         gXbm8Cr5zDKgY1yBsjKCGS2cjEEY0k6JnM8m9m+1SdrrlZNDM2EEZW6KuoaKwQDBUc31
         SuBsOj6SI0XzZS4rS8bPot8Xv49pAA91n59T71R3asaJ+Ajc09cOPH/i4MbIjh3pwVzr
         sEaZ5PkUsgs8dNkx4Zwdh/r4u7F2mOW9JzWzeFrQRrl2EqDI5sYa72/rQLi7Y+5qlaIg
         y3BvrmhiynzdOjjfiXzsj1ChAg3XYoEPLQOh/ih8x9FlplL54kQYgqOWy1dLQOuAp+IH
         wvvA==
X-Gm-Message-State: ABuFfoguTPPjqY3KOJimjZ0dtdb6enokGX1BUo8HSihDyRG5ezsomuLh
        QqR0u+vJoNjQRXwipI1S6gNYyhR2H21chJESIilv
X-Google-Smtp-Source: ACcGV609qES08Stu5GeGgYHDqLTa+FlUa/3NVxHNHzMHQbdResXqTojC4W4GFONr5BtWtx7cVoJHood7hTREVBeq1N8=
X-Received: by 2002:ac2:410d:: with SMTP id b13-v6mr976304lfi.19.1537847228114;
 Mon, 24 Sep 2018 20:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180919165248.53090-1-takondra@cisco.com> <f283c1e7-19eb-2b99-3fef-a19e2bf99a2b@tycho.nsa.gov>
 <153741130781.7326.1773144725860636439@takondra-t460s> <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s> <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
In-Reply-To: <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Sep 2018 23:46:57 -0400
Message-ID: <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for native labeling
To:     Stephen Smalley <sds@tycho.nsa.gov>, takondra@cisco.com
Cc:     Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:39 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/20/2018 06:59 PM, Taras Kondratiuk wrote:
> > Quoting Stephen Smalley (2018-09-20 07:49:12)
> >> On 09/19/2018 10:41 PM, Taras Kondratiuk wrote:
> >>> Quoting Stephen Smalley (2018-09-19 12:00:33)
> >>>> On 09/19/2018 12:52 PM, Taras Kondratiuk wrote:

...

> > IMO it would be more consistent if defcontext cover all "unlabeled"
> > groups. It seems unlikely to me that somebody who currently uses
> > defcontext can somehow rely on mapping invalid labels to unlabeled
> > instead of default context.
>
> Yes, and that seems more consistent with the current documentation in
> the mount man page for defcontext=.
>
> I'd be inclined to change selinux_inode_notifysecctx() to call
> security_context_to_sid_default() directly instead of using
> selinux_inode_setsecurity() and change security_context_to_sid_core()
> and sidtab_search_core() as suggested above to save and use the def_sid
> instead of SECINITSID_UNLABELED always (initializing the context def_sid
> to SECINITSID_UNLABELED as the default).  selinux_inode_setsecurity() we
> should leave unchanged, or if we change it at all, it should be more
> like the handling in selinux_inode_setxattr().  The notifysecctx hook is
> invoked by the filesystem to notify the security module of the file's
> existing security context, so in that case we always want the _default
> behavior, whereas the setsecurity hook is invoked by the vfs or the
> filesystem to set the security context of a file to a new value, so in
> that case we would only use the _force interface if the caller had
> CAP_MAC_ADMIN.
>
> Paul, what say you?  NB This would be a user-visible behavior change for
> mounts specifying defcontext= on xattr filesystems; files with invalid
> contexts will then show up with the defcontext value instead of the
> unlabeled context.  If that's too risky, then we'd need a flag or
> something to security_context_to_sid_default() to distinguish the
> behaviors and only set it when called from selinux_inode_notifysecctx().

Visible changes like this are always worrisome, even though I think it
is safe to assume that the defcontext option is not widely used.  I'd
feel much better if this change was opt-in.

Which brings about it's own problems.  We have the policy capability
functionality, but that is likely a poor fit for this as the policy
capabilities are usually controlled by the Linux distribution while
the mount options are set by the system's administrator when the
filesystem is mounted.  We could add a toggle somewhere in selinuxfs,
but I really dislike that idea, and would prefer to find a different
solution if possible.  I'm not sure how much flak we would get for
introducing a new mount option, but perhaps that is the best way to
handle this: defcontext would continue to behave as it does now, but
new option X would behave as mentioned in this thread.

Thoughts?

-- 
paul moore
www.paul-moore.com
