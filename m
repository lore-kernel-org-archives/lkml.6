Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B97020830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B97020830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbeKGDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:40:04 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbeKGDkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:40:03 -0500
Received: from null ([172.19.246.7]) by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N4eOd-1fLhn61sTH-011gGX; Tue, 06
 Nov 2018 19:13:19 +0100
Received: from null ([172.19.246.7]) by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1N4eOd-1fLhn61sTH-011gGX; Tue, 06
 Nov 2018 19:13:19 +0100
Date:   Tue, 6 Nov 2018 19:13:18 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Message-ID: <619586887.222691.1541527998449@email.ionos.de>
In-Reply-To: <87k1lyghp7.fsf@anholt.net>
References: <1540922921-3653-1-git-send-email-stefan.wahren@i2se.com>
 <87k1lyghp7.fsf@anholt.net>
Subject: Re: [PATCH] firmware: raspberrypi: Define timeout for transactions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:f94RfDlIddf8EgbuR0JPFJ4Rd34+GnQU79b80tYLoHqT2zi5mnp
 8uqb68jVqH7elAwDfVQLRAl4IUWP/y95gK9NWtK9YaCgfTpLOc7hiX/eRk9VJgNNSTeL68x
 1+6e7GtkRfQ/uQ2R0duXts9wHEO3fzqb9fcvLUQ6pHmqJH0OZEpo5TWIL1kwSTZmwr7VGef
 b87VL786EmuA48/D0g11Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GxEuiASqIs4=:qZEa3RgJmKIMd+wM/+gGiX
 8rnD1Z3h02kGBS1t7/716z1rMWYt7wyGUhB9dRceeLii5gqVbAvsz/Q+9H05md7Mm4eYX0X1q
 5kUfhu3/0OPXvVttvl9wrXarAX7hKMufILAw5kJrySvqlVGI94BriCU1/DWvlSl889ju+C/6y
 JqSVJsvHPgkA593ymPaJ9i8ZlOGryNHtUSeBnwgL8tjMY9YmkrBnmXpT4N0HcqaTKaSDPMSaL
 oEiM6CdoRQWo2cjwsCMtuMvLJa3vpYI6WjSwl6Nx9cSmb6ysf01LGL58K1Pf/agQ2dVffhb9b
 ESKAAYp8Ww5ZbbakU+tyHOTyrA1RZOSdE5Z7nyM4G7jCFXNsb297BsObbTd5yf4W+IHzS3azC
 7+bCoXAAsVo5gb059mG8+FdM6FA6TY6jgyoTe/uMReUfgI/QHp68ezo5u2tXZwieI+58Yq7hw
 /QMCvZ0e45SZUAULiYGKmWfBsSSz3Wx4LrJtY4wclPLjdR7tL+LBXC0TcNF1kuSAFd2B8WfBR
 ve6DdDtzOcokPMttyykfaPqT30bEBSEB3XLTaffhzE4X5AsyJ90d0CCLnJNwIBODv2O37CdCt
 YTEMTyQUV1U50lggFKf2gPWmSxHbXfwqZvyRDMK7IaRoEpeEI9B429ZOcn7FINnsK5xJ5Nrqr
 5A1NWT3m10pqxcfFb04aVml5HMEmhje9S2Jt4E1ysQB1A+ejvONLIEW5P0dT4SJgR9ZdghhvB
 xEVkzjwifgKBHKNe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Eric Anholt <eric@anholt.net> hat am 31. Oktober 2018 um 18:16 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > We should never assume to get a reply from the firmware otherwise
> > the call could block forever and the user don't get informed. So
> > define a timeout of 1 sec and print a stacktrace once in the unlikely
> > case the timeout expired.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Reviewed-by: Eric Anholt <eric@anholt.net>

Applied to bcm2835-soc-next
