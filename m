Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6659C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECEB208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFMYmyKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECEB208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeJEUrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbeJEUrX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:47:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42A62084D;
        Fri,  5 Oct 2018 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538747314;
        bh=TKzoi48WMJaXvILh5ub3jGs3aVGEfly1ygQ1R2wq8tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFMYmyKZymmPPF/m8jdBfWfrYtwrkcTe4VqHaWgRpzlSw1uDwPQEZN7a/J3Y/WOQo
         jm4OEmRLiL+eKA0A86F0SVdBka/KFUqJacCVD+qChbR2FSWY3d+XzkvT/f3a8wEGgf
         gNJUqXv+Huzt7wEQFVzpe0MSV3JddyLGvrJmaBjs=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 96D2C141DDC; Fri,  5 Oct 2018 10:48:31 -0300 (-03)
Date:   Fri, 5 Oct 2018 10:48:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf record: use unmapped IP for inline callchain cursors
Message-ID: <20181005134831.GA20250@kernel.org>
References: <20181002073949.3297-1-milian.wolff@kdab.com>
 <20181002153236.GD3541@kernel.org>
 <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f71ed02b-1234-db9c-6a48-1a399359b5e8@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 03, 2018 at 09:05:37AM +0530, Ravi Bangoria escreveu:
> LGTM.
 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

So, I've added this as a 'git rebase -i' 'fixup', i.e. kept the commit
log message for the patch this patch fixes, and combined the two into
just one patch so that we don't pollute the bisect history, since this
hasn't made it yet to tip, and I also added Ravi's Tested-by, since this
tests both.

- Arnaldo
