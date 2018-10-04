Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0442C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9376E2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaq2eOkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9376E2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJEDYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:24:45 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:41182 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:24:45 -0400
Received: by mail-yb1-f178.google.com with SMTP id e16-v6so4466436ybk.8;
        Thu, 04 Oct 2018 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YiK7lyO7b2aJXcB42eMi3FeR2xojGMX2RNKuvQuI354=;
        b=uaq2eOkFmUbNpetu1c60s5D+IqUxSSfO9pQxGrIUu7FY/ndIBVnRJNO8AUPjYhbWNh
         z+NtbTHPpUZdFauZoJ2a472aQ+407/2g+OFqcTQ3EcYu9uSJ2ewtoTWJzr+z1CbiBUq7
         EnO32/7sM2CdYIK3FnxrWlIxtQ5ytpPFFDs6Abt9ctobGJmPrsMIhu5hnXHMOZYu/xC4
         t9M/iyeTYH/Ok7uO7TsxkyVT9AQh5dSa8FaZFGMInPm062lOBTSlUeOfuQvlDTgORX+z
         7HPMr3x6kQGTnU78bnG2+2yeWAne7kNQVWFH2Q8eXw/wL38KeqmBOewcUpu5CUdOlUBq
         J8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YiK7lyO7b2aJXcB42eMi3FeR2xojGMX2RNKuvQuI354=;
        b=qAxmyjYrptwTzxvx8WA++jKdQhERMAWmer3XY10XKlliV/cWWwevjN2TTViIXAp8SC
         dSSPlkQTxPru2ruSRwkcz8RiLMifSHtB8a5X64ONr/hNH6ogDpejVaAoVIlyohB/+Gpp
         HJX17SiKUVS9kXbVJsaP3s8UMcBO4KtBa4El6nEFUpmHbqxHYsi3YqUTmGHB/O+uAZ5P
         YhAFWPJ+l92a5qUUdHuWs4vyO0/321kqg8O5laSsIiWgJcqKN3lo7GfeyNIPnQUw4fnL
         20+4SpIRLftJkkAUwOyqZN1WvhBWd3rtF8ipnKZpbtpCaxq2PKg3CyCje0AxuDmEcr5P
         9n6Q==
X-Gm-Message-State: ABuFfojwLtMfX11/IYWyoCTZ4ZMuYSuSR69i3wg1q+dGZXhJeXbkBfcR
        GI3YcUpvcGIEG6tAmHNDM/s=
X-Google-Smtp-Source: ACcGV611+5GvD9iQr4dcxE2kpU8UST3ie3lgXPUU/ZL5m3+jmynlQaOx7mjT/BalxeVbJYBhhamO3A==
X-Received: by 2002:a25:74ce:: with SMTP id p197-v6mr4675444ybc.343.1538684990609;
        Thu, 04 Oct 2018 13:29:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::7:7472])
        by smtp.gmail.com with ESMTPSA id u79-v6sm551541ywe.110.2018.10.04.13.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 13:29:49 -0700 (PDT)
Date:   Thu, 4 Oct 2018 13:29:47 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Amin Jamali <ajamali@pivotal.io>,
        Joao De Almeida Pereira <jpereira@pivotal.io>
Subject: Re: Cgroup v2 bug: "domain invalid" node can't be converted to
 "threaded"
Message-ID: <20181004202947.GL270328@devbig004.ftw2.facebook.com>
References: <CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com>
 <20181002210741.GJ270328@devbig004.ftw2.facebook.com>
 <0cf4f9de-70d2-cf94-12d2-283759638e20@gmail.com>
 <20181004182017.GK270328@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004182017.GK270328@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 11:20:17AM -0700, Tejun Heo wrote:
> Subject: cgroup: Fix dom_cgrp propagation when enabling threaded mode
> 
> A cgroup which is already a threaded domain may be converted into a
> threaded cgroup if the prerequisite conditions are met.  When this
> happens, all threaded descendant should also have their ->dom_cgrp
> updated to the new threaded domain cgroup.  Unfortunately, this
> propagation was missing leading to the following failure.

Applied to cgroup/for-4.19-fixes w/ reported-bys added.

Thanks.

-- 
tejun
