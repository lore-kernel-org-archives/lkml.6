Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498BDC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E6D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 02:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="UZHxwbTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E6D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=python.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJWLBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 07:01:55 -0400
Received: from mail.python.org ([188.166.95.178]:60286 "EHLO mail.python.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeJWLBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 07:01:55 -0400
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 42fHgT45TLzFqqN;
        Mon, 22 Oct 2018 22:40:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1540262438; bh=ZAictPMw/x6V6IPhaeBVpptYBwiVBlcZ3lMFeS2ahco=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UZHxwbTrxYZzCiYcDid+bUEJKIAsD8kf8RNLOuxaLZX42P4jNYPRMc3qRJB2I5IYy
         yYJmfSeNk0S5xDWeQUHuW6XLywSpNEPEGuc7XlFIdzoMznBak5HtV/VKDwflvJ4r9t
         xuZQo4XWd7yyo1Vt356YXunQwCN20U9EvAMBXeSg=
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 29EFA21FEC;
        Mon, 22 Oct 2018 22:40:36 -0400 (EDT)
Received: from web6 ([10.202.2.216])
  by compute4.internal (MEProxy); Mon, 22 Oct 2018 22:40:36 -0400
X-ME-Sender: <xms:I4rOW67PDAP5vCvqyL0ZS0_KjbblYWqtJZwU6WFLWQfTIqdrXrNmPQ>
X-ME-Proxy: <xmx:I4rOW3MSUFPqh3sWYOy7WSfzTGSerkYqP69S3RB1w7oT8b1wT7uUGA>
    <xmx:I4rOWyIj-FmV69OnhIpbtUeQFp7uRcoxtwCrXmQlt3VsJrrks-woWg>
    <xmx:I4rOW4HKaUVgrCpGw1S9KW6oRy2ZHm3H2fhRxGup2ghuvaYI29Ndsw>
    <xmx:I4rOW6ScrRAxyJwXKw-urr9VDVFxhI_8RlBR2ilKRDw2UCTO9J9eBg>
    <xmx:I4rOW0H1blGuFBIIu434vLCtcPEScBPXDgByocXcLGEv0hyKd6uCyg>
    <xmx:JIrOW6INluNHoZ-HcrXlkOSfjItZCkJmIVXOpSbBsp6G8GVvrl_t5A>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 4F1354274; Mon, 22 Oct 2018 22:40:35 -0400 (EDT)
Message-Id: <1540262435.2865915.1551182688.3057DD9D@webmail.messagingengine.com>
From:   Benjamin Peterson <benjamin@python.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-b315a288
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
References: <20180828035344.31500-1-benjamin@python.org>
 <20180830182848.GE6097@kernel.org>
 <1535665851.2058334.1491869472.4E860103@webmail.messagingengine.com>
 <1539143546.2716467.1536750504.65ADF11A@webmail.messagingengine.com>
 <20181010125506.GH10775@kernel.org>
Date:   Mon, 22 Oct 2018 19:40:35 -0700
In-Reply-To: <20181010125506.GH10775@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 10, 2018, at 05:55, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 09, 2018 at 08:52:26PM -0700, Benjamin Peterson escreveu:
> > Hi Arnaldo,
> > Did you get a chance to look at this again?
> 
> Thanks, for pinging me about it, will check.

Will the main part of my patch manage to make the cut for 4.20?
