Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB87C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1092168B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="icvLq88J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1092168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeI1D6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:58:13 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51780 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1D6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:58:13 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so357659itw.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxcterGl8s6MFONuH+El4gf/ocJRoDE8W0tjhlUDlJg=;
        b=icvLq88JLbmvr+lme9SeKRlnUGJDyF1SAYu/R+PRdFw9IiZkS9xh7z3VbBk9o6fdNS
         2ko8+mzPNNFe7rLamI3SRYXpxKwk5keKfeBBR1gw/5NFVRBwQBeUwK6/x4VoHTDN8tI5
         HptievJJK+WB7ke8hcY3chWJvMf9TqsQn3SaS3o9iuaTqYcKV97WbYNIJOa9VksUfoub
         v5C0GMYnLzbKrtpgIp2mB93UL1K87wa75w0H3c1cqODWwPZy3m9VkSZLix5yva4R1PON
         nQExBiqtpmAcxUp2en+mQgJblM5FyBC4JofADAeL03oQ4O0yfz7gMxcTV7kU7FN9gVr2
         eoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxcterGl8s6MFONuH+El4gf/ocJRoDE8W0tjhlUDlJg=;
        b=YDCWbzYKAaLD39pxATLftsHYAeft70t7Fzmvgq9gObd5Qc27yKWRkpQ4ODmsePrWuJ
         dsFdGuSBhX+jRSDppVcZaxRvoG8cWIQgu/yYXu+P7tbxocR3ecjlX2A0nKkuSP1kxbWW
         zDO1ulqaHIz/PPqeI0qduAEl0unjmGQ0lSW/Mwke8MZvTDJSYdFVA+x8t4gkL4QGYrzg
         8c+fez7mfRNbH0LgOgpcI4ySuqWamLKY99hrcfBFDmLMkEX8TY5ktqKYEPfY5osEGTmy
         6KnXaBG70x31bb6B3Gpz6tryMRWlEEB4qgJuzIPe01ZqA+7/ektvxMgNJwu2c3LR7M6F
         5jvg==
X-Gm-Message-State: ABuFfoipup1BeiALvKjqfP7a9H1fUf0qwWCw13N00we+M1mI5BT4Z5zm
        6jhFFAFyzYisOsWSuS9ItTzKjhaPc7M=
X-Google-Smtp-Source: ACcGV623iDYYMKqFQj1pIQrn8fl0gkhvJxA23w97L7lJNsgDWXBEOblbDSQxvwS6B/6lgD+Xv5X/6w==
X-Received: by 2002:a24:ad2e:: with SMTP id c46-v6mr390720itf.82.1538084274007;
        Thu, 27 Sep 2018 14:37:54 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a14-v6sm1057767ioh.45.2018.09.27.14.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:37:52 -0700 (PDT)
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: When purging persistent grants,
 keep them in the buffer
To:     Sander Eikelenboom <linux@eikelenboom.it>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180922195549.27953-1-boris.ostrovsky@oracle.com>
 <28aa9249-7406-21c6-f509-65411828e2d7@suse.com>
 <5bd1a695-50c6-e79f-38dd-c980fc2138ad@kernel.dk>
 <00030538-e1ce-28ad-3548-8e3b07083b05@eikelenboom.it>
 <b181cc24-16fc-ac94-24f8-1955efa6565d@kernel.dk>
 <04bc976c-9991-e24b-4994-55540b06f133@oracle.com>
 <4f53cd6f-0a73-ccdc-c816-1225aebd8d58@eikelenboom.it>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1d3d7e32-22d1-83aa-af0a-7ed6e628f5e5@kernel.dk>
Date:   Thu, 27 Sep 2018 15:37:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <4f53cd6f-0a73-ccdc-c816-1225aebd8d58@eikelenboom.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/18 2:33 PM, Sander Eikelenboom wrote:
> On 27/09/18 21:06, Boris Ostrovsky wrote:
>> On 9/27/18 2:56 PM, Jens Axboe wrote:
>>> On 9/27/18 12:52 PM, Sander Eikelenboom wrote:
>>>> On 27/09/18 16:26, Jens Axboe wrote:
>>>>> On 9/27/18 1:12 AM, Juergen Gross wrote:
>>>>>> On 22/09/18 21:55, Boris Ostrovsky wrote:
>>>>>>> Commit a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>> added support for purging persistent grants when they are not in use. As
>>>>>>> part of the purge, the grants were removed from the grant buffer, This
>>>>>>> eventually causes the buffer to become empty, with BUG_ON triggered in
>>>>>>> get_free_grant(). This can be observed even on an idle system, within
>>>>>>> 20-30 minutes.
>>>>>>>
>>>>>>> We should keep the grants in the buffer when purging, and only free the
>>>>>>> grant ref.
>>>>>>>
>>>>>>> Fixes: a46b53672b2c ("xen/blkfront: cleanup stale persistent grants")
>>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>> Reviewed-by: Juergen Gross <jgross@suse.com>
>>>>> Since Konrad is out, I'm going to queue this up for 4.19.
>>>>>
>>>> Hi Boris/Juergen.
>>>>
>>>> Last week i tested a linux-4.19-rc4 kernel with xen-next and this patch from Boris pulled on top. 
>>>> Unfortunately it made a VM hang (probably because it's rootFS is shuffled from under it's feet 
>>
>> What do you mean by "rootFS is shuffled from under it's feet " ?
> 
> Assumption that block-front getting borked and either a kernel crash or rootfs becoming mounted readonly. Didn't (try) to check though.
> 
>>>> and it gave these in dom0 dmesg:
>>>>
>>>> [ 9251.696090] xen-blkback: requesting a grant already in use
>>>> [ 9251.705861] xen-blkback: trying to add a gref that's already in the tree
>>>> [ 9251.715781] xen-blkback: requesting a grant already in use
>>>> [ 9251.725756] xen-blkback: trying to add a gref that's already in the tree
>>>> [ 9251.735698] xen-blkback: requesting a grant already in use
>>>> [ 9251.745573] xen-blkback: trying to add a gref that's already in the tree
>>>>
>>>> The VM was a HVM with 4 vcpu's and 2 phy disks:
>>>> xen-blkback: backend/vbd/14/768: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>> xen-blkback: backend/vbd/14/832: using 4 queues, protocol 1 (x86_64-abi) persistent grants
>>>>
>>>>
>>>> Currently i have been running 4.19-rc5 with xen-next on top and commit
>>>> a46b53672b2c reverted, for a couple of days. That seems to run stable
>>>> for me (since it's a small box so i'm not hit by what a46b53672b2c
>>>> tried to fix.
>>>>
>>>> If you can come up with a debug patch i can give that a spin tomorrow
>>>> evening or in the weekend, so we are hopefully still in time for the
>>>> 4.19 release.
>>> At this late in the game, might make more sense to simply revert the
>>> buggy commit.  Especially since what is currently out there doesn't fix
>>> the issue for you.
>
> Don't know if Boris or Juergen have a hunch about the issue, if not
> perhaps a revert is the best.

Anyone? Unless I hear otherwise, I'll revert the series tomorrow.

-- 
Jens Axboe

