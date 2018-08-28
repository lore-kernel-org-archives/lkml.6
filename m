Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07E8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEEF20897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vTy7YO+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEEF20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeH1Vg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:36:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42072 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbeH1Vg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:36:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so1027958pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nDhr+vu6VrpKF/O/niWP0ALlmNa4+hqr7LQrPx0QKUc=;
        b=vTy7YO+OzhyFLcSgFC+7Ioflzd0Ye2VGXrRKrnb59AEv1jGva72S7ITTXA4samPkQQ
         cGLWo7NgL8ru71+tQn65dQcd0BIrHZvxTto6Rm2J3FflXtHbeetuJtYOrAUMQm2HFldu
         yoaFe0V8kqGQvAozoSppRRC1JuIVM7V48ugzXUF3KTc0SEqzwRSHWDAQg4q9HmtGt0C/
         y8ydSUHk+fMXsGyt2Z6ZYnCfkhAbWGBG52H/W4OlYwlq2szLP4WDSV9OcXJu1zbpfdAC
         pmYMpFXY7C/NyB+kDCYyabP9tiyo5lv6u18vNCd+AmKsgH48q8pBn9pCZkDEw7NSwhF6
         0RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nDhr+vu6VrpKF/O/niWP0ALlmNa4+hqr7LQrPx0QKUc=;
        b=I+XEMWSorEUxwrj/C4A+bsCGx3nE0iGDbvD6fyfycMCqjODiuwZPidqhgajxLn6pqF
         CLjIi1flAO38Nq7P4PRrCotT8PDooK/U6j7/5pCsmWoDF2WJWCGWec1q2cR7szDsqhPF
         fktWkLOimSnmJw17FCyNG/4K4Fvbe8rFPpAkbJJ17gGLaBlkq7KrEUIkNn2fQVbGzbOK
         nULh0Ga7ZXm/oWH9Kf4l8gm/jpWOdTr0lMRCqm72gB5iyxzSwkEKVSShUIgXDnOJ5eEx
         ZJeBXgeqad9j6nKuwzWX8yXJOjbGEhJct+7Yk8O+09qbPoVVKc7brPr+QEQY3C7Ag3G9
         A+WQ==
X-Gm-Message-State: APzg51C9MU8OaYDxIZyQ2AyCO270bfAfpM8RFFgMqdT53+mR4VUNFRBI
        PhSz0NFIq0LgPFtfuShPYJ214g==
X-Google-Smtp-Source: ANB0VdZhq8zYCpitetRqGs9QLGklDvENzXFXZPHO+TsklgAo3te7J5w1VuPlDoQ8RIeQkvd8L5ehkg==
X-Received: by 2002:a65:4384:: with SMTP id m4-v6mr2443239pgp.265.1535478252725;
        Tue, 28 Aug 2018 10:44:12 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id u1-v6sm3226854pfl.187.2018.08.28.10.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:44:12 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] overlayfs: check CAP_DAC_READ_SEARCH before
 issuing exportfs_decode_fh
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
References: <20180828165259.211474-1-salyzyn@android.com>
 <CAOQ4uxgwKe7_QC7Rg=BTQ_WvnAm+-kSh0LXWGVOoHHAqJt3aXA@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <7998ae36-662b-91f7-c42a-8a4d35d333c1@android.com>
Date:   Tue, 28 Aug 2018 10:44:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxgwKe7_QC7Rg=BTQ_WvnAm+-kSh0LXWGVOoHHAqJt3aXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 10:34 AM, Amir Goldstein wrote:
> On Tue, Aug 28, 2018 at 7:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
>> Assumption never checked, should fail if the mounter creds are not
>> sufficient.
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> Cc: linux-unionfs@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> v5:
>> - dependency of "overlayfs: override_creds=off option bypass creator_cred"
>> ---
>>   fs/overlayfs/namei.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
>> index c993dd8db739..84982b6525fb 100644
>> --- a/fs/overlayfs/namei.c
>> +++ b/fs/overlayfs/namei.c
>> @@ -193,6 +193,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
>>          if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
>>                  return NULL;
>>
>> +       if (!capable(CAP_DAC_READ_SEARCH)) {
>> +               origin = ERR_PTR(-EPERM);
>> +               goto out;
> Which branch is this works based on?
> I don't see any out label in current code.

<sigh> I can only truly test this on 4.14 (android's current top of 
tree) and on Hikey with that. Lack of due diligence for Top of Linux.
>
>> +       }
>> +
>>          bytes = (fh->len - offsetof(struct ovl_fh, fid));
>>          real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
>>                                    bytes >> 2, (int)fh->type,
>> --
> Please add same test in ovl_can_decode_fh().

Ahhhh
> Problem: none of the ovl_export_operations functions override creds.
> I guess things are working now because nfsd is privileged enough.
> IOW, the capability check you added doesn't check mounter creds
> when coming from nfs export ops - I guess that is not what you want
> although you probably don'r enable nfs export.
NFS export/import blocked on Android devices.
> Thanks,
> Amir.


