Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49048C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E2F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E2F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cs.uni-dortmund.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbeKVCcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:32:03 -0500
Received: from postamt.cs.uni-dortmund.de ([129.217.4.40]:56641 "EHLO
        postamt.cs.uni-dortmund.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731131AbeKVCcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:32:03 -0500
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 21:32:02 EST
Received: from postweb.cs.uni-dortmund.de (postweb [129.217.4.49])
        (authenticated bits=0)
        by postamt.cs.uni-dortmund.de (8.12.6/8.12.6) with ESMTPSA id wALFpok4017274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 16:51:50 +0100 (MET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Nov 2018 16:51:50 +0100
From:   Christoph Pleger <christoph.pleger@cs.uni-dortmund.de>
To:     linux-kernel@vger.kernel.org
Subject: Permission problems  - though all three UIDs are 0
Message-ID: <0236bec1badc3e2cbbcbda6306dfa3d6@cs.uni-dortmund.de>
X-Sender: christoph.pleger@cs.uni-dortmund.de
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to ask for the possible reasons why a program, called from 
another program with setuid-root file permissions and an additional 
setreuid(0,0) to also set the real uid to 0, still gets an "Operation   
not permitted" error.

In my case, I execve lvcreate from the setuid-root binary. This works 
well when I use my program as a non-root user from the command line, but 
I want to call it is a non-root user from pam_exec PAM module and with 
that lvcreate fails.

Regards
   Christoph

PS: Please, no discussion about possible security holes in 
setuid-programs here
