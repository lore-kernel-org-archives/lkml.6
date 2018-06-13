Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8752AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343B0208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 19:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhT8pZkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343B0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935709AbeFMT6F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 15:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935333AbeFMT6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 15:58:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFE41208C3;
        Wed, 13 Jun 2018 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528919884;
        bh=phDslmCmxCwZOUaNmv2G583LJWHVPYSeqZ04RG0lW7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhT8pZkxknovWzka0IV1QLd4z7p6RORctKa+toeqsmtdNuUl0imO34pvgZu3ov6r5
         eNCoz74YmSQYRDws2cz+kyjo2p65rwSc8d4J6JED9QQTgI8z3tMb9zkxhdU7drz9XD
         eoNnKwGwkfVSwtlzv3lt/vgi/ThsiZwecgIablyU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 6DD7B1450F4; Wed, 13 Jun 2018 16:58:01 -0300 (-03)
Date:   Wed, 13 Jun 2018 16:58:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Sandipan Das <sandipan@linux.ibm.com>, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH] perf report powerpc: Fix crash if callchain is empty
Message-ID: <20180613195801.GE2686@kernel.org>
References: <20180611104049.11048-1-sandipan@linux.ibm.com>
 <7fe2c26e-a5a7-3141-870e-c93558bb082b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe2c26e-a5a7-3141-870e-c93558bb082b@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 12, 2018 at 09:28:09AM +0530, Ravi Bangoria escreveu:
> On 06/11/2018 04:10 PM, Sandipan Das wrote:
> > For some cases, the callchain provided by the kernel may be
> > empty. So, the callchain ip filtering code will cause a crash
> > if we do not check whether the struct ip_callchain pointer is
> > NULL before accessing any members.
<SNIP>
> > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
 
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks,

- Arnaldo
