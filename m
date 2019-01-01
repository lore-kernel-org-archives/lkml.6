Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5100EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCBA208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcfLjskb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfAATbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:31:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38776 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfAATbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:31:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so26244440wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kk0p4t86rAC+HUCgPTT8EGu3YWqIiZeKItVrgjxg82I=;
        b=LcfLjskbEc3HdqXj/MvSaY/j7O19ctQetCoQXQiyy1WHm4PTdj5cOg+I+uXO6LQd+P
         84gEF+nBKJYoNDqq04Jc3DCMNc0qU8JD7KcwC7zCmUXFBjAQOetrwmxcOrRAVvk2am1Y
         4jK2xTsbHqCo+gIXw0/XuObNkQR0rYu0jp/z59cxKz1h2Unm0YNMJwId7AM1+NEL6tdD
         k+tQ4uwfbkdGdkvZWRoGHCi72Wz7doFDsWLB7z43+3Sh5DxZQRFA+Boyv/dzhqDrG1vv
         1YJ8wIm2/nhPbJ8wU9qliog4/bmjb0TmkicQ30S/bv3MMidSMIWCcixB357pGaiB5s3m
         nJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kk0p4t86rAC+HUCgPTT8EGu3YWqIiZeKItVrgjxg82I=;
        b=mWKNcCCYFSiopP+dFFzwKcN+BQR5nmQYLIYWmBy2XkTLwWO1xiajT+Dz0hN4VCJXME
         rJ5T7BuVsimFNIdRWwc1hN4sivDpEaCni2PqoMMYF0O4PEuBf10i4Z/YcLTg0+vsbtlQ
         SkpLTj1MDSJTh9GWmaF8no7IdHcuMCvlS/1GUFBU5ImfdUFe4KkcWZ/uZZa+kvUOh33D
         nU73IIWLm9mjoh++RdHABjwsr0bHaW1KV6ZSJgf5EVvco/K3NrHGIWjlIiBg3WKNXM2O
         cWp9bLFS0pTfj+8Z3rB00aCRiRvVUHP/ZCQHBRdcimhRqgwqL1q03475eRlSFF+XJNlB
         y+ow==
X-Gm-Message-State: AA+aEWbo1dPeHCatubAOLghjJ4NOtGDQoEWicNd/mOT5RANPJZQZOJpA
        IeNDFZYuO4sfr1ZVzf65m5ryHipQ
X-Google-Smtp-Source: ALg8bN55bog+0fGpqtDWbDewuW7jHhL+D50jRBw+avCGth83E5O4X2Gfs53OuV33X2OBCcSdRY08kQ==
X-Received: by 2002:a1c:9a0d:: with SMTP id c13mr34709603wme.41.1546371093132;
        Tue, 01 Jan 2019 11:31:33 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1f23:d0c6:20df:6ac1? ([2a02:8108:85c0:3a84:1f23:d0c6:20df:6ac1])
        by smtp.gmail.com with ESMTPSA id o9sm28236756wmh.3.2019.01.01.11.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 11:31:32 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     insafonov@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <59368aca-c3d9-0563-aa83-118842834fb1@gmail.com>
Date:   Tue, 1 Jan 2019 20:31:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/19 3:17 AM, Larry Finger wrote:
> On 12/30/18 12:39 PM, Michael Straube wrote:
>> Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
>> is causing hardfreeze whenever the driver tries to connect to my wifi
>> network. That makes the driver unusable on my system. Reverting the
>> commit fixes the issue and the driver works properly.
>>
>> Dec 29 19:21:17 gentoo kernel: BUG: scheduling while atomic: swapper/6/0/0x00000100
> 
> Michael,
> 
> I have verified the freezes that you see. Although I have not been able to capture the console dump, I think we are likely seeing the same problem.
> 
> I do have a work-around in that I have not gotten any freezes when I force module lib80211_crypt_ccmp to be loaded before I load module r8188eu. This clue was used in finding what seems to be a good fix.
> 
> I do not know anything about demand loading of modules using try_then_request_module(); however, I noticed that the macro actually calls __request_module(), which has the following comment:
> 
>   * Load a module using the user mode module loader. The function returns
>   * zero on success or a negative errno code or positive exit code from
>   * "modprobe" on failure. Note that a successful module load does not mean
>   * the module did not then unload and exit on an error of its own. Callers
>   * must check that the service they requested is now available not blindly
>   * invoke it.
> 
> I note that it says "user mode module loader". Routine rtw_aes_decrypt() is likely inside some sort of locking, which leads to the "scheduling while atomic" bug that you see. As a result, I suspect that the module is not loaded, and that leads to the NULL dereference when the module is accessed. Please try the one-line patch attached, which forces lib80211 to load when r8188eu is loaded. With this patch, I have been connected to an AES-encrypted AP for nearly 3 hours with no problems.
> 
> Larry
> 
> 

I've tested your patch and it solved the issue. No freezes and dmesg looks good.

I noticed that try_then_request_module() is also used in rtw_wep_encrypt() and
rtw_wep_decrypt(). I guess that also could cause problems?

Michael


