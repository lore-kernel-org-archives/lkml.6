Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1723C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9851820838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9851820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIZTEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:04:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:39561 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZTEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:04:32 -0400
Received: from DESKTOP-SLJ7U3P.fritz.box ([95.91.253.176]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MK3bN-1g5ylo1zfh-001NUR; Wed, 26 Sep 2018 14:51:37 +0200
From:   Dollinger Florian <dollinger.florian@gmx.de>
To:     andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input-owner@kernel.org,
        linux-input@vger.kernel.org,
        Florian Dollinger <dollinger.florian@gmx.de>
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
Date:   Wed, 26 Sep 2018 14:51:30 +0200
Message-Id: <20180926125130.974-1-dollinger.florian@gmx.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810001714.14659-1-andrew.smirnov@gmail.com>
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
X-Provags-ID: V03:K1:gBAhESC9VKz/BNIKJClLrjDwVBm2dRIwDMpVOZZcp3l/RtLIyjm
 A0042u2vGP4OvQdchkMKaH0XUKGLex/OOrw47puztBNphyyuGy16wQ5+TOMBWox0ECExADz
 b4Ln5BNE4l67wiHSMs5okg28kyLc2f0rD8PAMVszYmyqsPi6ZBqx1Z2QilDVlTh9ZrSey+1
 JzqjP2yodKFFftmyxZGiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6udhG0KfY/g=:zgHSB2LbUPH3sFurq08oZf
 sgumxp8dBBlKi2GURy2cx3IyBKfMvVWFAFcYh2T5iETsXMafkkexyP6stUquWk9i5RcGvriNU
 EcrDJFYyFB15NtYexMidfX0xiKmGSTCPrEBLTgXWrSekL0Mc3I3pOqYC/Ruot/7n7xb11DHXt
 okIB/DwDEI36uT4Ix4q5p0qa6r4R4a+4PFpJhjkghScDwf0Ob2nXx7yxa5fP4rMgWWXI//l93
 9fbc3EzTY3DqOOdj+GCAIJQ/KuVT3duPYBI9V4FHYwV0oRokfupL2wyq/redZnphqcEz1+Gsh
 gi2elpM/F6tGgNfkketklw1/cbY3PvdNxr71iLxChGb8y8dki+l3VBesONvwCcvsl3Sn3alc8
 mrsFcqK7BgBoPKHaT1HP/GHOCIVXhwueJIWewxsG5GsPHEuPihQoazoEu5JOwoC8MQrRpAe3s
 sx6uL8vrJ7rd2HFMQTgg1xuDjQdi7o240+qQotbxggZEw0tDQBdzweoDBE2UVIw/o/mAvUEMb
 tY4DImbzZprQGw20T0pl9PSO4aIuxqNxcNRkuIStTv7a6zAs0ZDWdfU5bW7NwJUo8D9FzZPn1
 d9+cETg9QbdOC3biesol0a/rYS/L+3JFuxlOUz7HBL2RSrIsitK6uww4GXKEE/e3kTlYDuNRp
 ceOHQUrEvLcsEp/gnctQwlkQKCiik0+t9156/1JrOiKq6HBfkoxwYr9HpB1qOOridmgIJY5p+
 NTfooftwlT3wV5nHdBNphNbeYDKnzkS6G/YngEQ32eVu8rTfxSvNYTP9+ITRcolAT/m8AYK2M
 mYtw6SC1NvfrlKQP9+F5EYThxNwsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Dollinger <dollinger.florian@gmx.de>

Hi there! Why do you re-engineer the wheel? :) There is already a fully functional and tested driver out there (https://github.com/atar-axis/xpadneo). Would be much easier to help me (the owner of xpadneo) to push it into the kernel.
