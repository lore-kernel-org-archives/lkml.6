Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BCE2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BCE2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbeHPQN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:13:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbeHPQNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:13:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC8A2407541A;
        Thu, 16 Aug 2018 13:15:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE16010EE991;
        Thu, 16 Aug 2018 13:15:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
To:     yannik@sembritzki.me
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        James.Bottomley@HansenPartnership.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] Replace magic for trusting the secondary keyring with #define
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18609.1534425319.1@warthog.procyon.org.uk>
Date:   Thu, 16 Aug 2018 14:15:19 +0100
Message-ID: <18610.1534425319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:15:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 16 Aug 2018 13:15:22 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yannik,

I would suggest something like that.  I've switched the patches over as has
been suggested.  I think it makes more sense to create the constant first and
then use that.

I've also fleshed out the patch description a bit and added cc and Fixes
fields as appropriate.

David
