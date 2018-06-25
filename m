Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D70C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643C924FB5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="WhRuzb/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643C924FB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934599AbeFYPAj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:00:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32769 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934543AbeFYPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:00:36 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so6188692pgq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LUfB2GGro/ff3XcOnrh631gJjnAFe2fbs/V0Yli4a7o=;
        b=WhRuzb/GdlDY5O60bhr16i5sCFSWVhKHOJxgWuhDfx6PyGoeSo9lQb+GnbHm56Sb9e
         tzYX8lhazRjZNzxurDCkw6OHusR812DXIwAxpqMcyvkfeuuWoe1QOhUIWgoP6o9z2q2d
         jXypw2zS/aPjcm35cDK2SXxycJY6jGsrf0EGQRg7YkUlhs+A/reM+t0p+/PBr+s69VS5
         /vf5PHHw7cbay4TRQpWM8PI+LjqLIbNNvZzYhRnn0KYpnsdsj21PjYqVQMSlWKAkFBsV
         7S4J5CISB48g/Pz7io6+W/HDTd/zQZQgdtI9EVhlGkKrFIzUtApA7eP98JoxJf0FWa3x
         Lsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LUfB2GGro/ff3XcOnrh631gJjnAFe2fbs/V0Yli4a7o=;
        b=tK/RP6G0SrKpZxqIvNpbmfRrOPHfgUjxB3z/T6Mv7TlKJbxqDBzSy4o5c8OTvbVxK+
         0nMqP+SwuDQ6KTaWgk3iVi5G2QRdMPhduRXvSPx3DIS/CrUYFfUFmTPIDjASnIsJMnqp
         uy9fdxClkLYvXU7wTNh79Q6F+EJhFXJseLy1KR4h2CFYIvUDZboIIpJ95gDuL/938Bor
         dPbOn5YYXYWBy98Sy67mFiT22iPcD4vKsa/mn9HJN19DotjvJJT6tHsfSNi/kaaaD1Le
         /13XAROoxvO8wcZsVUK5O6mIqRZT/+tBPtSwU9dEzOLOcuCW3ubfpCou4xMhDQquK7bV
         maDw==
X-Gm-Message-State: APt69E2gUfOToHD2ntrmIS/cMQYayh5XHq8BhOMxxdW7As0SZPQa0iZa
        51MC5ppQ7FRPmD5q4oH1WrULcA==
X-Google-Smtp-Source: ADUXVKLjfcCjexdDwMA8EDjc49vWSl3bjsrFwwFUfXzr7KOm22yL3fNT+Hd/mxmLEZ6kvhvrKH4+VA==
X-Received: by 2002:a62:60c3:: with SMTP id u186-v6mr8679167pfb.230.1529938835833;
        Mon, 25 Jun 2018 08:00:35 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.googlemail.com with ESMTPSA id s27-v6sm36283466pfk.184.2018.06.25.08.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:00:35 -0700 (PDT)
Subject: Re: [PATCH v4] overlayfs: override_creds=off option bypass
 creator_cred
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-unionfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20180622171605.52989-1-salyzyn@android.com>
 <20180625123800.GA10739@redhat.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <4fb5e265-c72d-81be-489b-9f06e3db4218@android.com>
Date:   Mon, 25 Jun 2018 08:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180625123800.GA10739@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NB: Amir has asked for me to itemize all the gotcha and security 
concerns of this feature.

On 06/25/2018 05:38 AM, Vivek Goyal wrote:
> On Fri, Jun 22, 2018 at 10:16:02AM -0700, Mark Salyzyn wrote:
>> By default, all access to the upper, lower and work directories is the
>> recorded mounter's MAC and DAC credentials.  The incoming accesses are
>> checked against the caller's credentials.
>>
>> If the principles of least privilege are applied, the mounter's
>> credentials might not overlap the credentials of the caller's when
>> accessing the overlayfs filesystem.  For example, a file that a lower
>> DAC privileged caller can execute, is MAC denied to the generally
>> higher DAC privileged mounter, to prevent an attack vector.
> Hi Mark,
>
> I am wondering, what does it mean that caller is privileged enough to do
> mknod and set trusted xattrs but it does not have privileges to do mount.
> If caller is privileged, then it can do mount as well?
There is only one process, with one set of MAC and DAC security policy, 
to perform the mounting. There are multitudes of callers that have 
individually different and non-overlapping MAC and DAC security 
policies. Some can mount, do mknod, even set xattr, some can not. mount, 
mknod and xattr in MAC (selinux) rules can individually be controlled. 
The issues encountered are that the mounter (init) does _not_ have 
access privileges uniformly to all the files represented by the 
filesystem, it can not create device nodes. Another caller (adb root) 
will have mknod and xattr privileges, and yet another caller 
(system_server for example) has execute privileges for libraries that 
the mounter (init) does not.
> Or, what does it mean that a mounter can mount (hence providing access
> to certain resources on the system) but then mounter itself does not
> have access to those resources. If mounter does not have access to
> those resources, then mounter should not be allowed to do the mount
> and provide access to those resources to a third person?
Every resource has a MAC (selinux) label in the file system. For 
example, If the mounter has no vested interest in the ability to create. 
read or execute the resources, than the mounter will not be granted 
those rights. The labels are granted a list of rights to a specific 
"third person", not just _any_ third person.
>
> For example, SELinux context= mount option. So here mounter can create
> a mount point with label context=foo, and provide access to underlying
> files/dirs to the caller. Now if mounter itself does not have access
> to resources on which mount is being created, then how it is supposed
> to provide that access to unprivileged caller?

Not using that option, can't use it, really part of a less security 
conscious policy. obviously does not work in Android's security model. 
If we did, and it had blanket rights to do so, the mounter could be 
granting "random third parties" rights to files that have some specific 
controlled contexts.

Are you telling me to use the options to grant a string privilege hole, 
I'd say context= is a far more serious security problem and we need to 
suppress it's use (!). It is meant to mount untrusted/removable disks, 
by labelling all contexts at a lowest point, for instance 
u:object_r:untrusted_file:s0 so that we get no surprises of a strong 
source context from the filesystem.
> Going by your analogy of init being attacked, then one simply have to
> attack init and trick it to mount something with context=foo and gain
> access to resources mounter itself could not access.
Yes, they could. Perhaps both our examples are part of Argumentii 
Absurdum in their simplicity; but alas in Android there are _two_ inits, 
one that has a limited access to _system_ resources, and another that 
has limited access to _vendor_ system resources, and the neither is 
supposed to have blanket rights to the other's resources. Their 
overlayfs mounts will reflect the privileges.
> While my example is fully valid for disks, it is not fully valid for
> overlay as we do two level of checks for many operations. So while overlay
> inode level check will pass due to context=, underlying file system check
> will fail. But this two level of checks does not happen outside overlay.
> SELinux is not aware of stacking of filesystems so it could just do check
> on overlay inode. So if a caller opens a file and passes file descriptor
> to another process who is not supposed to access file, with context= mounts,
> I think SELinux will allow access as second process is allowed to access
> overlay inode.
Again, if we use context= mounts, the file privileges will be low, as in 
all applications, save for a trusted few with careful control, are 
blocked from u:object_r:untrusted_file:s0. In android, when Fds are 
passed around, the privilege of the caller will protect the fd from 
being abused by a third party. Obviously this allows the open privileges 
of the first caller to be bypassed for the second, but it will clearly 
block based on the source and target contexts for the file resource and 
the second caller's access privileges.
>
> IOW, if mounter is a separate process and if mounter itself can not
> access a certain resource, then it should not allow other lower privileged
> processes access to that resource. (Linux SELinux context= mounts). And
> I am concerned that by taking away checks for mounter's creds later, how
> do we ensure that privlege escalation did not happen by tricking mounter.
Again, context= is never to be used lightly, it must be at an untrusted 
label set.

Yes, a (limited) attack can be mounted(sic) by setting the privileges of 
the labels to u:object_r:init_exec:s0, but as stated before, init is 
only granted access to target contexts that it needs (eg: it can not 
create devices nodes, in /dev or anywhere else, that is granted to 
u:object_r:ueventd_exec:s0). Of course, no one is allowed execute and 
context transition for the init_exec label, so this behaviour I speak of 
is locked down 300 ways. There is no _root_ that also has all the DAC 
capabilities or blanket MAC privileges.
>
> Thanks
> Vivek
Sincerley -- Mark Salyzyn
