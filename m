Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7622DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B1820834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcuIxjvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B1820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLCLnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:43:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46537 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeLCLnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:43:06 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so11219052otm.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WtzCc7AgTuIPm8d6x2VuZKjqnIwdGuXPFknWJoEers=;
        b=LcuIxjvRUiqwQejzTumi5yXTkKjn+SksN8B4AgCCeBMiUOc+U19co/6Ay0Hfvw/zt3
         EgdwtwK7YqeyV0EUsHWR8/0SBxXZ0bWwU2PdGyk363v2stDcLK9F1L9L63SsZW5bE0j/
         8ftxhHJIAfRMGD+qGDkU9rYCbZOe+rWkzB9nWoMf1RnAbztROX54i58pijc224UFCwjV
         nbj0TELbuSeer0UW7Rb23BYY0zGp0v2PT77w1G7zkK43f1PY+kpPitRRDYJQ6DJPRyFN
         8ev5sdgy0NB2XVseytyZBAytGBFL3XRc7J+3lxTDOiCvu7hX8Mxd9leEEoaArmrmHv/6
         Hzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WtzCc7AgTuIPm8d6x2VuZKjqnIwdGuXPFknWJoEers=;
        b=tChgecfmL7wOjr+FGW0mBD9x9X6QemhELnecU/SenYsJNhFIq6CxSJ5Y7HFVNoOrhS
         d6XFZhwd7zDR6oRA0mgGJDmM7QDbzMqiDPWBfHVjxRVq9E8+ygnFFXOgkTsu1Mw5LQo9
         huQTravpgkjmmoVYDjPlHU4Lb1Qdo98XEAzMkZvwNSAn16iIGg4EGu0mmEt0un56wjOg
         iQ/K2oIa3tZ04tHRkLlX8q16L42VJaJJFExW1AGqWAGAvOkwWgARk5mnSscDwD6b4p+i
         jJZqgwz4QbyTBw4JC7+ZPiEvrmeA+etMpBbBpuXUrB7U+WCQ8orzSBJEimbXHJm6yjIA
         WQVQ==
X-Gm-Message-State: AA+aEWYm52ieA6jbAcqFL1i7o84HCyfs6ksLo907R68ktMVk/M5iSgII
        V5FCSTLPX/uQUG1oK+8xnqn72T18lhvwz5L9sN4=
X-Google-Smtp-Source: AFSGD/UySL6cSKHhgQYnEHIwvmq+CKebPJXBJgM2FHMsaUvpc6PmX8oQLlm0qci7cezPGVd1EOd+3U9tqTf8gWmGKRQ=
X-Received: by 2002:a9d:7285:: with SMTP id t5mr10360972otj.228.1543837344547;
 Mon, 03 Dec 2018 03:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1543804767-17650-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 3 Dec 2018 09:42:26 -0200
Message-ID: <CAOMZO5Bc2z9mtWN5HDDbLggryEaxF6eay2Wnu8AdBSBNFZSmXw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: update the cpu power up timing setting
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:45 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> The sw2iso count should cover ARM LDO ramp-up time,
> the MAX ARM LDO ramp-up time may be up to more than
> 100us on some boards, this patch sets sw2iso to 0xf
> (~384us) which is the reset value, and it is much
> more safe to cover different boards, since we have
> observed that some customer boards failed with current
> setting of 0x2.
>
> Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
