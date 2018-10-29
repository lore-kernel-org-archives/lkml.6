Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A75C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5433B2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5433B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeJ3Fh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:37:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:34007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbeJ3Fh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:37:26 -0400
Received: from homer.simpson.net ([185.191.216.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk3f-1g5ITL1zpr-00Xrmx; Mon, 29
 Oct 2018 21:46:56 +0100
Received: from homer.simpson.net ([185.191.216.94]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWk3f-1g5ITL1zpr-00Xrmx; Mon, 29
 Oct 2018 21:46:56 +0100
Message-ID: <1540846014.4434.10.camel@gmx.de>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
From:   Mike Galbraith <efault@gmx.de>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Date:   Mon, 29 Oct 2018 21:46:54 +0100
In-Reply-To: <20181029185412.GA15760@tower.DHCP.thefacebook.com>
References: <1540792855.22373.34.camel@gmx.de>
         <20181029132035.GI32673@dhcp22.suse.cz> <1540830938.10478.4.camel@gmx.de>
         <20181029185412.GA15760@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TDAxYgqPLv9HkGfQKOX8ex1Ip8m98vNP8LU3suHdGNGiAD1JCBL
 hTcNHvUVsXOaJ7UBQ0MQ+xf2UITua5xcxLBafvFYwYOFeB8JvoUk1sJyXCEFpO6hsNxifZP
 Ucw1nfNUOO5CJjXNFTN7y8nWBJDYRqkmAjiDWUB7FEQLesrsCO9rvgA3Wl8/qfemkLa+epa
 QPnupM8jcB8u6dut7taow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JTZH1oxYV+I=:39baQ/ABzsPwAGsbIMg0aI
 2jE/hgMgSGrtFo94Wnu+mgBktQq07/UuV8r+Gn0dFVzF8jJ0LN0O8ONDg0+lZmpSH9aCxCeKX
 r3fWdFP36uB/ytiUi4tAoFwgFZ1J18K/GUpWNeH2DviLGkG/1DAWH9MXbOh21KtPI0DyfiwUw
 obShDetWmcb9m2vT5rsW2LIRfD/X9bFScrwxwVRhWvlFATfIp4jbIEEZEoU1j5vwLzNZYUfAU
 l/+sslh0NOae8e7UgKbEIcBiiA8HlXXCVzq9Cw8xOW2lvd+qLGHxEcgB4Ql2wy2GOOOtTw5LA
 49cU79svFQSXdKXpJvZRdAiFarTEt4Z6bZIHBu+SzoTUQKlJz1dtVR58h2vAWmUqTNN3Dr0Pa
 101Ch20PcTmKcLOTWhT8o/61r26qOeM4sf2xJqXK24RafwMPAL4yDHDaJyh1qurkCshpvxMfL
 wLU4YLV6ajdrvMfJetIFR/kdEYWoLFqroE18WoX32rX4Nq2D8jS1/oPTrCvAJrr627IV1MHU3
 eFlm10/sn9Wuk+BLx3SQ1uA0OGAALt6l0zcqLuNqcNLDkLMV+rYL673vnh01B6rQXW7R6jjaC
 GXi2UvE5ExTozT0txoeJALxnYMOhbD5f9JWUREn+A6RHtI9cTGq7zl8Y9ws5BeFGWglF/pvAz
 qY26SibAIHRZ//EgP1nMQAM1MF9n8RNSmY5r5ulJ0xyGM419R+4L5eJ6JuvozUmorl8mnH/Uc
 7y35/Ad2yFRkzTVU5pqiL/MP5HM6EjTjbBTIsrnbqrZ3POztd29G8mHE8pWfLQy9GbQSY0ZRn
 +Gffgfpza1EivIdeNCR63cz/v+5IaY3hLzTBdmw0Wi3fWBE4Fo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-29 at 18:54 +0000, Roman Gushchin wrote:
> 
> Hi Mike!
> 
> Thank you for the report!
> 
> Do you see it reliable every time you boot up the machine?

Yeah.

> How do you run kvm?

My VMs are full SW/data clones of my i7-4790/openSUSE <release> box.

>  Is there something special about your cgroup setup?

No, I generally have no use for cgroups.

> I've made several attempts to reproduce the issue, but haven't got anything
> so far. I've used your config, and played with different cgroups setups.

Ah, I have cgroup_disable=memory on the command line, which turns out
to be why your box doesn't explode, while mine does.

> Do you know where in the page_counter_try_charge() it fails?
> 
> Also, can you, please, check if the following patch mitigates the problem?

Yeah, that plugs it up.

	-Mike
