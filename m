Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeDEOeA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:34:00 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:58028 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEOd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:33:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 5A920332E4A
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 05 Apr 2018 16:33:56 +0200
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Kees Cook <keescook@chromium.org>
Cc: David Windsor <dave@nullcore.net>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        keescook@google.com
Subject: Re: usercopy whitelist woe in scsi_sense_cache
In-Reply-To: <dee9721a530576e667881d86bbec351b@natalenko.name>
References: <10360653.ov98egbaqx@natalenko.name>
 <CAGXu5jLwyot++C2EXs+032Lz5WdG65GsEJ-Q55rfhSbkG1Nh+A@mail.gmail.com>
 <3265889.eu5sbW8aRz@natalenko.name>
 <CAGXu5jL++CEmLzFtGMVMhGWBzHpsRNJPTsEoc7Pw1dP--=azCA@mail.gmail.com>
 <7fc01f67a561ce1fad676fc34c2249e7@natalenko.name>
 <CAGXu5jKhiE512yQXp90M+Wie=8RkpMZT-Yi_9BgjfKwibP433g@mail.gmail.com>
 <dee9721a530576e667881d86bbec351b@natalenko.name>
Message-ID: <08e06234c81fac30ccff5a2695d02f2a@natalenko.name>
User-Agent: Roundcube Webmail/1.3.5
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1522938836;
        h=from:sender:reply-to:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:resent-to:resent-cc:resent-from:resent-sender:resent-message-id:in-reply-to:references:list-id:list-owner:list-unsubscribe:list-subscribe:list-post;
        bh=sybOaK8dzS2YbGCYCWW0KrY4eYOUWwQYzH6xQZL1ot4=;
        b=WPYATbTS5gDgichk4knn3zu3FWdxINRZQeJIjln1XxGKX6Gsr+HSinW+giSHx6iDtkZc+G
        UahyDr1T40EUCi31ZL/V4Vr/FFe/GFq/FTPRVVQoTjss67pifjA0xA4HhG7TDyYXYq0Hzp
        Kkz6beiNA2G10FqnKuvtnXiBxMtQoTY=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1522938836; a=rsa-sha256;
        cv=none;
        b=WGt5BtLTLNcnaFWCb0m/X5U3BglIsAaUvcuXY85bot6DkWIjJ7a3QfPH/Q4gzoEioMRatBQEL0nLeZhXnuLOyZRy1MrcV5XxPkbpW0T2GcnDGmd1+PyRL+dOKTjpYM3ewSetk928bYD/6dhvdWJU6lHloUkuZ3J00DY9Jta/ZeM=
ARC-Authentication-Results: i=1; auth=pass smtp.auth=oleksandr@natalenko.name
        smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.04.2018 16:32, Oleksandr Natalenko wrote:
> "-hda sda.img -hdb sda.img"

"-hda sda.img -hdb sdb.img", of course, I don't pass the same disk twice 
☺
