Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61633C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A79025DD2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIQBfADt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A79025DD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeGBPQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:16:30 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42564 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeGBPQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:16:28 -0400
Received: by mail-lf0-f65.google.com with SMTP id u202-v6so12334924lff.9;
        Mon, 02 Jul 2018 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGLHK4D1Ruv7gaPdfXMYb2O64E4ujrDcVB65JLQtDHg=;
        b=DIQBfADtXvtFUbpEiaNP0fxUckRgkXpyK2wxWLX4sLX223/xWPMIVKw94CopZUF5DS
         NpVgUoufoa6FmmvoPShMlfS6ESfhHaKWXHarOE+fgYLDNkC32x51XQFXHjyecbN/b2Cj
         0l0cULmziZs9AsxM0/618DcbXEgsDmnceXgl1JSrgbRsIhx30iI0RhHFSM+8ggCGc3vM
         whR5NAB1nekAPlVQBNECSeF1zwAA8fTKPTnN0KvgbSreRGNbAicLHihCD2wsQWl2GaEj
         wC0QE/7WXv4E858yKCRDapR81zqMusxLqr3x1rToEPtpQ1b+IssPyLL+e5oVZaIVRjka
         8hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGLHK4D1Ruv7gaPdfXMYb2O64E4ujrDcVB65JLQtDHg=;
        b=DgFXkf8KIzvcIhz5kX0/m6Af9oqtQYf9Fm40VxkGLJ+R7U1IKpk+ncxFibQyCY8I2v
         qpYcTRgAiqr1qw+eNsnSYnSSIeyymDZLDENxsjjRyv6KnWcsM14DafKabf1g7oFqHYsD
         gbw19ous/vNmGafaSpeZ7fj5vBUO07cxtRa9QfMSzoKN64NTkIk3WF3MKj45SaRCHIfz
         zACciSbp7nlx1IZKI9srDD8RUyiAKh0ygzrNgdBFLqnOBWtAm/KuUTOp544P+A0Vh04i
         yEm/j5SWZx8HIZlHVleRDgXW5vHlC8GGhl7uS42nl5arWtSn0ZEhsPZjmoMB1LP5t1mb
         4wrw==
X-Gm-Message-State: APt69E0M6DvXfFAk96dHLRBGRn+TvrOr57AvzMsaneuS7UDDCMsfSPhs
        HaSL7kSUcUG0HmwYgvEa0AiDi7B2
X-Google-Smtp-Source: AAOMgpde8LPydUahi/by9s1ebjMQFUIbnkUTTO6VzALPBSMfYm9x3klkENNcOL/W9sa65gFQhgi+EA==
X-Received: by 2002:a19:7403:: with SMTP id v3-v6mr4780645lfe.97.1530544586666;
        Mon, 02 Jul 2018 08:16:26 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id t66-v6sm552835lje.95.2018.07.02.08.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 08:16:25 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fa0Ys-000078-LA; Mon, 02 Jul 2018 17:16:18 +0200
Date:   Mon, 2 Jul 2018 17:16:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20180702151618.GK9802@localhost>
References: <20180628184030.GA23656@embeddedor.com>
 <20180702085100.GF9802@localhost>
 <3a1b5c84-091d-7f7d-2fcf-206ccd4f91af@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1b5c84-091d-7f7d-2fcf-206ccd4f91af@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 08:00:43AM -0500, Gustavo A. R. Silva wrote:
> Hi Johan,
> 
> On 07/02/2018 03:51 AM, Johan Hovold wrote:
> > On Thu, Jun 28, 2018 at 01:40:30PM -0500, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> >> where we are expecting to fall through.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  drivers/usb/serial/io_edgeport.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> >> index 97c69d3..441dab6 100644
> >> --- a/drivers/usb/serial/io_edgeport.c
> >> +++ b/drivers/usb/serial/io_edgeport.c
> >> @@ -1760,7 +1760,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>  				edge_serial->rxState = EXPECT_HDR2;
> >>  				break;
> >>  			}
> >> -			/* otherwise, drop on through */
> >> +			/* else: fall through */
> > 
> > This doesn't silence the compiler warning with gcc 7.2.0 as the "else: "
> > pattern isn't recognised.
> > 
> 
> I'm using level 2:
> 
> -Wimplicit-fallthrough=2
> 
> The thing here is that some people have pointed out that it can be misleading to
> place a plain fall-through comment after an if-else code block containing a "break".
> So, the solution above has proved to be a good one.

I don't mind the "else", but I would expect you to mention in the commit
message that you're now relying on the non-default warning level (2).

> >>  		case EXPECT_HDR2:
> >>  			edge_serial->rxHeader2 = *buffer;
> >>  			++buffer;
> >> @@ -1820,7 +1820,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>  					edge_serial->rxState = EXPECT_DATA;
> >>  					break;
> >>  				}
> >> -				/* Else, drop through */
> >> +				/* else: fall through */
> >>  			}
> > 
> > And this doesn't work either due to the "else: " as well as the fact
> > that the compiler expects the fallthrough comment to precede the case
> > statement directly (e.g. it would need to be moved out of the else
> > block, but that isn't necessarily desirable as we discussed last year: 
> > 
> > 	lkml.kernel.org/r/20171027203906.GA7054@embeddedor.com
> > 
> 
> Yes. I'm aware of that. This certainly is still triggering a warning,
> so I just consider this
> as a temporal approach. I still need to define how are we going to
> manage cases like this.

Ok, so why did you not mention that in the commit message?

If this isn't even addressing the warning you get with the non-default
-Wimplicit-fallthrough=2, I don't see this as much of an improvement.

Might as well leave this unchanged, until all warnings in that switch
statement are addressed.

Johan
