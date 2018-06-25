Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3282DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC3E26041
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJM7rR1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC3E26041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965084AbeFYSwP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:52:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42714 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964816AbeFYSwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:52:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so6459974pgu.9;
        Mon, 25 Jun 2018 11:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GS50vSQOzfoOQ/Vljk9phYAABQaRqMT11s3Ux+MjiHE=;
        b=lJM7rR1oTa1Hruf6/f5I5D7fglr9GnUJT+iNRO8X6+AHBQnnAGU7QTv0w86wbeygNx
         56lMqTt+zAi8tLuLjVTeFoVEGXRHit13OI2RoddOhiYywFd7CIiDwnIy48dRqP5WXKsx
         kDrYs0Dcvn0Xx6Q6qtsmu57iX9nx5pK+9Wa42t340op9HS3VFbQKZufFubeGL4c6vIL1
         llrs2f8BeRfRJorio+ODE34H1R2WgeTpW2QU2KhjNHVOLTv/82AqiGIWtWwHGcnj6F+B
         5sfcokK9yifNTul3X9CumupMBjABoreXxCa5ro1lDpvbnieYepEDaRjtGhgLAmlSoMA2
         1Weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GS50vSQOzfoOQ/Vljk9phYAABQaRqMT11s3Ux+MjiHE=;
        b=CLCSHlO6gZdfigVVMCHYT6lDSYvT0yn0wdTzHjGhNYEnMJ+32qdElZMKUX9XYt4FBA
         FcWXrF2YXAsMQHtdEtim/B0tqcUY4QRsDh3YbJwyE2zD54BZtCFI2ZuTXHlY7wsk43bS
         kAIUfFjSbMQRlYOSJMFJFZZAy1//gimJiWxln26bu1eyNMGTm+nuLGrYifcZrl98UpBz
         YYU1o0H/dqYUJhbI0kcn3Gu0tM5gCjE78NDEN4rILDNZe5GX+EWzOjDvjLLULK/SY0qY
         tjIBufkdK/k2jY1XaMyB4mX/7LQZDgBurc7PN5eV9pw6A64A8l1xcWMQ9GpyA/iuk1uc
         Y0yw==
X-Gm-Message-State: APt69E2xOU3tV9YxocORoTUFniGyw2VgfISXMGPUT0xn9LWyrKwuSmV1
        dPhLezfeH8GqIvPc/hMBTj4=
X-Google-Smtp-Source: ADUXVKIUjo5XpoJXZ9fFI7r2TWG2y8eR91WUiQ0itqEZH9SKN8L8CrY631XvnblEzhufcaMX0/ynVw==
X-Received: by 2002:a63:3f05:: with SMTP id m5-v6mr8759589pga.51.1529952732678;
        Mon, 25 Jun 2018 11:52:12 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id m12-v6sm19549893pgp.88.2018.06.25.11.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:52:11 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:52:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] Input: psmouse - clean up code
Message-ID: <20180625185209.GA136115@dtor-ws>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
 <20180119230629.49428-3-dmitry.torokhov@gmail.com>
 <e8ad7e61-342a-8d53-7de1-f30a58c91975@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8ad7e61-342a-8d53-7de1-f30a58c91975@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 08:35:14PM +0200, Jiri Slaby wrote:
> On 01/20/2018, 12:06 AM, Dmitry Torokhov wrote:
> > - switch to using BIT() macros
> > - use u8 instead of unsigned char for byte data
> > - use input_set_capability() instead of manipulating capabilities bits
> >   directly
> > - use sign_extend32() when extracting wheel data.
> > - do not abuse -1 as error code, propagate errors from various calls.
> …
> > --- a/drivers/input/mouse/psmouse-base.c
> > +++ b/drivers/input/mouse/psmouse-base.c
> …
> > @@ -157,39 +159,42 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
> …
> >  		case 0x00:
> >  		case 0xC0:
> > -			input_report_rel(dev, REL_WHEEL, (int) (packet[3] & 8) - (int) (packet[3] & 7));
> > -			input_report_key(dev, BTN_SIDE, (packet[3] >> 4) & 1);
> > -			input_report_key(dev, BTN_EXTRA, (packet[3] >> 5) & 1);
> > +			input_report_rel(dev, REL_WHEEL,
> > +					 -sign_extend32(packet[3], 3));
> > +			input_report_key(dev, BTN_SIDE,  BIT(4));
> > +			input_report_key(dev, BTN_EXTRA, BIT(5));
> >  			break;
> >  		}
> >  		break;
> >  
> >  	case PSMOUSE_GENPS:
> >  		/* Report scroll buttons on NetMice */
> > -		input_report_rel(dev, REL_WHEEL, -(signed char) packet[3]);
> > +		input_report_rel(dev, REL_WHEEL, -(s8) packet[3]);
> >  
> >  		/* Extra buttons on Genius NewNet 3D */
> > -		input_report_key(dev, BTN_SIDE, (packet[0] >> 6) & 1);
> > -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 7) & 1);
> > +		input_report_key(dev, BTN_SIDE,  BIT(6));
> > +		input_report_key(dev, BTN_EXTRA, BIT(7));
> >  		break;
> >  
> >  	case PSMOUSE_THINKPS:
> >  		/* Extra button on ThinkingMouse */
> > -		input_report_key(dev, BTN_EXTRA, (packet[0] >> 3) & 1);
> > +		input_report_key(dev, BTN_EXTRA, BIT(3));
> 
> While hunting a 4.17 bug where some openSUSE users lost their ability to
> mouse-click, I came across this commit. Putting aside it's a total mess
> of multiple changes, were these changes above intentional at all? I mean
> changing
>   (packet[0] >> 3) & 1
> to hardwired
>   BIT(3)
> does not look quite right. And if it is for some to me unknown reason,
> it should have been properly documented in the commit log. I believe
> your intent was:
>   packet[0] & BIT(3)
> ?

Yes, that was, I am not sure what I was thinking; I'll fix that up.

Thanks.

-- 
Dmitry
