Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3358C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D82208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImeBOzCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D82208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeGaIXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:23:24 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36258 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeGaIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:23:24 -0400
Received: by mail-qt0-f169.google.com with SMTP id t5-v6so14820158qtn.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 23:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wFWXAa+OCQnzMSQX8K7rpH03Sv8Hdm/xFO+meiGUaFo=;
        b=ImeBOzCsm/4K4QPepc+Dncut3xMypL9XgBoTahPQBiEolpB/4eGdHb4hwKct/T5oq9
         V45XDEibuzNSDjfHhlU0A9ytVitaEFbmrR+QiXKIwRynf6t9uKjiywaMChwfCMQFMU2/
         g2mmxZ1e/kFqcnSBAcQcMIDXukPjqz+xtKk0C/bw673QsQvcSCm9XvOTS3jmLvEcxsmX
         AN0nvQesbZUWohRhlFXZyZBklC24JUvNmzqNPqBWRMBzlibPlORYv+EH3PTGzhhIXD4e
         AfjPt6XWr8b2tH4ut2JQdfR84XSHoQeZnZWnSYbQF2WclMKEN3OqsSHjiI/QfCUWi+yf
         qaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wFWXAa+OCQnzMSQX8K7rpH03Sv8Hdm/xFO+meiGUaFo=;
        b=i+rDweG6LeJnDGJSvl8V0T8I3gUPOazJZJEzIHIccNrmgmk7ivatF54OGRhcR4ysz8
         1s8B7Vl3u4rZqgtfsQvXpEhaHCv9/PJGTc6OpPVpbsvt3cQCz7zZBaSgIBwJlR11l6VL
         I/9oaAWMkcgtVeMSbhy8/zUq/YLgbjqch9ckJW8BSsp5lNteiDKh6xQlvpcWyCq8E5F7
         Bq4V53ZfNttFvhtZVTboa//DmEIP00y/xDUXbpkNKVYheh3dlqQ7CbuO/CCVMXSqIWcg
         QPXKU/ljIuzTGyuBDW2OgByZ5t8Mb4n3h/ZhYhmKf5aAn3o26gQ8Q4R4a0HgpFLDDzAJ
         vUBA==
X-Gm-Message-State: AOUpUlH16S8nORy9PkrQ8WDdgXpRMKudmg8x8qMrakUQw0x+4AnJBTS9
        uD1TPo21VTr7okyANs+X/8qEYWh8OvMYv3j3D9w=
X-Google-Smtp-Source: AAOMgpf2gHiA1170Mge6YHfFmKxnpOfxU5G2gatl3tbQo+7ELK3LSfdpevNvFw00jBlYj/iLMOx5K71K+tgnKw+pxwk=
X-Received: by 2002:ac8:5144:: with SMTP id h4-v6mr19483315qtn.290.1533019477687;
 Mon, 30 Jul 2018 23:44:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:21e1:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 23:44:37
 -0700 (PDT)
In-Reply-To: <15f7c81085d98709dc38fa6d14694f893d6101e6.camel@perches.com>
References: <CAFGhKbzXiAx3iaveOQhXCseH2kg1U=j-sp0B9jNSF2wPUjDtFg@mail.gmail.com>
 <14f411527d551411defdd73a2507a13b7f07e789.camel@perches.com>
 <CAFGhKby698K852CWEh3zF_cqoumCgnv7OXLXrN2L9s-E4knBnA@mail.gmail.com> <15f7c81085d98709dc38fa6d14694f893d6101e6.camel@perches.com>
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Tue, 31 Jul 2018 08:44:37 +0200
Message-ID: <CAFGhKbzHmYX+fagyzsV2_PstGATfMuu=h8j40Mznwac393MHBA@mail.gmail.com>
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

> OK. How about:
>
> though this might not work on a path with spaces
> or some such...
>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f25f708cd2a7..afb9fb27908c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -852,9 +852,10 @@ sub is_maintained_obsolete {
>  sub is_SPDX_License_valid {
>         my ($license) = @_;
>
> -       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py"));
> +       return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$root/.git"));
>
> -       my $status = `echo "$license" | python $root/scripts/spdxcheck.py -`;
> +       my $root_path = abs_path($root);
> +       my $status = `cd $root_path; echo "$license" | python scripts/spdxcheck.py -`;
>         return 0 if ($status ne "");
>         return 1;
>  }

Thanks, works at least for me. Maybe use

cd "$root_path"

to get it working with paths that include spaces.

Tested-by: Charlemagne Lasse <charlemagnelasse@gmail.com>
