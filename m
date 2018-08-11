Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E1C46464
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9C522402
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ExkWi+Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9C522402
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHKFXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:23:03 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41626 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeHKFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:23:03 -0400
Received: by mail-pg1-f179.google.com with SMTP id z8-v6so5178005pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hnzYgA6uCwW08Ug9p00hDteCJhVAynNSJJOUtsY8aP0=;
        b=ExkWi+KnOI76hi36jb9qEcO63Qxdq9XY0ZDeElrNwKPrZ9oUEqXmScUmoD93GM6sy8
         iEk3zRVDpEeQNV84DDtaeOfatorUK7FNFcwMYu8jEBECXTAxb3svMvA9sKXIYx+jpDvD
         VgRe3WPnsBPDiV+ZC6+TknXit6c/CXBk4UpNIDobd08XsL1mLPVBU8bwZ9rr+fz3o5I8
         4uv5mNXuq0qK9qvTa4JqkjbNbVZH39WAWkdTyJfcReRx9C6XeyYT5V4cyBtGXFXK8J1i
         XjkDNSwggZgW0w5mraGViTGc9LIL+nEA5juZnoYvgxoX8UI+58Epl5MZRtFuE3XqcOdN
         UcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hnzYgA6uCwW08Ug9p00hDteCJhVAynNSJJOUtsY8aP0=;
        b=cyzqEOmbzRQcTNzbHpB/HSM1OasbiUpYkwn9DiDgjOcZskE8TuPr5E7Ut5thRZi6Gw
         6dbwAsS8ZZIHvNeBVfkoUvZzSjUdXhi6OylE9PdLDQQqfl3pgj3r/nv+1ZVI1++qrhup
         +rhM9SokjpYw8kuyJb2z5fe+1O1x0OeS6h7JjmuouuBl4qGLyGl5ao53jCzPTkyyHPqA
         9lPGEvY+dKZB8qUngUd0zcBfN0YcdPf5R7zT5PKFSqHaVNkObDiANRhRq1mO8HScIi88
         OywwfA8mj7gwp7e2nKS7SyaYEnZBvYCQaEv9fIKBLlNW9n15drNHnPoa2qTQubWrC0Hg
         XiUQ==
X-Gm-Message-State: AOUpUlG/c2GURC4s4RuYvnzxWICj3T0DU/AaaSKb+KuUu4B/hfeB6Hi7
        fQXDXGVa+f9REDDhXKTwj0IlBA==
X-Google-Smtp-Source: AA+uWPx947n63KO3xBOYclfMs8WtAki2RSkIR9MlEpy+ys+PgWnfQpFLaEDYxxHTssnSVUaIECHKfA==
X-Received: by 2002:a62:b29c:: with SMTP id z28-v6mr9689604pfl.8.1533955831092;
        Fri, 10 Aug 2018 19:50:31 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id r81-v6sm16674925pfa.18.2018.08.10.19.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 19:50:30 -0700 (PDT)
Subject: Re: [PATCH v3] f2fs: checkpoint disabling
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
References: <20180807234843.129387-1-drosen@google.com>
 <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
From:   Daniel Rosenberg <drosen@google.com>
Message-ID: <8fa37886-7eef-edca-ea14-9d3465efaeac@google.com>
Date:   Fri, 10 Aug 2018 19:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 01:40 AM, Chao Yu wrote:
> Hi Daniel,
>
> When filesystem is full, statfs shown abnormally as below:
>
> /dev/zram0       2095104 -17177769548 17179864652    - /mnt/f2fs
>
> I guess it's related to this patch, could you have a look at this?
>
> Thanks,
>
Thanks. It looks like I failed to check if we're running with 
checkpoints disabled inside of update_sit_entry when I updated the 
stats, causing it to underflow. I'll fix that in the next version.
