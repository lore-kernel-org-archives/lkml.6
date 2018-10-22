Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02312C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7920651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC7920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeJVWW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:22:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeJVWW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:22:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so3541894wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 07:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zjNfqDaBC077P5P8cnDiFJdiNgu1IySfoOWLOnkto9k=;
        b=oRmUXcwYMkHzEOOOKTTp1uoZq/NtHQ1WJIrqDhnSo3wVpB71ErG5deh+e6cjfPrhVM
         Nsp66+GVkYO4skRjIqwLu36pKkcHc9V9N+pS+5hDAj6bKganhhPR0uVwLQG7c049y+xX
         L+z3O2kXz69JejEATqDLpWD3iKuAJUnXuceFU4ALq0nKRttUxTAJASVq+wj5Tyt9moi9
         gH17HsN92pzumluNdRLDPEk6HkCwVOoGH378X+LwsQadYdfGlTGAC9D/eva5gGFy8uem
         XxzpyGfDgiB2wL6AiAvcB/REhAsstgQNOJh5ZAv7AmGK+N/Wq98gC2eFQ8CLHJakH6xt
         XB1g==
X-Gm-Message-State: AGRZ1gLZyDnufIzTHd4+3Typ6AHsJF6g8JbxlJHoPUvx7P1Lt1Qq3U9d
        PrxlhxI9kOBQSRk/HPgI4ACwmvEzxMO8Rw==
X-Google-Smtp-Source: AJdET5fkv/WB4ZVFJlnsG/AH2ArRmgb732NX0yNgy2jqeCHSWE3WN+qkAmP1xvWaYows44Tsrrck0w==
X-Received: by 2002:a5d:640b:: with SMTP id z11-v6mr5513978wru.64.1540217051951;
        Mon, 22 Oct 2018 07:04:11 -0700 (PDT)
Received: from localhost ([185.7.230.215])
        by smtp.gmail.com with ESMTPSA id u10-v6sm27488200wrt.59.2018.10.22.07.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 07:04:10 -0700 (PDT)
Date:   Mon, 22 Oct 2018 15:04:09 +0100
From:   Moritz Fischer <mdf@kernel.org>
To:     Andreas Puhm <puhm@oregano.at>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181022140409.GA1883@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Oct 22, 2018 at 01:15:34PM +0000, Andreas Puhm wrote:

Can you please send your patch using git-send-email?

[..]

> Subject: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled devices

How about:

fpga: altera-cvp: Fix registration for CvP incapable devices

The probe function needs to verify the CvP enable bit in order to
properly determine if FPGA Manager functionality can be safely
enabled.

> 
> The altera-cvp probe function now verifies, that the PCI device supports
> the CvP feature, before it registers the device.
> This is done by reading the CVP_EN bit,
> Bit 20 of the CVP_STATUS register (@ PCI Config Address 0x21C).
> 
> If this bit is '1' (CvP enabled), altera-cvp will register the device
> for further interaction.
> If this bit is '0' (CvP disabled), altera-cvp will not register the device.
> 

Could you add a Fixes <hash> ("Message") tag here, I believe we had this
issue since the very beginning, i.e

Fixes 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")

Something like ^^^^

Thanks,

Moritz
