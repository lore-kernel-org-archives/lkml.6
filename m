Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57DF20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57DF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alphalink.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeKJCMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:12:18 -0500
Received: from zimbra.alphalink.fr ([217.15.80.77]:52341 "EHLO
        zimbra.alphalink.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKJCMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:12:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 051A22B52055;
        Fri,  9 Nov 2018 17:30:58 +0100 (CET)
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uGi4Sc2yRSTW; Fri,  9 Nov 2018 17:30:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id BC36E2B52140;
        Fri,  9 Nov 2018 17:30:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail-2-cbv2.admin.alphalink.fr
Received: from zimbra.alphalink.fr ([127.0.0.1])
        by localhost (mail-2-cbv2.admin.alphalink.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fAeFFVqGgJSB; Fri,  9 Nov 2018 17:30:56 +0100 (CET)
Received: from c-dev-0.admin.alphalink.fr (94-84-15-217.reverse.alphalink.fr [217.15.84.94])
        by mail-2-cbv2.admin.alphalink.fr (Postfix) with ESMTP id 8FBE22B52055;
        Fri,  9 Nov 2018 17:30:56 +0100 (CET)
Received: by c-dev-0.admin.alphalink.fr (Postfix, from userid 1000)
        id 713EC60188; Fri,  9 Nov 2018 17:30:56 +0100 (CET)
Date:   Fri, 9 Nov 2018 17:30:56 +0100
From:   Guillaume Nault <g.nault@alphalink.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 063/114] l2tp: hold socket before dropping lock in
 l2tp_ip{, 6}_recv()
Message-ID: <20181109163056.GE1415@alphalink.fr>
References: <20181108215059.051093652@linuxfoundation.org>
 <20181108215106.791041209@linuxfoundation.org>
 <20181109153332.GD1415@alphalink.fr>
 <20181109162856.GA2407@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109162856.GA2407@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 08:28:56AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Nov 09, 2018 at 04:33:32PM +0100, Guillaume Nault wrote:
> > On Thu, Nov 08, 2018 at 01:51:18PM -0800, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > This patch was partly wrong. Here is the followup fix:
> > 94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")
> > 
> > Both a3c18422a4 ("l2tp: hold socket before dropping lock in l2tp_ip{, 6}_recv()")
> > and 94d7ee0baa8b ("l2tp: hold tunnel socket when handling control frames in l2tp_ip and l2tp_ip6")
> > should be applied/backported together.
> 
> Thanks for letting me know, I've now backported this as well.
> 
Great, it should all be fine now.
Thanks.
