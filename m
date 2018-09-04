Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716402086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzZHdBcv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716402086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIDSeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbeIDSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:34:06 -0400
Received: from jouet.infradead.org (unknown [189.40.103.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3FA20867;
        Tue,  4 Sep 2018 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536070131;
        bh=L0ILM8k8l8ZXCe5EOrj6D+eDNvWr266N8MHoEiXXCsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzZHdBcvrXu4GLue/IAj9P73S9LAhYvN/sIo0v4+nb5qYcRr319sgmaHtVkXAV1d0
         gM7u4BX+JVEbpnQl0mMDQErK4tssbxKvwlC5P0QsurzCHe8oewJNuP08uh14YF1cQm
         Luiynre4cO8tuO46dykN/bZEHRZa5uRcpU+v3en0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E03EA141FFC; Tue,  4 Sep 2018 11:08:37 -0300 (-03)
Date:   Tue, 4 Sep 2018 11:08:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] perf tool improvement requests
Message-ID: <20180904140837.GB5364@kernel.org>
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net>
 <20180904134218.GA5364@kernel.org>
 <20180904135325.GI24124@hirez.programming.kicks-ass.net>
 <20180904135835.GA25298@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904135835.GA25298@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 04, 2018 at 03:58:35PM +0200, Jiri Olsa escreveu:
> On Tue, Sep 04, 2018 at 03:53:25PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 04, 2018 at 10:42:18AM -0300, Arnaldo Carvalho de Melo wrote:
> > > So, use 'c2c record' to get the samples:

> > IIRC that uses numa events and is completely useless.
 
> I guess perf record on any other event would work
> in Arnaldo's workflow

Right. I should've avoided useless events ;-)

- Arnaldo
