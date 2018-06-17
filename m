Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CEDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D071B20891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D071B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934380AbeFQQvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:51:15 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46709 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934130AbeFQQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:51:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fUatS-0005AK-0X; Sun, 17 Jun 2018 17:51:10 +0100
Message-ID: <1529254269.2289.212.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 188/268] hwmon: (nct6775) Fix writing pwmX_mode
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 17 Jun 2018 17:51:09 +0100
In-Reply-To: <20180528100223.691255680@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100223.691255680@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:02 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Guenter Roeck <linux@roeck-us.net>
> 
> [ Upstream commit 415eb2a1aaa4881cf85bd86c683356fdd8094a23 ]
> 
> pwmX_mode is defined in the ABI as 0=DC mode, 1=pwm mode. The chip
> register bit is set to 1 for DC mode. This got mixed up, and writing
> 1 into pwmX_mode resulted in DC mode enabled. Fix it up by using
> the ABI definition throughout the driver for consistency.
> 
> Fixes: 77eb5b3703d99 ("hwmon: (nct6775) Add support for pwm, pwm_mode, ... ")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[...]

The code changes look fine but the comment on the declaration of
nct6775_data::pwm_mode is now incorrect.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
