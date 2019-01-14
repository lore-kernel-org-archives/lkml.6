Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D512086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547457324;
	bh=pS+Kas6AYsqX5nlheLdriFDcYaAFA5fTQ4pS2CyKYT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vOSACPXDdpiTTgTGlLHnQjIciR7DXWEa8bdaSsnUAq+6n+fjwVeZLxIiamwPeLDB4
	 bZ4iP+WXQW1fgJO4dhE5lvfuTB4uywHccervyXdsB+nLJH/UsFaOFs4Z5yeggirlzu
	 of69z+aDTPBWKIA3y9cG/KZBDtbFKPJvGy4UWUB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfANJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:15:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41682 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfANJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:15:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so15014669lfj.8;
        Mon, 14 Jan 2019 01:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pAl0NRe/IOMpdeJNTCxP6GfLep4vIhxtuy8P4HVR5WA=;
        b=AEynDroNcMTthSh+xYmPZFyl8le2P5JsaUlNweZJF5XweRx+xhafItxuxTdXm4eHBJ
         qgWdjdW1l0r/3D34R5geAgasAK9Ff95zowqie1vyBk7VeWeiAoH9M14pX94TYD8zimbR
         dtXnO3zOFebs3uAzXEbdQSZ37sLKfrUMuQLTEu0kg0/6DTUdKVmrU8RnZSfRL1+q3lCv
         ixmlB1CbGdW7HDgnXqn9Hsv3UoR/IMKQg5PaTu4nPWzP3qztIjyoTSRQrVlteI3mr4Ht
         L4FyNWYeRC8ElcXWapPSXDeruGWNWKi2hhC95TnqqgjRfINgqyQAR8aLM/t1dfpjfJ8g
         opbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAl0NRe/IOMpdeJNTCxP6GfLep4vIhxtuy8P4HVR5WA=;
        b=jgJyUkcaKiKWwfK4kMeAtXQH6PkYwnbP/evc6O5sOBf0x4QKj2oOTO2lWGpEroB/Vo
         /Vrn3zWjAW6d/Mh7BUaYqzwjUN+cBUfff4Jrzj/hwSCfDIQjb5fxZs6AWpUneRUHoYsj
         SCxWbxivESUigVOGUtmsSN1nbo3b2L82Mn6N3Zxi1SUISmPd7ntmAq6DHA+t/yxxX4bF
         dh7ZucaGi6dDiYTHTzdOp8mJv5mE8ri1EBJf6z2DPkhP22utB1if/HRvP7hzbyYmo3DG
         zxkopVoM9f1hOq3lX4iah1TvsFEyoUJTAJtI0LZsKu6qKPh5T0Nmeu1TqXp7tsXUncfU
         ip0g==
X-Gm-Message-State: AJcUukepq5nSwV2PpDoGn4fCwMNWjtfeRpMEnIbUNUL2cCQzWmlI8+Fx
        7Bh28oMgjgPWE18bj6WfzIU=
X-Google-Smtp-Source: ALg8bN517u39kh+oJWbED5/0FtXr8ELM9hlrKcxPHg5eJI5PsTDHouP7chKL3MBzirGaHsyiLa49+A==
X-Received: by 2002:a19:2584:: with SMTP id l126mr12334696lfl.69.1547457319513;
        Mon, 14 Jan 2019 01:15:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h85-v6sm17414485ljf.68.2019.01.14.01.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 01:15:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1giyKz-0000Na-HD; Mon, 14 Jan 2019 10:15:17 +0100
Date:   Mon, 14 Jan 2019 10:15:17 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20190114091517.GD3691@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-6-andreas@kemnade.info>
 <20190110122757.GB9725@localhost>
 <20190110180732.75490757@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110180732.75490757@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 06:07:32PM +0100, Andreas Kemnade wrote:
> On Thu, 10 Jan 2019 13:27:57 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Sun, Dec 09, 2018 at 08:51:50PM +0100, Andreas Kemnade wrote:
> > > Add lna-supply property.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v2:
> > >  - reordering
> > > Original order had a
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > 
> > >  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
> > >  1 file changed, 1 insertion(+)  
> > 
> > Ah, missed this one at first.
> > 
> > But shouldn't this go into the generic binding since it isn't specific
> > for sirf-star based receivers?
> 
> That idea was formulated with a question mark towards Rob.
> And no reaction from Rob about that.

Right, maybe that suggestion wasn't very clear.

But since this property is not specific to sirf-star based devices, it
needs to go in the generic binding.

Thanks,
Johan
