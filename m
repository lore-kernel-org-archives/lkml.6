Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14515ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EB820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EB820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeGTK2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:28:24 -0400
Received: from mout.web.de ([212.227.17.12]:53371 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727681AbeGTK2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:28:22 -0400
Received: from [192.168.1.2] ([92.228.185.52]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgZv-1gPe1Z1d8Z-00k5b2; Fri, 20
 Jul 2018 11:40:46 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
Subject: Re: [v3] Coccinelle: suggest replacing strncpy+truncation by strscpy
To:     Dominique Martinet <asmadeus@codewreck.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <6c657df2-a524-df22-eceb-6237cb5a9faa@users.sourceforge.net>
Date:   Fri, 20 Jul 2018 11:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vMh4g6gj3CzhUB8mOzLG5j9AXJP+DoXHS2O06BxDzJ2NRmHb5CT
 nzKWgOcnaiRhIj9jTKdgPDvUGuBrdgBJRB90Ehtsa4if+dSSBBE7jKzjkSSrZhkxv613RF+
 flhQfMJNRRkOoBY7X4gVRwZs42rP90BhStiCWC05+UKZ38Nf/A1J/iSQQwfHbWge1a2IVbs
 Fq4VZWrC343uE2OOhM6WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C1kpxoVY+VM=:pZne0lGUFXuA5kAiuD8wSH
 xvRFpSDZtj7Nbn0Dv4SycO13dumd+9om13bu7VtUHcTQ8p/jx150ms1fnrLG5DeLV3PsX2r3G
 QOoMhKGxO9eoVvAT9TTh27izLsWjYkQxI6afVp3ZesolSbGISUXKMH9munXOmTNN0vNKf1GFY
 PXQXBfGSkiQNGajufPjb5An2JGBYBAZmzkw3K+FUtz0ZmweSUfwwEJKJ0hrMeME8ZjD3eo3sR
 FzupWS14Gc3nMujm1Ep/JgW/ndpTPS3bUiSPFLrLCGbFn25tn4pAAW8vbe75b69mpQPm3QUL4
 +K3bAZ/EBA6sz7kp4ktQfVIiNSF8jvv5d+02csxYCwdhATNcW30XGQhhwKyTO2VGI3DzK5nM8
 2bA094gvpki7QQWzoH1vj3FYfglPpgq7822+UwiTPjeTKl4TBXaWw8AsTXvNpme4NhbXexBSl
 mFZB/+3G+gqYbRRSDDBqwUw2L4joGrPr+lHA2NPUEaxBiho4R2f5D16h67RZpYdgk5HEwMgbN
 cVDPT2ZIyCNd2SXs7BbaFN1MHovnR4d+1/TlFkFQ5zPADaI+aQRA8zKUl1YdLE9LEqKPAemNb
 qTMS+osg2F3QX7l2svJViIi62xfGgPumkwhzljdzUcxORoWcET5xRswEHqfwIra5FioX9CO4d
 6g8BObEaWnQ86Fl53johp+FoMqjjnl7AYxl9c/i4leCT3MvR1nSTeFTSkDr0m72eg3KwPq7XW
 1sMtW4ormFDU4rJCwzbkz59eodN1f66b/6XV7ZH8kMQLEJIMws4RV4Ro8aIZjacZLd5kleFVR
 RnpiwuV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I didn't move all virtuals in a single line because none of the other
> kernel patch do it,

It can be occasionally useful to preserve another bit of coding tradition.
I dared to propose the reconsideration of such an implementation detail.


> and still do not see any advantage of moving the string to not use a variable
> so kept that as well.

I am curious if other software developers (besides me) would like to achieve
more source code reduction according to the principle “Don't repeat yourself”.


> This should hopefully be the last version :)

* Do any related development concerns need further safety checks for this
  evolving source code transformation pattern?

* Julia Lawall has presented additional development ideas today.
  https://lore.kernel.org/lkml/alpine.DEB.2.20.1807200759230.2349@hadrien/
  https://lkml.org/lkml/2018/7/20/71


Regards,
Markus
