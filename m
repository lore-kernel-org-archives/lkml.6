Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CBEC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF47F20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF47F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeLAPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:20:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:35470 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbeLAPUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:20:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 20:08:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="255228081"
Received: from tsutanto-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2018 20:08:06 -0800
Date:   Fri, 30 Nov 2018 20:08:05 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Abuse <abuse@2.abuse.bgcomp.co.uk>
Cc:     David Miller <davem@davemloft.net>, axboe@kernel.dk,
        dave@stgolabs.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        dja@axtens.net, linux@dominikbrodowski.net,
        dri-devel@lists.freedesktop.org, edumazet@google.com,
        federico.vaga@vaga.pv.it, geert+renesas@glider.be, deller@gmx.de,
        corbet@lwn.net, kumba@gentoo.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, matthias.bgg@gmail.com,
        netdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        pabeni@redhat.com, paul.burton@mips.com, pmladek@suse.com,
        robh@kernel.org, sean.wang@mediatek.com,
        sergey.senozhatsky@gmail.com, shannon.nelson@oracle.com,
        sbrivio@redhat.com, rostedt@goodmis.org, me@tobin.cc,
        makita.toshiaki@lab.ntt.co.jp, willemb@google.com, yhs@fb.com,
        yanjun.zhu@oracle.com
Subject: Re: [PATCH RFC 00/15] Zero ****s, hugload of hugs <3
Message-ID: <20181201040805.GA14569@linux.intel.com>
References: <CAGXu5j+jBNBsD3pvUSfEh6Lc5T1YMpbM0HeG1c6BHiJe+cKVOQ@mail.gmail.com>
 <d7c34289-f03a-b641-cc9c-00395306511d@kernel.dk>
 <20181130.123507.1940310466680455876.davem@davemloft.net>
 <2007856.n5V9iKLVsV@eth7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2007856.n5V9iKLVsV@eth7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 08:39:01PM +0000, Abuse wrote:
> On Friday, 30 November 2018 20:35:07 GMT David Miller wrote:
> > From: Jens Axboe <axboe@kernel.dk>
> > Date: Fri, 30 Nov 2018 13:12:26 -0700
> > 
> > > On 11/30/18 12:56 PM, Davidlohr Bueso wrote:
> > >> On Fri, 30 Nov 2018, Kees Cook wrote:
> > >> 
> > >>> On Fri, Nov 30, 2018 at 11:27 AM Jarkko Sakkinen
> > >>> <jarkko.sakkinen@linux.intel.com> wrote:
> > >>>>
> > >>>> In order to comply with the CoC, replace **** with a hug.
> > >> 
> > >> I hope this is some kind of joke. How would anyone get offended by reading
> > >> technical comments? This is all beyond me...
> > > 
> > > Agree, this is insanity.
> > 
> > And even worse it is censorship.
> > 
> 
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> Fuck
> 
> I assume I will now be barred.
> 
> 

Thank you for taking the opportunity to practice free speech in the
always so welcoming and inclusive on-line world :-) Now I'll just have
to find my notebook and write this prose down so that I'll never forget
it. Thanks again.

/Jarkko
