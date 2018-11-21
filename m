Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB75EC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FAF213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="AVRB8fmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FAF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeKUK4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 05:56:38 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:10736 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbeKUK4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 05:56:37 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id A2787405A4;
        Wed, 21 Nov 2018 01:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1542759882; x=1544574283; bh=S6X8pF/QJ8E99aXp0jIBcd84ZtL2Qj6mSDk
        uLpJLWmw=; b=AVRB8fmu1KRpy2rOuKYfcRCawpHuB5DiKZx+PDtJ7+R82Yc2jjR
        vZCS/q5aLIdGObFq5OTcfmvian49noFzltrKFevkS6/fIYEJJhWGVIvLEOqEj8ZH
        EGGHyDGdTwN5pjCfjxgQQUd3+BmsV+O9Hd7sUhlRC66LMY06QToJ9O3fmWsikZSe
        VEX4MqK1nqMKayLCEpWjkKaaD0PwkbMVXGOFZFHgdDFHM/U8DII3LB8JobYahxtF
        6chcUI9xMgrzsYcGUl9tp5SujG//bprr4lqE+nEOseSgpUkZuf8tGMoepxeXwaLN
        6mfVUAGOegdtp29A1eUnSiX9+Wr3vUPCyetbuS4TRQHQPLGhaecGsZXJwlyP7rRo
        xKX4W/DEfxtfQMbj4HLfYUOmgqueHk1Gsc55qOozcbCL9JYUB7/P+xi8pYYU1y2V
        9ShByJ0tszo6UdW9K/FHY1EV09slUfSLM0DXlsrrJfKEBRmFYG6ILJ5mH23iORVl
        bTUKG0Bc4kjm8cvoSiLN/n4r7GGXfl2/VNEjPsRIoj7BVrs1eQy55ffYkKYPurqI
        Wpa5GgayD4DFU2A3gjBQgQU8xQZOTyfvap/c/JIFJqL0FmiZfBNVc2+d+faEnpe4
        +jfz/IXf0kA2hgz6ujanIyTsU1gVPUGcJQ8gYfC2Fa6E0LRBBEdq9XrQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id THGu8Xb2aBFH; Wed, 21 Nov 2018 01:24:42 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 0A66B402AA;
        Wed, 21 Nov 2018 01:24:42 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id B53F92559;
        Wed, 21 Nov 2018 01:24:41 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Alessia Mantegazza <amantegazza@vaga.pv.it>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] doc:it_IT: update italian documentation
Date:   Wed, 21 Nov 2018 01:24:40 +0100
Message-ID: <2014691.yjRn1oZ3S9@harkonnen>
In-Reply-To: <20181120091610.35ebffee@lwn.net>
References: <20181108232417.14982-1-federico.vaga@vaga.pv.it> <20181120091610.35ebffee@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 20, 2018 5:16:10 PM CET Jonathan Corbet wrote:
> On Fri,  9 Nov 2018 00:24:14 +0100
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > In this small patch set there is the V3 of
> > "doc:it_IT: add some process/* translations" in which I fixed
> > the recent conflicts in docs-next.
> > I took the occasion to add other two simple patches that fix:
> > - a missing translation in locking.rst
> > - apply a patch from the official documentation to the italian one
> 
> OK, I have applied the set, apologies for taking so long.
> 
> I do have one request: there are an awful lot of entries that simply say
> "ancora da tradurre" in here; those are not going to bring much joy to
> your readers.  
> Can I ask that you try to reduce those in number, either by
> doing the work or concluding that it won't happen and just removing them?

If you refer to the empty documents, the idea is to keep all links working (as 
discussed a while ago). It will not change much if I remove them but I still 
say "see document XYZ"; at the end the document is not there or it says 
"translate me", in both cases the reader is not happy.  So, I would like to 
keep them anyway to simplify the job.

If you are refering to those I added in index files as place holders: yes I 
can remove them.

> No timelines or anything - I'd just be happy to see the work go in that
> direction.
> 
> Thanks,
> 
> jon




