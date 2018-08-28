Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F31C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5702087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO7jS46p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5702087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeH2BNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:13:49 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33741 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2BNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:13:49 -0400
Received: by mail-yb0-f193.google.com with SMTP id d4-v6so1199125ybl.0;
        Tue, 28 Aug 2018 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i+Gc+ZMhFWjbnaxJBzhzEqRzTgiVvoqz22Cr+5S3tE=;
        b=bO7jS46pRs3jZnRMJ85tTGAFPbV/w9lLAO7+E3pHaR6fQF4ZEBEBEfCU5P5bg6l6mh
         +KhvChzsm9DNYeUOFdMQyLkGfdJVB4oq2GnBmH9zXSKm7hqpgs/2qHwQPCIQrUD/+nAv
         F7MREe9TPU81sMyCd94WxEd8GV/bgBkNzx1jSmox7XX3ysVfE8zdsAZzcDZky9gIINIR
         gqtzo61AVdvmFtqphUQD2mGF5Uci7RphBLi7CuoN10Pk542h9m/v1B6YXeiMrlSa2TOs
         ubwRkhQ5qJzhP82tt2VA7zut72tzUrnUtuWhwowF9qX4ohVPJJpdty3zCWiGlvclcmC0
         ji7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i+Gc+ZMhFWjbnaxJBzhzEqRzTgiVvoqz22Cr+5S3tE=;
        b=MMCkG1asc3xSgFVWy/r2LUsR8pi4ry0T/bk4rSVp6FjwODwW7IT6ttvokmLwcTW1XU
         Tmm4rqLG0rMkzcpjSAi9XX9s5nzp2Fwk+iHzcwbV3w1x6fjVdo6Jb6PD+bA9aAYqvMo6
         ZpWWVu4jFL2HG58m1wtOlQg+vaMKIm1xRFg8PQVtvhDn2sP0/TzMzymFElkw7WPaEaQf
         qwUBqazMzudNApI9AjEde2pNn+mcHqND6kcvLzCQnivYpK11YojIZA41/8rAnGMC74rW
         mjP2+wnGCno3f7cV9mQ4oHQt2+W9RO2NLS+XPiRkvCrz2ZhK92QPWY9GhYQVL63BU3HM
         V9cA==
X-Gm-Message-State: APzg51A147ax8shTuL0HmkeGs9Ah5ml04F5Tws7SjxVI2jEyq3FEfwcW
        WAso05BonMajFnxtJOBdnKk7fEQliZy2f1jj78Q=
X-Google-Smtp-Source: ANB0VdbBbs6V0Pe3MAPkOWYQ8RKGuaKDY3vuPHHvXZIphJLtSmEFINOjzERUbSr8zYJejZRNVKk9BpIgoCuPFvyr0mY=
X-Received: by 2002:a25:ea0e:: with SMTP id p14-v6mr1859068ybd.397.1535491218770;
 Tue, 28 Aug 2018 14:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180828165336.211643-1-salyzyn@android.com> <a8dc66c4-4761-4876-abd3-6dc135692404@infradead.org>
In-Reply-To: <a8dc66c4-4761-4876-abd3-6dc135692404@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 29 Aug 2018 00:20:06 +0300
Message-ID: <CAOQ4uxg5chFxo5wM-qtBYW0TPcsemtdh4WdRrtJDW_VvsAbtAQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] overlayfs: override_creds=off option bypass creator_cred
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 9:09 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 08/28/2018 09:53 AM, Mark Salyzyn wrote:
> > diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> > index 72615a2c0752..953e52971eb0 100644
> > --- a/Documentation/filesystems/overlayfs.txt
> > +++ b/Documentation/filesystems/overlayfs.txt
> > @@ -106,6 +106,35 @@ Only the lists of names from directories are merged.  Other content
> >  such as metadata and extended attributes are reported for the upper
> >  directory only.  These attributes of the lower directory are hidden.
> >
> > +credentials
> > +-----------
> > +
> > +By default, all access to the upper, lower and work directories is the
> > +recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > +checked against the caller's credentials.
> > +
> > +If the principles of least privilege are applied, the mounter's
> > +credentials might not overlap the credentials of the caller's when
> > +accessing the overlayfs filesystem.  For example, a file that a lower
> > +DAC privileged caller can execute, but is MAC denied to the
> > +generally higher DAC privileged mounter, to prevent an attack vector
> > +executing with the increased privileges of the mounter.  One option is
> > +to turn off override_creds in the mount options; all subsequent
> > +operations after mount on the filesystem will be only the caller's
> > +credentials.  This option default is set in the CONFIG
> > +OVERLAY_FS_OVERRIDE_CREDS or in the module option override_creds.
> > +Fundamentally The mounter has privileges, its ability to execute,
>
>                  the
>
> but this entire sentence is jumbled and awkward and could use some work.
> I tried to come up with something but I can't quite get what is intended here.
>

I have a very similar feeling - I do not feel any more knowledgeable after
reading the above.
My 2 cents - don't try to explain your reasoning for using this feature
the use case is too awkward. You may need to rationalize your use
case to get the feature merged, but spare the poor user who reads the
manual.
Explaining what  override_creds=off does is simple - stick to that
with a disclaimer about things that may not work well.

>
> > +for example, files and grant them these higher privileges is to be
> > +blocked except to lower privileged and appropriate callers.  This
> > +option turned off permits this kind of security policy.
> > +
> > +With override_creds turned off, several unintended side effects will
> > +occur.  The caller with a lower privilege will not be able to delete
> > +files or directories, create nodes, or search some directories.  The
> > +uneven security model where upperdir and workdir are opened at
> > +privilege, but accessed without, should only be used with strict
> > +understanding of the side effects and of the security policies.
> > +

I like the ending ;-)
Let's go with "The user may not be able to delete..."

Thanks,
Amir.
