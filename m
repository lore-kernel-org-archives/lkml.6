Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40360C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E49020855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="LNISDhrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfAQPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:14:49 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:49474 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727671AbfAQPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:14:48 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43gSKz0LB8z8sy8;
        Thu, 17 Jan 2019 16:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547738087; bh=K6Ae3twbw8YxXCICeqdA/JR41PeQQBds19AxiF+LAEo=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From:To:CC:
         Subject;
        b=LNISDhrbYAFGCbTO8fir9kjztTj38pwh+PnqgRdv3BIb4E12SMh+L2ri9Fd3OHoSr
         TFcZfYilZaz6xSHAjwuU3GjZMFzQwJhaw0w56P2l/DfHT/w9SGzFSF5QNV2afIGYNS
         Z87M3+h9+UGPUDKxqg+R3CLXmJu/h+OM1Urlb4Z0vkbD0IDl4/N6iQs8YTwBBm19Z+
         rsc3ARMC3b8mxR8O3K71fXk8IzPWsQR9aqEVuks/nzp1/ZCkDD8b5ysaknUP76wWdr
         N7o5Zzok+IjAfAc/oMcjUo9/hj3HFrsWrcU+w5F8GOYGWVCy65gc9jXx8EWqpD7KSi
         +EJfpon3CwldA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a01:c22:6e20:6c00:4536:d066:91f8:5831
Received: from [IPv6:2a01:c22:6e20:6c00:4536:d066:91f8:5831] (unknown [IPv6:2a01:c22:6e20:6c00:4536:d066:91f8:5831])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/hPhrvv04Bhi3s0fGCn/zqVRlWDXnZXEY=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43gSKw69wFz8skp;
        Thu, 17 Jan 2019 16:14:44 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] tracing/uprobes: Fix output for multiple string
 arguments
From:   Andreas Ziegler <andreas.ziegler@fau.de>
In-Reply-To: <20190117095102.724939e2@vmware.local.home>
Date:   Thu, 17 Jan 2019 16:14:44 +0100
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0F30FF42-AE03-45CC-8877-06E83038B6A4@fau.de>
References: <20190116084021.34b0beee@gandalf.local.home>
 <20190116141629.5752-1-andreas.ziegler@fau.de>
 <20190117150107.17f2c0c37e41126120c5eebb@kernel.org>
 <b5defce3-b52a-db20-bfd1-81eec9972fab@fau.de>
 <20190117165807.64e95553ff397e7f73ba495b@kernel.org>
 <20190117092042.4f689462@vmware.local.home>
 <5ceb9b3b-3f67-4e84-b029-6e6d8ccc0449@fau.de>
 <20190117095102.724939e2@vmware.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. Jan 2019, at 15:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 17 Jan 2019 15:29:09 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>=20
>> =46rom my side it's basically good to go, but I just realized that =
there=20
>> is no "Fixes: " tag in it but the problem it fixes goes back to=20
>> 5baaa59ef09e ("tracing/probes: Implement 'memory' fetch method for=20
>> uprobes") from 2013 (and is present in all current longterm and =
stable=20
>> kernels)... should I add a tag and resend a v3?
>>=20
>=20
> I was just about to ask you to provide the fixes tag. No need to
> resend, I'll just add it manually. I asked Masami to resend because it
> was a patch series. If it was just a single patch, I would have just
> asked what the fixes was for that particular patch. I can handle one
> patch, but not more than one ;-)
>=20
> -- Steve

One more thing maybe, the code in question was rewritten
by Masami in 9178412ddf5a ("tracing: probeevent: Return consumed
bytes of dynamic area=E2=80=9D) which is in v4.20 but the problem traces =
back
to the original commit mentioned above, so it will need manual so we
will need a slightly modified version for earlier kernels.

Regards,

Andreas=
