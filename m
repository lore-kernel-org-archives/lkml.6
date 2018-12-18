Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E2BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAE12133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="QFrELBWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeLRPcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:32:45 -0500
Received: from cmta16.telus.net ([209.171.16.89]:35388 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeLRPcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:32:43 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ZHMIgu5roPTKIZHMJgjxIf; Tue, 18 Dec 2018 08:32:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1545147161; bh=/jjnc/O4z57cBeFS2sRWR6xlW0NV1EzJx/Gbtsxw2KU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=QFrELBWTwT8oNOx7A1uIwQ9YRSunDURpAX1f5dtyLF65BVovrVifR1bRIl/siw3e8
         NcmICTOhWauJbIdMWpaInWvIC1pe4ZXq6/JTDZ65Zblmdca5+Oa5h53vhVyqM6ouOh
         niy1Kh/Re2QRl4BMtGnZf2rwaAy9orrlZl+t6DGFr3v7NiEmvLE1vhNstyNRt1k1y0
         8fov4vAPNLWg7iYTqRcs4shBF5lNZcQifBNS6d3yRPlMBeC5/hzt3ZIr9SlA81mojb
         ngDkVdgHSKQUqx4uYI5mVPHN47sQrHH/5MSehYlBEl4CBdtoZ06bMBYvHRK0hLH8Om
         Wj7cU/KMlHlGQ==
X-Authority-Analysis: v=2.3 cv=ScEmicZu c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=igVac7VHLN7dM1eNno8A:9
 a=a5Pr5dq2C4F9gyTB:21 a=QSMCXyC1Q8XIr_V1:21 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Frederic Weisbecker'" <frederic@kernel.org>,
        "'Mel Gorman'" <mgorman@suse.de>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Chen, Hu'" <hu1.chen@intel.com>,
        "'Quentin Perret'" <quentin.perret@arm.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: ZDGBgBJlZBdpLZDGGgQX53
In-Reply-To: ZDGBgBJlZBdpLZDGGgQX53
Subject: RE: [PATCH] cpuidle: New timer events oriented governor for tickless systems
Date:   Tue, 18 Dec 2018 07:32:33 -0800
Message-ID: <000001d496e6$e968c8f0$bc3a5ad0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdSWwjzkrz2UC6oWQw++qlF/5chxTgAIbjdA
X-CMAE-Envelope: MS4wfAjRkJIOdeZYBe6hEeQW5mNbcmN3n8RJY816t2bXS4/GBUopUZoQTWO/eORqFmk2brJojCVDUzlT8QRoYHYshLr9pipk4UFe3hwgr4kqwdrINgLHhK2v
 BzlAoJdFTPeOrEv9vyMalGlpkMDuPEnllyYDMGaUZXXrYxfUM809aE4S608M8yxSx38DLFpOdOG5DjtM5P/y/Pz2vimg3LiaN+RpIoTWpn1+a0Vb4JF6op6M
 okhIJtgdUje63uMwMx+37bADrIZeYFwFwcD9XrErD2riJBpT69OSlFZeEpheIpbmg6SrucxJevkzyADZUJihdo9p8NnhXd6u7XL9aAhMEv9HKSRcST3FhE4y
 TPeSSNCOR3V6t6jEsagFnHbjvRQadUxbaN8xRmGF/7YpTPL77CE7/xsPf1j+dFBbz21CFQ7O40vPs7EL46MCsnVYUW+Tn6EIqGE8dBs7BDCD9MzlNaiIjsQm
 Mw+vVnTeDEKO1bpK6xTj0qKBprujs+oxiKhArjmyqGBQfQXA5BRao5/k2bJWt4n7wbdzENkbB8zToqcn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

Just typos, not already pointed out by Quentin:

On 2018.12.18 03:09 Rafael J. Wysocki wrote:

> The venerable menu governor does some thigns that are quite

s/thigns/things

> time frame in which no timer wakeups are possible (becuase it knows

s/because/because

> +obtain the the *sleep length*, which is the time until the closest timer event

s/the the/the

> +increased when when the given idle state "matches" the sleep length only and the

s/when when/when

... Doug


