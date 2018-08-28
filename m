Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787AEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097A42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="CfNzdGZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097A42054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeH1Woz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:44:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39403 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeH1Woy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:44:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so1114339pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 11:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8B2ATl4y/uUk1SoMfkts1pM4K+TG5KkfoizaC4L+/aw=;
        b=CfNzdGZe1ieXSXne+UO+o+xOAlX5aR5tyr0uKAT7e87+Qr90YzCIOSGM8XaWcEhsqB
         fnKK0ZTl/V/ndF/Vb938CpChwq+I2kboaciqfDgWqTw6vyPN0eEZojW4r8AtgVGVnhD4
         IOQwyjMXgmXhLmzpmSbeE9LiSJPlpXZKlHMtW00CceosDwQZvX3daM+LYwiZ/zq03nAD
         OUOF3yb2Fvs/OujnjBrdnBX96bJqtrPVODqZjlJ/pF0v2Bc6S33c1+xxH4fp1DiG2aWk
         K52h1QWtIT7LpEb0Wb9nsGzPnf7as9j93v1Bctz1oV2R/1aWoLRychJmoznC+vGXvcsS
         hRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8B2ATl4y/uUk1SoMfkts1pM4K+TG5KkfoizaC4L+/aw=;
        b=ClG2HY7mKo5RMrj+u/jPSYY8l/mcBDkJqB78xGB6qJ0W9BBfJlYN+aIdjxHEEKpYbA
         eR9x95R2a0FI6OYmLBWlQ6+W+d2o3r3ayPm/vmCTfVduesQVFH/bkcsJSHvfZtXvu96u
         ZxTTVfylstVxhb0RnmZyos6NiVBdbChLwcrZqfbc4RY1GxiArBCkB5lovhrO2Vrf5Vru
         nZOnI4oHBtomb8T3Y8YOkWBP9VIUwb/EwUd/e1HOP0aP7TZBNdYJZZawujRISRb8PIWN
         XCM503NyJ8DXa4TYMCDoMzODvLY4qbiZv001YWv1PIn08Iz4UvOiM8TGKDubmu7VMUkf
         aFNA==
X-Gm-Message-State: APzg51AVsNXqXr7eaR+8vq01jskwABySttwPgYyg7uoUOJwpHJmShnw+
        FkicXEVfs3WiXL0dlv2GtTHZUg==
X-Google-Smtp-Source: ANB0VdaZY7j+nDoVu+MmuHd4pR7RX52G+991tylNBCRvV3CycVTb1VYZ+frPbY6a7dPrDtOHabkvXg==
X-Received: by 2002:a62:5290:: with SMTP id g138-v6mr2749909pfb.46.1535482316667;
        Tue, 28 Aug 2018 11:51:56 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z17-v6sm3945943pfl.146.2018.08.28.11.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:51:56 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] overlayfs: check CAP_MKNOD before issuing
 vfs_whiteout
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20180828165319.211563-1-salyzyn@android.com>
 <CAOQ4uxhRPOC_prhygrjndMMUrtU-S7FrLJ0tb4eJUV94GFj38w@mail.gmail.com>
 <CAOQ4uxg=maKZi=5Xet4mC1=uUXftyyKZagj0TBBm8emPDaLmtg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <004057f1-f0cd-5410-e4e3-a17287613f89@android.com>
Date:   Tue, 28 Aug 2018 11:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxg=maKZi=5Xet4mC1=uUXftyyKZagj0TBBm8emPDaLmtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 11:42 AM, Amir Goldstein wrote:
> On Tue, Aug 28, 2018 at 8:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
>> On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
>>> Assumption never checked, should fail if the mounter creds are not
>>> sufficient.
>>>
>>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>>> Cc: Amir Goldstein <amir73il@gmail.com>
>>> Cc: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>>> Cc: linux-unionfs@vger.kernel.org
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>>
>>> v5
>>> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
>>> ---
>>>   fs/overlayfs/overlayfs.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
>>> index 7538b9b56237..bf3a80157d42 100644
>>> --- a/fs/overlayfs/overlayfs.h
>>> +++ b/fs/overlayfs/overlayfs.h
>>> @@ -176,7 +176,7 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
>>>
>>>   static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
>>>   {
>>> -       int err = vfs_whiteout(dir, dentry);
>>> +       int err = capable(CAP_MKNOD) ? vfs_whiteout(dir, dentry) : -EPERM;
>> Should that be ns_capable()? Should the test go into vfs_whiteout()?
>> I feel there is no convention at all.
>>
> Nevermind, I don't think creating a whiteout poses any risk, so don't think
> we need to worry about CAP_MKNOD.
>
> Thanks,
> Amir.

Ok, will discard from the set, we can address this later if it creates 
concern (as in, not a dependency to my proposed feature flag). So we 
feel that whiteout node in the writeable playground of workdir/upperdir 
is not in itself a security concern. Other (more dangerous) mknod will 
be checked against the caller's credentials coming in.

-- Mark
