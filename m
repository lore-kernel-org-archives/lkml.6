Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA9C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270E420671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzxExb8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270E420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeJXE11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJXE11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:27:27 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9567220671;
        Tue, 23 Oct 2018 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540324953;
        bh=GBQ+SCspG3Nehgv6hkQ2wMExedkSBtfhZ00Av79nLHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzxExb8Gy5B6pUu1rwz3jp0gtsO/JdnHs3ikUqIJo/b8FMTpi414f9frIC4yhygqB
         CMm3hB8a7GNT+NlSm03l7IJIUUp7WbZjKTWvd5dGyPmnKgZJS5PfYPdxhgcKTmy4Q4
         WCWy0gYGqj5/YPMbYZ1H7qiTf91JJ0pzAvtfRi2s=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7F14D142C5E; Tue, 23 Oct 2018 17:02:30 -0300 (-03)
Date:   Tue, 23 Oct 2018 17:02:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
 Add All branches report
Message-ID: <20181023200230.GE6114@kernel.org>
References: <20181001062853.28285-18-adrian.hunter@intel.com>
 <20181023075949.18920-1-adrian.hunter@intel.com>
 <20181023181218.GB6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8A4D@IRSMSX106.ger.corp.intel.com>
 <20181023192935.GD6114@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C2B8AA7@IRSMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C2B8AA7@IRSMSX106.ger.corp.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 23, 2018 at 07:57:17PM +0000, Hunter, Adrian escreveu:
> > -----Original Message-----
> > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > Sent: Tuesday, October 23, 2018 10:30 PM
> > To: Hunter, Adrian <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>; Andi Kleen <ak@linux.intel.com>; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH V2 17/19] perf scripts python: exported-sql-viewer.py:
> > Add All branches report
> > 
> > Em Tue, Oct 23, 2018 at 06:41:17PM +0000, Hunter, Adrian escreveu:
> > > > -----Original Message-----
> > > > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > > > So, I followed the instructions then ended up with:
> > > >
> > > > [acme@seventh perf]$ find /usr/local -name "*xed*" | head
> > > > /usr/local/lib/libxed.so /usr/local/lib/libxed.a
> > > > /usr/local/lib/libxed-ild.so /usr/local/lib/libxed-ild.a
> > > > /usr/local/include/xed /usr/local/include/xed/xed- syntax-enum.h
> > > > /usr/local/include/xed/xed-attributes.h
> > > > /usr/local/include/xed/xed-build-defines.h
> > > > /usr/local/include/xed/xed-cpuid-rec.h
> > > > /usr/local/include/xed/xed-flags.h
> > > > [acme@seventh perf]$
> > > >
> > > > Ran ldconfig as root, etc:
> > > >
> > > > [acme@seventh perf]$ ldconfig -v -N | grep xed
> 
> What about:
> 	ldconfig -p | grep  xed

$ ldconfig -p | grep xed
$ echo $LD_LIBRARY_PATH 
/usr/local/lib
$ ls -la /usr/local/lib/libxed*so
-r--r--r--. 1 root root  132840 Oct 23 14:52 /usr/local/lib/libxed-ild.so
-r--r--r--. 2 root root 6842688 Oct 23 14:52 /usr/local/lib/libxed.so
$ ldconfig -p | grep xed
$ 
