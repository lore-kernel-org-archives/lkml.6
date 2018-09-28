Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD10C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FDF2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FDF2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeI1Tav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:30:51 -0400
Received: from mail.us.es ([193.147.175.20]:40368 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1Tav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:30:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7992121056D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:07:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 61F64DA8F0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:07:07 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5CD8BDA87D; Fri, 28 Sep 2018 15:07:07 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 68D71DA844;
        Fri, 28 Sep 2018 15:07:05 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 28 Sep 2018 15:07:05 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (sys.soleta.eu [212.170.55.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 3E5274265A4C;
        Fri, 28 Sep 2018 15:07:05 +0200 (CEST)
Date:   Fri, 28 Sep 2018 15:07:04 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [PATCH 07/11] UAPI: netfilter: Fix symbol
 collision issues [ver #2]
Message-ID: <20180928130704.kcmsnsecp6aqpk66@salvia>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
 <153622555128.14298.11612304975343930534.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153622555128.14298.11612304975343930534.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:19:11AM +0100, David Howells wrote:
> The netfilter UAPI headers have some symbol collision issues:
> 
>  (1) "enum nfnl_acct_msg_types" is defined twice, and each definition is
>      completely different.
> 
>      Fix this by renaming the one in nfnetlink_cthelper.h to be "enum
>      nfnl_cthelper_types" to be consistent with the other things in that
>      file.
> 
>  (2) There's a disagreement between ipt_ECN.h and ipt_ecn.h over the
>      definition of various IPT_ECN_* constants, leading to an error over
>      IPT_ECN_IP_MASK being substituted when being defined as an enum value
>      in ipt_ecn.h if ipt_ECN.h is #included first.
> 
>      Fix this by removing the conflicting constants from ipt_ECN.h and
>      including ipt_ecn.h instead.

David, may I upstream this or you will pass it to Greg? I can just
take this, as you prefer.

Thanks.
