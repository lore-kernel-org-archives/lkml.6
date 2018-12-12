Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557E9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173ED20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjDoTDJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173ED20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeLLRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:07:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40889 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeLLRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:07:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so16940414lji.7;
        Wed, 12 Dec 2018 09:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=dh9qOi2gOchLt7Tz6Maz2KC2vgfIol/GoPb1igeBc1A=;
        b=sjDoTDJXxxR1ybcmz1ccs9HVVPfu+yihkJfkvKRCxlpEnaMgfPM7DGZzKomAfqdTRt
         EwqKVzDaf9bKol2ed7dLjN2FUBd8zwQvtp1ENgjw7OS1a/fuOAtKfchGPUkqaaJUQBkf
         a2id6onOVtmXF2QiwSoAWp5wDHGknEmUpgvwIEIZ7bukmaN69TgP1Kiv2x+C1F3tee53
         8In8n0i4hd49wCBwwB618kO1kacTWPLipo7/BoeS5WC20QbDd1z6qSOAcO6R4uDu6Vzh
         rn7s3MjAauS94Xrb+mD8EUUyweR/h7846XdmJcjx0thDHDPru9Dpr0Ks8B2LpVja+yDi
         +B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=dh9qOi2gOchLt7Tz6Maz2KC2vgfIol/GoPb1igeBc1A=;
        b=DEHDzi2AI31GXEdjC07r3ezquG6mc2WA7eCfsupFcK+Nv0UUEwUv2Pmh3POWFAbxps
         2WXscDRf2w/2B9ylA+HZPeMOB02eKHk2hMysudM5YJpmn49542O5tcMoUIRJzJpIGrau
         L1504rSwJ6fpqG8tQRK5eMoaloxMkmo5wjupPTt8wRMBC3XTcoTW/fNszICkKikRIjVo
         NqdPm0p8CWcQkycJHLE/zczds3LW0+Mw76t6D5t8NYTBikN9zku6RnSAgmMp/1EHsa0l
         CVLK55hQMypkjEixLhYFIKdEJMenPWU5oRMQsKkhrU4STw9ISqTaAJqEhNcQYyBjhV9A
         ZRhw==
X-Gm-Message-State: AA+aEWaxrGpov0Nf4L8XPds9PlxZ+scykouuBNajuiNc1VBwkTm6Hs0t
        mca7AyFwpgOPEuQxj4KACZo=
X-Google-Smtp-Source: AFSGD/XJYhl2tdMHjMphFDLvnmUe0dSz8d3ayh6FvcCgVrEEcHZ7E831H5R8xAkHOJu9Hs+jObNCLA==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr12543405ljf.96.1544634462234;
        Wed, 12 Dec 2018 09:07:42 -0800 (PST)
Received: from [192.168.55.63] (nat.ds19.agh.edu.pl. [149.156.124.19])
        by smtp.gmail.com with ESMTPSA id b69sm3378967lfl.28.2018.12.12.09.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 09:07:41 -0800 (PST)
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, sweil@redhat.com,
        swhiteho@redhat.com
References: 
From:   Piotr Jurkiewicz <piotr.jerzy.jurkiewicz@gmail.com>
Subject: Re: [PATCH 00/52] [RFC] virtio-fs: shared file system for virtual
 machines
Message-ID: <dc2e6e0f-ab00-a114-0fc1-e787293a73cf@gmail.com>
Date:   Wed, 12 Dec 2018 18:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, virtio-9p cannot be used with overlayfs in order to obtain 
Docker-like experience (but with separate kernel) because of file 
attributes problems. I wrote an email about that to qemu-devel almost 
year ago, but it received no attention (I attach its contents below.).

Will virtio-fs avoid these problems? I assume it will be transparent 
from the point of view of file attributes, and not enforce any kind of 
security filtering?

Piotr Jurkiewicz

----

1. Upper filesystem must support the creation of trusted.* extended 
attributes.

9pfs has support for getting/setting xattrs, but calls operating on 
attributes other than user.* and system.posix_acl_* are dropped.

2. Upper filesystem must provide valid d_type in readdir responses.

This works, but only in case of 'passtrough' and 'none' security models. 
In the case of 'mapped-xattr' and 'mapped-file' models, d_type is being 
zeroed to DT_UNKNOWN during readdir() call.

All these limitations can be resolved pretty easily, but requires some 
design decisions. I can prepare appropriate patches.

Ad. 1.

Why are operations on attributes other than than user.* and 
system.posix_acl_* forbidden? Is this due to security reasons?

If so, can we map all of them to user.virtfs namespace, similarly as 
system.posix_acl_* are being mapped to user.virtfs.system.posix_acl_* in 
'mapping' mode already? This way any trusted/security/system attributes 
will be effective only when mounted via virtfs inside VM.

Ad. 2.

local_readdir() can fill entry->d_type with the right DT_* value by 
obtaining file type from mapping and translating it with IFTODT() macro. 
This would, however, require reading 'user.virtfs.mode' for each 
direntry during readdir() call, what can affect performance. If so, this 
behavior would probably need to be controlled with some runtime option.

'mapped-xattr' and 'mapped-file' models are essential for running qemu 
with overlayfs as non-root, because overlayfs creates device nodes, what 
is possible for unprivileged user only with these models.
