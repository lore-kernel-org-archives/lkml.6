Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B16BC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6245F2064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 22:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="s/dfAx/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6245F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJ2HGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 03:06:00 -0400
Received: from nag.0l.de ([207.154.252.120]:33484 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbeJ2HGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 03:06:00 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764594; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=rtLRRvIkhAUethEgNayEnSoIiZjs2nQYZYSBXH1Cc+c=;
        b=s/dfAx/uQLnV79Zu4mU/rD3+9ii31oTF7GsS77wcve0t7jWGnATe6b8y9PN7cIZcpTh/UA
        NAe/EXtZGDsnBpY89UoyaaM4Rrm6TPHvtBVusRLGThaWAWbPgOrRucsvjsbmrSmgwpiRGS
        6tjjO/dvWfTbSvq5C1Zb8DVTLutWWF7RF4sp7gq7mprgStjhaYfEVsv8hm65LTdoPV6uF+
        nSJUUS13sZWTNo0LOyXsNtUHMiKIM71an3BKdEHJGAtdekfUtv3020RgzfBnUf9gBn97lJ
        77y+DDZr2hzX/rPBeBvAXsOZO+H+rRX6tzdgt6i8tzESFNFKqtQEoe66AlrKvw==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>
Subject: w1: coding style and checkpatch fixes
Date:   Sun, 28 Oct 2018 23:09:19 +0100
Message-Id: <20181028220927.56227-1-post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540764594; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=rtLRRvIkhAUethEgNayEnSoIiZjs2nQYZYSBXH1Cc+c=;
        b=vGte10e7FMgJfrCmBqn33rN7c2vTpa+EANSepk46vC8PdWoEQEdiO04XHP+JHsCoal4u75
        R75N9CH7u30ZuiK7budYgHAKKNpOdsJBGe18ugGpPeZeWAbmfqbgpr/gwxv/uT8p6ff2Zp
        UjeUtosCaT5QjjiGQEyJv9kKwf+rHX1jueyFSE6zV5M42oP+5dhPNh7tz1ddBXK/eV538u
        hIsi3vyIRAsjjRpV30jdCq5XQwpMjsB5A9ZZ7VIx2X++4xABlBi2YvMyTrp2+vSf6WUlGh
        if3jDGAEZjblgpecjjeBwUvtQX5Ak4SzAqGD4wv+zQsc2qGZNSQCScA4UOsTrw==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540764594; a=rsa-sha256;
        cv=none;
        b=TmnSCgM84xAendRSkkpa4qA/++HZPaqPDKt397aMXmKtxo8T1wP3LZL4MLhTOHUZtlZVcMrdhU5WxBXaoMoxmAlSMcb+t3vdQhcbTJTskH+DTyxO11Isihf3UOFv433dyPTn9QBknMQAXUSJ58heWkHbH5/LJRhBSSZU6qn8msyIrSuu1vhkZjWQEfFOMOrdm1NNgZm8mYUzbPQN46mHiF/MAJu/xC5TvDVgellKUY2GPfjWyunK2weQN0q+V36C2tMnPADQDbcjUQQUkcd+bNjUIRzhup7fAj4SzbF56fb9qCOfY6ZH4oqb9yQx6Oo71QS4eLs0I62Q6H0UYKXF5Q==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is my first series of patches for the Linux kernel.
I started by familiarizing myself with coding style and
satisfying my inner OCD by cleaning the 1-wire subsystem.

Steffen
