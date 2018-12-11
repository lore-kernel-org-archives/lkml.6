Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3784C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A8220849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544526802;
	bh=CKjsjZUyOJXW33h2HbkaXJ2rcsiboFHzVLHGKme2a9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kqt37mP97FuNmU7JTNIBMGtNlmMTZvP8r6YsESXYRtUXjVbWyTx28XAt8aTJBPL3j
	 2cl21hsSfZysDJqSQdeEiuZ0vjj7RhaWqmBiCE2R/By0jsLENHbj7RoaVuLmCqrwVN
	 ia+7TO/hrqa6c3f5WcLBlfyBaMPT4IC68VpRMeeA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLKLNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:13:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbeLKLNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:13:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40FDFABC1;
        Tue, 11 Dec 2018 11:13:19 +0000 (UTC)
Date:   Tue, 11 Dec 2018 12:13:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org, bp@suse.de,
        pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        hpa@zytor.com, jkosina@suse.cz, ak@linux.intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/speculation/l1tf: Drop the swap storage limit
 restriction when l1tf=off
Message-ID: <20181211111318.GH1286@dhcp22.suse.cz>
References: <20181113184910.26697-1-mhocko@kernel.org>
 <tip-f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48@git.kernel.org>
 <20181211090056.GA30493@gmail.com>
 <alpine.DEB.2.21.1812111147300.8611@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812111147300.8611@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 11:47:52, Thomas Gleixner wrote:
> On Tue, 11 Dec 2018, Ingo Molnar wrote:
> > >    off		Disables hypervisor mitigations and doesn't emit any
> > >  		warnings.
> > > +		It also drops the swap size and available RAM limit restrictions
> > > +                on both hypervisor and bare metal.
> > > +
> > 
> > Note tha there's also some whitespace damage here: all other similar 
> > lines in this RST file start with two tabs, this one starts with 8 
> > spaces.
> 
> Fixed...

Thanks Thomas! I haven't noticed a different whitespaces and relied on
whatever vim decided to do.

-- 
Michal Hocko
SUSE Labs
