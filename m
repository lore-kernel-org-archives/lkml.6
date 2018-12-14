Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D4FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3414520675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tB4Pwqok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbeLNNuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:50:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3fBVwhQqeDeNgUc/wixhOKgwO7UP8XyEloNqdB7IBHs=; b=tB4PwqokB8jNc4LuFeI3v+jh2
        o3GVtvAKpJfTf4vV+wo+lEg5K0/cRMmmFYFaIB49+XiJXlZ2v2t2fOamMJq2ZCrJ9PqEOKp+9dNlD
        MS9a3srJhZw7yHnnMf+9wTbh6b3XH39FfuDoFaI+M4LsJH4BlZyUFVbY/TI2LfvaUQswRdTo8RKF9
        dUSpsfIsLqFGNI1DmTgJS2INTc1r23i6iQLq6YnTIDbMvXZIvor/G1nlRRvZkUlAW94Pq1AzDY38v
        nMt3r1vnIf1FoleqEwn1C9EW3z05LgEfXxBjdVULt9SgmUqZHGlBJLZ5BBduqu0HKUNQJtSBcTf0V
        SvzZqnQDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXnqr-00054u-En; Fri, 14 Dec 2018 13:50:01 +0000
Date:   Fri, 14 Dec 2018 05:50:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [LKP] [xarray] 93eb07f72c: RIP:__sanitizer_cov_trace_pc
Message-ID: <20181214135000.GA10600@bombadil.infradead.org>
References: <20181214083136.GB23332@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214083136.GB23332@shao2-debian>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 04:31:36PM +0800, kernel test robot wrote:
> initrds=(
> 	/osimage/quantal/quantal-core-x86_64-2018-11-09.cgz
> 	/lkp/lkp/lkp-x86_64.cgz
> 	/osimage/pkg/debian-x86_64-2016-08-31.cgz/trinity-static-x86_64-x86_64-6ddabfd2_2017-11-10.cgz
> )
> 
> HTTP_PREFIX=https://download.01.org/0day-ci/lkp-qemu
> wget --timestamping "${initrds[@]/#/$HTTP_PREFIX}"

I love that you're providing this service, but seriously, this is the
third report in a row that's just wrong.

--2018-12-14 08:48:21--  https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/quantal-core-x86_64-2018-11-09.cgz
Resolving download.01.org (download.01.org)... 104.90.64.218, 2600:1408:3000:28b::ae6, 2600:1408:3000:291::ae6
Connecting to download.01.org (download.01.org)|104.90.64.218|:443... connected.
HTTP request sent, awaiting response... 404 Not Found
2018-12-14 08:48:21 ERROR 404: Not Found.

--2018-12-14 08:48:21--  https://download.01.org/0day-ci/lkp-qemu/lkp/lkp/lkp-x86_64.cgz
Reusing existing connection to download.01.org:443.
HTTP request sent, awaiting response... 404 Not Found
2018-12-14 08:48:21 ERROR 404: Not Found.


