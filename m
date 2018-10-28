Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B9ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A4520672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 10:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYk5Gzsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A4520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeJ1SsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 14:48:22 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36614 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeJ1SsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 14:48:21 -0400
Received: by mail-wr1-f46.google.com with SMTP id y16so5486157wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/sIdGuk+1Ob2ZRTjOK5EPf0kuWxQal4NcCy5bh4Vpo8=;
        b=rYk5GzsqXjewMld+L/NcUJ2eQbLyCcc5XtqfdgosqDbw8Nz8I7NL6RE2WG/rDwndBb
         mMbW2DL5uE303RFOKv3KpdY0vjyMfKRlhkGl3aGuRLfkNPekmS1R7pIAyx0+zNAIFW07
         p2skJeeZbRxlqtEYFv08+nKHeYTIdx8xRdHGZeJ5tTP/1jN1MvMaIEWAr5eZyXed+s1w
         OJRghYqVbTk/TPkefHljcTRnN8okSaWr/btaFZFT8p+mZtORRrA1yBRy7wx8YLfVKXVS
         FE0TsxvU81ADnYYw0/4lzJaLkC22Vcrso4RVtjKqC4FVab2jHPp5P81PXYg3jEfVOBYB
         Bb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/sIdGuk+1Ob2ZRTjOK5EPf0kuWxQal4NcCy5bh4Vpo8=;
        b=PfCyK8LhfmooqkQ5zAxxvhwCn99XUhG20gwlYXVUNTeL9IwHgHQpuiNKnOdJB4sBr5
         xgom2idFqeiAk8u+dgT7V0H84Aibx+jgf9GMH72Gk/Tvw1m3tXZUhCupJWNkEjCB4Li5
         iHBXNQ+ant1HsQQWSrmjZilv8IdRfj7AAohmZVLE9plAY9coODEWoeNKs+yVcDq1x4EN
         yYYW7kDi5SJk1b6hHfjie1e/ODDMgN3qvetwAXtywmH9Fu6zrBekLIpf77jO51tfX4YF
         2Z11AQZUnH/5T//qA/nSshBOqT+HiI1dsH6ty3gvg1UJfzkP6YJETF82FOJzj0SQuB8L
         4iIg==
X-Gm-Message-State: AGRZ1gJIKXpk+efoVEPhr+ngGErYopcTcMzPt/wUoSmXjfxMR5fYUx2/
        uNW/VuT8nbNUvNHCfYssx0TOdnoK
X-Google-Smtp-Source: AJdET5fKAU6rEBlKFw2ZcQekPBeEGz7x5FCIulMr+xbt8f17ayMcjhkJbBOEq0DxhiR9mXMbmKxipw==
X-Received: by 2002:adf:eec1:: with SMTP id a1-v6mr11544642wrp.242.1540721048532;
        Sun, 28 Oct 2018 03:04:08 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id x139-v6sm16416906wme.3.2018.10.28.03.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 03:04:07 -0700 (PDT)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Straube <straube.linux@gmail.com>
Subject: Which SPDX Identifier for files without explicit GPL version
Message-ID: <406c69c1-43fd-f821-b74b-a1399ed636e9@gmail.com>
Date:   Sun, 28 Oct 2018 11:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

which GPL version should be used in SPDX Identifiers for files that
are GPL licensed but do not mention any version? It is not clear to
me after reading license-rules.rst.

For example:

/******************************************************************************
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
  * This program is distributed in the hope that it will be useful, but WITHOUT
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  *
  * The full GNU General Public License is included in this distribution in the
  * file called LICENSE.
  *
  * Contact Information:
  * wlanfae <wlanfae@realtek.com>
  *****************************************************************************/

or:

/* IEEE 802.11 SoftMAC layer
  * Copyright (c) 2005 Andrea Merello <andrea.merello@gmail.com>
  *
  * Mostly extracted from the rtl8180-sa2400 driver for the
  * in-kernel generic ieee802.11 stack.
  *
  * Some pieces of code might be stolen from ipw2100 driver
  * copyright of who own it's copyright ;-)
  *
  * PS wx handler mostly stolen from hostap, copyright who
  * own it's copyright ;-)
  *
  * released under the GPL
  */


Should it be GPL-2.0 ?

Regards,
Michael
