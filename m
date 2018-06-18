Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2508C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B8420693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LIKVx/m4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755463AbeFRV7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:59:54 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:41687 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755428AbeFRV7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:59:52 -0400
Received: by mail-pg0-f44.google.com with SMTP id l65-v6so8148523pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=79n1tUuaYmM9U6OjAavQWDOuLnRp4swwEURkasBbUV4=;
        b=LIKVx/m42SCmiCgayRNZj2ILTsJwjfegbSjFM9rr6BKbCcg29rRDpjskHXKW0kSE5h
         ifSL/pxZhx0twdbFf6Jb2inHHJk0AqUmzG0vwNhI7wfGkM9s2Z3JCFmM0iV7HBIu7Qk6
         EPFddb4rQXyLUjzGBWrZdz1470P6kRfOsW2wismxqu1EuXWkdxBWFJxTIlQcOVguW4kX
         jqFaOiRfdBZeu8bfH0gpRPG5PMP6VRtb2nBe4gHIjDCuzQSvp6Th7y6fGjK/J+KXilRU
         yQafbZnLKK8eZ+KC0pIFuLZTRZ51MFOz7LbKc5hcw0A4rkyCZ4CaZED6R+ItjuxmcGiN
         Zz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=79n1tUuaYmM9U6OjAavQWDOuLnRp4swwEURkasBbUV4=;
        b=K6RWP2sEYHngUZkEe1LDqRPjAionfHCd+wR/+x5yV8Xk0buhQiY5ES+f4oPhWwz8N1
         2iDfaBR+WULvfIjSH1pZKCRSPQQgpvuCYJTqKg4aueZMP64mwFXy5fyvxwnJ4L5UM17w
         lC316TAlduU4HY1At/eCatBgimdHtJbmxO3A1BBFPwqGXInWgyNhMiFbToOHGVws8ijd
         s9/Pp8b0LvhFbDXedeFbA6Lf78LuImYRpQ4dLo74uW8fq9iUtbapfm24ykJdOJvFBSLo
         xobH0yXu+7ywQX6H878L5Ix6kgxvxH8pGomxph+uyWircufPv1nvjJIm0LnGYlaYXWN3
         TrmQ==
X-Gm-Message-State: APt69E26QPy3YMuFDNy3wspdhkeevL2j6NuqpcXxnb73vxhMqStJdfyL
        Toa7B2WRjFdO6DpDudLnpAxy8A==
X-Google-Smtp-Source: ADUXVKJRgAw2UtR/xzQD8g/jUS5r/TDfolV655oIxLXqjydUebdcft5x+V2Xp8CIqYUkeJWztbZ8pw==
X-Received: by 2002:a63:780b:: with SMTP id t11-v6mr12371680pgc.91.1529359191600;
        Mon, 18 Jun 2018 14:59:51 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id y10-v6sm22234771pgr.44.2018.06.18.14.59.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 14:59:50 -0700 (PDT)
Subject: Re: overlayfs: caller_credentials option bypass creator_cred
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org,
        Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
References: <20180618154222.19279-1-salyzyn@android.com>
 <20180618185448.GA8749@redhat.com>
 <f141f883-0dbd-10ea-83b9-a1b38119b0c5@android.com>
 <20180618194345.GA15973@redhat.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <aecdeaca-74cf-54b1-3ea9-4751972074f5@android.com>
Date:   Mon, 18 Jun 2018 14:59:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180618194345.GA15973@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 12:43 PM, Vivek Goyal wrote:
> Will it be acceptable to write security policies in such a way so that
> mounter has access as well.
Unfortunately No. Policy of minimizing attack surface for a contained 
root service (init in this case). Just because it can mount, does not 
mean it can modify critical content; an attacker could use this to open 
a hole.

> Current model does assume that mounter has privileges on underlying files.

Only ones it appears to need is the workdir AFAIK, had to add ability to 
create in the <wordir> xattr in order to enable r/w mounts later. 
Although not all corners were tested, I did not see any copy_up issues 
b/c the caller had the privs in the Android security model when mounted 
with this new flag.

-- Mark
