Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5695BC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2A720660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP3DkSnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2A720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934123AbeFKRSU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:18:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46190 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeFKRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:18:16 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so12678205pld.13;
        Mon, 11 Jun 2018 10:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D71m0KbzYQmyFm7T8z9XP96iUOZv1+UojgeinFDB5fQ=;
        b=SP3DkSnzEfLXkAD4uEEp/Sfc714S/F9Nxpwj1or17BxDMKw+42EI3RMEeqUWwll70d
         WOS8R3oVk//NCPcUM1qC8E0PANnMkqOt4btZrIm7Ix7GLdguVtd5YB0MsRdbpsHBxYCV
         sPhaMVBoQaAuTs+ijxA5axXSTfHgo5JDLBKt5spr0di9PL3NDRb6c6OPTmdH7pZ14BJX
         NGKIwseaSsK9cPmOftL0ZsQ+fr3E3RkWckdedYp7F+ZleEcZ4fZPA1VtQEs8VQMcDwZI
         nKqXqHEimPlpo4XW/C9n/khiQ9le8JhndYva8ANMt1bZajManEVKvcUudov02N1/eUK/
         RaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D71m0KbzYQmyFm7T8z9XP96iUOZv1+UojgeinFDB5fQ=;
        b=JaEfPO8t4bIybCxTgLsY8rYtKB5wX4PorRAb3IIqv7RQfz6T8pgOY6+QhisXoStOd5
         o3mfGN+j/x0IV9yIhnyb2ZF+pKbPoFaJdLzHUKHMrgEdFIA8OSIGJgkHX3J4o8cDDdny
         LqpoGa/wLKH6zsHQ10w292Tfq0fp5FW2rbz0HjIdcwX3PFzsFvw1sQMnv+pOOnicod7l
         cEPvLo6YNIprCdu5kBaNJ5XkKNxGEuzRzpEss35rWnczz5wl5unqc8rPqtUR8zH7trfz
         ntHnVkIuCBfJ3BjDVl/tcixpENhaPbdRBrW0scDHrek7IvNg2v+JzG0CK1SxmXM7Mxih
         G9fg==
X-Gm-Message-State: APt69E1AeZMbMtCQ+kfZXykb0xEIXQsQdtSZVa8O2DP7heI0iHsq0CO4
        wf80JwJS/0SSoyxUiQB6MHk=
X-Google-Smtp-Source: ADUXVKII30l/3WIdOrtJoYjKwyr4acMlcImOPnhPby42rQANU/QZjkuU9aGY9GVRwiySABKn1iQTuQ==
X-Received: by 2002:a17:902:6105:: with SMTP id t5-v6mr92215plj.138.1528737495406;
        Mon, 11 Jun 2018 10:18:15 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id a81-v6sm46774801pfl.167.2018.06.11.10.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:18:14 -0700 (PDT)
Date:   Mon, 11 Jun 2018 10:18:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] input: add MT_TOOL_DIAL
Message-ID: <20180611171812.GC251078@dtor-ws>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
 <20180607075448.5706-3-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607075448.5706-3-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 09:54:37AM +0200, Benjamin Tissoires wrote:
> A dial is a tool you place on a multitouch surface which reports its
> orientation or a relative angle of rotation when rotating its knob.
> 
> Some examples are the Dell Totem (on the Canvas 27"), the Microsoft Dial,
> or the Griffin Powermate, though the later can't be put on a touch surface.
> 
> We give some extra space to account for other types of fingers if we need
> (MT_TOOL_THUMB)
> 
> Slightly change the documentation to not make it mandatory to update each
> MT_TOOL we add.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> new in v2 (extracted from previous series in its own patch)
> ---
>  Documentation/input/multi-touch-protocol.rst | 12 ++++++------
>  include/uapi/linux/input-event-codes.h       |  3 ++-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

(modulo input-event-codes.h vs input.h)

>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
> index b51751a0cd5d..6be70342e709 100644
> --- a/Documentation/input/multi-touch-protocol.rst
> +++ b/Documentation/input/multi-touch-protocol.rst
> @@ -310,12 +310,12 @@ ABS_MT_TOOL_Y
>  ABS_MT_TOOL_TYPE
>      The type of approaching tool. A lot of kernel drivers cannot distinguish
>      between different tool types, such as a finger or a pen. In such cases, the
> -    event should be omitted. The protocol currently supports MT_TOOL_FINGER,
> -    MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_. For type B devices, this event is
> -    handled by input core; drivers should instead use
> -    input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may change over
> -    time while still touching the device, because the firmware may not be able
> -    to determine which tool is being used when it first appears.
> +    event should be omitted. The protocol currently mainly supports
> +    MT_TOOL_FINGER, MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_.
> +    For type B devices, this event is handled by input core; drivers should
> +    instead use input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may
> +    change over time while still touching the device, because the firmware may
> +    not be able to determine which tool is being used when it first appears.
>  
>  ABS_MT_BLOB_ID
>      The BLOB_ID groups several packets together into one arbitrarily shaped
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index e8841cdb1ebd..a8d55f3909d3 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -854,6 +854,7 @@
>  #define MT_TOOL_FINGER		0
>  #define MT_TOOL_PEN		1
>  #define MT_TOOL_PALM		2
> -#define MT_TOOL_MAX		2
> +#define MT_TOOL_DIAL		10
> +#define MT_TOOL_MAX		10
>  
>  #endif
> -- 
> 2.14.3
> 

-- 
Dmitry
