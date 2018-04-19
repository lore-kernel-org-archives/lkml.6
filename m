Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2641146-1524126479-2-10216172646677393010
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524126479; b=c5VkMKCZLAIc9dIdaGsZRVyCf+fzI+1YN87b5pXGgmr6MDRo6P
    Lk6PN//pPTnMozdxlmCuIePA9j3IUi1DpgvqNMHPuc3zO0cRDgiQxlJ4IZDQxER2
    G4+X8yaiS3hFqn9Yq8dQ1sBQnqTjFBAd4DMSiMYVGHWvI+yBQ6EZE1kR6bQNfsDA
    yIVpA9kECDSP8w7dwMsBjopnl4zYtLK5ia/JtOKZsysCpdhIcZPGVuGx/XT0yHcP
    0En8b+nQg8VG2nKWQl3u6ZTxNsM8jwCn9bGAXYBR2vg2hnRIB6SjgaSF1Ly0/qRE
    XuBVwiiPtNZHOWcfqwR1aLys6rFBoY9+HP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524126479; bh=5y97gi7jVBmCyMx6m04DZPAQcUDUod
    jy4TBjKLOaQB0=; b=i2ujEaTVO0aTIlEcBXezT4eTjqO/jG69AiNAahsGsaCWiv
    KthTdpsT+itfeyDSwEu/pTVFQ6WRgu+OzZOdU5+rgC2XuXLMkOydPHnNacqb3HaM
    PKG2+Bz+DV7tWECkjboWmJig5Wk+DFEIcGjNhcHUaOQKrzxoBl3LXS18mz5qiklw
    Ux1Pw1UuftoK5iQqedaw3nHfH5pKM8hfzh0x4quUw1rVOX/xja8LVwKnwVdp029B
    eUujTCCw1rH3LEFae2vA32R15xnsJFw8caSwjVmNIicLuO56ulrQHjBeMz2YXave
    auUmbTzka8/zn+XhYjDFL3KbLLSmjoouApZBCfTg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4cRs5Ov x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4cRs5Ov x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGkCwMaKsJWEbe7+ex4hh/8MWZudr1opYSyeR04dawmtoWveU1uEmeHXkDwHO0aMOmJuNYgN8+xtSX0kVQl8ny+mp5JKQm58di9XnTclKVBbc9KKCM2A
    3ETjw0IuPt49TDWiJjsoPZmGMOjmTXl+xTbjlZMGB5dx9jjFAZbZ/TuFFzXW6MSm+Q3Q2G1sFYZfB/RJYaQAnS8ordFOnkNeGxtuLJAkDepCYXeRQtvTQmFQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=IpJZQVW2AAAA:8 a=dhcyZseQW1gdStzgT5AA:9 a=CjuIK1q_8ugA:10
    a=IawgGOuG5U0WyFbmm1f5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeDSI15 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 04:27:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33137 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751046AbeDSI14 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 04:27:56 -0400
X-ME-Sender: <xms:C1PYWhn1Lf99Gjryt2NKcQ-Qj2XSYfBAvvD8QY0az4I2-QeL0wrvsQ>
Date: Thu, 19 Apr 2018 10:27:51 +0200
From: Greg KH <greg@kroah.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for
 Amlogic Meson GX SoCs
Message-ID: <20180419082751.GA23187@kroah.com>
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
 <3b17d17b-cf3d-be54-2462-191e4f2af653@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b17d17b-cf3d-be54-2462-191e4f2af653@baylibre.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 10:18:35AM +0200, Neil Armstrong wrote:
> Hi Greg,
> 
> On 23/02/2018 12:44, Neil Armstrong wrote:
> > The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
> > identified needing this workaround.
> > This patch adds the corresponding version to enable a single iteration for
> > this specific version.
> > 
> > Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> This patch is now present in linux master as commit 9c305eb442f3b371fc722ade827bbf673514123e
> Could it be selected for 4.14 ?
> The patch has been reworked to apply for 4.17 as indicated in the commit log, but the original patch will apply over 4.14.

I don't have any "original" patch here, I just tried applying it to
4.16.y and 4.14.y and it did not work.  Can you please provide a working
backport?

thanks,

greg k-h
