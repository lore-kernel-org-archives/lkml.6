Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8FAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8643020844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8643020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbeHAPyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:54:46 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33300 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389498AbeHAPyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:54:46 -0400
Received: from [10.10.2.207] (pluton2.ispras.ru [83.149.199.44])
        by mail.ispras.ru (Postfix) with ESMTPSA id DEA2D540081;
        Wed,  1 Aug 2018 17:08:48 +0300 (MSK)
Subject: Re: [PATCH v5] staging: rts5208: add error handling into rtsx_probe
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
References: <CAHp75VfktnjL+G0vjHNHr=8mbDXu+4BDogsnxrp_2Bo4em=r2Q@mail.gmail.com>
 <20180801115557.7086-1-vasilyev@ispras.ru>
 <CAHp75VeSr-dDC+BvvTi1f2JBDL0UB31O=umatKE4y=0HQ4_8UQ@mail.gmail.com>
From:   Anton Vasilyev <vasilyev@ispras.ru>
Message-ID: <cac7e1d3-dc55-5857-5fe5-4ff5bc39f2d1@ispras.ru>
Date:   Wed, 1 Aug 2018 17:08:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeSr-dDC+BvvTi1f2JBDL0UB31O=umatKE4y=0HQ4_8UQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that staging-next already contains my patch v3, committed by 
Greg Kroah-Hartman.

Do I need to send a new patch with a label renaming based on Dan 
Carpenter comments?


-- 
Anton Vasilyev
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: vasilyev@ispras.ru

On 01.08.2018 15:18, Andy Shevchenko wrote:
> On Wed, Aug 1, 2018 at 2:55 PM, Anton Vasilyev <vasilyev@ispras.ru> wrote:
>> If rtsx_probe() fails to allocate dev->chip, then release_everything()
>> will crash on uninitialized dev->cmnd_ready complete.
>>
>> Patch adds an error handling into rtsx_probe.
>> Found by Linux Driver Verification project (linuxtesting.org).
> Have you based your change on staging-next?
>
> Seems not. You need to rebase and resend.
>

