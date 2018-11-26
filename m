Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EAC20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EAC20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeK0GcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:32:09 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0GcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:32:09 -0500
Received: from oxbaltgw35.schlund.de ([172.19.246.43]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mgvj1-1fktOp0k7p-00hN81; Mon, 26 Nov 2018 20:36:34 +0100
Date:   Mon, 26 Nov 2018 20:36:33 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <2009845931.201432.1543260993249@email.ionos.de>
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev46
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:3sCsHhsdID0vg4NtgQM1x+FnWi7PJgPq8Rf4oXzm0xlAolVDMaM
 yaIjbp6he2owa8+GCAbzSYvQhjNA4mnjCM4uqnzT6mGfRE33nv1susc1EI8HVlz40gHSUEq
 qH4p2Jg50b/OPEelWQb3TvefbLVDFuTgGtKMW9sDJKnUEDQjo/H6PdNisSJtADs7K8RjNMh
 GR+OFbCrMKVa0WzI9QRDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJlCHoAO7i4=:7dgGUDnewYIL3u+aV//65T
 bE+9+IVKMLqDWUk7m0ha+7jRJHWMoJbubGnEXjzJ6eUjTUBiIy3vJnmq7ku3mnALLFkVQf9OK
 eUsMcrjyJIOCQDE0eSSgRaLXPY/OzHwGlFi4dUKsm+eytU3FTYMJi0INPFDEayAOuw2SVBLUn
 JQC5Q0oxy1Uym+0rTl4+KGw24FeXqv6+gqdhGKx+hZRT3iE7pQ2i26Wg2RHX4CpMB+/nH8q+Q
 wv2hxxi1FsP1Ib9qlfpp9aVyimuPzdqO5YoQmIbm9wiUtgxK6MN8yaLdGP3W6HKj1ZzAT/0oR
 Lw/xWTv7mPjl5ecbjUIWUVlF0OHy1SBoHuuVgCh8gSuipVApe8YPBpzNO9pUBOJ873JgS7BoR
 EOdIwKsbCDLNhw2JDT75gcPERmMYeKDnu5GZ5Fy8cHfgbljKmokPpsIdVEp3cbwwget/+LLpI
 NtG6NFZF+DiXRi/QWQuUOsgel0paLrkc9UnMExFRJtv5x3b3fQEiTLClZtUAhNKHtHXV8y9ie
 h6UTxC0b/wgZKvvKBWK51jmEFbF8NV/iulKz/LUp2bs9JD1iMUMCiLfTIsNoQR/l43xjjdiB4
 p4VjtaG2cIIHK7JeufqnoBcJ5cbDN5ajzgQjDvM6eCXuO7537KBnHdCyCnZGkCxj7L2YuIjNw
 tN+BuHWTbyKpq4U1CG8ks8kDqFEAgzUXNB6my6AqwWh0PPKhUGtcSczgoZxvhDf86qyYjWbif
 KIt2CeltkNeBORJNbTsoWJA80VKBFyjbN9fMddG6cZewjNosBF/gwB9hEU1qUR/2pLVZhuNON
 RYwT/OrizC6QXRknNn7mGrUC0QDHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 20. November 2018 um 15:53 geschrieben:
> 
> 
> Hi All,
> 
> This series was written in parallel with reading and understanding the
> vchiq code. So excuse me for the lack of logic in the sequence of
> patches.
> 
> The main focus was to delete as much code as possible, I've counted
> around 550 lines, which is not bad. Apart from that there are some
> patches enforcing proper kernel APIs usage.
> 
> The only patch that really changes code is the
> vchiq_ioc_copy_element_data() rewrite.
> 
> The last commit updates the TODO list with some of my observations, I
> realise some of the might be a little opinionated. If anything it's
> going to force a discussion on the topic, which is nice.
> 
> It was developed on top of the latest linux-next, and was tested on a
> RPIv3B+ with audio, video and running vchiq_test.
> 
> Regards,
> Nicolas
> 
> RFC -> PATCH, as per Stefan's comments:
>   - Remove semaphore initialization from remove_event_create()
>     (commit 9)
>   - Join all three semaphore to completion patches (commit 11)
>   - Update probe/init commit message (commit 14)
>   - Update TODO commit message and clean up (commit 16)
>   - Fix spelling on some of the patches
> 

The whole series is

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Unfortunately patch 05 might not apply.
