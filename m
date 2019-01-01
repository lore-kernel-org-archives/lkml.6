Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03484C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2BA2171F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dts5fE7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfAATpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:45:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34905 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfAATpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:45:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so14192981wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 11:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wi2VaZ93NAj1XEIFe4Er8nHv1GWc0zEzcdIIZgeLyA=;
        b=Dts5fE7JixS0DCIjP3ufJyIPIosrqNFjKt66wabVEdfWN+N9NHuaHip/wMojcXJcg+
         LpCFTbcoh71guSDQAan40mmEq2nznRuA/Vh9kH4IZeD2KOXwVRop1L15ZXRNEtFUtDhQ
         QAvWQyRAtx/XAMcHWjQdofYS2e2VJH3aaGfGWQVFUom25N50I5iGyvqi7CMS8UTsZQoX
         y/II2Z9uEfwIoEHhYiWmrRRlRfaBti+3YuE2QhiXCTe/ykQx3KyAIjvnZG7dXMu44h3U
         PX2bvXMIkuqTkcsatZRgY8S58hQ8pAeDjzJSEBBqjJbkQh8M1z0eJnnr4mewIhioMNLJ
         W1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wi2VaZ93NAj1XEIFe4Er8nHv1GWc0zEzcdIIZgeLyA=;
        b=AZZY9kEVrDCknaR/S78VEpQqECCuZDiRE1sDAGF8/XJbX4O1BMM+1UCWboq+qBlUGt
         SMZ/SSVA4c6YwIuvI+rC1fUem9OtFI8POrcTeFSvOZ6F9QwIF3iTpF/ykY7pXGdZ1HmM
         m0m+XTrkgwevUbTrt3t9qpFfd6knFOMsyQMvQ8yifzQQPu3Drsny1cMLe2m0mik/vfqA
         lfNhLXMe9lY+HW0fuVrze8lG/D93IC1lcJhzK/PYvqrwFgUxLRpsW4COgTOTuzv1+SxL
         2ORdzlum7lJzgfPRAUA4YP63dJUcPfSO7bYHjblqg7J7guIVA2TJkEtQSkO1IFCdcrrJ
         +dHg==
X-Gm-Message-State: AA+aEWaG67PMKQkOOWFITeEQMhaBuCo2e10tw5HmzfQxkWomaOSt1oxA
        2pHTQmQ9S5eaDEZ6cP7+hqx2FHrl
X-Google-Smtp-Source: AFSGD/XEI4L52g2Sn/MI7Ei4ppYkkXtvOZ4tSBQ11buYuaNmsCBofTFc8y5NpG09Au/3lzRzreqZMg==
X-Received: by 2002:a1c:1801:: with SMTP id 1mr36266412wmy.153.1546371937742;
        Tue, 01 Jan 2019 11:45:37 -0800 (PST)
Received: from ?IPv6:2a02:8108:85c0:3a84:1f23:d0c6:20df:6ac1? ([2a02:8108:85c0:3a84:1f23:d0c6:20df:6ac1])
        by smtp.gmail.com with ESMTPSA id n5sm40915518wrr.94.2019.01.01.11.45.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 11:45:37 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Ivan Safonov <insafonov@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
 <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <f36f6d59-0737-6fcd-8189-068bd308f32b@gmail.com>
Date:   Tue, 1 Jan 2019 20:45:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <4dd17d38-8c4d-b5db-1091-edba0d95cadf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/1/19 10:02 AM, Ivan Safonov wrote:
> I suggested a patch for loading modules from interruptible mode, but this patch remained unclaimed ( http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124851.html ).
> 

So with these changes try_then_request_module() would work properly?

> For some reason I thought that this patch had been removed and did not track the fate of this code ( http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124573.html ).
> 

I reverted that patch (there are conflicts meanwhile) and removed
try_then_request_module() in rtw_aes_encrypt() and it looks good.

Perhaps the same applies for the reverted TKIP changes?

Michael

> On 1/1/19 5:17 AM, Larry Finger wrote:
>> On 12/30/18 12:39 PM, Michael Straube wrote:
>>> Commit 6bd082af7e36 ("staging:r8188eu: use lib80211 CCMP decrypt")
>>> is causing hardfreeze whenever the driver tries to connect to my wifi
>>> network. That makes the driver unusable on my system. Reverting the
>>> commit fixes the issue and the driver works properly.
>>>
>>> Dec 29 19:21:17 gentoo kernel: BUG: scheduling while atomic: swapper/6/0/0x00000100
>>
>> Michael,
>>
>> I have verified the freezes that you see. Although I have not been able to capture the console dump, I think we are likely seeing the same problem.
>>
>> I do have a work-around in that I have not gotten any freezes when I force module lib80211_crypt_ccmp to be loaded before I load module r8188eu. This clue was used in finding what seems to be a good fix.
>>
>> I do not know anything about demand loading of modules using try_then_request_module(); however, I noticed that the macro actually calls __request_module(), which has the following comment:
>>
>>   * Load a module using the user mode module loader. The function returns
>>   * zero on success or a negative errno code or positive exit code from
>>   * "modprobe" on failure. Note that a successful module load does not mean
>>   * the module did not then unload and exit on an error of its own. Callers
>>   * must check that the service they requested is now available not blindly
>>   * invoke it.
>>
>> I note that it says "user mode module loader". Routine rtw_aes_decrypt() is likely inside some sort of locking, which leads to the "scheduling while atomic" bug that you see. As a result, I suspect that the module is not loaded, and that leads to the NULL dereference when the module is accessed. Please try the one-line patch attached, which forces lib80211 to load when r8188eu is loaded. With this patch, I have been connected to an AES-encrypted AP for nearly 3 hours with no problems.
>>
>> Larry
>>
>>
