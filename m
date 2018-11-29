Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB75120834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGqMJ7b7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB75120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeK2XmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:42:16 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33620 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeK2XmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:42:16 -0500
Received: by mail-yw1-f67.google.com with SMTP id q11so693717ywa.0;
        Thu, 29 Nov 2018 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iJmgqZXY3y0vQ6KmC4LzDLC5SxPfoFeVnpf2BgwLRE=;
        b=HGqMJ7b7LBvwv8gJm3jAwIXTaiHgKwWAsCQsJIFCobDBiaoY+AFkOqwBsZKM2LkBec
         M18dw1ITtU83IdkJgG5kCQ7WNtrRWCCtC+U7OpLUX3olB88y5T3tNv/BLzzMlJbp814s
         eMv220ZqFFv3iSJtEJVR7+oIHM36Tluq2CliaE1l2ba+ucXLoryJLD1EvjohlEzArPZY
         CdTRnxlwA4sWqwn/72WiXTlltnAsFFc9x61+mLRf3v1uoMjDVWhFbfJo1tiHaZUcLN9A
         A2G43QJN4bL7A6tWxIKAGad/iwmg9iIA7k3aIP7d03WYZ041Fz7cVRuepRGoiL7yOhBO
         Li8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iJmgqZXY3y0vQ6KmC4LzDLC5SxPfoFeVnpf2BgwLRE=;
        b=ol9uzTY/K/wKHecPFpWV4uWJ2OE4CLUWlr64n0dCkJymVQS7uV3kXkA/xZgg9h2cLB
         HrrRiWhMjF5azdTRWEhDuncqoblMPw3isFmjtM732rfk3yBYewhLOoG5L68/gjVhBibz
         SYrfsmOlchvBcSMQi/2hvlvRJXzNaom7PXyYdcnUT8rmFU+gVwsdgCY3drcIFBsuz2zS
         MgDaFe7a0VOoik93sqkux/ojFX8ad4/OYVCqKaZQXGkUdKXHk6Bw5e3iYU3FFY9xP7IX
         9EuBk0MfeWb2HtSFCPspbL0O6OR6EAC9XToeVFuk7uHrnWx8QWPEqJ3rz6BmXYQuHzTc
         M1FQ==
X-Gm-Message-State: AA+aEWbxexpB/BXm55QmpygxZam25X2ZrP7UTFXTuvk8Okb3HkW1vXzu
        qMOCKOIw0NtgrEZC1whMkj3fmyYj1jC3+PqFZ6Y=
X-Google-Smtp-Source: AFSGD/Wot62agS8mjLskm8nqz3QemsXREKx+fyAaV1PgYY/HEVpa/ooDHurCQNkzpN5AMJhi3Do0ZB353iESVJy/C2o=
X-Received: by 2002:a81:ad1b:: with SMTP id l27mr1111482ywh.404.1543495021941;
 Thu, 29 Nov 2018 04:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20181129055559.159228-1-sashal@kernel.org> <20181129055559.159228-52-sashal@kernel.org>
 <20181129121922.GL19305@dastard>
In-Reply-To: <20181129121922.GL19305@dastard>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Nov 2018 14:36:50 +0200
Message-ID: <CAOQ4uxha4-DhcHQwvWbWuh5QXcDKYJ_b7HVGtT23D_gtkqkQ0A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 52/68] iomap: sub-block dio needs to zeroout
 beyond EOF
To:     Dave Chinner <david@fromorbit.com>
Cc:     sashal@kernel.org, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Luis R. Chamberlain" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Same again - what's the test plan for these cherry-picked data
> corruption fixes?
>

Dave,

Just to check if we are on the same page, if this was the test plan:
https://www.spinics.net/lists/linux-xfs/msg20639.html

Would "no regressions from baseline" have been sufficient to validate
those specific patches are solid for stable?

Thanks,
Amir.
