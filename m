Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1C4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61E8204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZKK+4RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61E8204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJQWvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:51:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55031 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbeJQWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:51:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so2332063wma.4;
        Wed, 17 Oct 2018 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bVSv5kvJGnsBnF4fTs51dmvQZ2ELFeKwYI05LDwB3bc=;
        b=sZKK+4ROFe8mBPRRhH3O5tTj/eEB3tkmZa8DIoOy+frQt4gK+nRFmBqz7FpzLrijhN
         0ce+1He/uWzEd68bERcKIWJ2W8163OP0R+A6JUSsnXiFtP7rGJsIUTkHobftDDBUHCLN
         5HIk5UCHVie4xJtyBOdu9NLX3UOZkzf3lzAMqa0MGwA+tlxuw8U89oKsB61SKY1iIF9C
         P5ww5kqtr9fyMzQ3R0v4gkymSVDpOvGkT872Pj+/tYCY1i+lMC0juFz5uUh9+QSCuu06
         +9pbr/q8qYuofvBWhDdFt6BJOTjXTrKqEJMKkCyDvokNrH1Z9iirV4E5pAZEYneYv3AV
         m1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bVSv5kvJGnsBnF4fTs51dmvQZ2ELFeKwYI05LDwB3bc=;
        b=YIBEiJvjvcGB5fDjXigoo/x1JJh97W+Twz3oJGJKZXYtVNnsvvMESRSmDz7DBqfIQT
         KPsHnXhFbdR1W39EZNJ1ENVd3tb6RZRwhy/p1+vqh7V8ERpz5lL27hSsYNBB+5KLl//g
         ukoJt0CPV3pU29ptMCGfhUdGlvjoZID80dazZoRtqgwpOSpkMH6ciQL2zSn8ju29aLQJ
         jV1/NqlKTP4p8fX0PqjAH6/jnTViytvFdnmoxMoHqy0jil+JQa7l3FDGUdcsIm+KVisl
         KAfzllUrCKGSfFi2vU+1TqV6zAkCa25PRx73OOZ0Bz9MTmc4Yl9k1gU8Hoso+JX6ENG4
         shwg==
X-Gm-Message-State: ABuFfohAPyhqJGo8qh5xCEJiucVDKzNAp2J+6FfMQXsNRbVG9h6ANrAg
        8tw68dMV9TuK2M9ZsIz32bcfyRlREYM=
X-Google-Smtp-Source: ACcGV60R7mDfHwAYhkl7w9QDt5rNlTaP16YQGH16jhyvu15ho/2fXAvUn86ZA9OGAW64D0DoosNl+g==
X-Received: by 2002:a1c:dc42:: with SMTP id t63-v6mr3229264wmg.17.1539788113311;
        Wed, 17 Oct 2018 07:55:13 -0700 (PDT)
Received: from [172.16.1.192] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id d6-v6sm11002486wro.72.2018.10.17.07.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:55:12 -0700 (PDT)
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <19866.1539782101@warthog.procyon.org.uk>
 <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
 <20181013061141.GR32577@ZenIV.linux.org.uk>
 <28710.1539782412@warthog.procyon.org.uk>
 <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com>
 <87woqgiqta.fsf@xmission.com>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <8f5cf2a3-c522-d0b8-1257-1814e8149956@gmail.com>
Date:   Wed, 17 Oct 2018 15:55:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87woqgiqta.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2018 15:35, Eric W. Biederman wrote:
> Alan Jenkins <alan.christopher.jenkins@gmail.com> writes:
>
>> On 17/10/2018 14:20, David Howells wrote:
>>> David Howells <dhowells@redhat.com> wrote:
>>>
>>>> I should probably check that the picked point is actually a mountpoint.
>>> The root of the mount object at the path specified, that is, perhaps with
>>> something like the attached.
>>>
>>> David
>>
>> I agree.  I'm happy to see this is using the same check as do_remount().
>>
>>
>> * change filesystem flags. dir should be a physical root of filesystem.
>> * If you've mounted a non-root directory somewhere and want to do remount
>> * on it - tough luck.
>> */
> Davids check will work for bind mounts as well.  It just won't work it
> just won't work for files or subdirectories of some mountpoint.
>
> Eric


I see.  Then I am still happy to see the fspick() check match a check in 
do_remount() (and it still solves the problem I was worried about).

I cannot blame David for the do_remount() comment being out of date :-).

# uname -r
4.18.10-200.fc.28.x86_64
# mount --bind /mnt /mnt
# mount -oremount,debug /mnt
# findmnt /mnt; findmnt /
[findmnt shows / has been remounted, adding the ext4 "debug" mount option]


>
>>> ---
>>> diff --git a/fs/fsopen.c b/fs/fsopen.c
>>> index f673e93ac456..aaaaa17a233c 100644
>>> --- a/fs/fsopen.c
>>> +++ b/fs/fsopen.c
>>> @@ -186,6 +186,10 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>>>    	if (ret < 0)
>>>    		goto err;
>>>    +	ret = -EINVAL;
>>> +	if (target.mnt->mnt_root != target.dentry)
>>> +		goto err_path;
>>> +
>>>    	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
>>>    				0, 0, FS_CONTEXT_FOR_RECONFIGURE);
>>>    	if (IS_ERR(fc)) {
>>>
