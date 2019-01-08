Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E359206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IorZKE5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfAHTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:08:25 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40075 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfAHTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:08:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so4363024lji.7;
        Tue, 08 Jan 2019 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tx4Bb5mSA+1eNEVjlB3sa9ST2w0B/EHzv4Fe3XWFzDE=;
        b=IorZKE5o6iAOlcPcvxlPJwG91X8mFCH9A68O29CxyNdrEXLL3zH0XKkFuE6H0S1An0
         7i2wnUWEESLe3XskumlHJ8gFn+tNFYvDbwnFevtybCarIihMR8tJAAKF1UDojyp4AiT2
         vGvSU33PFTmLCiUysUrOp6d9WV9hrMB6GYrlBqmf/ZbYmtAXrJL7fxBnj9YoneF5cb2m
         T1BxNI6hC2p1YHqDNk58BXX5AQH/7LoOYdtMLTpPsnKR2w46aiphgphIEMpKpP98MOCV
         d+i3CHRWfXM75m1NqQkebjV0e32gVj9yyIY0iPEFdrq1v65nudArOVyvNrdRSgwCvU0Q
         632w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tx4Bb5mSA+1eNEVjlB3sa9ST2w0B/EHzv4Fe3XWFzDE=;
        b=AVIGWIBAcbcDSfe2/R+VRfdVcoxsZAxvUlYvX5u5CmMm/WdRcq34mTijKmLyzzTKlZ
         gkqrQ6CPyyRBHs5OVSPYySo7qR+LCQ43lqdGQxIUSaP5drmeLEJLHUr0ZeCbs2XMkX7G
         2pljDjsMikkuud6Gw4nBOBsHj8IdZU1jEvVojPmRtq2mDtKqTUZ6wKybzSxT0vHVNCAv
         c72evA3wCDXqSI9YYNiLZvhJqYz3SyDkN1sRl0SyHn3+QlLpHFK2yRXn5od18nVSXtwV
         umwi7YrIFRrY9qP1hm/k1TURx2AmEn5SvPS/RWaR9dbeI2cQVNz3b7qtTuy/kKR62g+9
         o9Fw==
X-Gm-Message-State: AJcUukf1fyttCn/53w45FwwWrttkbD9vrHEba57RD9LOHQOfp5SS7CcM
        xhGkNtKHfqljsA4zwKd4Zx920QB3obk=
X-Google-Smtp-Source: ALg8bN74dvV6axouRToefh7K6ZH3fkqqMhq10Rcy+j0dYEfQvsmCO5VYbk1v0IZ0sRUmDVNaYgphEQ==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1717408ljh.59.1546974502178;
        Tue, 08 Jan 2019 11:08:22 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id r7-v6sm14460927ljc.10.2019.01.08.11.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 11:08:21 -0800 (PST)
Date:   Tue, 8 Jan 2019 20:07:57 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: chemical: add support for Plantower PMS7003
 sensor
Message-ID: <20190108190756.GA25862@arch>
References: <20190106171614.12615-1-tduszyns@gmail.com>
 <20190106171614.12615-2-tduszyns@gmail.com>
 <20190107153542.GD14782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107153542.GD14782@localhost>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:35:42PM +0100, Johan Hovold wrote:
> On Sun, Jan 06, 2019 at 06:16:12PM +0100, Tomasz Duszynski wrote:
> > Add support for Plantower PMS7003 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>
> > +static int pms7003_do_cmd(struct pms7003_state *state, u8 cmd)
> > +{
> > +	/*
> > +	 * commands have following format:
> > +	 *
> > +	 * +------+------+-----+------+-----+-----------+-----------+
> > +	 * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> > +	 * +------+------+-----+------+-----+-----------+-----------+
> > +	 */
> > +	u8 tmp[PMS7003_CMD_LENGTH] = { PMS7003_MAGIC_MSB, PMS7003_MAGIC_LSB };
> > +	int ret, n = 2;
> > +	u16 checksum;
> > +
> > +	switch (cmd) {
> > +	case CMD_WAKEUP:
> > +		tmp[n++] = 0xe4;
> > +		tmp[n++] = 0x00;
> > +		tmp[n++] = 0x01;
> > +		break;
> > +	case CMD_ENTER_PASSIVE_MODE:
> > +		tmp[n++] = 0xe1;
> > +		tmp[n++] = 0x00;
> > +		tmp[n++] = 0x00;
> > +		break;
> > +	case CMD_READ_PASSIVE:
> > +		tmp[n++] = 0xe2;
> > +		tmp[n++] = 0x00;
> > +		tmp[n++] = 0x00;
> > +		break;
> > +	case CMD_SLEEP:
> > +		tmp[n++] = 0xe4;
> > +		tmp[n++] = 0x00;
> > +		tmp[n++] = 0x00;
> > +		break;
> > +	}
> > +
> > +	checksum = pms7003_calc_checksum(tmp, n);
> > +	put_unaligned_be16(checksum, tmp + n);
> > +	n += PMS7003_CHECKSUM_LENGTH;
> > +
> > +	ret = serdev_device_write(state->serdev, tmp, n, PMS7003_TIMEOUT);
> > +	if (ret)
> > +		return ret;
>
> Beginning with 5.0, serdev_device_write() returns the number of bytes
> written before timeout (or being interrupted) so you need to check
> against < n here.
>

Right, on the second though that can be simplified by just ignoring
return value I guess. Anyway, thanks for pointing this out.

> Johan
