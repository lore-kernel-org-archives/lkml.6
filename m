Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E38C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D90620869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="e0qqtDsY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qgbRaSf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D90620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeIDK5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:57:19 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:60581 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726377AbeIDK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:57:19 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 06:57:18 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 8F10B4C1;
        Tue,  4 Sep 2018 02:28:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 04 Sep 2018 02:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=epQwX8VindIobxw6Xv2LIlc2IzE321uDHdIjShC88/s=; b=e0qqtDsY
        ABsOQDTgfqnjaUsU7RRPPsfdZyDY5ltazJXkvpwNYKV0GFFPrx675OuJ0rTeQjWB
        AzbsIkqPctxJ72WqgGlUr3XcxH5nVdu5W9pvc87PU278Z712OXa/EvdzRQqkCFfI
        y+fj96n2wzY4BFyvlNIqQ9Hoe3svBO3bpKf6bvVoT0dRiD30VPNm/2r7o3dk8gw+
        KS12wbprYmDLUyGPn8VklMtPWXKETqr4OVEUqLW495VPR/qC1mG1Ip/4EiGVBHRl
        T+eOSAw3J8n8m88NLNAgpSAYH0/AkKffk4wAtdGQh4KmTIXCCN7Hrf3FBeQ1dWbK
        uKNwf73iE3EZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=epQwX8VindIobxw6Xv2LIlc2IzE32
        1uDHdIjShC88/s=; b=qgbRaSf/xU/wBtze4Vv0D8juIRSm/M6mOiasnBRUNAiTd
        /V1o7tht7jvIbwWbaE0xLeC5aG5MC2WR1KXbQvWmN4loq0YrwN1lLz/XcpNtMzHf
        LJUdQAXptK7BR8T/VrywXxfISEDcB84aN21DwA1I69INxLHM5xhvdBKAD6Ll2xlO
        NNn5C2csBmIbBGasfOLAncwAH8sMRPeu/BYE0a7kxry+wQtk0fduz6Qo79sckA0t
        lwzMhS9/ehCJ7DxCQhluXeI0ufMntezLFnYRDmegO4Fmfa79RkCxkZml5LcTjhC/
        DNBR8bfQGDNOw4T6ql0HN/nKD38XsXp0GRyKm1K8A==
X-ME-Proxy: <xmx:DSaOW--d_9ZgdhIyUFTk_ebuWVrW4RFxkuKva-MrQpqtytgQkrbTAg>
    <xmx:DSaOWwUA2CLGD3PcEpp-RD-8psC1R6boSubc_Ymt7bxPTH8rFFnSHg>
    <xmx:DSaOW4FlWqfU_jCsIvLs7EuFpA9XrRPgIRNh7Kq1202kpb6-CeselQ>
    <xmx:DSaOW87ErK-9miUXVSt2tErq7PgPKHZfp4gsrS0sxjsmhSE4-2C6jw>
    <xmx:DSaOWyJ8Q-XxpxlKCGrXo-ztK63DCe9lWjJfohp7Z9x5V_E_ZpUBiA>
    <xmx:DyaOWyKEE30zdWAcSDL3ELMUUzwCjcKtz6wWnx3RP0x4s_k8Zd_TBK-wXDU>
X-ME-Sender: <xms:DSaOW345tEBJTK0xqxOilwpgtsPXKbkdyzzxulHCD1dSNcLtT8nAAw>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB48510299;
        Tue,  4 Sep 2018 02:28:26 -0400 (EDT)
Date:   Tue, 4 Sep 2018 16:28:24 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Harry Cutts <hcutts@chromium.org>
Cc:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/5] Add the `REL_WHEEL_HI_RES` event code
Message-ID: <20180904062824.GB1086@jelly>
References: <20180830215622.47550-1-hcutts@chromium.org>
 <20180830215622.47550-2-hcutts@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830215622.47550-2-hcutts@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 02:56:18PM -0700, Harry Cutts wrote:
> This event code represents scroll reports from high-resolution wheels,
> and will be used by future patches in this series. See the linux-input
> "Reporting high-resolution scroll events" thread [0] for more details.
> 
> [0]: https://www.spinics.net/lists/linux-input/msg57380.html
> 
> Signed-off-by: Harry Cutts <hcutts@chromium.org>

looks good to me, thanks. For the archives, the libinput issue filed for
this is here: https://gitlab.freedesktop.org/libinput/libinput/issues/130

Cheers,
   Peter

> ---
> 
> Changes in v2: None
> 
>  Documentation/input/event-codes.rst    | 11 ++++++++++-
>  include/uapi/linux/input-event-codes.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index a8c0873beb95..cef220c176a4 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -190,7 +190,16 @@ A few EV_REL codes have special meanings:
>  * REL_WHEEL, REL_HWHEEL:
>  
>    - These codes are used for vertical and horizontal scroll wheels,
> -    respectively.
> +    respectively. The value is the number of "notches" moved on the wheel, the
> +    physical size of which varies by device. For high-resolution wheels (which
> +    report multiple events for each notch of movement, or do not have notches)
> +    this may be an approximation based on the high-resolution scroll events.
> +
> +* REL_WHEEL_HI_RES:
> +
> +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> +    distance travelled by the user's finger, in microns.
>  
>  EV_ABS
>  ------
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 53fbae27b280..dad8d3890a3a 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,6 +708,7 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> +#define REL_WHEEL_HI_RES	0x0a
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> -- 
> 2.19.0.rc0.228.g281dcd1b4d0-goog
> 
