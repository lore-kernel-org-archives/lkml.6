Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341777-1520526379-2-2347887337519347021
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520526378; b=tAnfGiN/zYeLunVfQifk2Z5teV7iO55739sPyAa8N3GihoE
    wvsH8uZ9rl8dKvvEdhoNbuIkCUHeTpbJM+XaUhdGfI0ltTlOgav/xKAsDy6D2iFe
    zUMs41YlF9hGBBl4n70Jf+rX8l3XaXHrE8tR0TI1s2AJw+CmrfOkE5VkbEa6KTRc
    AvlOdjLhaIQI40mzD1E2FxHH+UvuAjiG6UiWYgQ9oz+GFVadVD3aK12KOihyaW5u
    2fdwxEQrXNnmv9lf6mrmuz5DraamRoTRnSHmrNbOx9PqK7TdTsZcLhpApAbysTJz
    2AXtVUirmmeJyFHPyn3tb1NANMUy5unQMs2z6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520526378; bh=sYN8yyZMd+s4oQ3KWeLjJtovCobZzWv7+i7S6s
    7bkyI=; b=B90CNTPuh1ZyveHGLGbNtcoTtf1NE6ABnvSH2jh5+Z+hr4Enir4Qsi
    LGtWXLnRqoAwobQWAOtADAoH/z8wQsw/Ukrp1i1FfUD1XdKc8Wqc/CT42Nmtr/do
    dF+mwG/aFoowsyPIaLbtJVIXuChjiutJdz/9IvJXCxmH0tm+AtfPFvIEBUarcf1X
    j9l6eCpwTK5O/dwcgwonhM+sE/v4rHOIZ26WrozQcvGfM5ppccsnVeLJcLWQO6mo
    z9i+hF3HdeleZvK0c5EdvfZT1IcHdgM5hUQxoO91OUhFDOuvsy7XGbWznkaZD3YX
    tBPstfsBiE4/HOidnQCwjq6VL2WnkIcg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cS2yT2LJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=cS2yT2LJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbeCHQ0P (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:26:15 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:65120 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933560AbeCHQ0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 11:26:14 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w28GPxgj020837
X-Nifty-SrcIP: [209.85.213.51]
X-Google-Smtp-Source: AG47ELtACDFC8CbKLB5qCtxxfMmYIBBYi+aVRDSVfHRmOmgdYDP3y6iLD1uMxktuAsvUWrQIl7ZA8jIBHLNoIaq9b9k=
MIME-Version: 1.0
In-Reply-To: <20180308110246.16639-1-jhogan@kernel.org>
References: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
 <20180308110246.16639-1-jhogan@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Mar 2018 01:25:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASk1wzziCHtNY4jo8GO_aXTwrAh1bY-CyLiOSmBKm=BMg@mail.gmail.com>
Message-ID: <CAK7LNASk1wzziCHtNY4jo8GO_aXTwrAh1bY-CyLiOSmBKm=BMg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Handle builtin dtb file names containing hyphens
To: James Hogan <jhogan@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-08 20:02 GMT+09:00 James Hogan <jhogan@kernel.org>:
> cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
> FDT (that is, the .dtb file) as binary data in the kernel image. This
> assembly source contains labels before and after the binary data. The
> label names incorporate the file name of the corresponding .dtb file.
> Hyphens are not legal characters in labels, so .dtb files built into the
> kernel with hyphens in the file name result in errors like the
> following:
>
> bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
>
> Fix this by updating cmd_dt_S_dtb to transform all hyphens from the file
> name to underscores when constructing the labels.
>
> As of v4.16-rc2, 1139 .dts files across ARM64, ARM, MIPS and PowerPC
> contain hyphens in their names, but the issue only currently manifests
> on Broadcom MIPS platforms, as that is the only place where such files
> are built into the kernel. For example when CONFIG_DT_NETGEAR_CVG834G=y,
> or on BMIPS kernels when the dtbs target is used (in the latter case it
> admittedly shouldn't really build all the dtb.o files, but thats a
> separate issue).
>
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.9+
> ---
> Changes in v2:
>  - Rewrite commit message (thanks Frank for some improved wording).
>  - Add Franks' reviewed-by.

Applied to linux-kbuild/fixes.  Thanks!

-- 
Best Regards
Masahiro Yamada
