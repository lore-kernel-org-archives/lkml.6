Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC464C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCDE20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ydvf1Ukc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCDE20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeHAXhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:37:42 -0400
Received: from sonic312-27.consmr.mail.bf2.yahoo.com ([74.6.128.89]:40774 "EHLO
        sonic312-27.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732138AbeHAXhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1533160190; bh=+2fZQjr3tD6pQkh4HrSJJODalznu1LCyT+3Sf1I0VOs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Ydvf1Ukc0hvB9WYkrDQKnd24oitwuJKMCiYAGdbIh7l/NUkYB8m5wLIIjK2kJvnN553AV9bAv6j8v7fvgQLgY4ox4dQgwDROCat2kTnj8jSVN8DP9gXNAyAz+aXqX0Pz48/w3GTazaxMGEnhhU3ti+Di6Bg4rTgfBofT6F7D7vKIOOApy3vNgEPOpA3n5E35iU0M1CrRxuGKikjxaWwqlKy1RxqI8/QEGzd6EWNartV2yEuO2j+FIcyRsKtmDmAG/bGhSmHySB7S1KHtKiH0qWOY14bNMVi3fNMBbcVwDfguSN7jdcSScfa2OhUdsOyXCjr2IquRtgm2D7PcbSAjVA==
X-YMail-OSG: BFyPABsVM1k5yx9_8POq_cFTlCdpsy.WZUvAPQHrgncSFe0tDDNS.GcbE5qgWMV
 1__o.arP6qSbjYQ.uHLHFCnNNKaWmkEJSCfH3kmtCqrcf4s2KIe4auqJTHrwNTR0gTHoK8qIb76J
 Bm47yELMwwsDRb2ugMrx8xnqQJdSgnK0OhYTZKObyYFe4L9HacjB4wBu7ht1BHUVpeQpwRxMRf6x
 vYYyS7pbpYk69rIdcgfN8DHD2zoiYaTmbEQsQiK5yQIGpbxH.dHTUpPaYsbixYZggv6jDxwrCIci
 Xmpo2gHSxBuuvLQ.2jJTR0JD5IpRoER7XPnlmY.vTPDUS23pdf4HsfuY8JxLyAI9Uw8ewMd8hMct
 f6H6RmReZqQCryHxJDjqU_u.v5VMqu0G.ZTQZH2l_VdC4sH_NnklYBNC8OTKTOGOQE2tPWhjiLEC
 aIAg4k5uXvxHtCKT1fqpCHxkqcG1rz128rCIkzLOUL8pD7Jjemhsi8G_ytMLHENULwY7QyAHfugQ
 oOydyjRaQxFNjrXi_yChc9zsimbqZbg5g.lZeEbx1uiIkf8IyNpErySDmymVysIit1H_RlqxA4Mb
 DHBmenUl_ht.n7CuxSedd9zvhvcX4zbLU3efRgdcjGz7pzusfnGnI91YVvhPoX4bjKevjoW0db50
 uXklcmXi08X4MSfdLTa1WOTB2L3l43UimSinCgLgdwe8i82EHJMZ8ixudDNx6TfRoVrrNMtGlpYh
 ceVeBE_OCnesE8nYHiSs7WmxkD.ggZzqLvWM.l7.BmZ.FxQ37XPXw8ybGgDZ6jl9FUFDOAqYec7h
 vvTwxFX0RJJcJCHlcBQuTwz1cATZdQqEiU0F84PYb8bB0v7pwL0R8MU3HKWEoD4P_EHleul2eW37
 G87i6qul0jq4kCg1Q3h5wKRs8zWSmU1vOmc5BEHbvOAFhqhatuVfp.5YvQSWq_2dNxvgCD8WeqcI
 iKfrNsMRYzgykBpXcv80fyYIGYXxfZQF3yrwWqDOzE7BTOSNyrpt6IuLJ7wNSXOI9LyULz9tSPx9
 ph8p.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 1 Aug 2018 21:49:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.104]) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b03cfa5b42b51641bb5044dea3f39daa;
          Wed, 01 Aug 2018 21:49:46 +0000 (UTC)
Subject: Re: LSM hook for mount, superblock and keys watch notifications
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
References: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
 <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
 <7561.1533157444@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com>
Date:   Wed, 1 Aug 2018 14:49:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7561.1533157444@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2018 2:04 PM, David Howells wrote:
> How about if I apply the attached patch?  It creates a new LSM hook that gets
> called each time a notification is about to be posted on a queue.  It is given
> the creds from the /dev/watch_queue opener, the creds of whoever triggered the
> watchpoint and a pointer to the notification message.
>
> The notification message includes metadata describing the source/type of the
> message and the subtype within that, plus subtype-specific flags.

This looks like it will solve the problem for security modules.
I still think there should be some sort of default controls.
The idea that the default is that anyone can listen for everyone's
events, and there's no way to control it does not sit well.
You could implement that as a security module with the one hook
that does UID based controls, but I don't see a lot of advantages
to doing it that way. At the least a process should be able to hide
the events it would generate from everyone. Better would be to have
a specification (e.g. mod bits, an ACL) for who should receive them.

