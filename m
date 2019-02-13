Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7F6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A511222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="WvfgX6sT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393593AbfBMSAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:00:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34694 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729522AbfBMSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:00:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id v14-v6so2850367ljv.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w6LPClstKObj3CIBolAxmqeW1Osc/gv6Fd4ZKYYFe04=;
        b=WvfgX6sTYssweXCF3errtzLsaomanelxvZrc0cccjMsV/8Vmso9HTbdFlyOdtz9vYt
         CcgafO+CMM9zvaz4zFDhUyLCtXfheWgBA9QYY+8Y4BTZJmJxXtQn3zKXpYUrmgqoq59V
         Rn7SH+qB9psBEVqwdKSOcMN8KRTEnSFts0SLNe0qJ8AtP24jedBe6zBhciQnQPhSTlXY
         EODLCOHskVnPI+xCPppxyWgGDzwvEpO40l8Ag4ncN6QgP9rLau6z+Nc1RJDrqiWqChpO
         FsJ1b6fZGW7YJsSNAKQYlkM0Jvzrzzwubcd8J8x+stmbWQ8ahNyIb++ss3/6VVMEQNnE
         NMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w6LPClstKObj3CIBolAxmqeW1Osc/gv6Fd4ZKYYFe04=;
        b=TUarimWeiUoobiSbVXrV55KqSvsvaf9TOtVKRrsIPsJhjwjAS1s65p2GPI0cyiF/Wj
         0wu9WCcei7CkhzcUrbbD1wnyucFhP7b9Mfwv+ATLLDudPVeTYQes4fWQYqWOnuS87vMd
         mMccu/Sb2/bl1/3/IvCP5cya4q96JTadD1UxWfJymq9gE34y9lI+Y317ps6rx2DwADoU
         p0Iqd/91b9gQBYH8rzBY1K8LensN4jNQdQ3Plo6k3onBbetl/S/SabJttzk9QY2Cphg4
         iO3vx0KVBRaH7G8m1G2V6+v95uf06Bb1lXEGY1HUNNFQn087O9l3vE27m+Un3OpCnSqO
         bDjw==
X-Gm-Message-State: AHQUAuYaaeIKOk/NJd0YEmf/jdFCOe3H7giumk1iJPty/2KMSd0PwVgH
        zQaWmGImbWCdV6+FUTmWP9QggnGTGfV7jEgmUgELr+ws
X-Google-Smtp-Source: AHgI3IbXhi73+SurP8lN+nETepTcs3DAi7BAwuqMPCcuM2vaFyevY6hvzjWxUet7OZQevw9hB2GDu9COcLjMV7Zihyc=
X-Received: by 2002:a2e:4504:: with SMTP id s4-v6mr1002549lja.165.1550080851750;
 Wed, 13 Feb 2019 10:00:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Wed, 13 Feb 2019 10:00:51
 -0800 (PST)
In-Reply-To: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
References: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Wed, 13 Feb 2019 13:00:51 -0500
Message-ID: <CAN1fySWPQnk26=8Qnf22Pw-N0tAFirwYs6n4uOJZ5LSH_aEuNQ@mail.gmail.com>
Subject: Re: Userspace regression in LTS and stable kernels
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, graham@grahamc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, had an issue when sending the e-mail and lost a bit of context
at the end, here's the missing bit:

---
[...]

Note: I wish to be CC'ed for answers and comments as I am not
subscribed to the mailing list, thanks.

References:

 * NixOS bug 53672, https://github.com/NixOS/nixpkgs/issues/53672
 * Bug 202497, https://bugzilla.kernel.org/show_bug.cgi?id=3D202497

Thanks,

On 13/02/2019, Samuel Dionne-Riel <samuel@dionne-riel.com> wrote:
> Hi,
>
> I am posting as a representative of the NixOS Linux distribution,
> about a userspace regression on 5.0-rc* which recently was backported
> to the 4.14.99, 4.19.21 and 4.20.8 current LTS and stable versions.
> The issue has been reported to the bug tracker, bug 202497, but seems
> to have gone unnoticed by the maintainers.
>
> The issue seems to break userspace for long-standing patterns in the
> NixOS distribution, with regards to use of the shebangs.
>
> Here is an example shebang causing an issue:
>
> #! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
> -I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.=
25/lib/perl5/site_perl
> -I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/l=
ib/perl5/site_perl
> -I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/=
lib/perl5/site_perl
> -I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/li=
b/perl5/site_perl
>
> (The shebang was artificially wrapped spaces replaced by newlines)
>
> Another contributor tracked the regression it to commit
> 8099b047ecc431518b9bb6bdbba3549bbecdc343 in the 5.0-rc* tree.
>
> I bring no particular fix to the issue, but I believe it should at
> least be fast-tracked to a revert for the stable and LTS branches, and
> since 5.0 might drop soon, a solution worked on, or possibly a revert
> until one is figured out.
>
> Thanks,
>
> --
> =E2=80=94 Samuel Dionne-Riel
>


--=20
=E2=80=94 Samuel Dionne-Riel
