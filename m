Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9005C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4046720833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cos.flag.org header.i=@cos.flag.org header.b="r2sMXTCm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=cos.flag.org header.i=@cos.flag.org header.b="siGd3CtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4046720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cos.flag.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH1RYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:24:53 -0400
Received: from outrelay2.flbmail.net ([12.139.121.108]:57278 "EHLO
        outrelay2.flbmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeH1RYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:24:53 -0400
Received: from mta1.server.flag.org (mta1.server.flag.org [10.64.251.47])
        by outrelay2.flbmail.net (Postfix) with ESMTPS id 5063548000
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:33:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cos.flag.org; s=mail;
        t=1535463192; bh=bBf0Vvl04j+2jzmXwRprfJcrb//3GWAwlq6wwG9DLLA=;
        h=Date:From:To:Cc:Subject:From;
        b=r2sMXTCmWHcrml2rfD0sB55PJ943Ow9Kf4Ec7Ez5Vg5XWWf46+Ebv7IbpLWRzxbo2
         HgXnFCy9ZZKcYW3BC7lv25ErWt0++b6ldST+QLqOS5Yn0O+MZauCLqMu7JGj56L+f3
         g7l/vczXUFj6ZJWeeoPulO/KVLCR+KBQylssuKJU=
Received: from localhost (localhost [127.0.0.1])
        by mta1.server.flag.org (Postfix) with ESMTP id 494C84A1D14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:33:12 -0400 (EDT)
Received: from mta1.server.flag.org ([127.0.0.1])
        by localhost (mta1.server.flag.org [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4K3Vp5uoeZgM; Tue, 28 Aug 2018 09:33:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mta1.server.flag.org (Postfix) with ESMTP id DF72B4A1CA6;
        Tue, 28 Aug 2018 09:33:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mta1.server.flag.org DF72B4A1CA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cos.flag.org;
        s=C82168C8-F236-11E7-AE09-40F562C2D254; t=1535463191;
        bh=v+7sDrpgI4SZkytIYAbtUw0o1+ebdonYsrxeZ7X4P2w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=siGd3CtDOuOecrgGFQ7lIcuIrOMZXterJaEYLl31NAhIQCBmeAk4F2bKW2QP4cis4
         2X5mwtprEUWJudljtOHksXXkptuPmG5DIGalUKwGCr2iR55P7XorBSOv6RE4Xb+l/Q
         45DsHo/OnnF8Rku5fUgjq3kdubc9bB0aNWL/K8XMEj/SSr2CRPqLsULDMSy9gEf59I
         XxtLWBAs43dIukIWv7r7hMmhYMzeWGeZGSCAbbnLRlcphkGiF4uF3VbSE6z6+CynX4
         dNgWyllU4lhXzSWIr3WXRh6li3D+6rpxkbbJ6FWhtnBdam9LL//ZNqc0Af/SFAR7rE
         vD7OMyiHBaL1A==
X-Virus-Scanned: amavisd-new at mta1.server.flag.org
Received: from mta1.server.flag.org ([127.0.0.1])
        by localhost (mta1.server.flag.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 70DDj21bxqtT; Tue, 28 Aug 2018 09:33:11 -0400 (EDT)
Received: from flbza1.server.flag.org (flbza1.server.flag.org [10.64.251.44])
        by mta1.server.flag.org (Postfix) with ESMTP id B91AB4A1519;
        Tue, 28 Aug 2018 09:33:11 -0400 (EDT)
Date:   Tue, 28 Aug 2018 09:33:11 -0400 (EDT)
From:   dimitry@cos.flag.org
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     dimitry <dimitry@cos.flag.org>
Message-ID: <314029050.47161.1535463191699.JavaMail.zimbra@cos.flag.org>
Subject: gpiolib: GPIO_GET_LINEHANDLE_IOCTL and GPIO_GET_LINEEVENT_IOCTL at
 the same time
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [4.35.210.206]
X-Mailer: Zimbra 8.8.5_GA_1894 (ZimbraWebClient - GC68 (Linux)/8.8.5_GA_1894)
Thread-Index: uuBz7tFBzPm1TWGesQaqQLvPuDEMDQ==
Thread-Topic: gpiolib: GPIO_GET_LINEHANDLE_IOCTL and GPIO_GET_LINEEVENT_IOCTL at the same time
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems gpiolib only allows user to request either the line handle descriptor or the line event descriptor, but not both at the same time. 

gpiohandle_request hr; 
gpioevent_request er; 
... 
ioctl(fd, GPIO_GET_LINEHANDLE_IOCTL, &hr); // so far so good 
ioctl(fd, GPIO_GET_LINEEVENT_IOCTL, &er); // resource busy 

I have a situation where I am trying to have 1 thread monitor an open drain/source line for events, while another thread writes to it. Not entirely unlike i2c pulse stretching. Is this not possible with the current gpiolib design? Or am I doing something wrong? If not possible, is my only choice to run an endless loop checking for line state? 

NB: I am not subscribed to the list. Please CC me directly in your replies. 

Thank you, 
Dimitry 

