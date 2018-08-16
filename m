Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0107720B80
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 21:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZdwxr7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0107720B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeHQAaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 20:30:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52785 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeHQAaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 20:30:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so5700101wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zw15N9x0fcyeML2V2m9ymLg8ERYkLSOK+qasLRsdLL0=;
        b=OZdwxr7wBYa+rnioVowJO9zjbEO3VCRkEiNcFVFeTZwhD9mZF4tbWpUvRYwk+a9lPY
         YZHP9Ne9yzwFlpSiLG1DslRr85oMr1eR7l+P5RP+K6hZyExwPMprhpysZq0j7JuZguIM
         MZDwEeujbTx3PWiIiWuvtZ4/ypuHndtY5UVbxYxreoFO1S8lkes5D0XzcT8SqwgZRFYx
         c/T1cmAxVbFRocCUUO/yCI8h1G/BPiju5BlotcK0xKcJbRHbzPxAB7j6jGV7h9HHjghB
         8RC8cfN/lS35wa7ns+Ex3DaVivQy0haqhW0+JqXe8JtrZJnqreLVbEjWbQMggAimDp/D
         sgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zw15N9x0fcyeML2V2m9ymLg8ERYkLSOK+qasLRsdLL0=;
        b=hWxF7oaI0b8mAXgB0qNlOiKQ8cnYxP11gDGVtJCkapadoXeI7kDJx1PtTgjyKzQRm7
         RVZ3Pzch7AA9LpadVYK9IZ7uNa08b7ymlI7xJcstXO2pjxxr4JI0O50u+mrg2/FOhpKn
         4VGoLZvRsTZZfmJdPzpucsjNwwdrQMR5/MhAElR8ggW8ctwXzGBnmANs0slUCz4bjWdW
         NibYxranWkvlTSsLckKns4BluDbau1mAgatXF8uDWUnI+G+o6At60rBRQYkuYB1T6iWa
         zVEN435as++T4KMPBQhWqebACD4MYRreitoJtmeBNzN2x5AWLVzQXsU4HscOeIecXQPd
         gDXg==
X-Gm-Message-State: AOUpUlHs5JbvNBiu/H1Dk1L8E1gW9T44/D/xHzaK7eqjy4/cFCQy+Ew0
        zuAMST0KiKRZU/zMjmEf9TKG7OxJNI002gTVBRw=
X-Google-Smtp-Source: AA+uWPwhyhLJNQk2tvZjPIdxUZBWv6h+7pGyarx7fokKNhqy6DoZVzMFlQa3WyySqKZ24ZfsmdCBwfV7nnFzRko3UhQ=
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr16629374wmi.16.1534454955453;
 Thu, 16 Aug 2018 14:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
In-Reply-To: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 16 Aug 2018 17:29:01 -0400
Message-ID: <CADnq5_P1RkU+-soWsCB1NE=15TZn4pLZTLpjdWeu16ZVjF9wxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu/display: Replace
 CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
To:     "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Daenzer, Michel" <michel.daenzer@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Wentland, Harry" <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 3:45 PM <sunpeng.li@amd.com> wrote:
>
> From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
>
> This reverts commit 8624c3c4dbfe24fc6740687236a2e196f5f4bfb0.
>
> We need CONFIG_DRM_AMD_DC_DCN1_0 to guard code that is using fp math.

MIssing your SOB.  WIth that fixed, series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
