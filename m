Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC35C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCDF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 00:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/Jw3cEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCDF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJPHv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 03:51:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37658 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 03:51:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id u6-v6so7320354plz.4;
        Mon, 15 Oct 2018 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7DXUw+6tWXE43ycSc3f1E1c1XVxf0qrjSnoAEn6qcss=;
        b=Y/Jw3cEs7pUWgKUELEXfv+nAfs08aNM5kKFX7JxUB0To+JiEoq2OKRIlVy501XzurS
         JMWv3r+yeGGOV97gl2iNauVZH73t8V4vQbn/KWAVfP4515C8ZxoGcVVi07cmI/ReFbUi
         +MLyYwxUxWYKM6aJFMLgdVZokPErNKQ+2GE4mQkRwQvDHxkepix5dk80u/QhK7H92flY
         4vDmWBQdeP5D9/hZ9mCZW7jrMu9pPgMxbTgFVTHriGA3qXiKIC9UGJjMIrEJ3EkGW9uL
         SPP6OKpPPjR8qZaI9mD3p9TqRIWbpAiKpkj/DO81101a9bE9tC583N3YYBZuo8v4yyvZ
         9ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7DXUw+6tWXE43ycSc3f1E1c1XVxf0qrjSnoAEn6qcss=;
        b=VDCyOk3SIakenAdb50vcFwsGJluOpCeTuPQOOBFpPqt2wwPx4dxlMq3lA0/QBaOjsd
         qotbdmEwTSLbSI7xM00pStpepVpEFQXKf1X0U613DbQXDnFyJ8GLYfSF2Y7JbqfseG7C
         LHSGbFTFS4Sjf7UfguqcL7maX/IjHlBGCqg0m7X7SFLVnCbHMK/X8rhyNd/M7iM8kSpo
         nS6aSqm3Z2fGUgEavPwuZ9deVC7YrCLSdmjtaHU5HCwvh8sZUJfaNeXALJQxZ0sMLGNY
         mPLAk7zwTxDr+5OLJL/rvVVg4S4qyFzHLodcEiqdALkPOwLsDJ1rwXUe2wvWQhrCN/EA
         J09w==
X-Gm-Message-State: ABuFfoi6s/89zLnV4iQF7L1i7iKnl6eQgpgwL1RBqcu8L5cK1IB7vAmf
        lHEP9MkpzgrBnrvvJd2Pm8I=
X-Google-Smtp-Source: ACcGV61MIoHDtMNIozhxWvaTC9TAFG5Zy1wdrNRdj0hF+/gEJw/S5HL6mVLhFf3yXHPemQm9H1PbYw==
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr18821528plj.121.1539648265072;
        Mon, 15 Oct 2018 17:04:25 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id o62-v6sm14980232pfb.0.2018.10.15.17.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 17:04:24 -0700 (PDT)
Subject: Re: [PATCH] of: overlay: user space synchronization
To:     Alan Tull <atull@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1539567282-1326-1-git-send-email-frowand.list@gmail.com>
 <CAMuHMdXad2g5zEZ8=XzzVgfijcatKYj5AjwVQg=W-by_rHfcAQ@mail.gmail.com>
 <e69685d5-e09f-5f7d-2ff0-7ead12500371@gmail.com>
 <CANk1AXQU=3Ap=wbO5b8c2pMq61hzuRkeWYNv2Esq+c9d+0e_BA@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3635be33-7301-ecd5-5966-24b0494771ef@gmail.com>
Date:   Mon, 15 Oct 2018 17:04:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXQU=3Ap=wbO5b8c2pMq61hzuRkeWYNv2Esq+c9d+0e_BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 13:38, Alan Tull wrote:
> On Mon, Oct 15, 2018 at 1:09 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/15/18 01:24, Geert Uytterhoeven wrote:
>>>
>>> Please say explicitly that tree_version contains a 32-bit unsigned
>>> decimal number, which is incremented before and after every change.
>>> I had to deduce that from the code.
>>
>> Good point.  I'll add that.
> 
> Looking at the code, tree_version being odd or even means something.
> tree_version is incremented every time the of_mutex is locked or
> unlocked, such that:
>  * tree_version is odd  == of_mutex is locked and the tree is
> currently be in the process of being changed
>  * tree_version is even == of_version is unlocked again and the
> changes are finished.
> 
> How about making this explicit in the interface by breaking it up into
> two attributes:
> 
> /sys/firmware/devicetree/tree_lock == "locked" or "unlocked".  If the
> tree is locked, you know that the tree may still be changing and the
> sysfs can't be trusted to be stable yet.  Or maybe even more
> specifically tree_overlay_lock?
> 
> /sys/firmware/devicetree/tree_version = a u32 that is incremented once
> for every overlay added or removed.

I like the extra clarity of purpose that having two attributes provides,
but it makes the user space dance more difficult.

With a single attribute, the shell code is (updated from the patch
to remove the variable "version"):

	done=1

	while [ $done = 1 ] ; do

		pre_version=$(cat /sys/firmware/devicetree/tree_version)
		while [ $(( ${pre_version} & 1 )) != 0 ] ; do
			# echo is optional, sleep value can be tuned
 			echo "${pre_version}  tree locked, sleeping"
 			sleep 2;
 			pre_version=$(cat /sys/firmware/devicetree/tree_version)
		done

		# 'critical region'
		# access /proc/device-tree/ one or more times

		post_version=$(cat /sys/firmware/devicetree/tree_version)

		if [ ${post_version} = ${pre_version} ] ; then
			done=0
		fi

	done

With two attributes, the shell code is:


        done=1

        while [ $done = 1 ] ; do

                # the order of the next three lines must not change
                version=$(cat /sys/firmware/devicetree/tree_version)
                pre_version=${version}
                tree_lock=$(cat /sys/firmware/devicetree/tree_lock)
                while [ tree_lock != "unlocked" ] ||
                      [ ${version} != ${pre_version} ] ; do
                        # echo is optional, sleep value can be tuned
                        echo "locked, sleeping"
                        sleep 2;
                        # the order of the next two lines must not change
                        pre_version=${version}
                        tree_lock=$(cat /sys/firmware/devicetree/tree_lock)
                        version=$(cat /sys/firmware/devicetree/tree_version)
                done

                # 'critical region'
                # access /proc/device-tree/ one or more times

                # the order of the next two lines must not change
                post_version=$(cat /sys/firmware/devicetree/tree_version)
                tree_lock=$(cat /sys/firmware/devicetree/tree_lock)

                if [ ${tree_lock} = "unlocked" ] &&
                   [ ${post_version} = ${pre_version} ] ; then
                        done=0
                fi

        done


The two attribute example is untested, could have syntax errors, etc.
I'm also not sure that the logic is correct.

My opinion is that the extra shell complexity makes the two attribute
solution worse.

-Frank


> 
> Alan
> 
> 
>>
>>
>>>
>>> IMHO that is more important than having the sample script here.
>>>
>>> Gr{oetje,eeting}s,
>>>
>>>                         Geert
>>>
>>
> 
