Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C268821722
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buwQq3+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C268821722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH0Kuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 06:50:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43889 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeH0Kuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 06:50:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so9576280lfi.10;
        Mon, 27 Aug 2018 00:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SjocBBrCQtxdAcNNw/CASvMiffQ/AsntiRGpp2MTatg=;
        b=buwQq3+RAg8VOy+XSAmAvftoRHi82jNbGSx+kDUZme/KT8wCsV8VD4J1a9TBqphJR1
         Nf3r+oui+gOTj0GSTr3LknXS9qmBSYhju8j478mK7Hil1cc0TzFFqWYQJPn/oDMOusZY
         MIezW6KZAc8jsxp/qmAwrWZ31AoozftUIgr7PqnlvyujXjD7Lyd24/x4JKaBNSigKXEh
         EfDP78tjL0ZmrI6DtCTr8ZVBAw8MjH4p0ZWrN2G4ZSPkIDkmYcn5MiCjlIaO4LFMpYQZ
         sdqP5xlXlx5WZ16OTBevZfTp5jeJIO/9huBpTlx92JjJJRI2KaoFGmaO2LfiDSMxVR8h
         L/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SjocBBrCQtxdAcNNw/CASvMiffQ/AsntiRGpp2MTatg=;
        b=LmyhdIla+K6xfva/EzhtfXjeHQhGAdg0EZm0K4qbfy1eHVuH/3Q61T+ThdVwrNU2jn
         B87jwNxCrdbrpUi7YQws4kzWRuaYYf3eiFobn/Q5dXNBDMaVO5gOrRePGZBZJp++Ofrr
         apSg1scleWs5xdUWQ5uRJhQ7vYQst3IPK/RoQ2Mfmjm2CTqIPGRsNvLPB8sabm7Mzuzs
         9VXn2T0rFo9dJ6wEccahE0fbTMQCPflhNvrFgiRSdVWhPfNne9vQliZ6EFjEe2DKwrRo
         nk/2EUsiaC4edNkSYKNzZBtPmpcD8gIp4r0Pz2/uVI1PsKQfI9lAmvuCuz2xVbGt2632
         UMgQ==
X-Gm-Message-State: APzg51CbPNH7aVBxbAEqhV9TCRGfjqDfogKi86+nrSVHmChFn94SR/g7
        tcjoBEnQHTvDdozzhbIRn4o=
X-Google-Smtp-Source: ANB0VdZR+j/uD73s0NpWwhoJlWkOCSZFQgQiAUoK6RYkex8eLJqNecVr/0F+Zy4khySueWRjfcBlrA==
X-Received: by 2002:a19:c38b:: with SMTP id t133-v6mr7786323lff.7.1535353509303;
        Mon, 27 Aug 2018 00:05:09 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g30-v6sm2762401lfi.84.2018.08.27.00.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 00:05:08 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fuBaE-0006Ud-E4; Mon, 27 Aug 2018 09:05:06 +0200
Date:   Mon, 27 Aug 2018 09:05:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "J, KEERTHY" <j-keerthy@ti.com>, Johan Hovold <johan@kernel.org>,
        d-gerlach@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
        ssantosh@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which
 it is functional
Message-ID: <20180827070506.GW14967@localhost>
References: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
 <20180822073409.GK14967@localhost>
 <20180822073719.GL14967@localhost>
 <ae71d45f-9260-3547-5ff2-355c084fcf8e@ti.com>
 <20180822084318.GN14967@localhost>
 <335b4efe-ab18-df83-35f2-ee232c09f2e3@ti.com>
 <20180822142220.GG7523@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822142220.GG7523@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 07:22:20AM -0700, Tony Lindgren wrote:
> * J, KEERTHY <j-keerthy@ti.com> [180822 11:11]:
> > On 8/22/2018 2:13 PM, Johan Hovold wrote:
> > > Yes, and a blacklist would make much more sense for something like this
> > > if where talking about specific boards.
> >
> > Black list is easier here?
> 
> After thinking about this a bit more I think the boards supporting
> deep sleep should add a PM related dts property to enable deep sleep.
> 
> The board maintainers need to test and verify deep sleep for each
> board, it's not something that just works for the SoC in general.
> Some boards may use different powering for things like DDR where
> it's power might be controlled by a GPIO regulator. And in some
> cases deeper idle states may depend also on the PMIC being used.
> 
> Maybe we already have some dts property we can use to describe
> the idle states the board hardware supports?

Yeah, unless you can infer this from an existing tree I guess you need
to add a new property. And indeed, a driver blacklist would suffer from the
same fundamental problem (with an ever expanding list of machines) as a
whitelist even if it would avoid regressing currently working systems.

Johan
