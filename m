Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B718C2F3D5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587A120861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080140;
	bh=RfUTqCvBl0Q0hDOb5vdkPynghlp9gn+QdOZFBkYiA54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o0JL2UjWNY9T5h2u6r45Y+BKnfeMlC70g+zTnQgIB1plFp9useYMehUaZg4Vc8Id9
	 Dsc6UG8QZzWJo0KSuPqWm03KbqpD6eM6F/qmecNa3C5gnPLY86XMu/EJt4bN1YdOxl
	 biFgo4uMt1cXahGdr4w6IeIw3X0O0qvjIS0+oEzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfAUOPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:15:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfAUOPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:15:33 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5AF120861;
        Mon, 21 Jan 2019 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548080132;
        bh=RfUTqCvBl0Q0hDOb5vdkPynghlp9gn+QdOZFBkYiA54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdElQTqAXEQ7NFltfGLoFdoaFw8B2GOunDPUjymJrAECBDonAMYXkawx+xTeN8ySI
         zdogCzKJsShkGV5+sU4gSKULE17WVH6nKlkJ93AvUKwL9S6ou+mkVVD+Ik839dcB0q
         9u6vf5s7k5rOiHv8C4+MOGxAs6GDUc71EQ4ZRZIY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDB3D4049A; Mon, 21 Jan 2019 11:15:29 -0300 (-03)
Date:   Mon, 21 Jan 2019 11:15:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Tony Jones <tonyj@suse.de>, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>, jolsa@redhat.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: fix crash when processing recorded stat data
Message-ID: <20190121141529.GB15707@kernel.org>
References: <20190120191414.12925-1-tonyj@suse.de>
 <aebdb574-66d2-9135-a6d0-3cd985abfc2f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebdb574-66d2-9135-a6d0-3cd985abfc2f@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 21, 2019 at 11:16:26AM +0530, Ravi Bangoria escreveu:
> 
> 
> On 1/21/19 12:44 AM, Tony Jones wrote:
> > While updating Perf to work with Python3 and Python2 I noticed that the 
> > stat-cpi script was dumping core.
> 
> [...]
> > Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
> > Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks, applied. Added your tby and Jiri's rby.

- Arnaldo
