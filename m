Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3547974-1527869892-2-18392531456930592358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527869892; b=ANo8nQR6RNFUrkKgyhBbTThjRUsHIBQ0sWuD5pU60Q1qNe0GBz
    Ln5nq2IuvjX/JZfsiUg/ngCfBZFYamfOXoJjSTlzLzl7CnbLRXMyO4zVg+/nGXMc
    qgnV5sm5R7pYDM4JsZsKVQYRjD6lsNzYml5jKibV/3OuN1JWVAWuljBk5Pdrwc4h
    ayYVf/rok06K8p5dzfat+6HfsubqyBRjehTVsKIcd+ahyn1vZ/6iNDRXcmCtRFG+
    8qXlV8BrKBYIk5hdqs0y1XmrBo71Cf5KOBuI4JxBwRNypknFAuPSNlHg5zjVHVOr
    AoQ8FOGzmzEHbaevmjTtuP3M5lBy7k3/fgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527869892;
    bh=kEbSj1KOS8HW2deEhZL0RgQ66EhlRILltdjyvLyI0Qw=; b=WWGmsTKzJJQU
    WBMEpuEwRdIQeu2/fiWR01C7YTHwNcVV+gtaIbojsgc3jIOT1xkKxH+lH2g8kyJq
    SdmhEZCdzpZwjVqf361EsH616YY3AEyMU0EvKEUmTr1BoOKn6vyapCUE+ri6eoV3
    B1jhTQqpTmdXY09Ir9rd9WrFFuSetIZO2uGOGrkvMA1UXak+d2X+An7CW53SzbTP
    5QW2yCxpG0uKbsVXjTuBC9J9q/ILYR+abycQczkNElig9dMrmiNta2cdAxlicOno
    nqwW5NbFmGl7oF5hezC4AwCPO00z0QcwrMwH3q4Hnz9dkkJjG9z2MllkE0MrMInE
    CzJ1qHGrDg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=rqQpOdDb
    header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=rqQpOdDb
      header.a=rsa-sha256 header.s=merlin.20170209 x-bits=2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP0WT+cGt1HR2ZCYy10BCdn4OnhkCn0tsuyiE10IYxv9U0Jg6DnRLQOSCrhnaIliV1TRCBA3hDwFOvqaM7KASvLDABF2cR4KBPxyGAc9W427s6Hiz5Ez
    PIMaxm+WA9Aw/rHXUjGBPEkDT5urZxgVOKPENJCQylDztQHeedX7oK5IfJXiHnm0cDX91YzYbz7ZULp80vOpsWHIGMj7t663yX75jjv2kcv5TfytemOMqdOM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VwQbUJbxAAAA:8 a=2_UqDxIOuWw3J_2zgJ8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFAQSI (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 12:18:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbeFAQSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:18:08 -0400
Subject: Re: [GIT PULL] overlayfs update for 4.18
To: Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
References: <20180529132148.GC23785@veci.piliscsaba.redhat.com>
 <20180601152625.GD23785@veci.piliscsaba.redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d1b5ffb-4786-6b7a-fbf3-84b79080ccff@infradead.org>
Date: Fri, 1 Jun 2018 09:18:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601152625.GD23785@veci.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/01/2018 08:26 AM, Miklos Szeredi wrote:
> On Tue, May 29, 2018 at 03:21:48PM +0200, Miklos Szeredi wrote:
>> Hi Al,
>>
>> I'm sending this pull request to you instead of Linus, because a bigger than
>> usual chunk involves the VFS.
>>
>> Please pull from:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro
>>
>> This update contains the following:


> ---
> 
> diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesystems/overlayfs.txt
> index 0a8e3c4543d1..79be4a77ca08 100644
> --- a/Documentation/filesystems/overlayfs.txt
> +++ b/Documentation/filesystems/overlayfs.txt
> @@ -280,7 +280,7 @@ parameter metacopy=on/off. Lastly, there is also a per mount option
>  metacopy=on/off to enable/disable this feature per mount.
>  
>  Do not use metacopy=on with untrusted upper/lower directories. Otherwise
> -it is possible that an attacker can create a handcrafted file with
> +it is possible that an attacker can create an handcrafted file with

bad change:
                                       create a handcrafted

Wait. Is this patch -R (reversed)?

>  appropriate REDIRECT and METACOPY xattrs, and gain access to file on lower
>  pointed by REDIRECT. This should not be possible on local system as setting
>  "trusted." xattrs will require CAP_SYS_ADMIN. But it should be possible
> @@ -318,7 +318,7 @@ does not support NFS export, lower filesystem does not have a valid UUID or
>  if the upper filesystem does not support extended attributes.
>  
>  For "metadata only copy up" feature there is no verification mechanism at
> -mount time. So if same upper is mounted with different set of lower, mount
> +mount time. So if same upper is mouted with different set of lower, mount

                                   mounted

>  probably will succeed but expect the unexpected later on. So don't do it.
>  
>  It is quite a common practice to copy overlay layers to a different
> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
> index 08b04d9fd6e6..e0a090eca65e 100644
> --- a/fs/overlayfs/Kconfig
> +++ b/fs/overlayfs/Kconfig
> @@ -11,7 +11,7 @@ config OVERLAY_FS
>  	  For more information see Documentation/filesystems/overlayfs.txt
>  
>  config OVERLAY_FS_REDIRECT_DIR
> -	bool "Overlayfs: turn on redirect directory feature by default"
> +	bool "Overlayfs: turn on redirect dir feature by default"

nope.

>  	depends on OVERLAY_FS
>  	help
>  	  If this config option is enabled then overlay filesystems will use
> @@ -46,7 +46,7 @@ config OVERLAY_FS_INDEX
>  	depends on OVERLAY_FS
>  	help
>  	  If this config option is enabled then overlay filesystems will use
> -	  the index directory to map lower inodes to upper inodes by default.
> +	  the inodes index dir to map lower inodes to upper inodes by default.
>  	  In this case it is still possible to turn off index globally with the
>  	  "index=off" module option or on a filesystem instance basis with the
>  	  "index=off" mount option.
> @@ -67,7 +67,7 @@ config OVERLAY_FS_NFS_EXPORT
>  	depends on !OVERLAY_FS_METACOPY
>  	help
>  	  If this config option is enabled then overlay filesystems will use
> -	  the index directory to decode overlay NFS file handles by default.
> +	  the inodes index dir to decode overlay NFS file handles by default.
>  	  In this case, it is still possible to turn off NFS export support
>  	  globally with the "nfs_export=off" module option or on a filesystem
>  	  instance basis with the "nfs_export=off" mount option.
> @@ -133,7 +133,7 @@ config OVERLAY_FS_METACOPY
>  	help
>  	  If this config option is enabled then overlay filesystems will
>  	  copy up only metadata where appropriate and data copy up will
> -	  happen when a file is opened for WRITE operation. It is still
> +	  happen when a file is opended for WRITE operation. It is still

nope.

>  	  possible to turn off this feature globally with the "metacopy=off"
>  	  module option or on a filesystem instance basis with the
>  	  "metacopy=off" mount option.


-- 
~Randy
