Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3502703-1523893009-2-9336191982895695695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523893009; b=UtBHacOGRGOsNJ6x9T0OnukIudSvRdXdv4KjJf36Ywvewzjsy4
    RTsSVRjVWl7dgMzZ+7ijW6FnPi2G7nVGAkx5YBtyNpts2OtuazlS2Hz+e2mnOLcE
    gg3dugKbymKUm7zajMhf2qyd5x2stsdbIbaaHLO0gziGxyqSWrgpIY4KOeRh0xik
    rhyXRoOS6+WmbFch0wmd2hGnesKhERHg6z901TYVGloFbYjCk3DKO7qDoh2HaHLy
    uhf5nAE2c2Il1J1ORGPf80fOXUIECzwyL+dmw+wrCfNiI1+xg9mqKABpvz76Q/C0
    jwlVUkXFG4XUZIF3YPuQtCc1WvOEukzFaoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523893009;
    bh=nxl2KgeO1Ball4XOq4nVZvDEh6YgePqW//7Bbf57ink=; b=ez4yOTGyl9r0
    dtEmtmal5xiJsFQBkea/jvimp/wc3vpvqG5RVDuS63e97clLSjFCG7EEAII4zMAk
    te4imkmEATx58WfrtUzerMRFxSeOl41ddca7kblAIRbsTgUiYurFyLZ01cf3tu46
    B8FfXO7isDGe9Dqna1aWdyoEerwBApY6nX1aPS5bmmyDiKM+Vf8QxBZMiwARvSFv
    J4dvVqNj+vPZstMjs2wF5Ji9mO2KP4Lwhtnx00kHkfXu26fMEycQm7HaneENFiwv
    Bv4KkkXhCm2oRvb4VxMBZu1cmU+OYRFbyszdXMzZ/VWMADOdM5JI9lt9qHYGOgML
    LFCEz3iVNA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOT6m+G0mxneC6o+7SLTJrW1AQR15z35khnqVD67nwzPcTCBwVsgYRpk5/MbP2fWUlzktWNcqPcycg93DZBkBLyd44laIf5cshTkSMggTHMbR2XaYMam
    rd+7tzNbCShvh4XHx786Hjmnt2sbMDWNVN8uyHRSdyZHdpygNyzS77PuRoQ0K05wNkj8wsrISSXHGb5zeetCzEZvz+L7KJ2KY9FFlDCArXsRm42/Y+1I3RDa
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=meVymXHHAAAA:8 a=VzY0cb-wj_IsmQyNyRgA:9 a=CjuIK1q_8ugA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDPPgg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeDPPgd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 11:36:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ADCA2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 16 Apr 2018 11:36:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Message-ID: <20180416113629.2474ae74@gandalf.local.home>
In-Reply-To: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
        <20180409001936.162706-15-alexander.levin@microsoft.com>
        <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
        <20180415144248.GP2341@sasha-vm>
        <20180416093058.6edca0bb@gandalf.local.home>
        <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 08:18:09 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I wonder if the "AUTOSEL" patches should at least have an "ack-by" from
> > someone before they are pulled in. Otherwise there may be some subtle
> > issues that can find their way into stable releases.  
> 
> I don't know about anybody else, but I  get so many of the patch-bot
> patches for stable etc that I will *not* reply to normal cases. Only
> if there's some issue with a patch will I reply.
> 
> I probably do get more than most, but still - requiring active
> participation for the steady flow of normal stable patches is almost
> pointless.
> 
> Just look at the subject line of this thread. The numbers are so big
> that you almost need exponential notation for them.
> 

I'm worried about just backporting patches that nobody actually looked
at. Is someone going through and vetting that these should definitely
be added to stable. I would like to have some trusted human (doesn't
even need to be the author or maintainer of the patch) to look at all
the patches before they are applied.

I would say anything more than a trivial patch would require author or
sub maintainer ack. Look at this patch, I don't think it should go to
stable, even though it does fix issues. But the fix is for systems
already having issues, and this keeps printk from making things worse.
The fix has side effects that other commits have addressed, and if this
patch gets backported, those other ones must too.

Maybe I was too strong by saying all patches should be acked, but
anything more than buffer overflows and off by one errors probably
require a bit more vetting by a human than to just pull in all patches
that a bot flags to be backported.

-- Steve
