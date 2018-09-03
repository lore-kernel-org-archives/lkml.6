Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9ECC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE6D20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d4Q2/kW6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h7plb/6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE6D20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeICRZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:25:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47882 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeICRZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:25:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 003AA60710; Mon,  3 Sep 2018 13:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535979933;
        bh=tddeEVPf44KlGurlZeqRtbCZkmPk2NsrFCu4g41NVvw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d4Q2/kW6Sg6VDotBMPQQgYygk1ghDo+jNuSFdaWh5nOvS+6QYU79F6VZYHFWp/Dqm
         re2fxjXo2JkGFv2P31llsNsA7KkK7sH+kq+LOwRHCw67HWRja9YGV4uW5UqT3wWibj
         gi0zC7OaJPhz1uXTpq7SJ2aUd2NjwI2Qd0SdGb/c=
Received: from x230.qca.qualcomm.com (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A99E605A4;
        Mon,  3 Sep 2018 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535979932;
        bh=tddeEVPf44KlGurlZeqRtbCZkmPk2NsrFCu4g41NVvw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h7plb/6gLaqBMeCIv0mJQGJEiGLfwLW/WJTTHHx9bChDGPWNhcfDkyaekzzKpBj+s
         rZovzkKYdaiB1zcw2uRfZxxhrrM1WvAS1VexSNX7hxdk4eT+KYPJQEYXFkX/kY7fzq
         KKdWZhKQ8oKMjIlaTWSgDvLu2U4bM8/+B05OWPbc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A99E605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
References: <20180901083834.11201-1-kristian.evensen@gmail.com>
Date:   Mon, 03 Sep 2018 16:05:29 +0300
In-Reply-To: <20180901083834.11201-1-kristian.evensen@gmail.com> (Kristian
        Evensen's message of "Sat, 1 Sep 2018 10:38:34 +0200")
Message-ID: <87ftyqwx2e.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Evensen <kristian.evensen@gmail.com> writes:

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
> v1->v2:
> * Updated commit message. Thanks Kalle Valo, Arend van Spriel,
> Lorenzo Bianconi and Andrew Zaborowski.
>
> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
> ---

The changelog should be here, after the '---' line, so that git can
automatically drop it. But I can fix it before I commit, but in the
future please add it to the correct place.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#changelog_missing

-- 
Kalle Valo
