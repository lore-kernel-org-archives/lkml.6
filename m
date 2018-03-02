Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AG47ELsAYmQ9dGbBqwtVfnVQ5QO0GuJmK9yk6z/MlsDqTysGCPbfq4VFVj0EFTcmYy7P8Rddw554
ARC-Seal: i=1; a=rsa-sha256; t=1519999251; cv=none;
        d=google.com; s=arc-20160816;
        b=DFAnAOKgM/NaENvdqv6EHtRio4ci35e1wp3S5ukuUCqmB9tw1en37dBi7nQC4zGjj4
         oLc2zo7mG+U2e/5K57jNZGAq7a/snzBFI+ubdTjpUo0R4hoTkV9PrENoYezHiWjr3WWm
         3g8qvlba8zi+ikz4t2OanciN/mFZRFDfIBS+ox7TWMnRQFNRGnDuG/1vDvhA7WwkgC1W
         /BeZ+eibkyeyMtSJj3iY/4us0WvQBwEpa9lZ6hM8gY6llzaIIQ/JJXvg6Oa3Ehj6Ct/0
         unM7oqD/XqkywH3MhzcCCHBG4l22XTyac7e7rQRpC6ylBkXPzv6rTwgJrxSnOr7r/hzI
         HdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=V+osiN+6ZU1jmhYsCGSRwIj3EFDU3Pi9tS6ZojeSb2g=;
        b=05UsFkwJGzx8vPvN9vi5dbeWFJHTYLkAyMenpY12Go7L4kfWXqmvV7Pq9OLU1rAMe/
         TOHIxWjCewUhszpr2i5GL3TTmhplfpOK+lASgCsy9A6QnG8LjKIUj+oRUUvd8HOH++vN
         JDCxPm/sm12UyA6oi4UJWZWjvVwslb8HKQ2dpTshjHmFsJgciO2A/+tT/OBgqSMcbwko
         A8fKPld4OSH26AUKaFgH1rOwBOb59cEq+/3RHv5d+hDPLrCXTqbJv7dgkeXGYGqv25TV
         Zu3VkqlZ6dKKekp2+ZhHPoR1ym/ORJC22nT6ZeYwDcJNz9xLuAiWfWMDE2TsDAWliXAp
         JfiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Date: Fri, 2 Mar 2018 15:00:50 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, dcb314@hotmail.com
Subject: Re: [PATCH] siox: fix possible buffer overflow in device_add_store
Message-ID: <20180302140050.eawswobo3fpkj52i@pengutronix.de>
References: <20180214142502.20787-1-g.schenk@eckelmann.de>
 <20180214170021.pf2di46t2ggfepim@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214170021.pf2di46t2ggfepim@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592386720059475890?=
X-GMAIL-MSGID: =?utf-8?q?1593834734822080123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Greg,

On Wed, Feb 14, 2018 at 06:00:21PM +0100, Uwe Kleine-König wrote:
> On Wed, Feb 14, 2018 at 03:25:02PM +0100, Gavin Schenk wrote:
> > Width 20 given in format string is larger than destination
> > buffer 'type[20]', use %19s to prevent overflowing it.
> > 
> > Fixes: bbecb07fa0af ("siox: new driver framework for eckelmann SIOX")
> > Reported-by: David Binderman <dcb314@hotmail.com>
> > Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

is this patch still in your patch queue? The patch didn't appear in next
yet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
