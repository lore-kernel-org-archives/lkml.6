Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D125C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174AA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDcrBYFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174AA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966640AbeFSPQ1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966451AbeFSPQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:16:25 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504E52075E;
        Tue, 19 Jun 2018 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529421384;
        bh=X5xrH1ZRoOoB9wLsakdVaMaEZuusmQvJ1e0Ca2y/gVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDcrBYFbUrfLpkucttWmsVYfD2wYG/5+/wjjLDRyxc8mjQQhS0rRqNvuqg/w0e2/9
         sEEmXYYs4d00VnDaNNRyMiehuzeOcgzbR+misEGvXuMQOqhhVpBfA0gkvSdwqAKSLL
         fJu+4FO1zPyCygCXxgwhPlPlBWGt1WAWTkwaditM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 088CE1401E5; Tue, 19 Jun 2018 12:16:22 -0300 (-03)
Date:   Tue, 19 Jun 2018 12:16:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/3 v2] perf alias: Rebuild alias expression string to
 make it comparable
Message-ID: <20180619151621.GI20477@kernel.org>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
 <20180615101105.47047-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615101105.47047-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2018 at 12:11:04PM +0200, Thomas Richter escreveu:
> PMU alias definitions in sysfs files may have spaces, newlines
> and numbers with leading zeroes. Some alias definitions may
> also appear in JSON files without spaces, etc.
> 
> Scan alias definitions and remove leading zeroes, spaces,
> newlines, etc and rebuild string to make alias->str member
> comparable.
> 
> s390 for example  has terms specified as
> event=0x0091 (read from files ../<PMU>/events/<FILE>
> and terms specified as event=0x91 (read from JSON files).

Applying, I think Jiri agreed with this one in the v1 post, right?

- Arnaldo
