Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC854C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958F20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InOOevSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7958F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754968AbeFTJjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:39:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32812 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754346AbeFTJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:39:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id y20-v6so3969008lfy.0;
        Wed, 20 Jun 2018 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=53RqdMgJe501ZwHBFy3GdDgzSQtdvcKbY6fc6DDTPuk=;
        b=InOOevSxFtmk02rvTEy/BHKi+zyy3m5HUeLLGfgFvweMqudz1/cKc4M8rTcFX1cbmw
         bW9hZ+Dxy3Ubr9YEC7ty8LpTigdHxwH/KGEMulPJB+6HOFZOo0z7H0aT4CsiasZhg8ti
         MXo6vSNXWtbBLuihR/o9IWlzfP81gesuV97zk/687/aVB7kx0lpQCINfH024TZH7V0B1
         3yO03TTBI2K86M29U3oPry3lbE+6yky7ZaeT6azFkU5cJP8YC6dGVsNoll+wfbRAaw01
         rNez4Sis+Lzt3MkxAKElqIkmZWY+LIRogFdH9wR4cp/+cWb6P/VzzlD2z+xs9saoeV57
         yomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=53RqdMgJe501ZwHBFy3GdDgzSQtdvcKbY6fc6DDTPuk=;
        b=YW+ViSMcOtxmpxMqJ/GAbkfSEplTRrrmiTj44o/4PAUATx8m/0tjLovs3sehnSq9fD
         YcmxtT8IlsHn+eCA7qKzlEmWhVqdBJPnqoZfGwLEHrHzjiSN/zapCLSyypAD+ovzHrwI
         4Eo9FIapcsTm96L9pwliKHYpNtiDrV3G8B7d37I+lQ5qydMQRbzOjLN5dXReO211SiwV
         2/7u+PDUsul4H77iXHbkWXJH0w3jLSWf+dZe75ieFwK8KklgXEgYUoOfiWhHnzEOCzTE
         JiosKX2+Nur/cjitfK+8oGGkJmE7luNBiW7+ZkknBorKrmNPgJ5Cx/gMjOxTjwUB6/eX
         H7eA==
X-Gm-Message-State: APt69E3+IgD1o/Ys8rZvcJlT1A0M1XDicKuyzTdHI+9e29ww1g+iQ5zp
        /ORixAMuQOD6nNx5A4kmk5nQvMTG
X-Google-Smtp-Source: ADUXVKIQJTzzVdEhPzff4OSHRCtCWefKLjUh17VRm7otxm4l0gIe/Ozn9XXZiNOZlhl2gGMxVxfCWg==
X-Received: by 2002:a19:a586:: with SMTP id o128-v6mr1285012lfe.131.1529487574236;
        Wed, 20 Jun 2018 02:39:34 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id f124-v6sm332771lfg.33.2018.06.20.02.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 02:39:33 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fVZZx-0003Bn-57; Wed, 20 Jun 2018 11:39:05 +0200
Date:   Wed, 20 Jun 2018 11:39:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Improve baudrate support for CP2102N
Message-ID: <20180620093905.GP32411@localhost>
References: <20180619091528.GN32411@localhost>
 <20180615212957.26539-1-pados@pados.hu>
 <0b27c3da292fa1f4b360614685fe8aa4@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b27c3da292fa1f4b360614685fe8aa4@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:50:54AM +0000, Karoly Pados wrote:
> Hello,
> 
> > Pass in a struct usb_serial (or port) as a first argument instead which
> > allows for more readable code as well as for this to be reused to handle
> > other device type differences (e.g. only 2108 besides 2102n handles
> > baudrates over 921.6k).
> > 
> 
> Sure, will do.
> 
> > Add a static helper (looks like you add a define in the gpio patch)
> > cp210x_is_cp2102n(serial) here.
> 
> Yes I have macro for that in the GPIO patch, and I will turn that into a
> static function too.
> 
> To keep the baudrate and gpio patches independent,
> do you think it is a good idea if I make a new patch which only adds the
> partnum defines and the helper function first, then baudrate v2 and gpio v2
> can build onto it?

No, that's fine. And you can submit it as a series, where the first
patch using the helper includes it (e.g. the baud rate one).

> > You can even test for bit 0x20 in the
> > helper if you prefer (we can always change that later if needed).
> 
> If you wish, but personally I think that is asking for future bugs
> in the long run. Even though the helper can be easily adjusted if needed,
> when/if a new partnum shows up which has nothing to do with the cp2102n,
> no one will think of having to adjust cp2102n-spacific code until bug reports
> start coming in. So I'd prefer to explicitly check for the packages, but in
> the end I'll use whatever you prefer.
> 
> What do you prefer?

Sure, I have no strong preference. You can keep the explicit package type
enumeration if you want, but move it to a static helper. We'll see how
this ends up being used in the series.

> > And even if the current code uses this odd formatting, your amendments
> > should not.
> 
> Of course. I also saw this is odd, but (apparently wrongly) decided to 
> stay consistent inside the function with existing code. I will change
> that too.

Yeah, that's admittedly a bit arbitrary. I should probably just clean
this up somehow once and for all.

By the way, have you tried setting other baudrates except the ones you
explicitly allow for here? According to the data sheet more rates should
be available, so perhaps just handling cp2102n as cp2108 (e.g. by not
trying to report back the exact rate used) or by actually calculating
the resulting rate could be another option?

Can be done later of course, just curious if you tried it.

Thanks,
Johan
