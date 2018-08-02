Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312442151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUfZRHsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312442151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbeHBPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbeHBPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yG0Vv7mIMpj2uHdH0SVQ/3lbG2nmHXUf9SV1gloRVfY=; b=VUfZRHsTeeS3dXQxRinThtz4P
        /s66AOL/eKYpmKsRBHKIm8wsl9uhkOjYauMLU6guTxJg4wI/9O7suL6Iay9mE1yzuZcHPgkw1/bjk
        QBG6oX5+8U5Z5xguSak+mi0K9BIm5WRF9qYxW0c0JtKpQf7M41DxETjqBDin9aXorTkdeQZ8rY0CV
        snhqKWr0pO3BbEjdLnWyh4DLnb4ddG3HdcMHVnpEuenAqpvjcELmqwhcY/+Xxi6xUMfM3AsdRO9HP
        KpWoXGElZqU37wXnrJAA59aNGmYK1S4vfmkWJF5no5p1XQxiZFa9d0dpRGjFPyIiC/tzIS2X8fToO
        oV5rcQMIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flDhW-0003tA-Ct; Thu, 02 Aug 2018 13:31:34 +0000
Date:   Thu, 2 Aug 2018 06:31:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] A novel case happened when using mempool allocate
 memory.
Message-ID: <20180802133134.GA11845@bombadil.infradead.org>
References: <5B61D243.9050608@huawei.com>
 <20180801153713.GA4039@bombadil.infradead.org>
 <5B62A30B.9000008@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B62A30B.9000008@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:22:03PM +0800, zhong jiang wrote:
> On 2018/8/1 23:37, Matthew Wilcox wrote:
> > Please post the code.
> 
> when module is loaded. we create the specific mempool. The code flow is as follows.

I actually meant "post the code you are testing", not "write out some
pseudocode".
