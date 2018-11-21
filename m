Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DECCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF620989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFF620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeKUVa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:30:29 -0500
Received: from mout.web.de ([212.227.17.11]:46735 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKUVa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:30:28 -0500
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 16:30:28 EST
Received: from [192.168.0.11] ([87.189.163.28]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYS2-1fu60d1xEk-00WTNM; Wed, 21
 Nov 2018 11:51:05 +0100
From:   Norbert Jurkeit <norbert.jurkeit@web.de>
Subject: Issue with RTL8111 NIC after upgrade to kernel 4.19
To:     nic_swsd@realtek.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     michael.wiktowy@gmail.com, jcline@redhat.com,
        marc.c.dionne@gmail.com
Message-ID: <d0a53002-bf14-6cd9-ab0f-5d3f9aa395ce@web.de>
Date:   Wed, 21 Nov 2018 11:51:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:J0d1NbHHFSGf+KU8mQ8uD3MvMPiW59ry3jFO9y5EfDhl/1Puz+G
 z3c1AiGVHaar7loKfxRKt/q5GeBXRbWrPrz/xTkf/7K3RULu5VStOXn9BDDAEnb4c1/UueX
 aKWG9aDB76t1DPJO7KWWcyaT6gvC9gjWr4ATDxcsjyCmWbrXUzB9GlDGg5L4awFNf+UOEEG
 P++MhgyBNS6ZsFeBZKCrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ah9e5xXOoDw=:9lorlu0fQa8VsVt9KA4K0r
 y8ZW+D18g0qbB2Gs0MQlHb1VwZUE+7XfFIZOGXBhNvyh7Gv7jD0PbDkFK4DXPR2EMSPtfpVyz
 8pDIZBlejDmjwWSdtosbhfSlIv5cHixFZErPlX++FSVZ5MVFVIfMPwoVSB/V2GEW4GHPRuw8t
 pgLJI+N7JMHLQ3T7iQ6cQYiEmLf6oVE/mFwNx8DS5nZ5neTGHf0X0Q71bJDV8rFVJ22SJ2JWY
 K4zhg7aPZuTwlgXGuYir9HV8RdmLXoeHOnFHJLDQNgYe5jkt3ThdEvPd2jynEVoXLi5ZgYNGq
 hjHfPYBAPrBcmF81HZfngRgjDBS9xgEI+eMqCssYk7p+Iv2lY1o4LP18JBUMtxiSi0DVzJrdz
 RhKZ1C3ooEVOMYp6qX7kwee3hfDDqMKHefZrHGCHHEENbBDL+QxEzTjUDnKO76pk1KrDWAuzf
 NSQtKMBvpOMs1OwG9EdBwh5UaYMFBsJZ5kD0xPVOar1jGL0aKmGIODk86qDkKQ+aNYrhtau1s
 qveKQQmgFJL2uEaN172H3QsHRAuEjMEoyv0N8h+KwL9OFrUMa6kdZUbDfkWHl5qvCtZ7pmgVg
 dPh/gaEs9FPht6er4b2b5bYXSWAMtfsRw3YkOtTBb24AZByyjG5ZlMOwmCw7woHDp0sWpCN1f
 Ic1+jnRyR8ngZy48pCvwC5kL9JjHlLtVSk4IqfMKebfCa6qZnhSl5sbDtfKRCTH6hrGi4fMSp
 Ig4sXY1+5p+m47aruac8yOD9uHe0etpuK70z9H9pDt1+zOegG2963DR6++X/UjpMFxCL06hbZ
 ivYJTl5eI3b+O2xDYVR4Z/Kv7O58M66ysu/iVt4HkP3fJ9UIy5RBT585tX5e+B1JGV4LxW2AV
 G/tkkeymVMwgUjqc9iu0IRBCzokJ1PvYX1KUyYlWkzbIFg2fATwseqZTZj1MtL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,

after upgrade from distro kernel 4.18.18 to 4.19.2 some Fedora users 
(including me) encounter issues with RTL8111 based Ethernet interfaces. 
The interface is not started correctly after boot with kernel 4.19.2 
(i.e. is reported by ifconfig as up, but not running, the LEDs besides 
the connector stay off and no data is transferred).

At least for me the issue seems to occur only after reboot from a 
previous session with kernel 4.18.18, but not after power-on, which 
means the hardware is not fully initialized by the new r8169 driver. 
Marc Dionne, another affected Fedora user, thinks that module "realtek" 
needs to be loaded, which does not happen automatically. Please see 
https://bugzilla.redhat.com/show_bug.cgi?id=1650984 for more details.

As Fedora kernel maintainers usually don't apply many changes to the 
upstream kernel, users of other distros will likely be affected as well. 
We therefore kindly ask you to investigate the issue and fix it in 
future upstream kernels.

Many thanks and best regards,

Norbert Jurkeit

