Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227DDC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB2420660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="pHkDyUJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB2420660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbeK0EhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:37:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41861 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeK0EhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:37:12 -0500
Received: by mail-io1-f67.google.com with SMTP id s22so14624620ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 09:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDturwg8qsxrN1xf6XDaVk8WYMlDhJGb6QPJJMKCVFg=;
        b=pHkDyUJ+5k8jzUWOKmAWZok9z2B1fxN58HXoPcLUD8+fu2e+mqbfwO3qEDVtdlHS+g
         rFHpMpINsOWbegkzUCFYaO1uyATn83Ihr+MG74eSiVhTE7Z/PJocZuk2HmGB+x84cPW9
         k9QvMxqDoMXuWqGafjQ8F1DW2P2J+CqOf+nKelFxPnX3rLvcvAYYwRRK+Bw533LcSxoM
         lI1sgwRY1QLSR1jDKyvkp/LFEMeBOmUOC85NfWYTrBex2e8Ic8+DCVovAKjGsI6tUZ/6
         zQfPLHlGXLAYz0sRsOwg+f3D0SL7xy4eH4MEn9KQJm4nhyon3UvzykxVuSf6gthrpKLd
         q2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDturwg8qsxrN1xf6XDaVk8WYMlDhJGb6QPJJMKCVFg=;
        b=V+ypOE9mshQuxzn1yQtuNYSFDmV9JoKXlVmX4jKffEuKRY5FTx8b8ZhrRlnReQj5C2
         77Qowd3qn+L0u5anJwSxo2A4Q/etB1ZohSox0AsxfIGCoAliTbuMkj2Lvl/gmFcYfwSn
         w4iqZQTzKy7bPWJrQTjYunUDvvlt6LJwAH8poBHJ+QT4u0NNl4/mOCq/kjyA67M+1Vpr
         QDw4RbbdTv2mcp5wQuPtSrmOEp1cTzbwcOh9y6JMkzX2mi3KY6WW8YLmgWYmH/c0dHDg
         eIQVOWtPyFDUiAV2uuIpgofBCcQUBhqT+Wq2KXwGN6ynzwSREaGDMheFrmyY8k21Xjsg
         L09A==
X-Gm-Message-State: AA+aEWZcn3xibUmT0NcqlEOsO5SKAilx92iWcAF0OUn8qNp3W6Uoy1KH
        nSdeFtxhkyPD1DCc8BHVLgAgyQ==
X-Google-Smtp-Source: AFSGD/Uzk2NNR4t3Q0VsIIouxbr9rGEDyEyPn3O2S/QyfPgIwkFLqHEsAOjIG1LTqNcaQRurnEJong==
X-Received: by 2002:a6b:c806:: with SMTP id y6mr21377963iof.79.1543254142237;
        Mon, 26 Nov 2018 09:42:22 -0800 (PST)
Received: from [192.168.42.130] ([172.58.142.221])
        by smtp.googlemail.com with ESMTPSA id y13sm283232ioa.56.2018.11.26.09.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:42:21 -0800 (PST)
Subject: Re: [RFC][PATCH] fs: set xattrs in initramfs from regular files
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, initramfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, james.w.mcmechan@gmail.com
References: <20181122154942.18262-1-roberto.sassu@huawei.com>
 <7f2b0288-a173-e2bb-70ee-d552610bfc1e@landley.net>
 <b907b5ca-1515-1ed4-d50d-28c1736c0eb8@huawei.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <79a41125-0232-6f6e-6f38-f4c45a7b439e@landley.net>
Date:   Mon, 26 Nov 2018 11:42:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b907b5ca-1515-1ed4-d50d-28c1736c0eb8@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 6:56 AM, Roberto Sassu wrote:
> On 11/23/2018 9:21 PM, Rob Landley wrote:
>>> The aim of this patch is to provide the same functionality without
>>> introducing a new format. The value of xattrs is placed in regular files
>>> having the same file name as the files xattrs are added to, plus a
>>> separator and the xattr name (<filename>.xattr-<xattr name>).
>>
>> I think you're solving the wrong problem, but that's just my opinion.
> 
> Instead of iterating over rootfs, would it be better to detect files
> with extended attributes (from the file name) when the cpio image is
> parsed by the kernel,

Huh, I thought at first glance that's what the new approach _was_ doing.

In band signaling in the archive is ugly, still requires new tools to create it,
doesn't address the y2038 issue... (Although we could cheat, treat the time
signature as unsigned, and buy another few decades.)

But doing that in the filesystem _after_ you extract the archive is beyond ugly.

> and call sys_lsetxattr() in do_copy()? This part
> can be turned on by introducing a new type in the existing format (if
> possible).
> 
> The impact of this alternative is very low, and LSMs/IMA would be able,
> with minimum effort, to enforce policies on files in the initial ram
> disk.

The cpio extension isn't a big deal, I was pondering doing it myself in toybox
(and submitting a kernel patch to consume the output) before Mimi approached me.
(I did the initmpfs stuff already, I've stomped around in this area before.) I
just didn't because mimi sent their patch first, so I waited for that to work
its way though.

Unfortunately, it's simple enough that there was a bit of bikeshedding. (You can
store time in milliseconds as a 64 bit number without worrying about the range,
but if you do it as nanoseconds you need two fields, but people spoke up and
said "but if you don't store the nanoseconds the rounding causes spurious time
differences when between filesystems and it confuses our build system about what
has and hasn't changed"...)

The new in-band signaling proposal is, at best, a hack. (Filename lengths are
capped at 255 in the VFS, can you strip the xattrs on a long filename by having
the extension fail to create in the filesystem? Or do you have an arbitrary max
length on filenames because you need to reserve room for the extension?)

Rob
