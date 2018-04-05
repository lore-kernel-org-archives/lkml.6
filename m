Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3756588-1522961324-2-5934457312904433912
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='in',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522961323; b=lLINe9gIdqPMtbfgxOw4VE4gFNJKcNcMWp+qsgJMMrb1Guqblj
    fvmzaYDyv6nV8qrjBY47iA9+CjKgWZmfnEb04PNoBR5uhqDgfU53PLCCEOYPhB02
    4jQarBC7IAPEDZXCtZgI+GcVn1tuWpugVDDSIW9BBqmZBaNKgdtuSpZZK7k6HCFa
    CxdQdFqr6eqndzFrPhIhw1YFy6A5mdQSlnv3PcoK70L//h5ezgjfCriW/pzEhpMJ
    aUt7dazFjwSJgBe7WQDPLKOOn1viwDslPHm1i6Qq2SKMkvpOlVOsplCAYDj805n6
    M/DHCqkJqgSVmHVYc73iI0HrrlSxJN6gFIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522961323; bh=JX1z1h20hn7EG0hVSsZVt5tsPIKnHR
    Ji2BeWOXhec5s=; b=ucRVOLDLgL5j4YGbXNqqYWBi4xqknoJBYaEH8Qv8Mqhjjl
    dt2oDXaidivZpKUfvMzj9TssdPoByOOZlsM+m3uFTZwpWmT/y3C7Ojlmhlgn5Thw
    R9FRUYNQOl1a+1j6evPk1NMqR496PUuoLdh/pYyd+nYg2iUJN118EPIU0VIyN24W
    o6Ji/i0gPGngyAMz5NxGr64DPNowmkunbIlHaapJW1o4a+eJLTCxx2ltgMLmuvBE
    ty5MBjQWB0xGRvi6krdeFKVFaerSZPZLb18CVmZFEH1ehpaF9rWdT7FCXL7U7Mrw
    Lg0OhoKEOmze5REbWViw/hBSaSTySlt5QkHk6GdA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PFdBBhzR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rab.in;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZNMjWRsS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rab.in header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PFdBBhzR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rab.in;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZNMjWRsS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rab.in header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEpBIgOoWgN9fkHla9F4fufcDfNFkSBzWeNWTL+SbiasorqmvWDZA1k4W9QAA8a/ziTpxO21pXY+Rs/D3Yyv3Va2GBJP7+PyzCaZIPnsnCbQKf8RyUbS
    Hd5+VIO8ryiT2Wa8E9Z8csPhtHuurJwPlajC5qB4PKh9plrkhkK31y25gDtGzNpdurB0ON+mjJXr8PG6eTlt4mvZps/0fs1yalSds3U3TO+E2InZzSE8FLH3
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=Kd1tUaAdevIA:10 a=TG1GKGewEXAA:10 a=ZZnuYtJkoWoA:10 a=vDLGeLTdAAAA:8
    a=VwQbUJbxAAAA:8 a=GBFFb3YszgcCX8Ydur0A:9 a=NJbB_K_LZQsJ1E_7:21
    a=JsKYCQxwdCtSyE-6:21 a=CjuIK1q_8ugA:10 a=1GWREyU_VPGQROUScI6K:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeDEUsl (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 16:48:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53971 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeDEUsk (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 16:48:40 -0400
X-Google-Smtp-Source: AIpwx4+C85Xuupln1XGfY1LIweIr1qFTGo+DXI4dCq6K87qE8L2JnPDJbJEAQa06DrhoXZ3NMvTacg==
Date: Thu, 5 Apr 2018 22:48:33 +0200
From: Rabin Vincent <rabin@rab.in>
To: David Rivshin <drivshin@awxrd.com>
Cc: linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm: kgdb: fix NUMREGBYTES so that gdb_regs[] is the
 correct size
Message-ID: <20180405204833.hn56zpd474jywrm3@lnxartpec.se.axis.com>
References: <20180405200916.27964-1-drivshin@awxrd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405200916.27964-1-drivshin@awxrd.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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

Acked-by: Rabin Vincent <rabin@rab.in>
