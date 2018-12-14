Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAC8206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544807872;
	bh=si89ryknyacgjP/yxP9B24vi2ZbJx27Y0wmVLKkHVzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=yp79Ral4HCFbJPQZx1X/wDguWLUdvhP1yRRGh2tPltTMGlpJC8twAKtMwscGdzC2t
	 eBnj7W75ZwklRM3nuIn49/G+4kzmaRQ2pDFS1P3zpsmffQ3cCFUPYtBk83zg40RYjI
	 lKKlvDg+JCcl0wVGRu7b/rfVQPg+B2H/zLlvchic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeLNRRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbeLNRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:17:49 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6BB3206DD;
        Fri, 14 Dec 2018 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544807870;
        bh=si89ryknyacgjP/yxP9B24vi2ZbJx27Y0wmVLKkHVzI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eSwGgQFE5R/tgzn233FWhQhLIH/nvK0McaXZCqaHjBPshbmBZcogw+MxzKI/VHz7A
         selFg5PEgQCsQE0HI+Sihp31/3d1zNSjtcQ90K7fdRMDchkgsEo8n/eP/NWwck3t/h
         Zmj2uwRoKCNhmXD0y/HX+k7Gmts/RtRxkdyPprZk=
Message-ID: <1544807867.10497.8.camel@kernel.org>
Subject: Re: [PATCH v8 12/22] tracing: Add hist trigger onchange() handler
 test case
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Fri, 14 Dec 2018 11:17:47 -0600
In-Reply-To: <20181215011810.61e1009d133fc1f999534d72@kernel.org>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
         <86f8570a993bd8b70e7d8a0260706736b59da2ea.1544483273.git.tom.zanussi@linux.intel.com>
         <20181215011810.61e1009d133fc1f999534d72@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, 2018-12-15 at 01:18 +0900, Masami Hiramatsu wrote:
> On Mon, 10 Dec 2018 18:01:26 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Add a test case verifying the basic functionality of the
> > hist:onchange($var) handler.
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> BTW, could you sort these test patches at the end of this series?
> (or at least after 2 features? since both depends on new
> onchange(var) feature)
> 

Sure, I'll move them down.

Thanks,

Tom

