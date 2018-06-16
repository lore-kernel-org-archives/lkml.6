Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22731C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8492088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 19:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8492088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932998AbeFPTZb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 15:25:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932542AbeFPTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 15:25:29 -0400
Received: from null ([172.19.249.154]) by mrelayeu.kundenserver.de (mreue001
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MJJta-1fX1yt3KJu-002psa; Sat, 16
 Jun 2018 21:25:21 +0200
Date:   Sat, 16 Jun 2018 21:25:21 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2103480434.399682.1529177121085@email.1und1.de>
In-Reply-To: <CAOMZO5D7FAiE8dXKmLHCmOdHek4w_LuYjz8uP9jdD7U6Z-7f5Q@mail.gmail.com>
References: <1529063093-19582-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5D7FAiE8dXKmLHCmOdHek4w_LuYjz8uP9jdD7U6Z-7f5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] regulator: pfuze100: add pfuze3001 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:CenHevTDGC+XeFyq7FcO4KbZ21T03Gt5KLzlggnqXZ17VqS/uv8
 x8y2hB8SEZrz0Mapp7QK3v+GG3Q1AynJGk2m3B/XN2vJBvFefIZr+XRDSlY7S0dKtQaC5ri
 jc1BFyM2WAdEiytq1m0IWj+Dv9YIM91UTkXhnzG9kCASaZPqg0nBgPVJ5ZD3OtY+wMvfK2C
 MGDrFo8/yccN4lqS7bBJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4WXUD7v8u9g=:8mW8Qdd0JVrkOWFA49FL4W
 r10RnsGFvsnDj3XYv1bklye0z57r+LYeqSueFCTgnK0h0Bkr/YKAXOYWSIOLspkYcGuD031Ta
 H/WUR2SAgQOzh/xItbkD4a/NG3V2L0ev2Y8r2g/W0zmNPzfJMNKhnZPYW6QMAQp1zbkBg82wg
 ZaJB7bfatbFLQWgZPBPNV23+geXfCcdMUnACeUfsrolYMNzAc4qnvMmHj5M6TX60EsgzZGXEC
 abQmw8eLCc5AwXa20OVdKAqe1P9fLx0vo60hpoq5pY6SVYVo0wfgKHzSPHNiXbMtAgtyBr4oI
 MH0gloXnn5HBTHfRUtMyc7nP4z5xyr9taZCAkcO9ZTasvJqo2uHd+aHEtEkRbToPg8mUPVXEL
 hDzGzeONmkW2UqETxnN5t5H/XauWBENsErOJ4supTCM8P8fQO4rrxJhs6EuuEfoicsb/Uh4cc
 pqvVITguNRAt6wluCYYMZi76fTs9W+kXI4W/AWttiEw7uYGL8webjWstFlNq0dlyeBje75deZ
 2dihUFpn3BTttOmBY9rAgv3n/zBgbDeJr+s+/jNVHMxmwteGpAFs7sPCPwNHvEao8CqlcOW4R
 ivpGdTgkg6i+lcaNc/rPYsZIIk8XsyLgziC0ePcQfkWpl/gZln24g+YfrQuA9MYs5MI/4ExRY
 Ey8X8ebxAvfvrnALXYRa6p/MkkfaHRmc9oEmgHT6/IOKh49Qx2i8XmnEMSvVuL8se2fcK4wzn
 E2LGAMAZ5OXrzeKS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 16. Juni 2018 um 20:40 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Fri, Jun 15, 2018 at 8:44 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch series adds support for the NXP PMIC PF3001. This
> > based mostly on the patches by Robin Gong and Mauro Salvini from
> > here [1].
> >
> > [1] - https://community.nxp.com/docs/DOC-331899
> >
> > Stefan Wahren (2):
> >   dt-bindings: pfuze100: add pfuze3001 support
> >   regulator: pfuze100: add pfuze3001 support
> 
> This series looks good.
> 
> Any particular reason for marking it as RFC?

since most of the changes based on Robin's and Mauro's work. 

> 
> Thanks
