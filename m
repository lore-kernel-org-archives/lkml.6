Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A61C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FC620878
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="aHz5xcx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FC620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeKUKrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:47:51 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:2194 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbeKUKrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:47:51 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 5478B356;
        Wed, 21 Nov 2018 01:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1542759357; x=1544573758; bh=DEId5AHj2FCB+XFC/+dB9ESMSixO8tLTW9r
        Z/ff2x5M=; b=aHz5xcx8w80SCSOugKPtzBzzc33iBWvlyf+IXnecc4QZH9nBf74
        OQ98Ydzx/IAuIaYSmmYogIEIoKhn1s85aTiexfVq3AcJiq+eVDpUCp6UBScV1lH0
        nD8Of6eay8ZssN6oSnAAX5uxwVTJxA6J/DrjW6u5Qcyxbo8YlBbyBLrXyoAcULNo
        b894BSCO0o9gOFgc2cbpAWmtZ0TGeifG8yoCvQ/nI2CVn8OrWPPg2VqKscKHhYNQ
        eUJquUfB4v/A0LpTucfnwuh2tGS2ttj3ZAIcdMYSVfqcfOlGrbe7+9AyfBsBZ/Vz
        u1wVvNUt9vlwbZNspShJUOavB3nSog13gJjEhNHuaanI312O0fyF9vX+/jd4TjjP
        QGjjh/fdLXSA8r3HSlG//yUrBnR5N+NgHFYuIvJ4lUD66P+xaRj6V0Py/GxPK7NN
        C0MEb3VA/FDq4N6GP86Ql41JAeIPSemNfrF6XsjvkOLMO8fxNmgA+xHv90DQrLb3
        uOwE+BvWdLqHswJ3YYKPQ6iCdwr+vN7NDQqK2qnAM1MQJmAMwdM7h1y07rilnUKf
        zbSOKYOaWC5zeJUgFSxsl9py53twhqFFhuW2aOvOg2OwG6mIVund+wZZjr7yg1/t
        LH+UY9dMwc+c5jVf9y91qkArTKA0j8w4fYbsUw8ru247LWVRykHQsidI=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2276FHUAqDwa; Wed, 21 Nov 2018 01:15:57 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 66FD81AD;
        Wed, 21 Nov 2018 01:15:57 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id E7CFE28A;
        Wed, 21 Nov 2018 01:15:56 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc:process: add links where missing
Date:   Wed, 21 Nov 2018 01:15:55 +0100
Message-ID: <1946641.tM1jjfZjbW@harkonnen>
In-Reply-To: <20181121000445.7960-1-federico.vaga@vaga.pv.it>
References: <20181121000445.7960-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just one note. There is not any PATCH 2/2, right before sending it I realized 
that it was not correct and  I removed it but then I forgot to remove the 
enumeration from this patch.




