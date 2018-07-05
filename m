Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77809C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D483223D3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="rWRnk5MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D483223D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeGEH6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 03:58:39 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:35443 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753041AbeGEH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 03:58:38 -0400
Received: by mail-ed1-f49.google.com with SMTP id b10-v6so5665116edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 00:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9XreV3dc2nhJB6iEAJDwsirriJr7cXXAaG1F7/nERAI=;
        b=rWRnk5MCNLv9QU6aNjIosThArsnGO6TtRbHRqFsUN2LCWo3HOVyKp9WUlCahk2nnLX
         n4I3/lpSMMpWUv6bi58k1mQ7jTHdink7dLhZHWDOjQWYhi3fvD6VvDmWVWneH8k45nyZ
         OVBOQ+q1GlXLA0JdlG9iUvNJunrcm1JWqSw5ElglHe54Zab6WmN7ooxB2aBf+6SVLBvZ
         N6O3VhNtb99NJ7XwTzNmmITYrYiFmT9ZlygKfCGUzHKkF1F1576/4bl4AQtdM5cJwGM9
         OoXHO/6q4gBsbpOt1QIRKHeuwOzda3Yy8tYIjZq6uPN2X1qLocSTxrbIQwUskzgsme0q
         Bq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9XreV3dc2nhJB6iEAJDwsirriJr7cXXAaG1F7/nERAI=;
        b=rKqOIpwhhaZr+yQBpcUjSEqqZDHt8e2SyItTZPaxy0aX6HgwFeosJckKIhXzgMKXrH
         KBuyUXgl3HGj0UE7xQOfnBbJpSK8nXL4TkxRAcK18V7NBuJTx/EnGl8cR3iP6uQSqTtO
         M7uCK78duRUKzTls0Q+3je4e0mI65mEpjpxtUIVomwQNDjrTOZCDGWKqfodBmcE2iL4t
         9dsRcqXKCrMJSVYDGYm44AjlHlhSlsWJ9i9fjRB6A9AizN2nbYAiPQbk2SRkQXaS6FnK
         /oOgB66hFJFRlZxLDXBKSUvImdK37Q3sOGUVuKaHmSLpfmzrXnNIgwd6mtqfFsOOjZbZ
         XQiw==
X-Gm-Message-State: APt69E2fnbTAhNARfxoixJdM3Zzn94mkluUaE54d7aGVRWJEV9ei6Dm9
        32oEPGN9wTgHEz2aA4bqb0PZO+meyiwcp6hxAtUWHQ==
X-Google-Smtp-Source: AAOMgpe/bhWMjVzcmgF8YHvgDrlOcr2eLV1Mgf6FUuOf1M2kz2gTfduzTok9lr/H90Mp8wQUPqqbhO6uMNDpJtneC4Q=
X-Received: by 2002:a50:a0c5:: with SMTP id 63-v6mr5585151edo.47.1530777516880;
 Thu, 05 Jul 2018 00:58:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:90f9:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 00:58:36 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 5 Jul 2018 15:58:36 +0800
Message-ID: <CAB4CAwcfj32FovZwpTbekvHpoc3gG0sVbNtW8jeXRcp5qwEsmw@mail.gmail.com>
Subject: [BUG] i915 HDMI connector status is connected after disconnection
To:     Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    We have few ASUS laptops X705FD (The new WiskyLake), X560UD (intel
i5-8250U), X530UN (intel i7-8550U) share the same problem, which is
the HDMI connector status stays connected even the HDMI cable has been
unplugged. Look into the "/sys/class/drm/card0-HDMI-A-1/status" for
checking the status while plug/unplug the HDMI, it shows
"disconnected" before plug in HDMI cable, then switch to "connected"
after plugin, and still stay "connected" after unplug. This would
cause the audio output path cannot correctly switch from HDMI to
internal speaker after unplugging the HDMI.

I then try to verify with the latest kernel 4.18.0-rc3+, the bug still
present. The full "dmesg" log is here.
https://gist.github.com/mschiu77/d761d7c5cf191b7868d4d7788ae087f1

The HDMI cable is plugged in at ~26th second.
"[ 26.214371] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
audio support"
then unplug the HDMI at ~73th second.
"[ 73.328361] [drm:drm_detect_monitor_audio [drm]] Monitor has basic
audio support"

Please advise what I can do to fix this. Thanks

Chris
