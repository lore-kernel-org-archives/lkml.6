Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2139197-1523046287-2-8932743872679109868
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523046287; b=lmypssh8e1oOkcOMPXYxlAliEmxSOXepcJfea0kHSO2G40nn7i
    8Ny6xyZ2Y3o9fh0Ac4QHfw378YNWDSbhZUdKrDyWGyUVLFHeNBrvIyE06ur99qvC
    mDkpl0mEW8HxirQUDrSaK12Afl6coQg7QCyCAYZKzwkCU5XfZcZjjnaqNWCm8f3/
    rVLe/R7U866U0czy5uBsOc4k1AE9MXo2E2jsqnm/04sWjZ1EB1g/xTearTD7mRZJ
    TTxUqJryhW7XlTMPtTS10m0IjphYs04RJOJ3PlDJT7SrDRghMy7v6ATAd10/xR60
    C6s85ASdXKU5Zx783rHSRSwOKe0o3kG+r3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:cc:references
    :in-reply-to:mime-version:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1523046287; bh=j56a7Vx33kIu
    f+lABFUbzlGBEOSKvj1KWrSnPhHceaE=; b=CoydcWphLsXsiYRVPf/IMNclY6FC
    Ls6BbCKWBs3jHR42JDZMtx+GViA2UZlSLasVk25ROCpcq0qXuh+gFGuLDC/dpfFt
    OG/jGIQPOUz1oaDpfugzKH+PjtEO6ep51Cr+hptHru/nm7b93g74jWpt85yqlxqo
    Er4sejgKvMeHH0g8jzomhvG2RK7+c7rwM4BJE1zXIY6Ocsyxt/9Ji8FLoCoK2WjN
    O5IJDTGUsAqnPF/54/LDoxsLcIYwb/tPX8qO9Lb6F7RAb+MZMJ5G94EB6V80sDmV
    +tNk/49YC3Pz+tMLvQhqj853Ij8sXgmYQVqPocl8JNFMALIfyZD6JrgbNw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256) header.d=rainbow-software.org header.i=@rainbow-software.org header.b=dziguATO x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=atlsmtp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rainbow-software.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rainbow-software.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=invalid (public key: not available, 0-bit  key sha256) header.d=rainbow-software.org header.i=@rainbow-software.org header.b=dziguATO x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=atlsmtp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rainbow-software.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rainbow-software.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM4hD3nwzrchEbz4qTMpVe4WARf2LAFxBPOpN5UM3Yr8E9pprck+Mrmw4hdzUJnLPtwVAFT449g7oLxh5pmA+ar6ZyBYADmm7iTHP0QjYw2UQ50AVIyd
    yid+Q6BgtoUTfTUFXlfyQBsI7FkYBxaocSxNkswTIQb/I0+ACgxprcqq3krL8hvafqVdXlcphz9N9RjO7nuOfq7mbpiJJGR2AYCLznHfuG1WphL/9fcZhgFU
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=nd3GUXzEnpALrS8Ax64A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDFUYp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 16:24:45 -0400
Received: from smtp-1b.atlantis.sk ([80.94.52.26]:45089 "EHLO
        smtp-1b.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeDFUYp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 16:24:45 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH] i8042: Enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri, 6 Apr 2018 22:16:19 +0200
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20180403170810.32005-1-linux@rainbow-software.org> <MW2PR2101MB10344E66701305F65F39EF24FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB10344E66701305F65F39EF24FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201804062216.20107.linux@rainbow-software.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 06 April 2018 22:05:59 Sasha Levin wrote:
> Hi,
>
> [This is an automated email]
>
> This commit has been processed by the -stable helper bot and determined
> to be a high probability candidate for -stable trees. (score: 24.5527)
>
> The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.92,
> v4.4.126.
>
> v4.16: Build OK!
> v4.15.15: Build OK!
> v4.14.32: Build OK!
> v4.9.92: Build OK!
> v4.4.126: Build OK!
>
> Please let us know if you'd like to have this patch included in a stable
> tree.

AFAIK, it was already included in various stable trees.

-- 
Ondrej Zary
