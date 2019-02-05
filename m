Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25CCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9C120823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="wTyHpEPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfBEA37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 19:29:59 -0500
Received: from vern.gendns.com ([98.142.107.122]:33484 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfBEA37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 19:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9143fEFiv9Z6gdD0b+ulyN7PkSp1bjjjNTkDc5sshjc=; b=wTyHpEPtSoR1YmGsslTM6Puq+3
        8bDGvH+jWFz2wSoFsrPKd2vkuLKuHPx3IM6BwZ/6o1MLOJk09ARjFZPTQnVafgMQXAwi8fVY4XCPH
        jCHKmVmIldUnuSQ2Tt9agB+/VuXlTR9VfpLmm0pC2yNU7/wi54tLCQNrDUE3PzNcm9uczr67BIlqS
        uHLtPBccOY5W7lLkOTZLWZHFR3wEJ7G1UniD0Sm2EMdYLolf/RLzpL7RCeENkRnwnb4Kz8yI+4vWg
        MrA78Q98LLeFNYMZa4bdlN8bTIqzBVt15jCmkrKhRmTFjw8pKWQ3OERo50FaeMmK0+v1QLuYZky9C
        1UpAc4OQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60374 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqoZB-0001WB-RM; Mon, 04 Feb 2019 19:26:21 -0500
Subject: Re: [PATCH 25/35] ARM: davinci: cp-intc: use the new-style config
 structure
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-26-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <55b5797c-ee0b-c2d8-9eb9-0d681da08018@lechnology.com>
Date:   Mon, 4 Feb 2019 18:29:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-26-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Modify the cp-intc driver to take all its configuration from the new
> config structure. Stop referencing davinci_soc_info in any way.
> Move the declaration for davinci_cp_intc_init() to
> irq-davinci-cp-intc.h and make it take the new config structure as
> parameter. Convert all users to the new version.
> 
> Also: since the two da8xx SoCs default all irq priorities to 7, just
> drop the priority configuration at all and hardcode the channels to 7.

As mentioned in a comment on a different patch, this isn't strictly
true (although in practice, it probably is).

This patch deletes a code path with the comment "Default everything
to channel 15 if priority not specified.", so it is possible (although
unlikely) that this patch could change a priority of some IRQ that is
being used.

> 
> It will simplify the driver code and make our lives easier when it
> comes to device-tree support.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
