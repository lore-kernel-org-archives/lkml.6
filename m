Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC9C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F7120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F7120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeLCSGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:06:17 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57797 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCSGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:06:17 -0500
Received: from oxbaltgw05.schlund.de ([172.19.246.11]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjOl-1hESyD1xNr-00lH6L; Mon, 03 Dec 2018 19:06:06 +0100
Date:   Mon, 3 Dec 2018 19:06:05 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, davem@davemloft.net,
        joe@perches.com, michael.heimpold@i2se.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <2117103003.410648.1543860365255@email.ionos.de>
In-Reply-To: <20181203142638.13178-1-tiny.windzz@gmail.com>
References: <20181203142638.13178-1-tiny.windzz@gmail.com>
Subject: Re: [PATCH] net: qca_spi: convert to DEFINE_SHOW_ATTRIBUTE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:MW/wmqV4T0qFlMYqCIyvdo4XAXWmJ7yIR/XagdrftHKqHi3k9BG
 gCUlj/W3TmH2QS6TkXnFtyb7tqQZmLENlIOLVAjYp8yuxust6FBvIQUgX5IXoQq6xkCwW30
 1TCGOtjknWfnPOcECoJia6EvWeSX8vXwLjIoj8CtAYFkgt9eMBwLJwM4XmrNyP3q0ozvK+c
 tepUVyMSrakxR0aFroFdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a3wl0fYalw0=:+Nn3zJpUIWKfHZVsr/QdDw
 9c7D1vvAnPLNNZNnyfyO3gTboLlx4AXeKmxVPYfC06okFrvW/0PykZjjT1iOipMyQ8FLv/tU2
 YQmKsmFsP2I+YRZa7agxy/fEFafiEMkdCGrbrTqL0BJOAro0KSvMuXhPK4UK6wB4BWbnBjlOq
 lZiC5MlmDFMisbvKTNzausnhcRQLVOF9HIhHsDUsz7UIOSZLnpC267/yIfPQpGMEtfm4Xfue4
 Ed69ZTVrOF5j1mz5QDDTU3XooE5at2wwKGzxXE/s6MBCe1bHXqh0QMfayCfR7ZVL5RNZpmIUi
 y0+POTlWDoU9ubKWRkJyNkL4Xy8e5S6FiQNqS8VUE0RW10IcCAiL439BCWkAanlrgYplriuK3
 r/HHsB/QL5MPykQpA+LKjevu1g3SmC0v4aZHQeMU1pWxbXkoodVqvLdE2X3LmwBHsStGg35xa
 bya+gH4ZAmpMDR52ae7rIrWCBh0zEu5drmjnSHTeyM6Fv1SI5KDFD49VUXHoCkfOqv1EsiCrP
 f4W9DKZ+/waTX7mcWHrWuMWMys0ZbfWAWoWlNXTlNT2VfP66606V8UGTED2D3BAXWMKODDH+I
 PuDagIocXUBoOLHvARAPk+PjzcEQtD1AoykZmO2lbesLgVtCdGgxCCeE3MT57EYGxZ7DevWDb
 ZlG+JxMo/hLPrwPoonc9CI0a5B6beMkysSodSW9L+gle/I86nrmFpFPSgeb/Euiwqm/5PuN+F
 Dah4TNzX8USbDzkK04Q2mSOuxqyDI5KMveohEkONSwDCiQPMFN1HlQiruiI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Yangtao Li <tiny.windzz@gmail.com> hat am 3. Dezember 2018 um 15:26 geschrieben:
> 
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
