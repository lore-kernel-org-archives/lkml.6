Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE06C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F2320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Vyuwh5t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F2320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeKIJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:02:50 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:34722 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIJCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:02:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id AD5CB40498;
        Fri,  9 Nov 2018 00:24:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1541719497; x=1543533898; bh=JKkCVhP7G5SnnYAZaTW
        LYBJA9X3W4g6nr/IEn9ZLnVs=; b=Vyuwh5t9JJrYKFxsveTe88O2mjOGnSDeIvs
        A+1IMPp51M0CrYhpZTu2BOO1Do3UDUE3uvwU/xTfCZGP4ZU0kBL6T042XfYGGsZH
        FikSPxe6ceBIMPYyq53a1Y51BvC1H+PTphGPaEQV4ULeD1zhT4nIMEGJF9Mbrr98
        1R3v/Yv1e/vWl93bnWZOPRQZZPoI1c6YosReVoi+G/ezWYVuk4Gzij37+dASNnaz
        N1RC+NP87HSyWqThb/xmqobAqbVV1N2zxr5aGI/0PVWBJL2zePvxbKfFhu/0v8J9
        uNPC0L56XINrIg4UE7Ek1eUUMHMtrT3zXptWIGHt5LzDmlSF6ZbptNXkLFqenOHd
        aHR6UVAgJx1W9dcvGu0z83IxxqbDeirJjweIr0cZT7VtT42oJeJ0HNps0hdJBin/
        sKcfPjGWwneLMHBy6hDQtxWUAl1Wl8d7kRJ/hKurBnvDtklFnXVppWQRvcA+EXwP
        wmg265FOCG/zL681QhwWZbIPlJKKKmWfCsXZ1rmhvUQYEvgDbw1d3zKHz5kSJJ1G
        x2gaW/F7yaVeO5/BUeAnOgWFVY8h9pd+I+YDPnnDb87616GfuSia6rtT4HYbOaWY
        tNUoDyuvQhF7W99BzFSena+pjOSKNvX83dicYNDMRyiDXpSASGzfd1OJSaY9DJqp
        YNTcIvas=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wv6hbXO2d7vV; Fri,  9 Nov 2018 00:24:57 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 2A55A403A1;
        Fri,  9 Nov 2018 00:24:57 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 9F762A87;
        Fri,  9 Nov 2018 00:24:56 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] doc:it_IT: update italian documentation
Date:   Fri,  9 Nov 2018 00:24:14 +0100
Message-Id: <20181108232417.14982-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this small patch set there is the V3 of
"doc:it_IT: add some process/* translations" in which I fixed
the recent conflicts in docs-next.
I took the occasion to add other two simple patches that fix:
- a missing translation in locking.rst
- apply a patch from the official documentation to the italian one


