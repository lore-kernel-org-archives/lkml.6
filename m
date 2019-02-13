Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF79C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3847C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20150623.gappssmtp.com header.i=@dionne-riel-com.20150623.gappssmtp.com header.b="Ns7tvNi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391631AbfBMR5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:57:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33356 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfBMR5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:57:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id q12so2510114lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VAjY+/bIOpJdGWQMH2R7x+05QKpXxteV+S4zLK9ofRU=;
        b=Ns7tvNi0mZKdMDFfhbnN/LG2kICzb5lka48fhvM6pU70hzoEaF5BHmlDYiE8HR6vzT
         of3DgJY8+lGSSjUZ89luR17Y3/Ja4w0JIcEFJ9AfCEFbTn2KcYci5N2f0W9L7Ho235Xz
         WRmvgdfqsZ1nBGXWgKPjAI/W+eryl/6nG//z9ytCkspXIlbKYo051KE+CLAwVr3gBVBl
         BiVG+rqR7yoEtmc76lECHc0eTHM0N4SdaG+3rUeqzC9omUdvLtzkKQQ/rKAfQA0LGNvH
         iFwGpSU2o/zFY8tFlx9Cxkg9pmu1hGzC+i2CP5aXeGygJZ++xj8OH9hfU/dpJwXV7d7t
         XzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=VAjY+/bIOpJdGWQMH2R7x+05QKpXxteV+S4zLK9ofRU=;
        b=C+hiBAGec3bhQMv6Ag9oQhcCnKP8887634dr7vrJ6D6akGNRY/I43DA7wls3YI4aVL
         5+DqCYvfR4UQqg2isgwloECaFuOs9IBhWwAT+gvEDCc3j7dXbkCQhe9+Rn1kXQmPsX19
         flLJ5UR5O7H8eLhG49sl9lT1020HMPD/o1R646QZrJa2nWr8UBdlzdsvVwYdlQBBH74l
         JwimieUGxsSlDekE3YAP/FOQ7yh3ESczUBFa8WvrIKO79SQh1qCfftQn+vPYnh+Sxtyn
         ROaLoe0/fjBnL6Vs8Mg7CV8ko53BxiPno2rPFKTrUbACmnS2bceP/k60yjFkKHIqkRsX
         8flQ==
X-Gm-Message-State: AHQUAuZkBBi4DiPKR9nIMjEOhdL79789yFIc/JGft8ZYFjqQZxNk3VdI
        UbH3yqCHYveJqRZ7ckBLe7GBvMCN0O5vFZ9NGoMxk+1X
X-Google-Smtp-Source: AHgI3IZGneiKDOMs/7Mwr1X+5YTuv6nRuVhxpqyuMKsB/BW0BRTIiDFgSu5aMfpwJCs5GTxooILLAuQddeyYutQFTxc=
X-Received: by 2002:a19:5013:: with SMTP id e19mr1036562lfb.89.1550080656243;
 Wed, 13 Feb 2019 09:57:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:5612:0:0:0:0:0 with HTTP; Wed, 13 Feb 2019 09:57:35
 -0800 (PST)
From:   Samuel Dionne-Riel <samuel@dionne-riel.com>
Date:   Wed, 13 Feb 2019 12:57:35 -0500
Message-ID: <CAN1fySViLgrLAHHfTHMef-Bkh73kUHKP-ava6TbgALeSE4LfFw@mail.gmail.com>
Subject: Userspace regression in LTS and stable kernels
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, graham@grahamc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am posting as a representative of the NixOS Linux distribution,
about a userspace regression on 5.0-rc* which recently was backported
to the 4.14.99, 4.19.21 and 4.20.8 current LTS and stable versions.
The issue has been reported to the bug tracker, bug 202497, but seems
to have gone unnoticed by the maintainers.

The issue seems to break userspace for long-standing patterns in the
NixOS distribution, with regards to use of the shebangs.

Here is an example shebang causing an issue:

#! /nix/store/mbwav8kz8b3y471wjsybgzw84mrh4js9-perl-5.28.1/bin/perl
-I/nix/store/x6yyav38jgr924nkna62q3pkp0dgmzlx-perl5.28.1-File-Slurp-9999.25=
/lib/perl5/site_perl
-I/nix/store/ha8v67sl8dac92r9z07vzr4gv1y9nwqz-perl5.28.1-Net-DBus-1.1.0/lib=
/perl5/site_perl
-I/nix/store/dcrkvnjmwh69ljsvpbdjjdnqgwx90a9d-perl5.28.1-XML-Parser-2.44/li=
b/perl5/site_perl
-I/nix/store/rmji88k2zz7h4zg97385bygcydrf2q8h-perl5.28.1-XML-Twig-3.52/lib/=
perl5/site_perl

(The shebang was artificially wrapped spaces replaced by newlines)

Another contributor tracked the regression it to commit
8099b047ecc431518b9bb6bdbba3549bbecdc343 in the 5.0-rc* tree.

I bring no particular fix to the issue, but I believe it should at
least be fast-tracked to a revert for the stable and LTS branches, and
since 5.0 might drop soon, a solution worked on, or possibly a revert
until one is figured out.

Thanks,

--=20
=E2=80=94 Samuel Dionne-Riel
