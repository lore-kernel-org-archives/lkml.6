Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CDFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C92156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7C92156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeI0TcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 15:32:18 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:50627 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeI0TcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 15:32:18 -0400
Received: (qmail 5482 invoked from network); 27 Sep 2018 13:14:03 -0000
Received: from mail.sf-mail.de ([::ffff:78.47.74.12]:36456 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <leobras.c@gmail.com>; Thu, 27 Sep 2018 15:14:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 27 Sep 2018 15:14:03 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from
 direct make command
In-Reply-To: <CADvQ+rFPiaGKLyzfSx4DmTnmgG15=Jk0RVy8xuYYyvLPJfDdkA@mail.gmail.com>
References: <20180927014138.GA8988@WindFlash>
 <5236278.7dVKUIXYaR@daneel.sf-tec.de>
 <CADvQ+rFPiaGKLyzfSx4DmTnmgG15=Jk0RVy8xuYYyvLPJfDdkA@mail.gmail.com>
Message-ID: <136913b41707c8556fb5d41969d2080e@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2018-09-27 13:23, schrieb Leonardo Bras:
> Hello Rolf,
> 
> On Thu, Sep 27, 2018 at 3:34 AM, Rolf Eike Beer <eike-kernel@sf-tec.de> 
> wrote:
>> Am Donnerstag, 27. September 2018, 03:41:38 CEST schrieb Leonardo 
>> Brás:
>>> Creates new Makefile to avoid building driver if
>>> 'make drivers/oprofile/' is called directly.
>>> 
>>> This driver is usually built from arch/$ARCH and seems to have
>>> no meaning building alone.
>>> 
>>> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
>>> ---
>>>  drivers/oprofile/Makefile | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>  create mode 100644 drivers/oprofile/Makefile
>>> 
>>> diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
>>> new file mode 100644
>>> index 000000000000..acaed2ad6eee
>>> --- /dev/null
>>> +++ b/drivers/oprofile/Makefile
>>> @@ -0,0 +1,2 @@
>>> +#Does nothing, since the source is called from arch/$ARCH/ tree.
>>> +
>> 
>> Now there is a blank line where it does not need to be.
>> 
>> Eike
> 
> Oh, it's a Makefile, and as all text files, it have to end with 
> newline.
> If I am wrong, please let me know.

No, that's fine. But it means it has to have one LF after "tree.". It 
had none, now it hat 2.

Eike
