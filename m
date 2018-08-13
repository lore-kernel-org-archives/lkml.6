Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C21C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A0C21782
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 04:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyF0/qiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A0C21782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeHMHjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 03:39:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40364 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeHMHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 03:39:20 -0400
Received: by mail-it0-f66.google.com with SMTP id h23-v6so11780495ita.5;
        Sun, 12 Aug 2018 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYXpJfwsER+EeXHbgL8do+8ipCe/rSy/AGFQDlxEo3Y=;
        b=FyF0/qiO3W2i4AMhzO/U6/V6zxAIcGSOG0uFZXgBwwap6rLF3TLL4GlsqwCX2eUKUS
         9f1O8sjo+tEerYAKioFn7/cng5zP9WKlh1SmnmKYZAg+4VfpUPRVAGIBaOwkKOOKLIcZ
         eG2PdSA3KeSQlyQCJkNpFnwncWYe7ZYCZJJ0U5a0zBK0DxGmOY4OJAYgO4ZmPF+NnxZH
         5IitCuw6/RWCXz2fDuxtD5ndX6vJAhob3MiobmOX225r39YpHOsr5GHObfIC4O4KIDAm
         TOOABNYiU0vFwHzW2Htn3jy1ZKSEoMvySas5fdlbiONfMXTOmdpzOFN9uPnRzqE6Gvnd
         ++HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYXpJfwsER+EeXHbgL8do+8ipCe/rSy/AGFQDlxEo3Y=;
        b=BVITx6gUcEoDzRT4qrJlFxDJPiYp+LjnIMozH+o2Y557osnViCydHqQbU2+OEcFXuC
         Lt6JHqSy5MbLn8nwITGQKdk5ijwUqlEQa09mJyVDeX+lto9rncI4jmrJxCMhzD58naku
         GHVFWjE5PTxpt/Iam3qTWo8N+WnmkswGkjsLNeqi5mvoodWOLpn6aRdusrMn6OlbaCiv
         kG1gTWMQkJ9vC4HaQAwYiMVDDFGXms+UtPITL/g0aYe2x6RFEMF1N0ZiMFP0YSAgVKPt
         UuS4+89tzEjSuXFXm+jZYOlUeR5H33C42RkOZwEfX9Q8ewYb8wv8XERiJLH14brbP2cK
         D3eQ==
X-Gm-Message-State: AOUpUlGb5HfRF+N9n+GXliOpQUhmNMnP4tWzOZ+Rj8wfQtpCm1Z2z6nI
        1gCJsJZMUHxOmYgj/4JsWBTSXI1ovwvOvSBLqn5Hx+5s
X-Google-Smtp-Source: AA+uWPwJn1IEbsWbDdvbJjlfAZUxnA2KyyPik3t+fHeL3MuPapyifnVT3lhwLdIL5MwKNK66wXnPl/VwmE/4iP4CWdU=
X-Received: by 2002:a24:1c0a:: with SMTP id c10-v6mr10230704itc.101.1534136327042;
 Sun, 12 Aug 2018 21:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180812145207.11395-1-kristian.evensen@gmail.com>
 <871sb3zc3v.fsf@kamboji.qca.qualcomm.com> <5B708025.4090906@broadcom.com>
In-Reply-To: <5B708025.4090906@broadcom.com>
From:   Kristian Evensen <kristian.evensen@gmail.com>
Date:   Mon, 13 Aug 2018 06:58:35 +0200
Message-ID: <CAKfDRXg=u_mZ_ZZsA2_A=+E5cPDXsWYB2RVXBJpXHp62zvDoHQ@mail.gmail.com>
Subject: Re: [PATCH] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
To:     arend.vanspriel@broadcom.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle & Arnd,
On Sun, Aug 12, 2018 at 8:44 PM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> > So have you tested this and with what devices? For example, does it work
> > with recently added USB devices?
>
> I was looking into this as it looks suspicious to me. From reading the
> description of this ext_feature flag it seems this is an extention of CQM:

Thank you very much for your feedback. My commit message should have
been more detailed, sorry about that. I have checked that the flag
works as intended with mt7602-, mt7603- and mt7612-based wifi cards. I
have not had the opportunity to test with any of the recently added
USB devices, as I don't have access to any of those.

In order to test the flag, I wrote a small program which subscribes to
the CQM-multicast group, passes an RSSI threshold-list to the kernel
and logs the received CQM-events. I then disconnected and connected
the wifi-antennas of the different cards. My threshold list was {-70,
-60, -50, -40} and while unscrewing the antenna I received multiple
below-events. When I attached the antenna again, I received multiple
above-events. As an example, here is the log when I tested with mt7612
(singal level when starting was ~-48 dBm):

Requested nl80211 generic netlink id
nl80211 has generic netlink id: 23
mlme ID is 5
Added socket to mlme group
Sent NL80211_CMD_SET_CQM
No error
Wifi (idx 18) went below threshold. RSSI -52
Wifi (idx 18) went above threshold. RSSI -49
Wifi (idx 18) went below threshold. RSSI -52
Wifi (idx 18) went below threshold. RSSI -62
Wifi (idx 18) went above threshold. RSSI -59
Wifi (idx 18) went above threshold. RSSI -49

Based on how I interpret the output and my understanding of how CQM +
RSSI_LIST works, this output shows that mt76 works fine with
NL80211_EXT_FEATURE_CQM_RSSI_LIST (at least for my cards). The list
was interpreted and handled correctly, as I received events when the
RSSI passed different thresholds in my list (-50, -60).

BR,
Kristian
