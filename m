Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C45822459
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="plFz+XmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C45822459
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeGFWF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:05:59 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:62222 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753688AbeGFWF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:05:57 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id D07F55A2;
        Sat,  7 Jul 2018 00:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:date:date:subject:subject:from:from:received:received
        :received; s=dkim20160331; t=1530914754; x=1532729155; bh=gTQg2l
        viJDPNEkrU1AqH4Zs52eMXtWXvjmtXrKST9bw=; b=plFz+XmB1eh6+IWAS5r1So
        7Hvah3Z+BV4Al9pXKqmUBowYivCICiww/sCmBA+U4a9eVLxdrkXg8HeYHU5uLrUK
        UGOQYraZqtp7y4W8fx26hnixUUb+RjyQdOdfxLNTczRq6iPI/oUjt5Wv+Ox2HqVx
        IhuONpT2sV85maNEbx2y+7FH0tvLrON4bbwCiPivSe0sI5ElbMpqsdrV85tsETMK
        zmEZOLNgAEqBVbw19QAyabsag0TPk8C9VqXKCmD1QR27Rg/vOyp3HtSjuuGRY4d1
        Ostmy0TYt3lxTXNNXdHTMqkxeJCvYbgCrzpT06kpNm6Wrs16O6AuBLCvi9vJCQVl
        Lw4ELeWlov03qHLtCLiNShvG6v9NxvX8QNzPBZCru1nmd4I+EPfyh5vuiFrDrvVG
        uNCDsNzeF7HQCyD8AmmOyxV/KnlvN0GmqRB2+cOaAqHBHhKpiHDGU7L5U3LYPzxR
        qt8NmH83bfj2dTgGKN1G1wTfsCWfDxXudQRh7rJZ+JAh8WngK4B06iRen0UOW4Xw
        +cSnVDxH4MA4DSz6f93qE5F99KlWzZyfOgGDpGLABhj5Pwikv4gOSyPH82cFGLtc
        F/K6rB8wlCe9qmFQtHDtPHH2anrVAnmRStR4xYei0iaJVU7bVsdJKz8/XyBNEM+P
        z2uw6wMsHJg8R3FsSdoV8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WkDMEQpGzl5L; Sat,  7 Jul 2018 00:05:54 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id C4778526;
        Sat,  7 Jul 2018 00:05:54 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 75719254F;
        Sat,  7 Jul 2018 00:05:54 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: doc:it_IT: kernel-hacking translation
Date:   Sat,  7 Jul 2018 00:05:15 +0200
Message-Id: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciao Jon,

This small set of patches introduces the kernel-hacking translation in Italian
and fix the locking.rst internal links. I do not know if this is a problem
with **my** Sphinx environment but these links were not working.


