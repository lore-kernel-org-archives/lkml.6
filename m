Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2D6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298362195D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="SMJ0HNyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfBQJvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:51:36 -0500
Received: from vern.gendns.com ([98.142.107.122]:53714 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfBQJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/jvlntGlSk+Xlg41FiakC/b0XUQYvDkHsuK6sir2RtE=; b=SMJ0HNyZ775tTE+d/86PonkFX0
        N+1fj8gL8DUctgx28yph5SivVjfEc1v4305gUwBch9XKaNKgo/RvmnlKL072Vlv9gWx7lXdpSq7a0
        rMIswwHf7nE+1BNNRK+qbdT5tdzbdu+bdCDynYpFxXnVtEnIna3BhGqdwssOW7Rsvc+ao90MLhDsm
        PqdZPq5UOYb/Z/mEh09+KDLv1A5uS+dxVNCW4JpNd7WZa0yoVh9pCcOm7Jy7QSMwXNLHl9xSYjfl6
        LxhkuZn7BMQrqbO4GXimk4yjFPJRvR+rw+JNJXNqai2IfcmEEsAqw8MgwTsxXpwpgAe0VREmk4EKs
        hd8vD9gA==;
Received: from [185.122.190.68] (port=25740 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvJ6a-0007jF-BT; Sun, 17 Feb 2019 04:51:24 -0500
Subject: Re: [PATCH v4 22/37] irqchip: davinci-aintc: move the driver to
 drivers/irqchip
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-23-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <fc4a978b-e8fb-91a5-db24-b4d69ccd2527@lechnology.com>
Date:   Sun, 17 Feb 2019 10:51:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-23-brgl@bgdev.pl>
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

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The aintc driver has now been cleaned up. Move it to drivers/irqchip
> where it belongs. There's no device-tree support for any dm* board so
> there's no IRQCHIP_OF_DECLARE() - there's only the exported init
> function called from machine code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

