Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD749C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5207520846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5207520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeGZD00 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:26:26 -0400
Received: from ozlabs.org ([203.11.71.1]:35635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbeGZD00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:26:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 41bbFN2tN2z9ryl;
        Thu, 26 Jul 2018 12:11:49 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id B9A7EEE78BF; Thu, 26 Jul 2018 12:11:49 +1000 (AEST)
Message-ID: <fb26bda65b80eef4916a94f5e4c534d55015d28d.camel@neuling.org>
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
From:   Michael Neuling <mikey@neuling.org>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 26 Jul 2018 12:11:49 +1000
In-Reply-To: <20180725193647.GA23643@kermit-br-ibm-com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
         <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
         <20180725193647.GA23643@kermit-br-ibm-com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Should we prefix every line with the PID to avoid this?
> 
> That's possible.  An alternative would be prefixing each line with the
> process name and its PID, as in the first line.  For example:
> 
>     pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
>     pandafault[10758]: Instruction dump:
>     pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> The above can be interleaved with other messages and we'll still be able
> to match process and its corresponding instruction dump.

LGTM.

Thanks!
Mikey
