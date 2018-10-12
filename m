Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6384C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870320868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e+PXqgWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5870320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeJLXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:06:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbeJLXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2sA5tfTIvEaM1qI/0e0pM/CTxPXfKw1bix9vslNlRFc=; b=e+PXqgWeoiwEAiL0vDGP9kpB24
        g7eeCrewsOF01UpG8JkrtgzEVOF7Ynh5xsOIU4NAEUATFkvGuG+5Dv/diw6FMLTJZ8PP63CkYOCfy
        KwaRIIhRrQNANB8tfrgdLGcpCsqKzCgoISd3DQwqjz7W5MDmgHe0oI0q+120S/EgKci6xR42ay8S9
        PIdqtBp4Q1JyByBvL1NGAsy6xWl7gsBjw3cJdnP8w5R+oKPr2fzeOflMGHZVIQPb5Vwkdjg3qsp6H
        DwZKzefSJVftVV3jbrpe+pwDB/2Eax1RQUV8kIwv9UWYQyz2ac3JQBQwnBJmIcnBVPHxaW7dTv2bC
        yJw+YV1Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAzRV-0001ii-Pv; Fri, 12 Oct 2018 15:33:33 +0000
Subject: Re: [PATCH] rxrpc: add IPV6 dependency
To:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20181012123624.2001922-1-arnd@arndb.de>
 <24845.1539354316@warthog.procyon.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <233e57a0-c01d-82fd-0522-b80345d37416@infradead.org>
Date:   Fri, 12 Oct 2018 08:33:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <24845.1539354316@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 7:25 AM, David Howells wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> +	depends on IPV6 || !IPV6
> 
> That looks weird.  It looks like it always ought to be true.

It's a common idiom in Kconfig.

It prevents AF_RXRPC=y and IPV6=m, resulting in this build error.

-- 
~Randy
