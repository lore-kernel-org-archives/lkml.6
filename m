Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60EBC2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601A02082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601A02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJ2Fbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:31:55 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2Fby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:31:54 -0400
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue001
 [213.165.67.97]) with ESMTPSA (Nemesis) id 0Lq1ku-1fdOJp2QgC-00dmaY; Sun, 28
 Oct 2018 21:45:41 +0100
Received: from null ([212.227.220.15]) by mrelayeu.kundenserver.de (mreue001
 [213.165.67.97]) with ESMTPSA (Nemesis) id 0Lq1ku-1fdOJp2QgC-00dmaY; Sun, 28
 Oct 2018 21:45:41 +0100
Date:   Sun, 28 Oct 2018 21:45:39 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
Message-ID: <1781917429.4071.1540759539282@email.ionos.de>
In-Reply-To: <20181026134813.7775-10-nsaenzjulienne@suse.de>
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-10-nsaenzjulienne@suse.de>
Subject: Re: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:AP132CI8f7r0+10ZQlbynbHoAyjHk37j7zXWu2dYfoRr7twQrmv
 /jbP3ztBzSnK3fZoX1O2IwNgGZIWUGi5+iZI5vPA0oHhC+rcFjYlwQQkJGv8g2SySuPhWqy
 9j86KiZoYIzeWS6bVUEgR5WIXfQfiwUGCw9qXno2GjIuX9fv50ciuaCCDcIgvnRTAtW4mSd
 ozAcaztliVAokNjFBtRXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QIX2j605bA4=:rAhGAoFHoAwXxDQbeFB22z
 Fl/8l/TslZF1dA/LC9hD6eFYgL0N5Bcg+wd5YZorsm6wVDIBU38KPYrRlteN2hezUzsGn7Bwq
 BS/BaQxo3iMlciVz5By2oCu+FC59/3ZN5eTW4rOnDJSeelj91/E1eHVTLtHMNPbkReRSulZrX
 INChZSmzvQthvX4yHzNdh5oNbGam5mbZe/It9EjwfMgx6F02H8PhiY2C4EvppfmfuZ/v2oYU7
 0U0YiYuCm63qbTRTlLT+DlXNNl1Pyd5mzg/um4SmcbSjSgORkpaeVMHDsOgNo6zF4wKn/mAq/
 ZXLjFFsGl0rqWlbe3XBs+ebnj+YQGIit3Sp5yNXFYfZddVfE4giMLpZ/tE2G5qvsFPHbiPWYc
 yN+b3DwWoGJzk3L/bmdd5zHcsUN/VXck3uB0uAe7b+rPoKa3XZKq1BTzC1cdLFI8YBxcY866k
 k8OSrRcoBPnwAGndj/C73Xkpgsk61wx0u7tUu+C0Z4ZVx0XBgQu+yPf/BK+hhN9PuITVkDlqy
 JPK/iP8YG07yom3k0okQMf4jpUs90R+FFCEOzQO9BveRUNWPF2IlUibOUGt29/bJQePXCBQMW
 5lZJyAzEhxlF5d6kyRzUFRS3EwZQDjhNeflEAKXbVzJHSfgVOYr0/JNLEdo3ocEK+lS9+lzGq
 thRvXpdneF4PW79RgLiz9aN7Q8j/cK3EnTTOoh4nIUWDvbBHhVLg8bPZ/+Iuzbx2wMGq9Yy0Z
 O2KQFih27prlFGgN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober 2018 um 15:48 geschrieben:
> 
> 
> vchiq_init_state() initialises a series of semaphores to then call
> remote_event_create() on the same semaphores, which initializes them
> again.

i would prefer to have all init stuff at one place in vchiq_init_state() and drop this ugliness from remote_event_create() instead. Is this possible?
