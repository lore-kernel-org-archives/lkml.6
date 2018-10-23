Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD188C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7944A20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7944A20813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengaru.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeJXAzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:55:48 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:56790 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXAzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:55:47 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id D69941A40245; Tue, 23 Oct 2018 09:31:41 -0700 (PDT)
Date:   Tue, 23 Oct 2018 09:31:41 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     netdev@vger.kernel.org
Subject: [QUESTION] AF_UNIX connect behavior when listener backlog=0
Message-ID: <20181023163141.a6nn5pua4o4zndde@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of AF_UNIX sockets immediately establishes a
new connection even when the backlog on the listener is zero.

Wouldn't it make more sense for connects to become synchronous with
accept when the listener is configured with a backlog of zero?

That way connects can be reliably refused from the listener side via
e.g. closing the listener instead of accepting the connect.

I'm not subscribed to netdev, so please take care to include me in any
replies on that list.

Regards,
Vito Caputo

