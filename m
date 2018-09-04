Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FAD20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c05bI1Vg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HWNj+hjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FAD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeIDMjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:39:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:39:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E874607B9; Tue,  4 Sep 2018 08:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536048915;
        bh=8iezEVjBv+2SQh9WDTIlp9lIsrAxC3UjhLSfLSBpddU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=c05bI1Vgvm4zNjasYN8j7KX5pa0ttLIGnjavEGaARskmgu3PiK6Chb3zZbePymrZa
         Nr537RCJTuoq4gnzWIkKqOtb4BMJLQW6E6bp3QFq1op1pPDlAkfh6M9UglrYkWSw4X
         clVjJhyw1c5sZ0EeT6TmVqH3fiwMuJGKvwtjNEJs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D485606AC;
        Tue,  4 Sep 2018 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536048915;
        bh=8iezEVjBv+2SQh9WDTIlp9lIsrAxC3UjhLSfLSBpddU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=HWNj+hjFcDAPbDD6f3L26veHKFt1xz+eKpK377tfsDPqmKlIUPbhdX70gTdXgUOXT
         zRNpDLxP3xkZkuAGwKp0Et/Mcv3+uXIb14BXWxlDtJfhInGulsx4H4OXx+ZxIGn9G/
         Opb0pdqRykFVkxDxuBgqD0fLQual+Rn+IYU3ZoDM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D485606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180901083834.11201-1-kristian.evensen@gmail.com>
References: <20180901083834.11201-1-kristian.evensen@gmail.com>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kristian Evensen <kristian.evensen@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180904081515.6E874607B9@smtp.codeaurora.org>
Date:   Tue,  4 Sep 2018 08:15:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Evensen <kristian.evensen@gmail.com> wrote:

> Enable the use of CQM_RSSI_LIST with mt76-devices. The change has been
> tested with the mt7602, mt7603 and mt7621 PCI wifi-cards. I passed a
> list of RSSI thresholds to the driver, and when disconnecting/connecting
> the antenna(s) I got an event each time the RSSI went above/below a
> threshold.
> 
> While I have not been able to test the change with any of the mt76
> USB-devices (no access to a device), the RX RSSI management code is
> shared between the two device types. Thus, CQM should also work with the
> mt76 USB-devices.
> 
> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

b37b30afc2b3 mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST

-- 
https://patchwork.kernel.org/patch/10584647/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

