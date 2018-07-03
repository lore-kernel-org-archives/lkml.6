Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9728C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B8524658
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jidanni.org header.i=@jidanni.org header.b="T07UU5su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B8524658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jidanni.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933712AbeGCIdZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:33:25 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:42843 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933016AbeGCIdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:33:23 -0400
Received: from homiemail-a143.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id BA20693CAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 01:33:22 -0700 (PDT)
Received: from homiemail-a143.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a143.g.dreamhost.com (Postfix) with ESMTP id 2E56B4E5A075
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jidanni.org; h=from:to
        :subject:date:message-id:mime-version:content-type; s=
        jidanni.org; bh=SX8cOuUM7H4z4FGQ1EPqYTACHCw=; b=T07UU5sunUjL/XXd
        9NyK2XNV+pyVDq582J343C8wA32KD2WniAtwlYzFGIBMEePceJJuzubB35gV0h42
        bmcO0woR1b5EE9PJimMfvbZjlVrC0OxCgoP6BsIDfOlDKX+RzUgj4LVrDvX48Sio
        b5KyZUItB7epRqB+yqYBV6RDDeI=
Received: from jidanni.org (39-12-203-212.adsl.fetnet.net [39.12.203.212])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jidanni@jidanni.org)
        by homiemail-a143.g.dreamhost.com (Postfix) with ESMTPSA id A20834E5A071
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 01:33:20 -0700 (PDT)
From:   =?utf-8?B?56mN5Li55bC8?= Dan Jacobson <jidanni@jidanni.org>
To:     linux-kernel@vger.kernel.org
Subject: recvmsg bug not clear
Date:   Tue, 03 Jul 2018 16:33:16 +0800
Message-ID: <87601whg6r.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users won't even know what string from this to google on to find
out what this is all about:


Jul 03 13:57:20 jidanni7 kernel: ------------[ cut here ]------------
Jul 03 13:57:20 jidanni7 kernel: recvmsg bug 2: copied 73BCB6CD seq 70F17CBE rcvnxt 73BCB9AA fl 0
Jul 03 13:57:20 jidanni7 kernel: WARNING: CPU: 2 PID: 1501 at /build/linux-uwVqDp/linux-4.16.16/net/ipv4/tcp.c:1881 tcp_recvmsg+0x649/0xb90
Jul 03 13:57:20 jidanni7 kernel: Modules linked in: nft_r...


So please make clearer messages.
