Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C48ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588C2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C588C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeGMSxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:53:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729982AbeGMSxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B88972632;
        Fri, 13 Jul 2018 18:37:58 +0000 (UTC)
Received: from treble (ovpn-122-49.rdu2.redhat.com [10.10.122.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BE971C72F;
        Fri, 13 Jul 2018 18:37:58 +0000 (UTC)
Date:   Fri, 13 Jul 2018 13:37:56 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Remove reliable stacktrace check in
 klp_try_switch_task()
Message-ID: <20180713183756.gfddtn3gbwkwpqbj@treble>
References: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531382706-9732-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 18:37:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 18:37:58 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We bail out during patch registration for architectures, those don't
> support reliable stack trace.

Does anybody know if that change was intentional?  I thought the plan
was to allow non-consistency-model arches to still use livepatch, and
that they'd just have to 'force' patches to completion instead.  That
seems a little more forgiving.

-- 
Josh
