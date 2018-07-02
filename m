Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE076C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90897250E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90897250E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeGBOR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:17:28 -0400
Received: from jusst.de ([188.40.114.84]:58054 "EHLO web01.jusst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeGBORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:17:23 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 10:17:22 EDT
Received: from [192.168.42.5] (i59F77CE6.versanet.de [89.247.124.230])
        (Authenticated sender: julian@jusst.de)
        by web01.jusst.de (Postfix) with ESMTPSA id 9049A1B02F74;
        Mon,  2 Jul 2018 16:07:19 +0200 (CEST)
Subject: Re: [PATCHv2 3/3] usb: gadget: f_uac*: Support multiple sampling
 rates
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <erosca@de.adit-jv.com>
References: <20180630181638.GA8807@x230>
From:   Julian Scheel <julian@jusst.de>
Openpgp: preference=signencrypt
Autocrypt: addr=julian@jusst.de; prefer-encrypt=mutual; keydata=
 xsBNBFhOYt0BCAC5ZRlr+b9nOaePfv6jWpuUtglGwyjnkSwPMh5X63W6gwCG4INaC26rV48k
 EABB6/BIGP4AL2rT/tfyZJpiQFc/0rdxvxWqe7i6CJTX/CpGGMoa6ks2QRJEQh5jskt+Sfzv
 oSvPRQK8qENKMR4htiBT/Q/yeDZWE/tg3Jou9r7FZ01nrtvEAYCp/us5zKNI0DT5IpGZvXbJ
 ZHr/F8LXqgLr+IZgy4mi0tQlCxq7Z4J0cbCHzUDq11BeJgSIN8ZhX6lNmp2K6TTloZwnIQoJ
 5xMcG1HueJEBecinAYZbs1ttNpMAHRlnPAVowy4IvMWi7fpwlsrtWyE8I5rykY8+908XABEB
 AAHNH0p1bGlhbiBTY2hlZWwgPGp1bGlhbkBqdXNzdC5kZT7CwJEEEwEIADsCGwMFCwkIBwIG
 FQgJCgsCBBYCAwECHgECF4AWIQT+8GIUJBFSo03kB031IojQo4u6HgUCWcpjDQIZAQAKCRD1
 IojQo4u6Hl5LCACzqegaJi1fBWN6/+wLjMMkxR5Xu0gsw8Ukpa3/sF5NfSW2aM941pmEJ1MU
 ryn1CMSWanVouRGfJzeonndL2ZITxc4j8eR9FbpnwE8Y5dxzcdBRxT3sif+j7hhyrznxfMQQ
 I3j4SxYzWLq9CUfY+LuHS3YQqA0wQaji4D/VDQX7lOGzbb7foMTOzJEgS3EMaq7AgbALB4U3
 gNAxURlMne9e0uwpHCcQXelj/k1vb8etrveVWpuFE8IPMRrMSNtUBt33Q0tqloDQ0N75cXy2
 V0rt3vGZFl9Kmpb6JFrVKG8nicldCzOp3VfRIVGHBfEkzEUk/wciPetAD42BVTEB3BrazsBN
 BFhOtp4BCADSMOinOERO0Br9IGzEDrCXTVQkiFxJTgkn6s7FwLRr4IX0YNVp/7Yn1tSHHnyU
 TusYBgRkfHJEwE2X7wwyoU8bo81Egt4KpFdsJukYNtPmqncB76zrU9MKDWTIADTJINCPCl5L
 sGWLDG1iKFL6hL5dF7KOzb3GYl0sfOQWVSUT/jmSXeOmSp6hlw9wdoEUHh5JF7ubonca8qg2
 FZzqocVFuH816ws2S28uUq4frUF/D7TVKrA60+97TaO3A/jbU6pjtul2yoqdVUT0lfAe5NNl
 Yy61XVamHY6UyCm+VOTAGNadMUFUrIT0nNJ1OXJ9WiQnPiznjljdm8XmggK9SSHtABEBAAHC
 wGUEGAEIAA8FAlhOtp4CGwwFCQPCZwAACgkQ9SKI0KOLuh59vgf+O+uIKq35+8Lkjk39MGIR
 UqgBPic7CiUR+2mn69UTvhLy8nSmrdf0r57bBXGdHzpPRnOXTUMvuClvRr58CAn9304VsVb+
 ZgEENpxqBJLUCshcrPgKeHZ1zJdTpbIDvFk2cOwOZk3SXs8FRtQtg1LPKQQCCPO+iKOwbFt7
 0r/9O8/NgmGXGuIymzikfzg1bG1ZZDYP6BevRBDZ3k0Ylv6Z9FRfeuY9c/n9mUP0Cpa8aecE
 /ixpeEKZ+1nQh8sSAffF2Kgg6bMir666yiQmiHMYcZni7l8Czz7Abb+rvz+b2thjPZACvA9s
 lnIwAUt6vTm2+JTSGUYSWEmwAce+OPwyDQ==
Message-ID: <2333fe05-da2e-e6f6-931a-16fce2980f17@jusst.de>
Date:   Mon, 2 Jul 2018 16:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630181638.GA8807@x230>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: web01.jusst.de;
        auth=pass smtp.auth=julian@jusst.de smtp.mailfrom=julian@jusst.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu,

On 30.06.2018 20:16, Eugeniu Rosca wrote:
> Would it be possible to revive the uac2 multiple sampling rate
> patch-set [1] by rebasing it onto the most recent kernel? If you
> don't have time for this, I could help you.

I have this on my todo-list for a while now... In fact I fixed the build
errors reported by the robot last year, but didn't had the time to
verify all of it and push again.
Still, I'd be happy to get this merged, so I'll try to check the state
of this within the next days and either post to the list or get back to
you if more work needs to be done.

Best,
Julian
