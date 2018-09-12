Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C6E20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQZJwS8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C6E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeIMEI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:08:57 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42196 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeIMEI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:08:57 -0400
Received: by mail-wr1-f47.google.com with SMTP id v17-v6so3670169wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XlolwNdnXfu08pxexsrWwZrtMYsBrJu8y6D5Jo0DqZs=;
        b=XQZJwS8v/d8DwGaDa5rN9HBhBTCUC93UDZ2JeMAl/wSOjIHY4ci33H4EQiA+gxP5m4
         v0L3S7bXleGAeIlNexuXwBVnvZNuRh99CWpmzRpSVqSiyN5/5d9Jq7vVQHPnPqBL12YP
         vCzuq5S439fjaAx4lm3sqox6dD9KQKN2UsTHcaCfu7loYw4G7K36XY1+6GL5bFBdhRAF
         JiHnD88aZGfucLgxOjCQWj+NMQD1qddC3OB68LmcRGgllHVnctNeKZncBx5q2sjtaWkG
         yey2dXZQmcmokJwblImTac7J+AJTrdnALzSfJs6qMEXfLoQL+dS3V6nWtR6CyRqQfGHx
         2uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XlolwNdnXfu08pxexsrWwZrtMYsBrJu8y6D5Jo0DqZs=;
        b=tDEsHerrpmbAnZSBAAchacsuVzeHVPzVnPj/9wxeTccbInCuPZiAtcaKq5lIR8QekQ
         eKmALOXKMh/IGpd+4+NwpD+lbNli+Rg1H0OarSBgr+cUgGrWNE2BOO5QMzfaZZ6uuCct
         O+GUK0ylNDGGMOEKSeF7XdBV11Cq7HoRDYRhVp8h5/kfwcqL0V5AQJ+qsBE7UZWyYpTm
         vlVVPiGiE8IJPO9RbY9cbv06kkMDXfNGoBeU6cwDg18b0fxE4l9TzomC+oCVABqYNxcD
         EhvCOXg3iarF5G9mJ1wKkR685crYjKQozEjWIywdgC9CVarPWOl6YOpmtsbhvxCrI556
         7BGw==
X-Gm-Message-State: APzg51ClPIBSjf3SpOrB3Evf/nemGUcreINmGhtyeDh21QBFtVwn8tOA
        M93Q2AHdJpVUj3MQDsj5CA==
X-Google-Smtp-Source: ANB0VdYFJ2YfFVNt1KFO+k/+mo3UyHA51Eh0IpK2mavrkSjbdrF5qbyHX05BUYzu9M60CAnq2W5qwQ==
X-Received: by 2002:a5d:62c2:: with SMTP id o2-v6mr3427980wrv.83.1536793335209;
        Wed, 12 Sep 2018 16:02:15 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id h82-v6sm1600873wme.11.2018.09.12.16.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 16:02:14 -0700 (PDT)
Date:   Thu, 13 Sep 2018 02:02:12 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     prakash.sangappa@oracle.com
Cc:     linux-kernel@vger.kernel.org, mhocko@kernel.org,
        dave.hansen@intel.com, cl@linux.com, khandual@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180912230212.GA6567@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The /proc/pid/numa_vamaps shows mapped address ranges to numa node id
> from where the physical pages are allocated.

All these files make the problem with useless dentry and /proc/*/* inode
instantiations worse (unlike top level /proc/* files which are
tolerable).

> +address-range	numa-node-id
> +
> +00400000-00410000 N1
> +00410000-0047f000 N0
> +0047f000-00480000 N2
> +00480000-00481000 -
> +00481000-004a0000 N0
> +004a0000-004a2000 -
> +004a2000-004aa000 N2
> +004aa000-004ad000 N0
> +004ad000-004ae000 -

'N' is useless data.

Parsing with awk won't work because field #3 is separated with space
but field #2 with '-'.

%08lx-%08lx kind of sucks: 32-bit get aligned data so parsing can be
faster by pointing to &p[8+1] but not on 64-bit.
If scanf("%lx-%lx") is used then leading zeroes are useless.

Text is harder than it looks.
Please in the name of everything holy add new honest system call.
