Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B2FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CB020684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WB/vsaU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CB020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeKVMnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:43:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbeKVMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Xd491HEnuf+bk74bPJPG2oZIfbHa2OMGQrvUXvSbck=; b=WB/vsaU4L3jCME/FT/RF9a92C
        Dtbn+4eIZFZZcL7pDr2n2zGBfSL0EjRLgMaNRTubgRja7hX7jLPJWI5TMOqC0bIPa0bVIEAfaA5zv
        aBzuA53gR4lyaNZRLmSKNMiGLdRbrHvFeAlkF0b/3idCrT/mD+eX7YkMh4JsWlaL8XNmdPch7JZwl
        QMUkUwbeYY4fdDsyTPo1xBfFSROgyXuc0vleRxpwq4XwlknNxteftqzxsO31rR95WYs8ozAl783ZB
        QeXuREqORPNNAi+ovGkaLi4Eo7Vntwg73k2V06T3nYC1t1D4feikjn4DXFp8sBtbUMBSfp1jjHRJ4
        88BLmrUxg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeO2-0006IA-0P; Thu, 22 Nov 2018 02:06:34 +0000
Date:   Wed, 21 Nov 2018 18:06:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        pasha.tatashin@oracle.com, jpoimboe@redhat.com,
        ard.biesheuvel@linaro.org, Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>, ktsanaktsidis@zendesk.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Add /proc/pid_generation
Message-ID: <20181122020633.GN3065@bombadil.infradead.org>
References: <20181121201452.77173-1-dancol@google.com>
 <20181121203150.GK3065@bombadil.infradead.org>
 <CAKOZueuCYOsaHZzoz5nNPr8Jb-fEiHTR4MektaJx8vuUXcrKCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuCYOsaHZzoz5nNPr8Jb-fEiHTR4MektaJx8vuUXcrKCQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:38:20PM -0800, Daniel Colascione wrote:
> On Wed, Nov 21, 2018 at 12:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Nov 21, 2018 at 12:14:44PM -0800, Daniel Colascione wrote:
> > > This change adds a per-pid-namespace 64-bit generation number,
> > > incremented on PID rollover, and exposes it via a new proc file
> > > /proc/pid_generation. By examining this file before and after /proc
> > > enumeration, user code can detect the potential reuse of a PID and
> > > restart the task enumeration process, repeating until it gets a
> > > coherent snapshot.
> > >
> > > PID rollover ought to be rare, so in practice, scan repetitions will
> > > be rare.
> >
> > Then why does it need to be 64-bit?
> 
> [Resending because of accidental HTML. I really need to switch to a
> better email client.]
> 
> Because 64 bits is enough for anyone. :-) A u64 is big enough that
> we'll never observe an overflow on a running system, and PID
> namespaces are rare enough that we won't miss the four extra bytes we
> use by upgrading from a u32.  And after reading about some security
> problems caused by too-clever handling of 32-bit rollover, I'd rather
> the code be obviously correct than save a trivial amount of space.

I don't think you understand how big 4 billion is.  If it happens once a
second, it will take 136 years for a 2^32 count to roll over.  How often
does a PID roll over happen?
