Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B3AC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8023E20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8023E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeJ2Fsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:48:45 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54159 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeJ2Fsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:48:45 -0400
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MDyc8-1gOXhW1t5Q-00A2Do; Sun, 28
 Oct 2018 22:02:34 +0100
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MDyc8-1gOXhW1t5Q-00A2Do; Sun, 28
 Oct 2018 22:02:34 +0100
Date:   Sun, 28 Oct 2018 22:02:32 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        eric@anholt.net, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
Message-ID: <437901663.4228.1540760552985@email.ionos.de>
In-Reply-To: <20181026134813.7775-17-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-17-nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 16/18] staging: vchiq_arm: rework probe and init
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:eEKKRKXLuY1pOUZ/1ZoLZpavHl0hHK6yAC0FS9gHnVswAGS1qw8
 3OVTesRVnOkcx1dV6TbJU1Espi7Zh4VmsiUDmfhmO/zn3migtDBA+6LR4TuLlaQ/+OIGC9R
 mns2sqwNhL9NJmy9M67FElNwZAaWfgQhksYHuEXCPLduhvpAgZ15VthEg7rXQVLXKkFFhl6
 xcm5lc1AqQ7zYxj+tT4nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nyDqYVtyGSI=:aCKZwPEE/U814vVKOXricD
 w62wZv+OGF/M90MeOZWCEmXf1vMGjrZR/Ga7gPjOSK9Yaqjj7QHmIahJPhpO4XEcjskIFnRZM
 ydRlB73ykMXPlJ4VR3pMpdQ5E0fjz4Oh8NCrrEVbtV7KNriNaaa+bjXHsdq+cdtgL2LadDAoC
 gxSxQjkEBkcePqfaPluVf+yYiLid4WfUtgM6DK3IZCBVSxwiKOFtXEMcYGH9NnyOTkIGQ93YC
 aUxvSS29MTT/cBpLUAYL9WZz7+8s33ghFsHp7V6OSNN5SVTeCc1yde4qvWTG6+3XEpKXftAah
 DGi6oqcT+w6rYvum5TxONFEEC3QkN6X/ICEYx5nIggkXZNy6MeDtqjkcr7shvXv1jBGscu+KH
 gTg5KNKTZlnpUp4Za5QAbjcLEPmsyWI3OJC3+nrhUiqiO+NjK0VeUvhhQReJjiVTTMdeyjEaL
 sHxbEufVwhABISoZ/JP4YyONaqkS5rcJsFhvPouyry2KKI/Q0bxOFNJ7J1XeJBDiaPSGIjGpa
 zaUF8Yppwccf5xcgZevWdXx2qz4QFKir0n9i4tCeY1I5bG8oiy/nLypIazMdSEhHEz8subaQg
 2yiqwCSu1YdMkFcnY9Kk2kyY3F3FVo80Py5uvWvypnnhorFtAfUAZY601aaGQgMXawPqD+ULr
 hSCMBpLczFFt9avmzqM8fG60ngVx3PuSdDDHsFmOVUbL5Teu1KlW924oZup80Oqj5E1HuWIK0
 Gh0oaHdWDCBngI7i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> Some operations performed in the probe function should have been
> implemented in the init function. Namely class and dev region creations.
> 

Please explain the why in the commit log
