Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E0FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44927208EB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Xqyh5kM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44927208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeHZR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:26:52 -0400
Received: from sonic313-19.consmr.mail.gq1.yahoo.com ([98.137.65.82]:37919
        "EHLO sonic313-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbeHZR0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535291054; bh=t3EoGl91gKLzLIAZTGBnXp/EAhF8F77vdqLrlP9wNkY=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=Xqyh5kM5mIOHWlW0VCEQH71dFniB04R7ipaf19c8dbdYkfLh7hTa6PDmNILMGewNqWsqFScmXig2++4M8sEjDQ2+ggck+lQFF5wim9V/iORjuhl3qisvLE2e0nXLVpApA4ybWYizWRwQCGDyHWrF8OvGhqTwtur3vNk2rD3m1/MGNJKH2YTRDm9YOa25W/No9MAAqECJbz+cfk9mIW+0CI9FFHw/Ka7ZJ3JzQeH0N/RXf+68UkiDojLMPOX3XaHy+PrSKLUkrMYe58FVhlF3oM8CUP4MxXa3VIj28N4pzX8yRcS4+VH4H+P+xRhyfGbmamOgdE7bevKejGChW9dSSQ==
X-YMail-OSG: 6mEE1VoVM1nCj.AoKOE1M4UTIKuzP3mHTOLFxIf4rjRK0JokLw91o5IVeoHUx1K
 xsIC9F.OyS9hirI.dIUhSe6IOQOcMtpV3yNrz4ezAsbLlsbK7iSHaVzo0mGa2hiFU3gVW1k65rP7
 bTMV4WSe0XtuA2FkGJPAJgmHGAJ9tTV7L245V.5B9nlirrqf6zIusGJ4gOBAYhqgEa.mCfYX.idk
 m6NyvzRc.0VZ0Ii.BG02vWlbtMH1OF__d97Pk6T0w_MhFKDDn8cs0gTJtEuy5m9RDpqfiOwlxydb
 U3fj3YOytfrahxkGN_QaKdped2KFyKLtLW8HY2RvgVn9y9AczooB4.wMsI2AKscrToTk8IresxbW
 dHVFT7OcpjWbFi6nc0aZWk9s0pT.389tb2p9WYib_odQcNnlP4lmtyaOL3Ja89srN5yF9Ze9yIAw
 NpnECf_A0dXjf5GxssYMmTg9L0fhNpGKaMzQWYwob_IXjU6ix0atoLkkjN3eBiSj5nZALRmXJ.kS
 4TfuGcgIskAQIUvUh2tq3NiOykZ.hGduBRbnzmdnn21nNLrH5vvCUjz1VIpm2UMby8VDZqzLGXsU
 h5WcB5BGQrSwm3WQ4B5tQCt3mu8QWhVSO9miJsFJ4iIma.9g8xtNcuz2SX4ASwwnd1gSCrJKPB.X
 hxyMKOwqylE_J25arViH1e989EwyD.C.BShviYgsIORtQlJrAsu041jx3MeEtg_PmAYxpEVvcl_X
 NBHOIoFZGLYT2PgG3MgMgE10YqEpaCVQfJwZzrJUC2LzbYaN0zQ4Cn7_JLwDrQsf6zeRop.3jgXw
 8n9NpjUw3TOk5s43JzGTuShH2FYzeao_9ncaYrTnNGoQcqaGw9yh1klxovfYX6BnhhuuakhHP2Qy
 h5xnXk5icuZk9a.MB7rrY2ZddhJVKxAJkifeFnxfQZcaJ5_cO9kdpikw.kEsan5YfBNdrQsvU729
 Bv9tjGh8Gb4HbS4Iuw5_XcLfyTPgjH.Adr8j6xztdX9huiPFb2xbD2QrSuNapBPWBLgzzZZO1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 26 Aug 2018 13:44:14 +0000
Received: from 116.226.251.211 (EHLO [192.168.1.7]) ([116.226.251.211])
          by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f89c707d63cb376e614ab031b9829e85;
          Sun, 26 Aug 2018 13:44:13 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
Subject: Re: Re: [RFC PATCH 02/10] fs-verity: add data verification hooks for
 ->readpages()
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>,
        Gao Xiang <gaoxiang25@huawei.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
 <20180825041647.GA726@sol.localdomain>
 <21e86199-28a7-4693-aef5-5fc28842535c@huawei.com>
 <20180825071827.GD726@sol.localdomain>
 <c907ad1d-c7c8-714a-0e59-373c1df3afe8@huawei.com>
 <20180825170624.GB10619@thunk.org>
Message-ID: <a7ee7fb5-26a0-6737-9246-93d6d7432a42@aol.com>
Date:   Sun, 26 Aug 2018 21:44:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180825170624.GB10619@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

Sorry for the late reply...

On 2018/8/26 1:06, Theodore Y. Ts'o wrote:
> On Sat, Aug 25, 2018 at 03:43:43PM +0800, Gao Xiang wrote:
>>> I don't know of any plan to use fs-verity on Android's system partition or to
>>> replace dm-verity on the system partition.  The use cases so far have been
>>> verifying files on /data, like APK files.
>>>
>>> So I don't think you need to support fs-verity in EROFS.
>>
>> Thanks for your information about fs-verity, that is quite useful for us
>> Actually, I was worrying about that these months...  :)
> 
> I'll be even clearer --- I can't *imagine* any situation where it
> would make sense to use fs-verity on the Android system partition.
> Remember, for OTA to work the system image has to be bit-for-bit
> identical to the official golden image for that release.  So the
> system image has to be completely locked down from any modification
> (to data or metadata), and that means dm-verity and *NOT* fs-verity.

I think so mainly because of the security reason you said above.

In addition, I think it is mandatory that the Android system partition
should also _never_ suffer from filesystem corrupted by design (expect
for the storage device corrupt or malware), therefore I think the
bit-for-bit read-only, and identical-verity requirement is quite strong
for Android, which will make the Android system steady and as solid as
rocks.

But I need to make sure my personal thoughts through this topic. :)

> 
> The initial use of fs-verity (as you can see if you look at AOSP) will
> be to protect a small number of privileged APK's that are stored on
> the data partition.  Previously, they were verified when they were
> downloaded, and never again.
> 
> Part of the goal which we are trying to achieve here is that even if
> the kernel gets compromised by a 0-day, a successful reboot should
> restore the system to a known state.  That is, the secure bootloader
> checks the signature of the kernel, and then in turn, dm-verity will
> verify the root Merkle hash protecting the system partition, and
> fs-verity will protect the privileged APK's.  If malware modifies any
> these components in an attempt to be persistent, the modifications
> would be detected, and the worst it could do is to cause subsequent
> reboots to fail until the phone's software could be reflashed.
> 

Yeah, I have seen the the fs-verity presentation and materials from
Android bootcamp and other official channels before.


Thanks for your kindly detailed explanation. :)


Best regards,
Gao Xiang

> Cheers,
> 
> 					- Ted
> 
