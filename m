Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C15C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0CE2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=twistedcode.net header.i=@twistedcode.net header.b="PiTLrvoB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C5GJtDZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0CE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twistedcode.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeK1TCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:02:54 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58553 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727341AbeK1TCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:02:54 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A992921A02;
        Wed, 28 Nov 2018 03:02:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 28 Nov 2018 03:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twistedcode.net;
         h=reply-to:subject:to:references:from:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=mesmtp; bh=Gl4ADWUL5olzHLYi+jskIYn
        CrCkd4qT3kyWFHYt/rtg=; b=PiTLrvoBKSY1XFm7HaI1UhFMWdBTYlxna7IMIkG
        ILtIjYbe888bERPDePgHox0hiEj9c9Gmrvq4LRBwuoEnNGNVyAmJeaw/3cKHcg64
        qdYJldI2726BzmbUKcFx3B1NABH55FiQ0yp5Uaxu2SopHqTaI66dkDYVkU+U/gxU
        4R80=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Gl4ADWUL5olzHLYi+jskIYnCrCkd4
        qT3kyWFHYt/rtg=; b=C5GJtDZ8Pgf+hUqYc8gWgL4CuI2IxB/tyayzvZKhcqLUf
        8jLM9Nb8z6hsrLhvtCovwOFbqTVibsm7WCRob9TK4r2/9nThinLbpZMHIdFXusbE
        5yDI/x0q+mRCmAO00y+kG9jPhRS7IcyzKmGfPKWoEaEDdsYieSI2D+a2UrmrHZxe
        Fe9T0epEpVBsxG0a6XHKvitLqb+3StM/bLaYrLdg1Ajc7/OTFCT3zbf0fWHcVsDL
        oD7WfTZKwPyMwfE2VJAPWHMNvPHlfCs4TGFbMBk6vRXON4pYFlnJITukhHxO/80I
        2+84Tq+4RTUxbPqR2bEHzS6jI+S5KNJCG0X5VG6rw==
X-ME-Sender: <xms:gEv-WxfFrLIgEjqoKxjVsoP2AdcuwpO3QY2vNAEgc1_q5nLh_lsxig>
X-ME-Proxy: <xmx:gEv-W9ESRAA9IMIa8yhYIWWqpT2LKgB6GRibKGNLoOzkG_Hk0SiEXw>
    <xmx:gEv-WxcEG6VvKOlByvV9ga4GgQ4s8c2td5eBsgQKQKDE3-2EUM4V3g>
    <xmx:gEv-W0J630MHsF7erRsQBDaXp2KKE1BCley7byZ_Gj6j-aXTifl92w>
    <xmx:gEv-Wypt2jiDlEaTKIuWQxwNLXSlySEbhOus8PA2-CL4eVzEA_mm4w>
    <xmx:gEv-W7ashcsZ3E3PLhipc7VPlAf_us2p2ycrSHkSkN4D1rnW2olYGQ>
    <xmx:gEv-Wwd6Sk-vZIOiYF3jWUSMaU_MXbXzz4uYp0Geirruw0RDr7yGsg>
Received: from [192.168.1.2] (d220-122.icpnet.pl [109.173.220.122])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A6B0E4898;
        Wed, 28 Nov 2018 03:02:07 -0500 (EST)
Reply-To: grendel@twistedcode.net
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Andrey Jr. Melnikov" <temnota.am@gmail.com>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
 <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
 <vb31df-25g.ln1@banana.localnet> <20181128041555.GE31885@thunk.org>
From:   Marek Habersack <grendel@twistedcode.net>
Openpgp: preference=signencrypt
Autocrypt: addr=grendel@twistedcode.net; prefer-encrypt=mutual;
 keydata= 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
Organization: I just...
Message-ID: <5d21196e-15d5-3351-e431-576d3640387f@twistedcode.net>
Date:   Wed, 28 Nov 2018 09:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128041555.GE31885@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2018 05:15, Theodore Y. Ts'o wrote:
> On Wed, Nov 28, 2018 at 03:16:33AM +0300, Andrey Jr. Melnikov wrote:
>> Corrupted inodes - always directory, not touched at least year or
>> more for writing. Something wrong when updating atime?
I've just seen the errors come back despite having MQ off :( However, this time it took 5 days for them to come back, so
MQ must play a role here. Also, indeed, they happened after fstrim ran and this time *only* on the SSD disks reported
below, another clue? This time the errors were "just" orphaned inodes + invalid free inode counts, all repaired without
issues by fsck.

> 
> We're not sure.  The frustrating thing is that it's not reproducing
> for me.  I run extensive regression tests, and I'm using 4.19 on my
> development laptop without notcing any problems.  If I could reproduce
> it, I could debug it, but since I can't, I need to rely on those who
> are seeing the problem to help pinpoint the problem.
> 
> I'm trying to figure out common factors from those people who are
> reporting problems.
> 
> (a) What distribution are you running (it appears that many people
> reporting problems are running Ubuntu, but this may be a sampling
> issue; lots of people run Ubuntu)?  (For the record, I'm using Debian
> Testing.)
Ubuntu 18.10 here

> 
> (b) What hardware are you using?  (SSD?  SATA-attached?
> NVMe-attached?)
The errors occured on both SSD:
  - Samsung SSD 850 EVO 1TB, firmware rev EMT03B6Q
  - OCZ-AGILITY3, firmware rev 2.25

and spinning rust:
  - Seagate ST2000DX001-1CM164, firmware revision CC43

> 
> (c) Are you using LVM?  LUKS (e.g., disk encrypted)?
LUKS. Both the Samsung and the Seagate use DM for encryption.

> (d) are you using discard?  One theory is a recent discard change may
> be in play.   How do you use discard?   (mount option, fstrim, etc.)
fstrim runs weekly and the Samsung SSD is mounted with

   rw,nosuid,nodev,noatime,discard,helper=crypt

marek
> 
>       	      	     	     		- Ted
> 

