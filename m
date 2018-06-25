Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401192602C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401192602C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964965AbeFYSfU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:35:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54097 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964851AbeFYSfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:35:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so10342382wmc.3;
        Mon, 25 Jun 2018 11:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3BpJT3aaqrPl/MPmMb1dOV3lt0pHwBoJ1+4xaSlh4qo=;
        b=O4UlHCcuv7ILxBFQqqZQf0+Ultfmubw5ncAnGgZRGz13rDRwQ260lnFdxNjJXi5IYg
         AoMCFovkAsEXNaMofHbYSUjENrdKCxWKZjJ/VSH39cwArQT1uD+AA/5hjJ+h7hjRBFdd
         u9j0sDpqstc9sD2qLLrrSS7EUh4+E84cP+NBMhfXF09R776+9cqeutRsgZqXc+2DgSss
         GsCNjXlQnvgww4cRQhjazM14LPXSimOz2Vm6TKV4YDxKLR6sNVBUkCn1jXdxqr5A4Xny
         gYv/Le8Ykl5b0c9F/cerLgF/66ODsY4QxdqPzxFI8ZGOjwzwx2BRUJVFM97vrvvIFDcR
         vMrw==
X-Gm-Message-State: APt69E2ao5d9HMnG7NI7OPVxjhemCq8QBEmfcA+lKp3GKYoPEKTwJGQ7
        vBmk4/uIcyLKrsMg9Ou8y/d99A==
X-Google-Smtp-Source: AAOMgpeTPe5NNtUBZSiDGAWkgN5bvP4pz69DlsQcdQ1k/D98TLsWEU/uhoXnKvB+tVDgiba5kot4Qg==
X-Received: by 2002:a1c:d681:: with SMTP id n123-v6mr1777917wmg.158.1529951716301;
        Mon, 25 Jun 2018 11:35:16 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id b16-v6sm27820726wrm.15.2018.06.25.11.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 11:35:15 -0700 (PDT)
Subject: Re: [PATCH 2/7] Input: psmouse - clean up code
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
 <20180119230629.49428-3-dmitry.torokhov@gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e8ad7e61-342a-8d53-7de1-f30a58c91975@suse.cz>
Date:   Mon, 25 Jun 2018 20:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180119230629.49428-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20/2018, 12:06 AM, Dmitry Torokhov wrote:
> - switch to using BIT() macros
> - use u8 instead of unsigned char for byte data
> - use input_set_capability() instead of manipulating capabilities bits
>   directly
> - use sign_extend32() when extracting wheel data.
> - do not abuse -1 as error code, propagate errors from various calls.
…
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
…
> @@ -157,39 +159,42 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
…
>  		case 0x00:
>  		case 0xC0:
> -			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> -			input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> -			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> +			input_report_rel(dev, REL_WHEEL,
> +					 -sign_extend32(packet[3], 3));
> +			input_report_key(dev, BTN_SIDE,  BIT(4));
> +			input_report_key(dev, BTN_EXTRA, BIT(5));
>  			break;
>  		}
>  		break;
>  
>  	case PSMOUSE_GENPS:
>  		/* Report scroll buttons on NetMice */
> -		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
> +		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
>  
>  		/* Extra buttons on Genius NewNet 3D */
> -		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
> -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
> +		input_report_key(dev, BTN_SIDE,  BIT(6));
> +		input_report_key(dev, BTN_EXTRA, BIT(7));
>  		break;
>  
>  	case PSMOUSE_THINKPS:
>  		/* Extra button on ThinkingMouse */
> -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 3) & 1);
> +		input_report_key(dev, BTN_EXTRA, BIT(3));

While hunting a 4.17 bug where some openSUSE users lost their ability to
mouse-click, I came across this commit. Putting aside it's a total mess
of multiple changes, were these changes above intentional at all? I mean
changing
  (packet[0] >> 3) & 1
to hardwired
  BIT(3)
does not look quite right. And if it is for some to me unknown reason,
it should have been properly documented in the commit log. I believe
your intent was:
  packet[0] & BIT(3)
?

thanks,
-- 
js
suse labs
