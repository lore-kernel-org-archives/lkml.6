Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FCEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED0E25BB6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stIgPHm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED0E25BB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeGBIvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 04:51:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41026 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbeGBIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 04:51:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id a17-v6so8806841ljd.8;
        Mon, 02 Jul 2018 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3My401lb/sQB3l5NERJxMDxI2gKqsok/1mh22W65fIA=;
        b=stIgPHm2/2T+yfAe+qBo5/cGRt2q6+4KWmwfvgDdxM39kfIkKVO009hJMzfGzh+ykO
         w8egvmAvAniCKx3KWzWNLOETBHHwRLeU1ZFgLZAtEYji7fdhW7xq90/GMgmh2QKZXEEV
         4GP1lEraemG8GZoezzdOum3Z3DZ51wbs7KmJkSZuiSDrYRTJHaNYU7scZp/d3630ZhT6
         HayXDNPsXS+xSAMVHLTdfh1geYScqdaANsAW5o4+R3TIwByxZnNzEa1Jd5DuK+Fq0eeM
         zjOkGUKlbJZ/W63SaIsHmVdfj8me/S98QQVnPqpwhnd3qcleRxxhusPsaGOyKl3rwZE7
         aTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3My401lb/sQB3l5NERJxMDxI2gKqsok/1mh22W65fIA=;
        b=A34QsN3SHY2h1yiAf77CxSOLA4DXoB24cg4ofkjVeeUcGgd5sYTYER4+l4KwjIjPWV
         4mzuIqmIXKgnfCkfwoXoUCs6u+JDwtHO2lPCXajWQ4trFFgqRWhXihG1ILTw2dQNMdJo
         DesQod0KTfT74LU2e+Z8tTF0w8pAEXz44j2L1zcl73TFNRexNvM79wUnAbKWQ/tYfHkE
         SLqOEVYQ+BmBxZw9b175zUKZ8AxoIkkdsGa+4qY3IhwkfwevffmEVWE/x9tgeAA6g4M+
         Qd20zaR+6X4+3vDNz5eL7rIMeHtiDruqdtoBKHRs2sWX+IltHEec7FnDQbjJ4poLgLSP
         cpyQ==
X-Gm-Message-State: APt69E0WIaalu6PT9D2IB9zu96/ADUSMPgEtqx9gxXfcKgOjvHMmJzQw
        voccmChUgXBPQhsWfuSu1tw=
X-Google-Smtp-Source: ADUXVKJZJpe0Dzd7Q4uxGE1ByD8e9Q43kqCj+NyzjVc2VVM0DV5jrVxW6YvWh2en6cmt4Wp+VRls0w==
X-Received: by 2002:a2e:5c41:: with SMTP id q62-v6mr15606071ljb.77.1530521469690;
        Mon, 02 Jul 2018 01:51:09 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id j7-v6sm2529504ljg.48.2018.07.02.01.51.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 01:51:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fZuY0-000836-OW; Mon, 02 Jul 2018 10:51:00 +0200
Date:   Mon, 2 Jul 2018 10:51:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20180702085100.GF9802@localhost>
References: <20180628184030.GA23656@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628184030.GA23656@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:40:30PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/usb/serial/io_edgeport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 97c69d3..441dab6 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -1760,7 +1760,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>  				edge_serial->rxState = EXPECT_HDR2;
>  				break;
>  			}
> -			/* otherwise, drop on through */
> +			/* else: fall through */

This doesn't silence the compiler warning with gcc 7.2.0 as the "else: "
pattern isn't recognised.

>  		case EXPECT_HDR2:
>  			edge_serial->rxHeader2 = *buffer;
>  			++buffer;
> @@ -1820,7 +1820,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>  					edge_serial->rxState = EXPECT_DATA;
>  					break;
>  				}
> -				/* Else, drop through */
> +				/* else: fall through */
>  			}

And this doesn't work either due to the "else: " as well as the fact
that the compiler expects the fallthrough comment to precede the case
statement directly (e.g. it would need to be moved out of the else
block, but that isn't necessarily desirable as we discussed last year: 

	lkml.kernel.org/r/20171027203906.GA7054@embeddedor.com

)

>  		case EXPECT_DATA: /* Expect data */
>  			if (bufferLength < edge_serial->rxBytesRemaining) {

How do you compile test these these patches?

Thanks,
Johan
