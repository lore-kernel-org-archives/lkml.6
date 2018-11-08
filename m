Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF034C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62F120844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="IjDQLDoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeKIJC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:02:58 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:58596 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIJC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:02:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id B2770804;
        Fri,  9 Nov 2018 00:25:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1541719504; x=1543533905; bh=S4P+esw0e3XxDpKRX8/3D8RiUBSmReRCOUO
        AxxnySAo=; b=IjDQLDoWAEtJBu1D8VzXrbLJfI12MgVaztitgi3pH81WUPORLAF
        62YUL4uvLqlQfeivyeWWHngfPOAyKTk/vi2v6b5YA7CE5eEs989u/7w6H2JqQSaF
        WaebE6d1uV4nOh06i+Lo4aAH54/byELZTbJkljZgYdTyY8qLx3/wKPO8WE1qmQOV
        G02DHibOcRvPPQmEdICulghviKI+WQEtJs3LmkXzZqZ9/lrfM16QYjofbVeQ0sIZ
        ir8NPIUEVToGVxRMtQvAZJ4bkq9h8PazQc+nHxxkMCC8sbkYx6/sVZ3F9dmf9oW3
        aMTKZWQoavVFtvFv2FF1Rc32yidcdY/Bcoon4eTbvdN/wSFkaatEnFnqmwF2tVMp
        3ybCvONGMGj1ioV27JtpnUYFNqC4gLstc2vMS/cAId69EoXm8zL8ZdLCmPG+KpMl
        ntDauCNekGGO1wbBGFXgdVk3qMxJiFNe93rLNmXl8XxkoyPLFPj7M972ooet8u8i
        DdPk/sH1gybhwjDCHM/B+mMJmcQOhV9K0efGWO6/RueC1z79RD/6R02gbbM9PCKj
        c7d5caZNhzkeAdhWhBsiDUnm1bHepLia9IIdGVwZYfIPC62MSlEG2lZGKM605JAA
        2rk2Mv8BnRA4IRY5iDJL71HAmiJvDeFJK0DvJgWZOUkLiTX224AJaVyo=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6JHcxClbMaAj; Fri,  9 Nov 2018 00:25:04 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id C20BB2ED;
        Fri,  9 Nov 2018 00:25:04 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 32DFCA87;
        Fri,  9 Nov 2018 00:25:04 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 2/3] doc:it_IT: fix locking.rst section title
Date:   Fri,  9 Nov 2018 00:24:16 +0100
Message-Id: <20181108232417.14982-3-federico.vaga@vaga.pv.it>
In-Reply-To: <20181108232417.14982-1-federico.vaga@vaga.pv.it>
References: <20181108232417.14982-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This title was still in English. I just translated it

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Documentation/translations/it_IT/kernel-hacking/locking.rst
index 753643622c23..0ef31666663b 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -593,8 +593,8 @@ l'opzione ``GFP_KERNEL`` che è permessa solo in contesto utente. Ho supposto
 che :c:func:`cache_add()` venga chiamata dal contesto utente, altrimenti
 questa opzione deve diventare un parametro di :c:func:`cache_add()`.
 
-Exposing Objects Outside This File
-----------------------------------
+Esporre gli oggetti al di fuori del file
+----------------------------------------
 
 Se i vostri oggetti contengono più informazioni, potrebbe non essere
 sufficiente copiare i dati avanti e indietro: per esempio, altre parti del
-- 
2.19.1

