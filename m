Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFD2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D6C219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6r1bmGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D6C219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbeHFMKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:10:45 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:42469 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:10:45 -0400
Received: by mail-lf1-f45.google.com with SMTP id u202-v6so8600492lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/kbcRTyRzhy9nQ1Hf9rCViAbPBoiJtiq4R8dsHsw5Y=;
        b=P6r1bmGp6Dqc9FbTNprL49y7djGWxKmcrIwGwtSx59nRHE/ZJLjI2+3QHoEWKFXB5l
         xIJT3kes8AVGyPHeK0LrZxBYqaoY+ttzgdw1kxoFQzgkN0NT+1M4J7oiTd9DUWxEVfqS
         7+ZdTuwZWUzZz4SLCje7udVkvcBcc3dytpBzEadMZhHz6j/mW2YBvsjv88G2Q7kx2HBQ
         eu3J4WcSPikisZJkjw5uWoPOkVbS3cjBhUuo6pe/h0WyUbzN+bYMShLYTBYaMRvTNDr7
         FLk0u5sBWt859q2v1QG0swDajKcGP4PyIrROXen73AdP1f6mwb1OcEnC4pSjrrxF6unL
         2fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/kbcRTyRzhy9nQ1Hf9rCViAbPBoiJtiq4R8dsHsw5Y=;
        b=Zi0Yk/3/ZTvJR00WmjIIoIU/gqYfrHL/jg+TFyO1YOa/cfwYOZpEEGkdUV1yaWw0wH
         vpyvNyqk7JmQgsmFswwyMS1h8Sl9Cmu5Pb23oiStFHPnEd6J7ADEcCF2IkwBO3Jsf5gY
         6nZV9F7nPDAk3ny482bILI0mekz6vUoE51/+jXwn0hK9IXs4HezOcd/BeDvijTQpd6Vn
         +pF/81k/IGJKU1CLDbzNp6GyR7zjv+Tz5MQoLJkh+mXzsQ/Gp67sWAfLdqoaiV/x2Hke
         8904+W0AqNRmq3sDoA56XNsmf76pC4rw2EQ3xlcaWm4clmAuU2T+8a9rAmyrOndF8pt7
         VMSg==
X-Gm-Message-State: AOUpUlFKvSJucyo7gPZu1Iid8SzW89esVlcSXgJhHSTcyqWvlQQTnJw2
        wLdWlKdSVgp0izvWn4MeTsnksJ0W0HlYMCxbxf4=
X-Google-Smtp-Source: AAOMgpeu42WY+HCrCa5fxO7n+Sl7JQ+C2YkTy0A9MHHEHKkYiWfiNWggROdroRPw8TahbmPESXsrXinr7UGzDtmZg3g=
X-Received: by 2002:a19:12df:: with SMTP id 92-v6mr10392495lfs.80.1533549744102;
 Mon, 06 Aug 2018 03:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com>
 <CAHCio2idn3oh55n7urkRPqkdyo+Y-0Qhg=Vc2VHXy2Wy2q1wiA@mail.gmail.com> <20180806060649.GA19540@dhcp22.suse.cz>
In-Reply-To: <20180806060649.GA19540@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Mon, 6 Aug 2018 18:02:10 +0800
Message-ID: <CAHCio2j-oH2v5xY9F=Naoj9ao4cYw+LP6kqi_GELafqJ4qB6iw@mail.gmail.com>
Subject: Re: [LKP] [mm, oom] c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
To:     mhocko@kernel.org
Cc:     Wind Yu <yuzhoujian@didichuxing.com>, rientjes@google.com,
        rong.a.chen@intel.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
Sorry, I cannot open the link you shared.
