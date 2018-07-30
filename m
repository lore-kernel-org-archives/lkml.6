Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E5160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1338B20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAnDWvEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1338B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeG3R2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:28:12 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42256 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeG3R2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:28:12 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so12574536qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7RaUCo26ialGDmIuQvrEJIWo5JgWbunsR3FShOKfHy4=;
        b=JAnDWvELxwRUTDO7xxkjQlJnLM3OsdEItzrcEPYdlArJfwzrY1nRHcuWH5jQmUxe5I
         Qyty5py4vzILOTGExSWePpSRSWo5mrt1sO3YmOnxOYP3DePxVco01GEPfSF4By9uQx1d
         8MIqBx9jM0fn5AEvsdqLYcHOWVnYTTJRh+4NCLb65Ld1IqdDburbkVOwYVRwkGFDA2uG
         8vm9SijAaX7AgGKTcUAwH3Rpkr9pPRzGfwFefyV+N9Gy6QkDafJOgxUdx1sPKXYk9my0
         +oEMkYaj8L73uRIKnOAQbismKs1WhWFWGqSfFcms3NXCNipNVDGuyL2Ls75JhkcjPynt
         hUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7RaUCo26ialGDmIuQvrEJIWo5JgWbunsR3FShOKfHy4=;
        b=b6S1yApbozB4MgoSrrSNcvTYa7759teghPZDr1eMHCf06SA/4WcvnwGNJbqOcAic03
         goHsvQ5ZJ9ebDJMBCO8V1XOqcCc3JhuWyg0BDUYuIWM4MsND5SPe1n654CuRNB1F0enc
         2ET7PVXvcu6Rdvg3tBPOw2J3owl90YVG/Owp+zIu6HtMHQpwEXm9l3eIwXWwyhxn/qao
         XbbIKD2W5wyvvwLc6uqfQJmMK68ITOZXjNYTKNpZx8WpCLhhPiAetUitNhPfTH6hV/Cc
         xDIh9uxwKtXHEIhoR3U07Mw59jqk3erxMJs4GqAjxhLzmpaHvuQIzjceBxAaEY4XkgMr
         2jQg==
X-Gm-Message-State: AOUpUlEf9QTiR5BIlBD2cPMgNyAnqZpOk+pxptmzVdaa4VuGHt3qbMnu
        usMMgynWWiF4zTfP6fgQ4T3oLrPnADVfXShfThg=
X-Google-Smtp-Source: AAOMgpdpJQnDfMZDitnxTa7mIaKcIcvj7kXce8+AeOIbUXsoLJYbyraHu8mtveGB7QIEy0vaMtkjLRL5JcmidXVPxR8=
X-Received: by 2002:a0c:f7d2:: with SMTP id f18-v6mr15611200qvo.175.1532965956512;
 Mon, 30 Jul 2018 08:52:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:21e1:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 08:52:35
 -0700 (PDT)
In-Reply-To: <14f411527d551411defdd73a2507a13b7f07e789.camel@perches.com>
References: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
 <14f411527d551411defdd73a2507a13b7f07e789.camel@perches.com>
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Mon, 30 Jul 2018 17:52:35 +0200
Message-ID: <CAFGhKby698K852CWEh3zF_cqoumCgnv7OXLXrN2L9s-E4knBnA@mail.gmail.com>
Subject: Re: checkpatch: SPDX integration breaks --root
To:     Joe Perches <joe@perches.com>
Cc:     Rob Herring <robh@kernel.org>, Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this work for you:
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f25f708cd2a7..f0e6913c5cc1 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -852,7 +852,7 @@ sub is_maintained_obsolete {
>  sub is_SPDX_License_valid {
>         my ($license) = @_;
>
> -       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
> +       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
>
>         my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
>         return 0 if ($status ne "");

No, because $root is a git repository in my case (linux-next to be
exact). The problem here is that spdxcheck is ignoring $root and just
assumes that cwd is a linux git repository. And when it is one but not
a linux git repo then I get following error:

FAIL: "Blob or Tree named 'other' not found"
Traceback (most recent call last):
  File "/usr/src/linux-next/scripts/spdxcheck.py", line 234, in <module>
    spdx = read_spdxdata(repo)
  File "/usr/src/linux-next/scripts/spdxcheck.py", line 41, in read_spdxdata
    for el in lictree[d].traverse():
  File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line
298, in __getitem__
    return self.join(item)
  File "/usr/lib/python2.7/dist-packages/git/objects/tree.py", line 244, in join
    raise KeyError(msg % file)
KeyError: "Blob or Tree named 'other' not found"


Still, your change looks good when $root is pointing to an extracted
tarball with the linux sources and not to a full repository
