Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05484C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D019520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfAQPE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:04:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfAQPE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:04:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41F6018DF61;
        Thu, 17 Jan 2019 15:04:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBF9760BE5;
        Thu, 17 Jan 2019 15:04:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190108081247.2266-2-kasong@redhat.com>
References: <20190108081247.2266-2-kasong@redhat.com> <20190108081247.2266-1-kasong@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, jwboyer@fedoraproject.org,
        keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com,
        nayna@linux.ibm.com, dyoung@redhat.com
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21895.1547737461.1@warthog.procyon.org.uk>
Date:   Thu, 17 Jan 2019 15:04:21 +0000
Message-ID: <21896.1547737461@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 17 Jan 2019 15:04:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <kasong@redhat.com> wrote:

> +extern const struct key* __init integrity_get_platform_keyring(void);

This should really be in keys/system_keyring.h and probably shouldn't be
exposed directly if it can be avoided.

David
