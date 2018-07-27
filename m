Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A176C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670AA20873
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="wVRpZ3a1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670AA20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeG0JHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:07:31 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:21816 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbeG0JHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:07:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 6A9173E1;
        Fri, 27 Jul 2018 09:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1532677609; x=1534492010; bh=K6PBwdzWw+24c8i9MHjBwU7vZ78QdEdaIlO
        h4JI+/4E=; b=wVRpZ3a1yX7y6OnVZRttfugeYmrRR0WpE5cTW7CMGD89oetHIk+
        kShPveC6+dF6Ee6UHjY6LtijaNacDxQnbKVccpEC/JMYtOjBnQK9Tz6lDdgExABP
        3mQFeGi2LSJSkzlSXxjf7YiFuia6HPzvXrYpasr+or9egtPF5Mt93kTi4KBNZNkk
        fxERfOztmELBHsI/ffzTJs5T7hRp3G/RwKBX7URd5LIPazJhblmKoXWbJZk28a36
        dOjc6UyYK8D9dI47FTWRNUivMyvD0DPJUGsLs5HGWr+rTqpQ0VLpV7FfdLYHBGDm
        +uBcLnzcK4zrgkQknWjzom9WbJaijiXBxBWE5zXuDFugN/Dh7kNA3f6MUVot2e9h
        hUjcP8hq5PrxrBYgEQJdfQ71IcMe4UOFqwajDbvDwCF0RYZJetkH+NxtNNmGeUME
        A+PHCfYXoYQ3YRNY4zpxNYGCWvWhbVSCO5eeJf7Apkbzl6G6F0U55eosx2CkprdK
        EEkLLnQyIT56FMtXMWLCWwCzuKdNUJRtOObmUkVx3IeD108LMGF1fvsI2K1zk2JM
        9y3nP5vMo6/9zGncyGoHZIAySbYYhGbGa3BBuMECGrJnlDKUgr/asp7XIywW2+Yh
        +ueQTMdaKCr5P6+gUw9bIc/jls5s/uBGiKgaYKwlI/krfhIZp3h9QJ3k=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MXPVOOudFRNr; Fri, 27 Jul 2018 09:46:49 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id EF1D62A4;
        Fri, 27 Jul 2018 09:46:48 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 9AEEBA20;
        Fri, 27 Jul 2018 09:46:48 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH 2/2] doc:it_IT: translation for kernel-hacking
Date:   Fri, 27 Jul 2018 09:46:47 +0200
Message-ID: <1944849.qmSSJrysef@pcbe13614>
In-Reply-To: <20180726162330.786826cf@lwn.net>
References: <20180706220517.28623-1-federico.vaga@vaga.pv.it> <20180706220517.28623-3-federico.vaga@vaga.pv.it> <20180726162330.786826cf@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I know, but I believe they are still good documents if read with a bit of 
pragmatism: many concepts there are evergreen. Then, it clearly says 
"unreliable" ;P

Your wonder, make me wonder. Generally speaking, how readers can understand 
how old is a document or if it still correct (in the sense that the document 
and the correspondent code are in sync)? Clearly here it says that it has been 
written for Linux 2.6, but most documents do not say anything about the last 
significant review/update. This let people think that documentation and code 
are always in sync. How this is handled? Just by enforcing people to update 
the documentation when they change, for example, an interface that has been 
documented?

On Friday, July 27, 2018 12:23:30 AM CEST Jonathan Corbet wrote:
> On Sat,  7 Jul 2018 00:05:17 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > This patch includes the kernel-hacking translation in Italian (both
> > hacking.rst and locking.rst).
> > 
> > It adds also the anchors for the english kernel-hacking documents.
> 
> Applied, thanks.  Though I do have to wonder a bit, since these documents
> are ancient and haven't seen a lot of maintenance in recent times...
> 
> jon


-- 
Federico Vaga
http://www.federicovaga.it/


