Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8D8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1E22082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+RgY96i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1E22082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJBWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJBWTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:19:47 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2AAA204FD;
        Tue,  2 Oct 2018 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538494549;
        bh=S3SSRpxZqKci1rxTG04Sjgeuq0PYuj9PdlSwJ2q5cFk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A+RgY96iKB+COd1ooNlnS3NkNcUDFc0MXki3iKZIIqnqB0R0xJWF+kAHF/wGB+WFG
         vlA54na17imLl7b3CS6lQ/ajFJ90QrPMQZbvaC3OnXtf+wJLsQsqqGNeFY2GlOUAgK
         Xc2bARjO2aexGDW35RCcUbdOfTLxaGOfDWepamQ4=
Message-ID: <1538494547.16568.1.camel@kernel.org>
Subject: Re: [PATCH v5 7/8] tracing: Add hist trigger onchange() handler
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 02 Oct 2018 10:35:47 -0500
In-Reply-To: <20181002165309.da3d63365ca774cf6b47b80c@kernel.org>
References: <cover.1538403550.git.tom.zanussi@linux.intel.com>
         <0a17743dc24db781ebe72dcae1306ea5d9a0f7ef.1538403550.git.tom.zanussi@linux.intel.com>
         <20181002165309.da3d63365ca774cf6b47b80c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, 2018-10-02 at 16:53 +0900, Masami Hiramatsu wrote:
> On Mon,  1 Oct 2018 11:18:07 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add support for a hist:onchange($var) handler, similar to the
> > onmax()
> > handler but triggering whenever there's any change in $var, not
> > just a
> > max.
> > 
> > Also, add a testcase for it.
> 
> Could you separate the testcase and document update from this patch,
> since those are maintained in different trees?
> 

OK, will do.

> And also, could you update <tracefs>/README so that the testcase can
> ensure the kernel supports this feature? Since the testcase
> (kselftest)
> will be used for stable kernels, it should check the kernel carefully
> and exit with "unsupported" instead of failure.
> 

Yeah, makes sense, will add that check.

Thanks,

Tom


