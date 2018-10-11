Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5A7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3DB20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3DB20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeJKVfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:35:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeJKVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:35:15 -0400
Received: from [192.168.178.69] ([109.104.47.253]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoNu2-1fM9iO3H2G-00ons1; Thu, 11 Oct 2018 16:07:24 +0200
Received: from [192.168.178.69] ([109.104.47.253]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoNu2-1fM9iO3H2G-00ons1; Thu, 11 Oct 2018 16:07:24 +0200
Subject: Re: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
 [Resend in plain text...]
To:     Mike Brady <mikebrady@eircom.net>, Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.org>
References: <20180904155858.8001-1-tiwai@suse.de>
 <20180904155858.8001-18-tiwai@suse.de>
 <4c5f9aed-8fbe-fe22-0c8d-097d8915805c@i2se.com>
 <s5h4lelu84e.wl-tiwai@suse.de>
 <8866e22a-6cd7-d32d-92e5-9a4e60206d2f@i2se.com>
 <s5hworhs559.wl-tiwai@suse.de>
 <828AF61F-4F6F-44C3-B463-7FE4EB8974F1@eircom.net>
 <s5hy3b7z138.wl-tiwai@suse.de>
 <425F6E5F-782E-4288-ABF0-180504FD7B01@eircom.net>
 <F63F1767-B8DA-42EE-9E74-A9A3D28C7D1F@eircom.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <2a6270e3-fe1b-e22e-20d3-3a09abe11d4e@i2se.com>
Date:   Thu, 11 Oct 2018 16:07:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <F63F1767-B8DA-42EE-9E74-A9A3D28C7D1F@eircom.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
X-Provags-ID: V03:K1:CtmzfJ9cA3NIhk7mhfni1qQsTb7SAwKUNaxaVZYGaX4n6z9B+SX
 +ihzhC4WczlnfUeftBtCkVQh5osBRYDT4FOoViC2LDpFHezugLh4DmI83d3lcKdNqTyrRrr
 g12P+tq1z3Durgj8v9BTiztav1MYRoj7XpreGw6T/YypsHzeAjrFYvUmn7yF7BvC4FQLwrD
 9ynf3RyjLgmisFI8Ei/5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZkNQ7/A62bk=:i/tdW3Od55tO+QiGTDOu4d
 CeqfZs0huVla4djYrbLY8ihxLxY5pBbrKDoQucy585JrdO/+G2a2dwbmS/k1pR7oRmBYlg4MN
 P79KR85CAaVEDHWfK207mOG6bs7TogoSkXFg7XZA6+LiQGoVWKnHDJEzqXb+mCH1HzZHydG/n
 pQhUDCXosWQUPTe1ANVH2cvtCJhCFE4sNpEzPMsFl6/bYJFMnzxU9uVd3dbi3KxQKREpo96m2
 dZnwKXCaz7VEz/2jpLa/FLyBzb+SIZEOLHBkoCSe0nsX8Dk7N62SOMNorzVlwYxcFDwk9eQAX
 wGt/nrPGpG8dhcmaiqU/Ajsoh//HFpQswKfEPar9mqrUM8s6I3q5KneeM+QDzro5LEDGSoWVc
 FJLhjS+eE2isrLAkF8qO6yox3sf/Wfhmm8I2HE9mRjGjz+m7EibfyLcXMIZokc99x6OO1IFbo
 9+xd/BQ36i5Ad0r7JjQX4jLoXZrNyksH2N4zVEhHpJNeLfLsU36Tosx8Kt52p4rhq78upe27v
 MJcee23dY3EFWWLf1A/MhXdi+W7daTG5N+ZC0/EKi4xHxf8IOVPNOhTCEm3w3aNTJMmoUPisk
 Dvc8qe8KzaIW+IEqs7F0miMPu0RynAoRXv9uWtnMEri3VAOoYCnsNbcgjxVRxOAKfzvl1SDR4
 VbGLpEvr0oEV/6rEK1zgyWG4Dup9oM3AUL9Koa+CkcIywsI2DHgydPJRnLGtsHpcmjQbfyVC7
 2m73tVhcvcrEamrb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Am 11.10.2018 um 14:53 schrieb Mike Brady:
> Hi Takashi. Just testing out the updated bcm2835 audio driver — it seems that it will underflow at somewhere above about 4410 and below 5120 frames, whereas the present driver is happy down to at least 2000 frames — I haven’t tried lower than about 1700.

in order to avoid confusion please describe a behavior relative to
commit hashes and trees.

Are you able to bisect to a specific commit?

> Is this change meant to happen?

Takashi's series has been applied to next since a month.

Thanks
Stefan

>
> Regards
> Mike
>
>
