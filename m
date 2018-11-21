Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135A72145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="cif+df//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135A72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbeKVC2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:28:45 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:13722 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbeKVC2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:28:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 29F27A64;
        Wed, 21 Nov 2018 16:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1542815622; x=1544630023; bh=YdsMC3JWrhMd658gz1ABveCbMekDsMRD/iU
        EtUYf4s8=; b=cif+df//MKyHjZxDkgmwiCY7WT2kGIJqoIYiK/xyKxbX7J9kotJ
        oTXNDCNEUhtUa/EM01vXDCcwH8CupT48fFXjC3RMcE16kt6aVVvN5O28X6Bj0Oaa
        Ecl/ewCkCvR3o1x6M3qT8+L2n2A5Gq8W8owO1/aach2MM9MLcmJef+1xSLEaZfoq
        r0vRE54D7eQfGCB/Tqg76J1uszumqIjTvRNV2SK286Uq68CeJS86i7FahAwEMMqe
        kiypnAzjyMMXpe2H30aEW6kfUEeyxHnSNRpvKZ7bS/iON1Y6t7U5w22NFXjhjzpj
        AvlKCRsZHYFN/hOkpgSw5NeMMTjmyc+KFD0z/kk7LXX1u8lkkNA34yC/mObpk3WA
        zvPFJM/EklPG/cyx6r8b727j/2nf8/ag784c/chn3lgYiA13VXL1xFdVvJTfKala
        fQejiRObf5vH2SPDHMYF0JKdGr+N9i9IZnJeX3BGAiXZSi4SuXf5c3bbM69bFbsj
        +gfTcerhOr4neOzbeFt4GoHZYehyfDLH9SNyMA2aMPvR6lDSi4cd7VkAnAX6X75e
        qapyOAFLtcvYUT8qr99i4rB0TZugwFywAYsn/EkgRmuBK2go9jar6LajfkOWVpQE
        s13SJQG+J1sabmIY+UkgsPV74cryFEHwZsntW+PJEBo6c17dQcxsnPrk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5cIcBsz10Gza; Wed, 21 Nov 2018 16:53:42 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id A7825811;
        Wed, 21 Nov 2018 16:53:42 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 4B997B51;
        Wed, 21 Nov 2018 16:53:42 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc:process: add links where missing
Date:   Wed, 21 Nov 2018 16:53:41 +0100
Message-ID: <2954499.FhAtZrsb9b@pcbe13614>
In-Reply-To: <20181121132346.GG3065@bombadil.infradead.org>
References: <20181121003519.12559-1-federico.vaga@vaga.pv.it> <20181121132346.GG3065@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 21, 2018 2:23:46 PM CET Matthew Wilcox wrote:
> On Wed, Nov 21, 2018 at 01:35:19AM +0100, Federico Vaga wrote:
> > Some documents are refering to others without links. With this
> > patch I add those missing links.
> 
> I am a neophyte to ReST, but ...
> 
> > +++ b/Documentation/dev-tools/coccinelle.rst
> > @@ -4,6 +4,8 @@
> > 
> >  .. highlight:: none
> > 
> > +.. _devtools_coccinelle:
> > +
> > 
> >  Coccinelle
> >  ==========
> > 
> > +++ b/Documentation/process/4.Coding.rst
> > @@ -315,7 +315,8 @@ variety of potential coding problems; it can also
> > propose fixes for those> 
> >  problems.  Quite a few "semantic patches" for the kernel have been
> >  packaged
> >  under the scripts/coccinelle directory; running "make coccicheck" will
> >  run
> >  through those semantic patches and report on any problems found.  See
> > 
> > -Documentation/dev-tools/coccinelle.rst for more information.
> > +:ref:`Documentation/dev-tools/coccinelle.rst <devtools_coccinelle>`
> > +for more information.
> 
> when I tried to do something like this yesterday, I discovered that
> doing:
> 
> +.. _memory_allocation:
> 
> didn't work, and I had to do:
> 
> +.. _memory-allocation:

I would say that in principle it should not make a difference. Both '-' and 
'_' characters are explicitly allowed:

http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#reference-names

> instead.  Also, when doing 'ref', do we want this style of ref, or do we
> 
> prefer the plain:
> :ref:`devtools-coccinelle`
> 
> which is what I did yesterday.  

The style depends on the situation. In this patch (mine) the objective is to 
show that there is a file that talk about the topic, it's there (the path is 
visible), and by the way if you click on it you are able to open it.

> Maybe that's why yours works with the underscores and mine didn't?

This, honestly, I do not know. Perhaps it depends on the Sphinx version in use 
or some other python package? As explained here:

https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html

Sphinx environment can be fragile.

-- 
Federico Vaga
http://www.federicovaga.it/


