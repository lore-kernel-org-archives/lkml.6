Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2098C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71762073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 00:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FABZeA08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71762073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeI2Gpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 02:45:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44557 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeI2Gpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 02:45:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id b19-v6so1728169lfa.11;
        Fri, 28 Sep 2018 17:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wva+ImSP3ywkbSui0dViTSdDClJwuf9DWgEyGO258M=;
        b=FABZeA08eC8OFgSHK+jjamKjnFHZSKohBiQZTNePROseELrgHAroGypc7g5aCnJ1YI
         lQf3GDmN8oLbFD7e951o7stsPfJfGJ2/8/jPSsqMamQnHO16HbbZGUT7fIxQ5JlDCmGG
         h4Kd6vr/h+0owLkR08nlwEBXHpC5KEc2U8NkqMR6qaa4i4GHl5kBa2Xk80DZKOmWUbw3
         y8s+5srbojnZbwswZGmRDERW1nf/y0NfYzhikn31/mnhGER/FS3GdmgFBh0V6y6bveay
         2uFRKZHzuU4zoHFCPbwgnd0+ji3ixeHLYxplkpTYYsn7xJDv06BL0xJPezS1p2i10JJ+
         y6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wva+ImSP3ywkbSui0dViTSdDClJwuf9DWgEyGO258M=;
        b=g7gqzba5CE5AHaVM2zsJI+vSnDePZWcYTFjbjKioeVNLXyeq4Cq2a9hsgCo9nbH0j2
         3qofSF2MCV7RyJab+SzFIMyiFbu8SkrDx06e4xcKM6Hq0BKKKQS+dPVK15CddzfV7Etm
         y8iqoakxv1b/lpXJF2t6XxlS+fr5XsPaxkV0yEuBqraSewtHV50I1K0ApAMeonIbYyVV
         p5KLDk9ERS649tHLCTkQbhzVOSN+VrakckC7IaUPuIHwc6KfbBch+07cUxtq+OUEAQen
         6FUjT2lsPYz0qK0goSECGIZ4+S60LO2evZMe0yNK5GG62w1ZqphGlUTgtMYc/rD7OtcW
         qEhQ==
X-Gm-Message-State: ABuFfojenMPzpxGgmKqaE8rSniBETNX+5H3YWt3LVpVrudegcdRHBsIQ
        JOoKg+qrM2YNHTBn8zDXVgjs98yjXbcWjBTERg4=
X-Google-Smtp-Source: ACcGV62/VfUjIG2IsNM+ouNWqsH9Ixx13GEm5pDP/sWSjpvkadsMRivW9kr9AHUoDVR2O2MfDL63McfdxsiK6OqwgmI=
X-Received: by 2002:a19:5710:: with SMTP id l16-v6mr432825lfb.71.1538180370067;
 Fri, 28 Sep 2018 17:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
 <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com> <20180925152022.GB27695@ulmo>
In-Reply-To: <20180925152022.GB27695@ulmo>
From:   Gottfried Haider <gottfried.haider@gmail.com>
Date:   Fri, 28 Sep 2018 17:19:18 -0700
Message-ID: <CAPoCmY+mNYSV8gq7VCcSJHDpmoq-i7SDJ6uQ5VbLpMZB=b0waQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in sysfs"
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     fabrice.gasnier@st.com, stefan.wahren@i2se.com,
        gohai@sukzessiv.net,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        loic.pallardy@st.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, michal.vokac@ysoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thierry & Fabrice,

>> Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
>> to notify of a change, e.g. pwmX channel being exported/unexported.

I tested this patch, and I am happy to report that it works with the
udev rule that Raspbian (Raspberry Pi's Debian derivative) has in
place:

SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
        chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
        chown -R root:gpio
/sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
/sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
'"


So while I can't comment on the uevent semantics, it would solve what
the original patch attempted to enable (non-root use of pwm).

Tested-by: Gottfried Haider <gottfried.haider@gmail.com>

Best,
Gottfried
