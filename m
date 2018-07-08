Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2BC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532FF208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="n2/C/g3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532FF208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeGHXOr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:14:47 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:58972 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754388AbeGHXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VINED8CtmbFdAJWbnd556rAyzkEYvob9VzS4z+4q5sI=; b=n2/C/g3qGQtDLsTXwTYHsqZmv0
        aS4sh/UhD3yoFySpu+BBRWyKr2IFeZvfyD+Rrsn7JELdXhXttZ+4Hoe3ufDuCP6jlJqGyUQyfi+B/
        KyiIB/JmzuqTlN3hPL4bOnOzzhx/zhKRXCo1t5gYCP4fdAtx0oKrp9cmpCmnzcymPVYMMzvdORx8I
        I4FGuckzrbFpcShH5f7+aaZs6lDyYI8o5uF1AMd2M1huQrHaf8v7VaqU1eYQIxYNFPtJ0a2r1+ivy
        NQaZQgiwaDPOlZV/kO0yfkEgWOcHLNQRIkEpFaP7Jg2JlI9rXSH33POI7Zb7M71BDWd4iy31zpuh3
        fEu4GDcA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51538 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fcItA-00AtrB-B7; Sun, 08 Jul 2018 23:14:44 +0000
Date:   Sun, 8 Jul 2018 16:14:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, jdelvare@suse.com,
        avifishman70@gmail.com, yuenn@google.com,
        brendanhiggins@google.com, venture@google.com, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [v8, 1/2] dt-binding: hwmon: Add NPCM7xx PWM and Fan controller
 documentation
Message-ID: <20180708231443.GA25802@roeck-us.net>
References: <20180703232326.355718-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703232326.355718-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 02:23:25AM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM7xx Pulse Width Modulation (PWM)  and Fan tach controller.
> The Nuvoton BMC NPCM7XX supports 8 PWM controller outputs
> and 16 Fan tachometer controller inputs.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next; while doing so, fixed a couple of whitespace errors
recognixed by git.

Thanks,
Guenter
