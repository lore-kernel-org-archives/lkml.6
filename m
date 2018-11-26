Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC4CC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1794F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPZtZb3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1794F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeK0Xds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbeK0Xdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:47 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EFD4208E4;
        Tue, 27 Nov 2018 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322159;
        bh=/mEAS62gyG7E4/S32vpECJweL38vGafA9Vkn4JsCBTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPZtZb3ye9C4zK6W4QZaMSDQ4iWyuIwlZwPGRQk6vrxxplZW8wuRTYn+QFCTn803N
         tfP8HKjI21+ye0po+S7IaOu5kk8Y+vorjXOw4gZDlwqEPjMiyAVGoiJHhnPiG+Ig2V
         GM/ol8L+VtMGrgui7LZ0S5E+0F/bnsN0SyQVdlDA=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 560A141120; Mon, 26 Nov 2018 15:40:17 -0300 (-03)
Date:   Mon, 26 Nov 2018 15:40:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCHv2 01/10] tools lib traceevent: Use LDFLAGS in the build
 commands
Message-ID: <20181126184017.GB5518@kernel.org>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-2-jolsa@kernel.org>
 <20181016112136.3a72a452@gandalf.local.home>
 <20181016154526.GC6631@krava>
 <20181017102341.53412998@gandalf.local.home>
 <20181116130158.GA30583@krava>
 <20181122093006.GD15953@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122093006.GD15953@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 10:30:06AM +0100, Jiri Olsa escreveu:
> On Fri, Nov 16, 2018 at 02:01:58PM +0100, Jiri Olsa wrote:
> > On Wed, Oct 17, 2018 at 10:23:41AM -0400, Steven Rostedt wrote:
> > > On Tue, 16 Oct 2018 17:45:26 +0200
> > > Jiri Olsa <jolsa@redhat.com> wrote:
> > > > On Tue, Oct 16, 2018 at 11:21:36AM -0400, Steven Rostedt wrote:
> > > > > I'm guessing that the CFLAGS are not needed here, but shouldn't that
> > > > > also be mentioned in the change log?  

> > > > yep, sry.. v2 attached

> > > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

> > Arnaldo,
> > could you pull in this one?
 
> ping, thanks

Applied, thanks,

- Arnaldo
