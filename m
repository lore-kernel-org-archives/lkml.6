Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1690573-1523028791-2-9443951362979755382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523028791; b=uTNYfJXvba6mb0V/yPusA/oySoI2WMEKM1bQMl/zYJp1in40rL
    LXJPr1VUdpa7wy/mT3r6QUy/8ANVuox4ZUu8/l2xaOxJVDTdFZVRIC8rw9p4siaf
    KBFikDhLwzNxDABaDOsRZQgJrTVWbbwJqVpKYFESjUB+OMZcT5MtPqy7xqWpkkTt
    WEbG87vYHe1GoMOXPWKdEFp9RyB3XLXE8LaEOruDpv2Vz2qvyBHeEkqB0M27DKJi
    oX598ZhA2gMAh19U7C8CrA2S3NcSaegs99li16u7DGXEcIZhakr351/tIUvudXF7
    EZQK30t2yeJ8yyu7KJydZq7znYizYMY1mmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523028791; bh=skCrP7pzJqHhlD9OEmwVG6r0N1poZf
    XocTnkTno9NdY=; b=K7DrbdE65IEfYB555i9jHNFRdnVOxrJjuteDYe9ojoPqEY
    +kdDubJ2VHky2ko3Dfh5UQ0jUE+CvoXy3nUKcKlqi3MpPIexx3T4KjINXINO+Xq5
    N6QLgkwO+bOqw1NgNdusIJozVnFRwuSiPnTbVNe8WwJlefnr7FmDHcq6Ii5DDVjU
    jVFB+lV9h3MdY/jux31oDZPxTLNPVD622VGjXxrVjhuS5OSL/l/1T5dsQMlf+MeJ
    FNO3YBSE0PKN4NGXwgpUveo6uUdkUj7ZWDuZNGJate57JF9J1RAAvyroL/stUHZO
    ZH0kMEVeb5pnATOLrVojsOrEA3xfNu8RTKiH+OwQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=S/3clS7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Pc/b7/ww;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=S/3clS7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Pc/b7/ww;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfArrTe7lJcaVpTXyDSdT5GYuAt6k8PAKWButVi6p5OTE/jwPbaSelRuE9kjBzMohJH/XMVqJcPuETj2UdF50U/0fddtfcGyG1aEXmWiF23v9NIUDpEyx
    OJVl9qXxbSDLeffN22pK0cHCx5K2U39L34zfZS1XY+0qCkbO/hgRZTk8vwAZLzn26Mdxps4pIAzxIpADqFbL+sx2aGVWmhMHJikbAthEfgfRZvv3Nrok0oSy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=vDLGeLTdAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=soA2EV3Md8QFVwTE4TsA:9
    a=---qCfsZss-MUEta:21 a=jCyBLj4HfbT0iWP4:21 a=CjuIK1q_8ugA:10
    a=1GWREyU_VPGQROUScI6K:22 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeDFNZV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:25:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54723 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeDFNZP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:25:15 -0400
X-Google-Smtp-Source: AIpwx4+uSN9ZNJ1/hAlt95UhVs/UeysT7sc0f4X1n/m0GrDG5XIF2kL558vo94cw93J1xoI6adEu4g==
Date: Fri, 6 Apr 2018 14:25:11 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
Message-ID: <20180406132511.uzl6viazwaey4bem@holly.lan>
References: <20180405200916.27964-1-drivshin@awxrd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405200916.27964-1-drivshin@awxrd.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 05, 2018 at 04:09:16PM -0400, David Rivshin wrote:
> From: David Rivshin <DRivshin@allworx.com>
> 
> NUMREGBYTES (which is used as the size for gdb_regs[]) is incorrectly based
> on DBG_MAX_REG_NUM instead of GDB_MAX_REGS. DBG_MAX_REG_NUM is the number
> of total registers, while GDB_MAX_REGS is the number of 'unsigned longs'
> it takes to serialize those registers. Since FP registers require 3
> 'unsigned longs' each, DBG_MAX_REG_NUM is smaller than GDB_MAX_REGS.
> 
> This causes GDB 8.0 give the following error on connect:
> "Truncated register 19 in remote 'g' packet"
> 
> This also causes the register serialization/deserialization logic to
> overflow gdb_regs[], overwriting whatever follows.
> 
> Fixes: 834b2964b7ab ("kgdb,arm: fix register dump")
> Cc: <stable@vger.kernel.org> # 2.6.37+
> Signed-off-by: David Rivshin <drivshin@allworx.com>

I pointed some trivial autotests at both gdb-7.12 and gdb-8.0. Results
look good to me!

Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  arch/arm/include/asm/kgdb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> index 3b73fdcf3627a..8de1100d10674 100644
> --- a/arch/arm/include/asm/kgdb.h
> +++ b/arch/arm/include/asm/kgdb.h
> @@ -77,7 +77,7 @@ extern int kgdb_fault_expected;
>  
>  #define KGDB_MAX_NO_CPUS	1
>  #define BUFMAX			400
> -#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
> +#define NUMREGBYTES		(GDB_MAX_REGS << 2)
>  #define NUMCRITREGBYTES		(32 << 2)
>  
>  #define _R0			0
> 
> base-commit: 0adb32858b0bddf4ada5f364a84ed60b196dbcda
> -- 
> 2.14.3
> 
