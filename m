Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EF6C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DCA2656A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DCA2656A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934396AbeF0NCY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:02:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750774AbeF0NCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:02:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 51C61400B45A;
        Wed, 27 Jun 2018 13:02:22 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id DAC992026D5B;
        Wed, 27 Jun 2018 13:02:19 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Wed, 27 Jun 2018 15:02:19 +0200
Date:   Wed, 27 Jun 2018 15:02:19 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     LiuYang <yiqiaoxihui@163.com>
Cc:     avi@redhat.com, mtosatti@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: modify macro definition 'R' to 'R ' because of
 gcc-5+
Message-ID: <20180627130218.GA25804@flask>
References: <1530017988-8026-1-git-send-email-yiqiaoxihui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530017988-8026-1-git-send-email-yiqiaoxihui@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 13:02:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 13:02:22 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-26 20:59+0800, LiuYang:
> GCC 5.4.0 enables raw strings by default and they have higher priority
> than macros, thus R is interpreted incorrectly.
> Fix it by putting a space between macro R and a string literal.
> 
> Signed-off-by: LiuYang <yiqiaoxihui@163.com>
> ---

This got fixed in 2012 by b188c81f2e1a ("KVM: VMX: Make use of asm.h").

Please refresh the tree, thanks.
