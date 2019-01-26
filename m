Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B80C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9321902
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 13:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548510670;
	bh=2LTXwCRW/Dnj1NIS+fH+kkO8DsOEfOSTJGndnHxgT7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z+rH/qucDdL9gSx11HtqQg885EddMfmt1VyLtZiDn+m0ttyg3cMj1HXZbg/ROtDkS
	 pC5DZNMq2IoTnjmUo096Mk75prbpVsIylrNfeHuh6d2fAglHNrfdg8+T1JIBjjI3he
	 luzIVoOAobAn5Z3wICusq5MK9DG961JMiXootSdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfAZNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 08:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfAZNvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 08:51:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76CC21872;
        Sat, 26 Jan 2019 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548510667;
        bh=2LTXwCRW/Dnj1NIS+fH+kkO8DsOEfOSTJGndnHxgT7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx5IFVxS5lMg1mfr/aOy+K5HieY10TwOyfEd6pUjHhLbwOpVSqMP8z27WDxr75NPl
         oBucGgJ2ypzXwkUjTPyQOjnIs/ddwRPrFpPzP42kdDo13McxwwjCd0vR0hqxZFjGtp
         KB3RJ/tuctKfXxRGaR0uBlnO5GxoAeMuyiDG1hqU=
Date:   Sat, 26 Jan 2019 14:51:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] drivers/accel: ocxl: Move non-uapi include files
Message-ID: <20190126135104.GB23749@kroah.com>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
 <20190125181616.62609-6-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125181616.62609-6-olof@lixom.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:16:16AM -0800, Olof Johansson wrote:
> Separate to expose the edits vs pure moves.

Ugh, putting the uapi files in misc/ was a mistake, sorry I never caught
that before, my fault :(

greg k-h
