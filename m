Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/rFEOs+DwM+PvB//chiEbSB9cNmNZ7K7ieRnRYRUHfHzILZZQQbVJwGjXmLeSsUFAIG6yQ
ARC-Seal: i=1; a=rsa-sha256; t=1524301497; cv=none;
        d=google.com; s=arc-20160816;
        b=ulydTNPmg+dTbrzhRDX9+Ws3kSy+X7uQ/+5Hz2egEVqy1e8b1wnbNc91p6tqmY1oG0
         KPOb6qM+AkB6AMR0DAF9c5DFMo5n2K/3XNxjqfj+CXsxuMf0YjtFMtDDDRBPFJZSQfX+
         yMr3QxA67FmdN0j4AgcKji6ZQevVa38DBRXmqRY2IPKTa7ZjPjeAFfyFppdNDPtm4kaf
         +wpkic0PA+0DLjsH1kTBcBUC/jQJm24/GxH36sD5X6bJ5Ak55gmOCgkN5lM6TlaV19b+
         17hp0os01FmnTGa35jV+Iae1A77txjKNynwSZEK6QuOTjGP0WPwrKenPlyHLlfmgTN/l
         isxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=OI1OugHEGr0TiNJ3QW2E149pjk10RqQoKyXpCb+p1nQ=;
        b=Qi1OfHdGt/rXSbuHzRJmWleWQGi7Th3Z2Lk9mIeQE9ZsaiJKKvwGda7UFSIjODyHBQ
         Tkwa29hig8YjIWgcd9omlbCnCpFlCxrQCYrYLRdd6T4G6CJvhm6BQY+he3aUU80op1B+
         41tggCefBSICf/2QJD+VHiwt3sUElbTJEUrWdiAl7buACOx/cShlbmcpln7+bBZFWXeM
         +nZGWU0pYNmYnhToV9r6Oi835ZUbC0spS0J6m8VVSn1Kt0A+qMlXWevE8hGHGnjPLR1n
         2MBoQLvwQd/AkTuWu+RXVHXPtCzTP2C1WUqxAzNwSSlOangu2bwC4mv88igFGtDSm/jf
         TX1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeDUJE5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 21 Apr 2018 05:04:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42374 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeDUJE4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Apr 2018 05:04:56 -0400
Date: Sat, 21 Apr 2018 11:04:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
Subject: Re: [PATCH v4 1/2] char: sparc64: Add privileged ADI driver
Message-ID: <20180421090449.GA8194@kroah.com>
References: <20180420205221.488589-1-tom.hromatka@oracle.com>
 <20180420205221.488589-2-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420205221.488589-2-tom.hromatka@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598287411994032224?=
X-GMAIL-MSGID: =?utf-8?q?1598345967306800400?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 02:52:20PM -0600, Tom Hromatka wrote:
> --- /dev/null
> +++ b/drivers/char/adi.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0

Good, but:

> +MODULE_LICENSE("GPL");

That's the wrong line :(

Read include/linux/module.h for the correct string to put here for a
GPL version 2 only module.

thanks,

greg k-h
