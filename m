Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBCA2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbfAKNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:51:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732892AbfAKNvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:51:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4598356F3;
        Fri, 11 Jan 2019 13:51:46 +0000 (UTC)
Received: from flask (unknown [10.40.205.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0A931000049;
        Fri, 11 Jan 2019 13:51:39 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 11 Jan 2019 14:51:38 +0100
Date:   Fri, 11 Jan 2019 14:51:38 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM/VMX: Avoid return error when flush tlb successfully
 in the hv_remote_flush_tlb_with_range()
Message-ID: <20190111135138.GG14852@flask>
References: <20190104072044.1800-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104072044.1800-1-Tianyu.Lan@microsoft.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 11 Jan 2019 13:51:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-01-04 15:20+0800, lantianyu1986@gmail.com:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The "ret" is initialized to be ENOTSUPP. The return value of
> __hv_remote_flush_tlb_with_range() will be Or with "ret" when ept
> table potiners are mismatched. This will cause return ENOTSUPP even if
> flush tlb successfully. This patch is to fix the issue and set
> "ret" to 0.
> 
> Fix: a5c214da("KVM/VMX: Change hv flush logic when ept tables are mismatched.")
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---

Applied, thanks.
