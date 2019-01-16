Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05978C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A3420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSxiXvnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbfAPWUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:20:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43598 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732911AbfAPWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:20:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so3728879pfk.10;
        Wed, 16 Jan 2019 14:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fdarlz6hqiv/oLKf8homc0JZcyforYG/4zayxS3EavA=;
        b=tSxiXvnfSJFbFL7UueIBgO6wcL07ypiY6T1gYF02rZVglv7qQc+zACgNZh21ZZxYA+
         MCclwdlxN1FI01g7ZRvwyO5Ly9Iu4bh5VI1A0T+obHw34tS0DvTifoRQHgtA+7HUUMkO
         bH6/4J9S9Q5zmwdIYbpnB3PFl54VKGBrxWUYVXaenKZju1mVn9682CT5mBEd87XQ0nPa
         RxoqKm/UWl8xg+n2YwVUcUsZSh/538r9ZiC+10bNOL76IlKjOaJay1iheYVuEBCDZwBX
         IieqQtliOWCfzTIIDIyDkiZ7gmHczlT+LT8R/o6cepGleYtQmTCf8ofYo5RGYyJbBSx3
         qmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fdarlz6hqiv/oLKf8homc0JZcyforYG/4zayxS3EavA=;
        b=bOeRSmJIGDZybA6wY4Dk2lTf4kgXfcjg6asUcJo2mW0e9rccHW1XzXVhwqUbJoaPJ1
         hVypCYjbNnB0P9i+qEH2iyQVU8b1jzy584fUnmnnv7S9oDNxPmi6wHQ+tZLbo4WVX/rR
         8T4+peFxepPuq5g/VpTWFTNEqkx+n2+CJOiBlIkyKDckBDTJQ9xhUErZ7yrZmmpRcQ3n
         Srj+l1368xDXQ5G5qaeqZzTo4CocAJQiUSVG7LTGFYREqZZ4K6px8PqqDMmgg1cja3tr
         nWD2/L8ibGIgVpg38/vW0acVvpP4a9KQyxAl94k+obOsUFzz2ysenuDwrttZwasf+xT7
         1AYQ==
X-Gm-Message-State: AJcUukeACauPbGfqjwMh9cRCn5SdmqgSF6GtAppHph9EWQKIrzkMJH2z
        2wa3zZOE8WnONKEQUER0+CI=
X-Google-Smtp-Source: ALg8bN6RatEEc6P7+8RmBRY1CHdTPhNHoJd/B/T5AxgQanHmlzOR2vFs+nAEbWebYF2RX+p+5RyzOg==
X-Received: by 2002:a63:5107:: with SMTP id f7mr10577942pgb.218.1547677230830;
        Wed, 16 Jan 2019 14:20:30 -0800 (PST)
Received: from [10.67.49.9] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id 125sm9839840pfd.124.2019.01.16.14.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 14:20:29 -0800 (PST)
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume
 callbacks
To:     Andrew Lunn <andrew@lunn.ch>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
References: <20190116153419.3208-1-miquel.raynal@bootlin.com>
 <20190116155651.GC29244@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <e9ac5203-87ba-c14f-8140-5b100808a8a4@gmail.com>
Date:   Wed, 16 Jan 2019 14:20:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116155651.GC29244@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 7:56 AM, Andrew Lunn wrote:
> On Wed, Jan 16, 2019 at 04:34:19PM +0100, Miquel Raynal wrote:
>> Bring S2RAM support to the mv88e6xxx DSA driver.
>>
>> The content of the *_irq_poll() helper is moved in *_do_irq_poll() so
>> that that the function can be called from the ->resume() callback
>> without using the *work pointer.
>>
>> +static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
>> +{
>> +	struct dsa_switch *ds = dev_get_drvdata(dev);
>> +	struct mv88e6xxx_chip *chip = ds->priv;
>> +
>> +	kthread_cancel_delayed_work_sync(&chip->irq_poll_work);
>> +
>> +	return dsa_switch_suspend(ds);
>> +}
> 
> Hi Miquel
> 
> I don't think this is sufficient. You are leaving the switch itself
> running. It will still be forwarding frames. And since the host is
> shutdown, there is nothing doing spanning tree protocol. So you are
> likely to cause loops in your network.
> 
> Take a look at bcm_sf2:

There is a big caveat though, bcm_sf2_port_disable() checks a bitmask of
ports that might have been configured to allow Wake-on-LAN. Technically
you could also leave the switch running during S2RAM on these platforms,
which requires putting it in unmanaged mode, in order to continue having
stations "talk" to each other.

But in general, Andrew, is right, you must quiesce all activity on the
switch while you suspend it.

A possible approach could be to call the port_disable, port_enable
callbacks from dsa_slave_suspend() and dsa_slave_resume(), I might have
some patches doing that already somewhere.

> 
> static int bcm_sf2_sw_suspend(struct dsa_switch *ds)
> {
>         struct bcm_sf2_priv *priv = bcm_sf2_to_priv(ds);
>         unsigned int port;
> 
>         bcm_sf2_intr_disable(priv);
> 
>         /* Disable all ports physically present including the IMP
>          * port, the other ones have already been disabled during
>          * bcm_sf2_sw_setup
>          */
>         for (port = 0; port < DSA_MAX_PORTS; port++) {
>                 if (dsa_is_user_port(ds, port) || dsa_is_cpu_port(ds, port))
>                         bcm_sf2_port_disable(ds, port, NULL);
>         }
> 
>         return 0;
> }
> 
> qca8k does something similar.
> 
> 	Andrew
> 


-- 
Florian
