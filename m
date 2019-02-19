Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EFA21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550582176;
	bh=xbq/QLQmXxxqMeufFMakKWrJvUnWf7RsAZDXkmoYr50=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=0dUWlIyI0SJfr6PmelCXTH1c+h9G9zOQDmjmKb28aMb6X5OCGdOaZE6cnJa3PctI7
	 XDwgFbCNL+AAq0SqS/widIyPEeIIeuEpaPW1zYnq+GwAMH7nfMZHbp6OcOiRo/fU9x
	 UszfHEinW81TUBrm1Xj3z/9O/I0EzacGbRPQcfeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfBSNQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:16:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfBSNQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:16:14 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F792146E;
        Tue, 19 Feb 2019 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550582174;
        bh=xbq/QLQmXxxqMeufFMakKWrJvUnWf7RsAZDXkmoYr50=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rJZqKizRgvIy7J5GuO9JtW+ISJJL7aiE56J+rl1AGoFR16o6JpbwvXDqa13yiTioW
         jTniyqq8xYiLlCLBTzjX+wmVotOAMK4GRsKxLBSS2G9wr8qlEP8d/NRDFF5OSYUlFd
         ELj6eRxmvpVisJnNi5OVTu3BYpaer0j+y0X5OBPo=
Date:   Tue, 19 Feb 2019 14:16:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] HID: roccat: Mark expected switch fall-through
In-Reply-To: <20190211215334.GA6216@embeddedor>
Message-ID: <nycvar.YFH.7.76.1902191415550.11598@cbobk.fhfr.pm>
References: <20190211215334.GA6216@embeddedor>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/hid/hid-roccat-kone.c: In function ‘kone_keep_values_up_to_date’:
> drivers/hid/hid-roccat-kone.c:784:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    kone->actual_dpi = kone->profiles[event->value - 1].
>    ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      startup_dpi;
>      ~~~~~~~~~~~
> drivers/hid/hid-roccat-kone.c:786:2: note: here
>   case kone_mouse_event_osd_profile:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/hid/hid-roccat-kone.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index bf4675a27396..c4dd6162c1d6 100644
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

Stefan, could you please confirm that this is intended behavior?

Thanks,

-- 
Jiri Kosina
SUSE Labs

