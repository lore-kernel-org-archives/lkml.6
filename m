Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D47C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAA1208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nKq4FbEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAA1208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934085AbeGIRmY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:42:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39483 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933757AbeGIRmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:42:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id h20-v6so5716053wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4/uMPH8OsYDWz56eKbhlMN5vxkCE6Fymwy8jti6KZJE=;
        b=nKq4FbEuPSAaiGr4if0vo7KLuaxhNhtM5LrofANdsv2wspxe3vLe+miJGCCDd7GLfT
         YpOpnEbTGwlA5m9emS0bs/8Fm3KFaF81X3hyyoiSD7Xq0FnGTFV24ngbTqNuquXcNLpG
         uqe3yIxScIE8QES9ZtkWxa05kWtI5655J2EuEoSpRdlZuJ2/lethaqouTWz7mmqyFp+U
         GB3s2gT0YBopFpc9qKMR9yIguWL6bJwYFeGYin7Sq/9lpGRHlJP8T4ZBTWMsiV8R7ktg
         g0ONn16q0rNF2Fc60B2xGcxGbGTurGzKm7ZfmcEal74/OmcMTAbhFsw8zUCtNxS34Tjj
         +GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4/uMPH8OsYDWz56eKbhlMN5vxkCE6Fymwy8jti6KZJE=;
        b=hPt1OeXob6vGRfypqdkKhD+FsEUgP5gfpnn5nzxuCEb53SAJ2kiBffZHYNFTtoo2aD
         DkyA1ooq2n7VhiEEf/+P0G4LTUae+y5aJJc7smBzSb3Yawovt4uk7loJ4Ut/XW/wZl/T
         8NYh73rhwcPluqJ/e+48Ofqs6+hhjn0Rfd9jxgKilvMpTucZMHFz2sXmMZj+u/iTTWJz
         bf71QAHbfeAWjz6kokXrundkYXrZy7NJg2Uzr/fB1G17nHQWXvaAnR1gy+0zYS3+GNqz
         /URbP4+CcgyP8QxTKA8HL1cxVEC7GstSgV4jINnXah4R/Loe51wgoeidfr9aeW3bt3q1
         aAsA==
X-Gm-Message-State: APt69E0hxwcdjDJyBaSgqiLemeDIcnycq9Fro62YaPIOEXceurJc+oaF
        s888pIrAJSxucoivEWcAmu1ikg==
X-Google-Smtp-Source: AAOMgpfBKT2McGTtywsfLQ/pbzkpVRaS/2oV5fycwHstO2AvMyETjORixpXv/nNOXPE0KrskbgAoLA==
X-Received: by 2002:a1c:b45:: with SMTP id 66-v6mr9371797wml.45.1531158141252;
        Mon, 09 Jul 2018 10:42:21 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i6-v6sm6410752wrr.10.2018.07.09.10.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:42:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fcaAz-0000k3-2j; Mon, 09 Jul 2018 11:42:17 -0600
Date:   Mon, 9 Jul 2018 11:42:17 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/cm: Remove unused and erroneous msg sequence encoding
Message-ID: <20180709174217.GA2658@ziepe.ca>
References: <20180704104801.912482-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180704104801.912482-1-Haakon.Bugge@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 12:48:01PM +0200, Håkon Bugge wrote:
> In cm_form_tid(), a two bit message sequence number is OR'ed into bit
> 31-30 of the lower TID value.
> 
> After commit f06d26537559 ("IB/cm: Randomize starting comm ID"), the
> local_id is XOR'ed with a 32-bit random value. Hence, bit 31-30 in the
> lower TID now has an arbitrarily value and it makes no sense to OR in
> the message sequence number.
> 
> Adding to that, the evolution in use of IDR routines in cm_alloc_id()
> has always had the possibility of returning a value with bit 30 set.
> 
> In addition, said bits are never checked.
> 
> Hence, remove the encoding and the corresponding enum.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/cm.c      | 14 ++++++--------
>  drivers/infiniband/core/cm_msgs.h |  7 -------
>  2 files changed, 6 insertions(+), 15 deletions(-)

Applied to for-next, thanks

I suspect the bits were probably added long ago for debugging..

Jason
