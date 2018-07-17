Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5B0ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA302146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA302146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbeGQO0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:26:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731655AbeGQO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:26:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0E0FAAFD2;
        Tue, 17 Jul 2018 13:53:28 +0000 (UTC)
Date:   Tue, 17 Jul 2018 15:53:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
In-Reply-To: <20180702182907.GA22465@embeddedor.com>
Message-ID: <nycvar.YFH.7.76.1807171553020.997@cbobk.fhfr.pm>
References: <20180702182907.GA22465@embeddedor.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/hid/hid-roccat-kone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index bf4675a..c4dd616 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -783,6 +783,7 @@ static void kone_keep_values_up_to_date(struct kone_device *kone,
>  	case kone_mouse_event_switch_profile:
>  		kone->actual_dpi = kone->profiles[event->value - 1].
>  				startup_dpi;
> +		/* fall through */
>  	case kone_mouse_event_osd_profile:
>  		kone->actual_profile = event->value;
>  		break;

I *think* the fall-through is correct thing to do here, but I'd like to 
get explicit Ack from Stefan. Stefan, please?

-- 
Jiri Kosina
SUSE Labs

