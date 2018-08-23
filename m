Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBAB2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="maF+zbbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBAB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeHWXMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 19:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeHWXMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 19:12:18 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6532147A;
        Thu, 23 Aug 2018 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535053266;
        bh=VfjEVZ6/sBCanN7PQxGB1CnchLJRBcKdR2JmRUg6lY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maF+zbbdlCf/HsMzb4pgabKerTavu/2Xt1ZlKHXpz9fMVwI7Pz6XFgRUUK29jJpKE
         Rwn4jsSvkoI6R/Jpwi6+IsN01Vm04niZRaholHvKTy/zwcU3Ju2uBspor0qYC1oTzu
         A8OOYJN7vP+X/0hhLceHCB0IjlU7dt49ZQgv/GmI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4C3EA141C3F; Thu, 23 Aug 2018 16:40:59 -0300 (-03)
Date:   Thu, 23 Aug 2018 16:40:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     William Cohen <wcohen@redhat.com>
Cc:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin Jambor <mjambor@suse.cz>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] AMD perf PMU events for AMD Family 17h.
Message-ID: <20180823194059.GB22309@kernel.org>
References: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
 <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
 <20180823143141.GA22309@kernel.org>
 <40464a66-9085-f26c-88cd-8d510b07a859@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40464a66-9085-f26c-88cd-8d510b07a859@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2018 at 12:16:43PM -0400, William Cohen escreveu:
> On 08/23/2018 10:31 AM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Aug 23, 2018 at 01:21:45PM +0200, Martin Liška escreveu:
> >> May I please ping this.

> > I was waiting for someone to give some ack, perhaps Will Cohen can take
> > a brief look and provide that? Will?
 
> I had already deleted the patch from my mailbox earlier, so I
> downloaded the patch from the archive and added some inline comments
> to the attached patch.

Thanks William! Really appreciate, I think we need this kind of review
for these JSON files when they get submitted, Martin, please address his
points and resubmit,

Thanks again,

- Arnaldo
