Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C07ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D34E214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D34E214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeJQOvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:51:03 -0400
Received: from david.siemens.de ([192.35.17.14]:58918 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJQOvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:51:03 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w9H6ujJG014575
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 08:56:45 +0200
Received: from [167.87.8.95] ([167.87.8.95])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w9H6uilx019682;
        Wed, 17 Oct 2018 08:56:45 +0200
Subject: Re: [PATCH] scripts/gdb: fix lx-version for gdb 7.3-
To:     Du Changbin <changbin.du@gmail.com>, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20181017023652.6867-1-changbin.du@gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <62b6aff8-8ca2-7d6c-d810-64d10a25f2d4@siemens.com>
Date:   Wed, 17 Oct 2018 08:56:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20181017023652.6867-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.18 04:36, Du Changbin wrote:
> For gdb version less than 7.3, lx-version only one character.

                                           ^^^ prints?

> (gdb) lx-version
> L(gdb)
> 
> This can be fixed by casting 'linux_banner' as (char *).
> (gdb) lx-version
> Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018
> 
> gdb 7.4 seems to be no such issue.
> 
> Signed-off-by: Du Changbin <changbin.du@gmail.com>
> ---
>   scripts/gdb/linux/proc.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> index 086d27223c0c..0aebd7565b03 100644
> --- a/scripts/gdb/linux/proc.py
> +++ b/scripts/gdb/linux/proc.py
> @@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
>   
>       def invoke(self, arg, from_tty):
>           # linux_banner should contain a newline
> -        gdb.write(gdb.parse_and_eval("linux_banner").string())
> +        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
>   
>   LxVersion()
>   
> 

Looks good to me otherwise.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
