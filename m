Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719E62063F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guHdfGYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfAOIbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:31:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39475 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfAOIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:31:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so1885329wra.6;
        Tue, 15 Jan 2019 00:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wTyboMc45g10/opeatWRRyFil2kUfSxdKqIQP2wlS2o=;
        b=guHdfGYPHAKCS0NPFJxIbrtcHW91VXjpY4DwljanmuqGneOES2GbDP6GZ/1rup9olP
         zp1sarbGyV3bK1LYsGI1GbvuRSURdEwdS/nJqcQn9hHEOQTgIheMnoJq2JcW7C2KjoNY
         xN5SwTHmNYJSXGDuclcYn6DTBTaxvz4VvD+VOTkwVasB50r7rr83rhGM9U8aOy/NU1zn
         8Gc25th9DGvvbc/L6vEVxMeO5Q9IiKbOQcZXAOedrAsFk8E8w2mmY1aU22OhnUlaNmqB
         bQyU7cL9LQ5vNgAAMsFip45sg0iN/s/v/xh11bYy5FgjRnRIa9BPOHTkmPV6wengUaSa
         KhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wTyboMc45g10/opeatWRRyFil2kUfSxdKqIQP2wlS2o=;
        b=UJvnnv5N14xMVLzE2V9hHdTDpB/cb6z13PPV2kcMjQ3q6qNwR0YyI6m8XfrvkcY735
         6ZpjO/gJeYwCllnL2CPMM/CjqRATPkcCFNFzBYK2L5nY3PP06UoYRBqgboWI2jkU2qD7
         olvUwGfQzplNhtw4bQQiMFaSUNR4H2oD7yc/IItw/0C8647R+1bXsPJBV2t9TEQqRuUd
         8xNFLj+TYySu+g1lHFPXCbHtQE/6B1EygWyYCd4aJqP3ta3NYn5o67C97Kznwa11pBqb
         aMmFVLoq5ZzuD02lNeGXpFQglFDZ+BghrO2SsyVMLnJwT/PtLZGXbZHZCLIE1FMjhwD6
         tD9w==
X-Gm-Message-State: AJcUukdp0uFcS8wDGo6XT6HR7WEX1wt/Q4XfF+9MyPAzQh9+YAHSkIdy
        C0MdxmgMSHm5pF9c8jclXTuxffWP
X-Google-Smtp-Source: ALg8bN7cJ5u6ExsZ2JgdE+5Kmlg+Em6CYrNT46vLM4KC83QmZwk9c+pOZ6afgLbMEVX+jXFv9g+lsQ==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr1936632wrp.200.1547541074125;
        Tue, 15 Jan 2019 00:31:14 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id c202sm38831382wmd.40.2019.01.15.00.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 00:31:12 -0800 (PST)
Date:   Tue, 15 Jan 2019 09:31:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Michael Sabolish <sabolish@me.com>
Cc:     Jan Kara <jack@suse.cz>, Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190115083111.qq2mt2p2kn4opwx7@pali>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
 <20190114123042.GH13316@quack2.suse.cz>
 <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2019 19:07:35 Michael Sabolish wrote:
> I can try and make a pull-request for udftune, and I can just copy the API for tune2fs.  It would work something like:
> 
> udftune -O read-only device            (to set read-only access type)
> 
> or:
> 
> udftune -O ^read-only device          (to clear read-only access type (aka set rw))

This API is ambiguous. What does it mean for ^read-only? In UDF you have
following access types: overwritable, rewritable, writeonce, readonly,
pseudo-overwritable, unknown.

So you would need to know to which R/W access type to switch
(overwritable, rewritable, writeonce or pseudo-overwritable).

With information of media type, you could be able to guess correct
access type. But for UDF images stored in VFS there is no media
information. Also you can have uncommon setup, e.g. usage of CD-R
writeonce setup on CD-R/W disc. So "autodetection" of media type would
not work always correctly.

So I think that it would be better to have following API:

  udftune --access-type=<new_access_type>

or

  udftune --change-access-type=<new_access_type>

I understand that you would like to have similar API as tune2fs, but UDF
settings are too different from ext*.

-- 
Pali Rohár
pali.rohar@gmail.com
