Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E6FC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3286920835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvBRjetS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3286920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJMRVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:21:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeJMRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:21:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so15880796wrw.12;
        Sat, 13 Oct 2018 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5zoa/6o2NMGwyWnXNc+7JnTarUKk9/4IQ4KcNFli70U=;
        b=EvBRjetSAlKOg55fxap2dH3++ie+mr5C5cfKhzJlidDN0aE1CyNduNYQbP3Gu+oJdD
         H54jNdsm7Y3FWgUnJaB3VADuXG43ADhwx5Sm4pDaSrbHr3tRBZXfBCPakGn/l0wWP8y1
         muk13TaAN2yWsx5leJ8P/kSlv5rbQC3vZFYfjTdBCrBNqpqy/cpyXCh7mxV9XWHyTp3K
         TuX1iuqH0eNWV9X13NCSut+QqgUmFRcphIA3tMD6/37zK/3uN0unwk5YWHvraTBOwHxY
         1Lg9Uudeb/hg95OGNJsg+Vz+cBmsoxY45y88jpnKXzAeXLXZ5QFYwBdlmuqQ0KxHjM3Z
         lHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5zoa/6o2NMGwyWnXNc+7JnTarUKk9/4IQ4KcNFli70U=;
        b=P9xuo3Dw/sWLR10O7aAeP8eXENFF4RywSQhsIsszmMalciDP1Z0SQZ/awSqFf4f87Z
         AgUF1SrUK/5wTUud7WcJZ+jMUMRy+0ETI1Qmwgv0THZpfdtz23y3lj8lPeBqfA2rM/4G
         V6N9xBK0+5mJRoAlLn99lATuFWW0HWCOE2bixWhx8EtEG6t6OPTnih8MNPPlo7sWxLnE
         J/Kzp/A2a+9U/WFKJ0gSV5ZssAjHzF5h2HzGz4jhYYCR+YlAQU6X92VQYMgUUk8ntw0l
         MbEmGkhnb7HUi8B0KBOctaO1slKHQbbMVKEBIRuqXPNNRCaopbcLIC/M7otbaO3pQexS
         BhWw==
X-Gm-Message-State: ABuFfojm/oJav8bgjzUpgSAnE+22xUwA8miabXq37O8tPrJl2WF4sZah
        pFBmUTvAE9+BgAY8Krd+ZwZHBIm5tBk=
X-Google-Smtp-Source: ACcGV60t7FCGKRWY3h7XyMMtnYYBfdlgksq/LcUIflCgujCgZbftpMGGjKwC9fldVaKR9CxUdRHPLQ==
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr8044403wrm.145.1539423903801;
        Sat, 13 Oct 2018 02:45:03 -0700 (PDT)
Received: from [172.16.8.139] (host-89-243-172-161.as13285.net. [89.243.172.161])
        by smtp.gmail.com with ESMTPSA id w192-v6sm2724382wmf.33.2018.10.13.02.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Oct 2018 02:45:03 -0700 (PDT)
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock
 for reconfiguration [ver #12]
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
 <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
 <20181013061141.GR32577@ZenIV.linux.org.uk>
From:   Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
Date:   Sat, 13 Oct 2018 10:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181013061141.GR32577@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2018 07:11, Al Viro wrote:
> On Fri, Oct 12, 2018 at 03:49:50PM +0100, Alan Jenkins wrote:
>>> +SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
>>> +{
>>> +	struct fs_context *fc;
>>> +	struct path target;
>>> +	unsigned int lookup_flags;
>>> +	int ret;
>>> +
>>> +	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
>>> +		return -EPERM;
>>
>> This seems to accept basically any mount.  Specifically: are you sure it's
>> OK to return a handle to a SB_NO_USER superblock?
> Umm...  As long as we don't try to do pathname resolution from its ->s_root,
> shouldn't be a problem and I don't see anything that would do that.  I might've
> missed something, but...

Sorry, I guess SB_NOUSER was the wrong word.  I was trying find if 
anything stopped things like

int memfd = memfd_create("foo", 0);
int fsfd = fspick(memfd, "", FSPICK_EMPTY_PATH);

fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
fsconfig(fsfd, FSCONFIG_SET_STRING, "size", "100M", 0);
fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

So far I'm getting -EBUSY if I try to apply the "ro", -EINVAL if I try 
to apply the "size=100M".  But if I don't apply either, then 
FSCONFIG_CMD_RECONFIGURE succeeds.

It seems worrying that it might let me set options on shm_mnt. Or at 
least letting me get as far as the -EBUSY check for the "ro" superblock 
flag.

I'm not sure why I'm getting the -EINVAL setting the "size" option.  But 
it would be much more reassuring if I was getting -EPERM :-).

Alan

