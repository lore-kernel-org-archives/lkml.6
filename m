Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565AC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA4217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="Ye0gRjYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CA4217FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGGOiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:38:09 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:49748 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753447AbeGGOiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:38:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id DEA3F403AF;
        Sat,  7 Jul 2018 16:38:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:organization:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1530974283; x=1532788684; bh=ZtnlHxnrUM7OBkXbQDI
        bQyuCbnzhefUGIQlHJ+DkLig=; b=Ye0gRjYWuAd09p01KjBOvZ9drKllpjgCJJP
        JRMGg+6HcwC3IPkkopTjDClhDdblJpgcshNMs4zNZ7Ll3cVSxaSLW8/5JcOrpJje
        rPCtQhW+txs1P1S694XMs0QapyAMbCwVH2Cv8/yOfGdspec+Si/3cGdXkBmO26Mj
        cOk2JdOJ3UDZUpvcZ1NuFc5tJITezPQjeMUtwaBKMfpd8jQsyeJAlSHZoMETVlXk
        D7ffp3s+sLXVUtZeNynXsEMTsNbdVfwjQpO6LXjSFlZZ5MzBD7jqwXFGMkZXeA3U
        L8wne9u6pxyNQgzLTWnb1ZvarCQ8hQuSwx2RClVlRm72OY1m8rwl/YOp1UybOLdJ
        IkOPM+RpwVHgdOcLrokLLTVrCxo8iy7Gt9Kg/slxmyAJ2ieGNwjNLyVLrNBXlBtV
        hiTcQJNlwWTyvVszwSi9gMFdw4neifeWARMWblVVLsDmo0Wdl2XOHbWznum0a14f
        n4eE+mR4z4yrsYRRwpNk1j1AWisoYmGhUGpuaHbOlQQij6/orBtgQInKwKFazQlE
        7ndqrdn5z4Dvu9KyPBwWD0/EcxFLiIvYCL/B78g6R3SqGlCBIOlQx1bbtxq62BQR
        BO0GfcKlEsKz5HrJXSVaPwdsbt6uH5n95McLjt9vSFL4htopDS2c2cqoPFg5bXpR
        bkQvEmQc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pGeLqpbXh1iy; Sat,  7 Jul 2018 16:38:03 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id EADE840381;
        Sat,  7 Jul 2018 16:38:03 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 8CECC381;
        Sat,  7 Jul 2018 16:38:03 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: doc:it_IT: kernel-hacking translation
Date:   Sat, 07 Jul 2018 16:38:01 +0200
Message-ID: <2354575.ij7tX15MBX@harkonnen>
Organization: VAGA
In-Reply-To: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
References: <20180706220517.28623-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, July 7, 2018 12:05:15 AM CEST Federico Vaga wrote:
> Ciao Jon,
> 
> This small set of patches introduces the kernel-hacking translation in
> Italian and fix the locking.rst internal links. I do not know if this is
> a problem with **my** Sphinx environment but these links were not
> working.

And I forget to say that I changed the header part (translation 
information). The idea is that metadata field are less invasive, cleaner, 
than notes when rendered in HTML. I think this (metadata fields) is better. 
If you agree I will change what I did in doc-guide.

-- 
Federico Vaga
http://www.federicovaga.it/


