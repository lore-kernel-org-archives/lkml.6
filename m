Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C78C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE521927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTBomzCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391451AbeLUS1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:27:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38869 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbeLUS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:27:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so6223951wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8+w9t5OKE0FQ9muwd/s67DyosSXruezMRXngmK6X5VY=;
        b=fTBomzCP9w77wF7GjosVOBTekzPGdiixyaK+hKfkbMcHPh3fawWx/CrUTFn4unP/+h
         wUBbDuVc4Hs/xFDpMhzXidbGY5zkEYTupArJ+K72zaoSfcgUK9dkPcmVeGkrJFh5Jzpb
         clfL8Pp3uOkX/55POJdYDF0Rb+Ss2F7peD00FYBnhRnHljnI/clGm3PIM4fupIYsf0Lj
         pLZN/b5xqOYdLwFUqsYI++2Hf5WosqP/3XmhZmDFhi/ryyfH6weA/lyc7gL+KmpAt0J/
         hmgZNnBQBt3wkY61k8DBibt9sS860+gtHaJ+noF0JGy+d1ulQXmfSJ8fskSd3DgsSJ5m
         GNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=8+w9t5OKE0FQ9muwd/s67DyosSXruezMRXngmK6X5VY=;
        b=kVLf9Z430qikePsCI8l5fG2+ZqghqspwCMxH5KcLOeUPbeg3w4mFGWwuhBMi+Wvn3q
         FauJTnvqPIqpHxdO7kIuQkIDa4vykoX0zVFrjXVaE/ooREZfRHRDuAquRnEXAA0rn8/R
         V5VUGazqhMLJMjodPmVSx5p0QCUzRbmu2EsOTBW9ltUH3g5lS1v0LE8oSsFIBvtWcHek
         /kaPvx6uN5T1qm8hhBaUsoMjxehvYVcx5Q87LnT1JuQtS70VNXeNOZdwFoplVz6ylKku
         vnzl2Ru9dbA1YuhSvGqLIgIRPgyxhqpFA/3EcoWTfQWGuwQabSo3kzQSJ86s10rUcVDo
         pRFA==
X-Gm-Message-State: AJcUukeZdq1kzIqVwgx8iek6FwIDsYNVEwIhi8ksC+3js1CRSAY3Ahpd
        uyNWmkoyQ1sgMvqxFOcz7SE=
X-Google-Smtp-Source: ALg8bN69Dqt1NwRzblzixefkuE4pRIAVIUd13x2jRI5ARUA71u1bt1rWbGhG0NbJjwUS+Yh1JSb0OA==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr3599756wra.282.1545416825308;
        Fri, 21 Dec 2018 10:27:05 -0800 (PST)
Received: from ?IPv6:2a02:908:125b:9a00:a142:2be6:b7be:5a3a? ([2a02:908:125b:9a00:a142:2be6:b7be:5a3a])
        by smtp.gmail.com with ESMTPSA id 199sm14765520wmh.21.2018.12.21.10.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:27:04 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/2] drm: Revert syncobj timeline changes.
To:     Dmitry Osipenko <digetx@gmail.com>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Jason Ekstrand <jason@jlekstrand.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20181108160422.17743-1-eric@anholt.net>
 <20181108160422.17743-3-eric@anholt.net>
 <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fadfc03c-7f80-216b-299f-27a1d8d7877b@gmail.com>
Date:   Fri, 21 Dec 2018 19:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <faf15d58-a076-49fb-c903-15acdf6f8ffe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.12.18 um 18:53 schrieb Dmitry Osipenko:
> [SNIP]
>> @@ -931,9 +718,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>>   
>>   	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
>>   		for (i = 0; i < count; ++i) {
>> -			if (entries[i].fence)
>> -				continue;
>> -
>>   			drm_syncobj_fence_get_or_add_callback(syncobjs[i],
>>   							      &entries[i].fence,
>>   							      &entries[i].syncobj_cb,
> Hello,
>
> The above three removed lines we added in commit 337fe9f5c1e7de ("drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set") that fixed a memleak. Removal of the lines returns the memleak because of disbalanced fence refcounting and it looks like they were removed unintentionally in this patch.

That was already fixed with 61a98b1b9a8c7 drm/syncobj: remove 
drm_syncobj_cb and cleanup.

This cleanup removed all the duplicate checking and is now adding the 
callback only once.

Regards,
Christian.
