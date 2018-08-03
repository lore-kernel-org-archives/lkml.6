Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C30C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B3D21708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbGjdNSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B3D21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbeHCCsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 22:48:36 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40255 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeHCCsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 22:48:36 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so1777016plp.7;
        Thu, 02 Aug 2018 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4n4qaCUXb7AAcqu7GnjvdoEi4MLUA4kL86sNmhjheLo=;
        b=RbGjdNSpv1S0dha3AzCEfbqPOh8YxWS+je2lJg7QGSFniZWMI+gy3IxFuOQYipPnjj
         LdU9/3TZpaMavu4oPXopncmxbjsBylCkswsjbgg/yq9SkYSeMaPzYoZlv32BUjPErQ9q
         lBS58Ge6gtoS2J1wkQlkfmTcwbFjxiu+mLObQZhxs2ejSz6XlnxMOKthbXT/Rb8HorQ6
         mmU56MzanWZOI+dMOiN3HqqfzdBIQzmK2MtagAz+AgnJUbdMG7pUwkWr3RScb/deAN5A
         6o58nVvLq7PCbGY6EOj84fi9JeMR65lh7Ll8j03/tVn69oZfeX7C9H+UN/FHWR985gLQ
         AyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4n4qaCUXb7AAcqu7GnjvdoEi4MLUA4kL86sNmhjheLo=;
        b=qhbhSQHwg6Jh3cDGSZ+18R8XwfQGSM/AGMnPMSwGZMr1ZcxWi0HudamvwDXCKG2Lmf
         CG2awyj3/1H/2UHfAnQeb+XUJ041yQeLnFlCv2WDPjhKkPtKu1gky3O0EyPzNqY/18sM
         xa0LJr5IL65pbwcMJqGL78cw9MWAbvIeo5snV/t4tN7WTPd5nULGBLA2GbykHm55fM0w
         RS3cKJHvK/wQGj+ei6uGm1lnLwfL291gDSmhmsJula3+6hicm6Es7wG+9eLSg51+2yTo
         mcOv63KBzHgmJ5v7IBH7xyfwBxuYMNZXPXTghK9c7nYoitkTDW7k0VHrBUvJ5/AcmTuZ
         AYlQ==
X-Gm-Message-State: AOUpUlHogp45KBZzEWD3Uh04affGCuT45bTotZQrc5pR8yKdIU88g8NO
        9emkhRl+lUCceffCIyS8/3wAk3iGz9Tvi62/xhY=
X-Google-Smtp-Source: AAOMgpeCJlmu8o5CAxvcD85wMRBP+WpW0sejQ5ZREGpp9ouS86Vi5csSyPDen+rpwdRwjZtqizkFi8wGLxQBhDrsgeQ=
X-Received: by 2002:a17:902:20e9:: with SMTP id v38-v6mr1473307plg.107.1533257693802;
 Thu, 02 Aug 2018 17:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180731232618.23586-1-lsahlber@redhat.com> <CAH2r5mvWHnkrQ+zF81_E-KkpVZA3YtZLB_LTk1dmePv0Y3Ktrg@mail.gmail.com>
 <1735951147.19009312.1533165340522.JavaMail.zimbra@redhat.com>
In-Reply-To: <1735951147.19009312.1533165340522.JavaMail.zimbra@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 2 Aug 2018 17:54:42 -0700
Message-ID: <CAH2r5mu_HeKuGieq10DdV0en8=zRj96HdKVSuzO9UYB1Nh3Ukw@mail.gmail.com>
Subject: Re: [PATCH 0/8] cifs compounding
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        samba-technical <samba-technical@lists.samba.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Big performance benefit (for this first narrow case) with Ronnie's
compounding patches (now merged into cifs-2.6.git for-next).   This is
the first code path enabled for smb3 compounding but looks very
promising, if we continue to get such dramatic perf improvements (as
we go forward implementing compounding to help stat, readdir etc.).
Note that we have seen that Macs are quite aggressive about
compounding in SMB3 (and Windows benefits a lot as well) so there a
quite a few future code paths that we can optimize.  It obviously
helps with more than network latency though, it can reduce server load
as well.  Additional improvements in handle caching and directory
leases (currently only implemented for the root directory) will also
be a big win in the future as they are extended in cifs.ko for SMB3.

I did some primitive tests with and without Ronnie's patch and it was
from 40% to 2000% slower before his patch (on the wire).   I tried df
and stat -f.  Note that stat -f shows the greater benefit (only one
compounded request on the with his patch, instead of two requests only
one of which is compounded with df)

Without his patch:
local (fast network, to Samba)  ~2/100ths of a second
remote (Azure, encrypted) - 16th/100ths to 17/100ths of a second

With his patch
local (fast network, to Samba) ~1/1000 of a second
remote (Azure, encrypted) ~6/100ths to ~12/100ths (stat -f vs. df)

so basically "stat -f" on the root goes from 3 requests to 1 send on
the wire, while df goes from 4 requests to 2.

Good job Ronnie!
On Wed, Aug 1, 2018 at 4:15 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> Updated patch.
>
> Thanks
>
> ----- Original Message -----
> From: "Steve French" <smfrench@gmail.com>
> To: "Ronnie Sahlberg" <lsahlber@redhat.com>
> Cc: "CIFS" <linux-cifs@vger.kernel.org>
> Sent: Wednesday, 1 August, 2018 5:19:36 PM
> Subject: Re: [PATCH 0/8] cifs compounding
>
> I have merged the first three tentatively, but did a little cleanup of
> scripts/checkpatch warnings (see attached lightly updated patches).
> For patch four (update receive encrypted standard) I noticed some
> endian errors - can you fix them (when I built them I got these sparse
> warnings)
>
>   CHECK   /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3075:66: warning: restricted
> __le32 degrades to integer
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3076:49: warning: restricted
> __le32 degrades to integer
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3079:68: warning: restricted
> __le32 degrades to integer
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3080:49: warning: restricted
> __le32 degrades to integer
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3101:28: warning: invalid
> assignment: -=
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3101:28:    left side has
> type unsigned int
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3101:28:    right side has
> type restricted __le32
> /home/sfrench/cifs-2.6/fs/cifs/smb2ops.c:3108:28: warning: restricted
> __le32 degrades to integer
>
> Attached are the lightly updated versions of the patches that reduce
> the checkpatch warnings - but can you cleanup the endian errors in
> patch 4.
>
>
>
>
> On Tue, Jul 31, 2018 at 6:26 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
> >
> > Steve, All
> >
> > An updated patch series based on Pavels feedback.
> >
>
>
> --
> Thanks,
>
> Steve



--
Thanks,

Steve
