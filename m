Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2ABC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DDE25A64
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DDE25A64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smarthome-wolf.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeFYN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:28:01 -0400
Received: from dd39320.kasserver.com ([85.13.155.146]:45652 "EHLO
        dd39320.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755461AbeFYN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:28:00 -0400
Received: from dd39320.kasserver.com (dd0802.kasserver.com [85.13.143.1])
        by dd39320.kasserver.com (Postfix) with ESMTPSA id D724A2CE0120;
        Mon, 25 Jun 2018 15:27:58 +0200 (CEST)
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SenderIP: 108.171.129.168
User-Agent: ALL-INKL Webmail 2.11
In-Reply-To: <20180625123554.dlpgejqmjm7haak4@mwanda>
References: <20180624094245.23741-1-Valentin.Vidic@CARNet.hr> <20180624163138.30976-1-Valentin.Vidic@CARNet.hr><20180625123554.dlpgejqmjm7haak4@mwanda>
Subject: Re: [PATCH v3] staging: pi433: replace simple switch statements
From:   marcus.wolf@smarthome-wolf.de
To:     Valentin.Vidic@CARNet.hr, dan.carpenter@oracle.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        robsonde@gmail.com, michael.panzlaff@fau.de, hle@owl.eu.com,
        luca@acul.me, linux-kernel@vger.kernel.org,
        marcin.s.ciupak@gmail.com, linux@Wolf-Entwicklungen.de,
        simon@nikanor.nu, joe@perches.com
Message-Id: <20180625132758.D724A2CE0120@dd39320.kasserver.com>
Date:   Mon, 25 Jun 2018 15:27:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

I'd like to mention once more, that the idea of the abstraction was to 
support multiple modules of Hope-RF.
If the decision of the "team" of developer of this driver is, that it 
should be reduced to a Pi433 or RFM69CW driver only, I fully agree, 
that the abstraction layer isn't necessary (tough improving readability).

But if the "team" wants to extend the driver - here I explicitly want to 
Name Marcin Ciupak and Hogo Lefeuvre, both were discussing this with me - 
I highly recommend to keep the abstraction layer.

And once again, I have to announce, that - if noone appears, who wants to 
help me with selling Pi433 - I can't effort to let Pi433 on the market 
longer then end of this year. From this Point of view on long term it 
might be senseless to prepare a Pi433-only driver.

Cheers,
Marcus

Dan Carpenter schrieb am 25.06.2018 14:35:
> I'd still prefer if we just removed this abstraction entirely and used
> OPMODE_MODE_TRANSMIT everywhere instead of bringing "transmit" into it.
> 
> I know that every author thinks their abstraction will definitely be
> useful in the future, but generally kernel style is to remove
> abstractions.
> 
> But I guess this code is an improvement over the original so the patch
> is fine.
> 
> regards,
> dan carpenter
> 
>

