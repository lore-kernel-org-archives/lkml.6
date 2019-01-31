Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23325C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA72087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="YKYYufjE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OQYGaN8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfAaIwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:52:09 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45881 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfAaIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:52:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1DEF72010;
        Thu, 31 Jan 2019 03:52:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 31 Jan 2019 03:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fVvqtshcW3aQ/fCzF3Idj5wTT7L
        AWXWjPWnicnLXBQU=; b=YKYYufjEdGtvRUN8vPDv4LMSdt0+Xym/egEtYMCpiLB
        V5+fkvE26N+Pofy2akjpvYZxa7WUUTcPpZd7SMiDx+QVgEHVq36qfKwhQRnsToew
        YQJFI0SR7caVBqulssTpnseQxQIJnpUAx2gtf/18/Us3OygXJaPSyWZk/iQtcdr0
        gIAgHph10pubckWQysDfJOHXNr+s6q52j7a1penC/xABGHSt83MP50aIQTYAjLTT
        Wues5zYYBq/RYigODJvdA9LOsafKUyHIxvar+ioHjHO575Aex1y9Xj4a97dKFEf6
        yro4R04OHwmVXFyDtIhD+uGPOAFTktmFz+kd5oR3Hlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fVvqts
        hcW3aQ/fCzF3Idj5wTT7LAWXWjPWnicnLXBQU=; b=OQYGaN8zVA74Ld/UTcwIJI
        WP3knQxhG+KbEmjVJ3plFO8GBE39iu+dfo9ArI3ECPtU/SUUXQuIG46e62Tn7Olz
        Ff0wVNjwj+0qgfbHCFl6VXnaTCcs5VHNSVDqi4GcbB+xGelhakWl9mPJtlIoKSEH
        MUaEERXQADdne7PnB+zOrmPgiHF8OXnTjdZWQaJXNUNQAEdlISZnG4KEkSp64Cot
        /FjQcvEAWc+wcATPoO3TiRD8FBDNuFLLTC7mCbjokSZRe4jxjP/VsA4lQ+Zk6dJD
        cRHPYqEY4woPNXSMIp9wabPoHJE7LFL/lGYcsKCf9bZUdiyRGjjt1hLCFQUDDqwQ
        ==
X-ME-Sender: <xms:MrdSXGCXafpvRCD0XQ0LAG1j3evpPI0Zbh2D1JZazdyLHOeNPm5RVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrjeehgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculdeftd
    dmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdforedvnecuhfhrohhmpedf
    vfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosghinhdrtggtqeenucfkph
    epuddukedrvdduuddrvddufedruddvvdenucfrrghrrghmpehmrghilhhfrhhomhepmhgv
    sehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:MrdSXIQ3QDL0fzH1kICB-JFxLUROfuvRlrrcvgBDGBC04VqWT5XjFQ>
    <xmx:MrdSXMq2SSdeIhRQymvWgxx8hpu5l-kBzRNuOsJqjx64i2NKjrG6xQ>
    <xmx:MrdSXCzRZa0grsWLxLCnYFI8sRFnMskUbuNLF6e6tESFuVqqoAWYCg>
    <xmx:NLdSXFQ6D4W43LDdvv_YXapYzxHHW7WZ2iZa6QHMHkrvIW7PNxzszg>
Received: from localhost (ppp118-211-213-122.bras1.syd2.internode.on.net [118.211.213.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63A9FE412C;
        Thu, 31 Jan 2019 03:52:01 -0500 (EST)
Date:   Thu, 31 Jan 2019 19:51:53 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Christopher Lameter <cl@linux.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] slub: Fix comment spelling mistake
Message-ID: <20190131085153.GB23538@eros.localdomain>
References: <20190131041003.15772-1-me@tobin.cc>
 <20190131041003.15772-2-me@tobin.cc>
 <9C8C1658-0418-41A9-9A74-477DB83EB6EF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C8C1658-0418-41A9-9A74-477DB83EB6EF@oracle.com>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 01:10:21AM -0700, William Kucharski wrote:
> 
> 
> > On Jan 30, 2019, at 9:10 PM, Tobin C. Harding <me@tobin.cc> wrote:
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> > include/linux/slub_def.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> > index 3a1a1dbc6f49..201a635be846 100644
> > --- a/include/linux/slub_def.h
> > +++ b/include/linux/slub_def.h
> > @@ -81,7 +81,7 @@ struct kmem_cache_order_objects {
> >  */
> > struct kmem_cache {
> > 	struct kmem_cache_cpu __percpu *cpu_slab;
> > -	/* Used for retriving partial slabs etc */
> > +	/* Used for retrieving partial slabs etc */
> > 	slab_flags_t flags;
> > 	unsigned long min_partial;
> > 	unsigned int size;	/* The size of an object including meta data */
> > -- 
> 
> If you're going to do this cleanup, make the comment in line 84 grammatical:
> 
> /* Used for retrieving partial slabs, etc. */

Nice grammar, I didn't know to put a comma there.  Will fix and re-spin.

> Then change lines 87 and 88 to remove the space between "meta" and "data" as the
> word is "metadata" (as can be seen at line 102) and remove the period at the end
> of the comment on line 89 ("Free pointer offset.")
> 
> You might also want to change lines 125-127 to be a single line comment:
> 
> /* Defragmentation by allocating from a remote node */
> 
> so the commenting style is consistent throughout.

Will do with pleasure, thanks for the tips (and the review).

thanks,
Tobin.
