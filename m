Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999EDC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2702075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2702075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936089AbeFRSqh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:46:37 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:42305 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935726AbeFRSqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:46:35 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUzAd-0004Kb-BQ; Mon, 18 Jun 2018 19:46:31 +0100
Message-ID: <1529347590.2289.271.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 16/37] i2c: rcar: rework hw init
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Date:   Mon, 18 Jun 2018 19:46:30 +0100
In-Reply-To: <20180605170109.859976584@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
         <20180605170109.859976584@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 19:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> commit 2c78cdc1c06308a59d6ed4145cdba73fdeff8c0d upstream.
> 
> We don't need to init HW before every transfer since we know the HW
> state then. HW init at probe time is enough.

This part got reverted upstream by:

commit ae481cc139658e89eb3ea671dd00b67bd87f01a3
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Apr 18 20:38:35 2017 +0200

    i2c: rcar: fix resume by always initializing registers before transfer

so maybe that should go into stable (4.4 and 4.9 branches) too?

Ben.

> While here, add setting the
> clock register which belongs to init HW. Also, set MDBS bit since not
> setting it is prohibited according to the manual.
[...]

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
