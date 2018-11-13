Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31B22243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 07:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31B22243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fkie.fraunhofer.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeKMRNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 12:13:47 -0500
Received: from mailguard.fkie.fraunhofer.de ([128.7.3.5]:40501 "EHLO
        a.mx.fkie.fraunhofer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeKMRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 12:13:46 -0500
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 12:13:45 EST
Received: from rufsun5.fkie.fraunhofer.de ([128.7.2.5] helo=mailhost.fkie.fraunhofer.de)
        by a.mx.fkie.fraunhofer.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <henning.rogge@fkie.fraunhofer.de>)
        id 1gMShp-0004yA-AO
        for linux-kernel@vger.kernel.org; Tue, 13 Nov 2018 08:01:49 +0100
Received: from srv-mail-02.fkie.fraunhofer.de ([128.7.11.17] helo=srv-mail-02.gaia.fkie.fraunhofer.de)
        by mailhost.fkie.fraunhofer.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA384:256)
        (Exim 4.89)
        (envelope-from <henning.rogge@fkie.fraunhofer.de>)
        id 1gMShq-0004x8-RK
        for linux-kernel@vger.kernel.org; Tue, 13 Nov 2018 08:01:50 +0100
Received: from [10.71.67.24] (128.7.89.212) by
 srv-mail-02.gaia.fkie.fraunhofer.de (128.7.11.17) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Tue, 13 Nov 2018 08:01:49 +0100
To:     <linux-kernel@vger.kernel.org>
From:   Henning Rogge <henning.rogge@fkie.fraunhofer.de>
Message-ID: <d5459b78-490e-9aa7-6f0c-2fe4475575bc@fkie.fraunhofer.de>
Date:   Tue, 13 Nov 2018 08:01:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.7.89.212]
X-ClientProxiedBy: srv-mail-01.gaia.fkie.fraunhofer.de (128.7.11.16) To
 srv-mail-02.gaia.fkie.fraunhofer.de (128.7.11.17)
X-Spam_score: -1.0
X-Spam_score_int: -9
X-Spam_bar: -
X-Spam_report: Spam detection software, running on the system "mailguard.fkie.fraunhofer.de",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, I am working on a self-written routing agent (https://github.com/OLSR/OONF)
    and am stuck on a problem with netlink that I cannot explain with an userspace
    error. I am using a netlink socket for setting routes (RTM_NEWROUTE/RTM_DELROUTE),
    querying the kernel for the current routes in the database (via a RTM_GETROUTE
    dump) and for getting multicast messages for ongoing routing changes. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 SHORTCIRCUIT           Not all rules were run, due to a shortcircuited rule
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Subject: [rtnetlink] Potential bug in Linux (rt)netlink code (repost from
 linux-netdev)?
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a self-written routing agent 
(https://github.com/OLSR/OONF) and am stuck on a problem with netlink 
that I cannot explain with an userspace error.

I am using a netlink socket for setting routes 
(RTM_NEWROUTE/RTM_DELROUTE), querying the kernel for the current routes 
in the database (via a RTM_GETROUTE dump) and for getting multicast 
messages for ongoing routing changes.

After a few netlink messages I get to the point where the kernel just 
does not responst to a RTM_NEWROUTE. No error, no answer, despite the 
NLM_F_ACK flag set)... but sometime when (during shutdown of the routing 
agent) the program sends another route command (most times a 
RTM_DELROUTE) I get a single netlink packet with a "successful" response 
for both the "missing" RTM_NEWROUTE and one for the new RTM DELROUTE 
sequence number.

I am testing two routing agents, each of them in a systemd-nspawn based 
container connected over a bridge on the host system on a current Debian 
Testing (kernel 4.18.0-1-amd64).

I am directly using the netlink sockets, without any other userspace 
library in between.

I have checked the hexdumps of a couple of netlink messages (including 
the ones just before the bug happens) by hand and they seem to be okay.

When I tried to add a "netlink listener" socket for futher debugging (ip 
link add nlmon0 type nlmon) the problem vanished until I removed the 
listener socket again.

Any ideas how to debug this problem? Unfortunately I have no short 
example program to trigger the bug... I have rarely seen the problem for 
years (once every couple of months), but until a few days ago I never 
managed to reproduce it.

I have asked on linux-netdev but got no reply expect for a question 
about rate-limitation.

Henning Rogge
-- 
Diplom-Informatiker Henning Rogge , Fraunhofer-Institut für
Kommunikation, Informationsverarbeitung und Ergonomie FKIE
Kommunikationssysteme (KOM)
Zanderstrasse 5, 53177 Bonn, Germany
Telefon +49 228 50212-469
mailto:henning.rogge@fkie.fraunhofer.de http://www.fkie.fraunhofer.de
