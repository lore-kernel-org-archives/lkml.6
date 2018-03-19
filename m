Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114250-1521473889-2-5369290020858164157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521473888; b=c1x+wfLqWtKnLjMEPyZ6vD0aas5WDQRFze8pXEx5G6WDomz
    0JdnpRjpz4IItlOqlStdSXoxjS5hHL83iNGDoeZNKcG1WUfL1gONOXMtFlFFzgqS
    iNz7l1pa9/27xo2VAafwa2A+zn5SowQ1DY1zIJaEjaSEfLc2BHqs2I2CjA95vjCA
    bKEH8DSRXaeJ1E+qzDQ/cBZw/R1Tqs3cy5tYacSnHHab6FMRoRYZayKYKBSd32Ov
    htBELn/7ZIzAXB/KxQ/uLjX9QDLpPCCtM9GP9KD6qpvVWZo1whUs6xrviCDEtZuf
    IyAtj0og1ffwS7cRDZ1Ss/XRXR7+mkXLFsk8COQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521473888; bh=kLalYuDUwXH1jSNa+K1+J7fCrd
    8AftHYHnVbikRdhH4=; b=iyt94r304VVhiCuEWdc+U7enQqZDQZZG3ubP3ck4C/
    eG65a4dO6A8CnJEOQhKf1Ug3JwvXbvvTsIrFyN//kbwdgG2aH2AZNm74FD8Of88z
    aegmpTLYjAODOrQBnTkfl90eSw/3h4W/XwmgZVdpDbB2Z1yCcnwiwUWXSalEYNOt
    HAae6NjJZXdxc93hfaCQH7CO7z9pDnEFCZzkQ6WyI1kHHu5csnE9dF8ZRKmECW9A
    suRfivVZY5e8WZzN2Wo1EN6/vbnZlga/yGLJIQSSfb0A750rBPmM7JaOqbe6kQsj
    uBWu3ywn+2ISzVaNGlqTNG/ATS4tP7M7XmjaCSC2+Qig==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gTICV1sr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpefvvghjuhhnucfjvghouceothhjsehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegfeeggeenucevlhhushhtvghrufhiiigvpeeg;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZUJZjN/J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gTICV1sr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpefvvghjuhhnucfjvghouceothhjsehkvghrnhgvlhdrohhrgheqnecukfhppedvtdelrddufedvrddukedtrdeijedpvdeivddtmedutdgumegttdeludemvddttdemmedvmeejvdgsgeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegfeeggeenucevlhhushhtvghrufhiiigvpeeg;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZUJZjN/J;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755497AbeCSPh5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:37:57 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34179 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755892AbeCSPh0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 11:37:26 -0400
X-Google-Smtp-Source: AG47ELtArPwBMW5ejnbc1XGB0B7fNed90yHshjppKkcLfei9M7uFfvN55+MKvnpQNtWr/rphpbR7eg==
Date: Mon, 19 Mar 2018 08:37:22 -0700
From: Tejun Heo <tj@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] libata: Apply NOLPM quirk to Crucial M500 480 and
 960GB SSDs
Message-ID: <20180319153722.GP2943022@devbig577.frc2.facebook.com>
References: <20180319153400.25694-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319153400.25694-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 04:33:58PM +0100, Hans de Goede wrote:
> There have been reports of the Crucial M500 480GB model not working
> with LPM set to min_power / med_power_with_dipm level.
> 
> It has not been tested with medium_power, but that typically has no
> measurable power-savings.
> 
> Note the reporters Crucial_CT480M500SSD3 has a firmware version of MU03
> and there is a MU05 update available, but that update does not mention any
> LPM fixes in its changelog, so the quirk matches all firmware versions.
> 
> In my experience the LPM problems with (older) Crucial SSDs seem to be
> limited to higher capacity versions of the SSDs (different firmware?),
> so this commit adds a NOLPM quirk for the 480 and 960GB versions of the
> M500, to avoid LPM causing issues with these SSDs.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Martin Steigerwald <martin@lichtvoll.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied 1-3 to libata/for-4.16-fixes.

Thanks.

-- 
tejun
