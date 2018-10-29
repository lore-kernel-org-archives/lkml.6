Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2042C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5604820870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vw65rX1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5604820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeJ3Co4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeJ3Co4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:44:56 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1144E204FD;
        Mon, 29 Oct 2018 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540835716;
        bh=QcuORfmAL79u8PDA5uSbC3+wJDnCwX962HhcfXHQcqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vw65rX1bP+YSmSfPvG+obBGqRkUmb2+1tSzWkHC/Q+hLtr1TpJ04fPKQEiLdJKGgI
         6Yg4cuj+1qoOFFHOFVV8Ua0ply+v7LO5U3nEIiYUgIwaSuZgzIWo3x0ZjBfoTMmq0R
         sMSKduu5vRh0T6rA3X+ARMotVhvSEXxBrxZzKMxA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 382A1142C5F; Mon, 29 Oct 2018 14:55:14 -0300 (-03)
Date:   Mon, 29 Oct 2018 14:55:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        kan.liang@intel.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
Message-ID: <20181029175514.GI21857@kernel.org>
References: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
 <20181029130331.GC21857@kernel.org>
 <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
 <20181029.104008.791032322062574758.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029.104008.791032322062574758.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 10:40:08AM -0700, David Miller escreveu:
> From: "Liang, Kan" <kan.liang@linux.intel.com>
> Date: Mon, 29 Oct 2018 10:33:06 -0400
> 
> > I just realized that the problem in KNL will be back if we switch
> > back to non-overwrite mode.
> 
>> What is KNL?

I guess its Knights Landing.

https://en.wikipedia.org/wiki/Xeon_Phi

- Arnaldo
