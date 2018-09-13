Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F2C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C59204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 08:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C59204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeIMNNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 09:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25617 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeIMNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 09:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FCE188E64;
        Thu, 13 Sep 2018 08:04:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3D26C30912F4;
        Thu, 13 Sep 2018 08:04:40 +0000 (UTC)
Date:   Thu, 13 Sep 2018 10:04:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Compiler flags for libapi and libtraceevent
Message-ID: <20180913080439.GA24224@krava>
References: <7cfcd0da8aba77488feb7403055596d434772545.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cfcd0da8aba77488feb7403055596d434772545.camel@decadent.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Sep 2018 08:04:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 04:06:46AM +0100, Ben Hutchings wrote:
> I noticed that tools/lib/api/Makefile has these conditional
> assignments, similar to tools/perf/Makefile.config:
> 
> ifeq ($(DEBUG),0)
> ifeq ($(CC_NO_CLANG), 0)
>   CFLAGS += -O3
> else
>   CFLAGS += -O6
> endif
> endif
> 
> ifeq ($(DEBUG),0)
>   CFLAGS += -D_FORTIFY_SOURCE
> endif
> 
> But it doesn't set DEBUG to 0 by default, and nothing under tools/perf
> exports its value of CFLAGS or DEBUG.

hum, AFAICS tools/perf/Makefile.perf exports CFLAGS:

export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK

jirka

> 
> tools/lib/traceevent/Makefile doesn't seem to have any logic to enable
> optimisation or Fortify.
> 
> Shouldn't these libraries both have optimisations and Fortify turned on
> by default, like perf itself?
> 
> Ben.
> 
> -- 
> Ben Hutchings
> Computers are not intelligent.	They only think they are.
> 


