Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeCLFwT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 01:52:19 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33649 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeCLFwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 01:52:17 -0400
X-Google-Smtp-Source: AG47ELvGhC9TgH80eP0kkxxwjtGyhos7+Wq8jq4h9aALie8kOSnoSfywPqujyoakd+FbvdjrBGJALw==
Subject: Re: [PATCH 0/2] mtd: use put_device() if device_register fail
To: Richard Weinberger <richard@nod.at>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
 <3975609.gPYExXdWMR@blindfold>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <4a280604-16f2-776b-d997-d5882af6fe35@gmail.com>
Date: Mon, 12 Mar 2018 11:21:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <3975609.gPYExXdWMR@blindfold>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday 12 March 2018 01:05 AM, Richard Weinberger wrote:
> Am Freitag, 9. März 2018, 11:50:47 CET schrieb Arvind Yadav:
>> if device_register() returned an error! Always use put_device()
>> to give up the reference initialized.
>>
>> Arvind Yadav (2):
>>    [PATCH 1/2] mtd: use put_device() if device_register fail
>>    [PATCH 2/2] mtd: ubi: use put_device() if device_register fail
> Uhh, this is not obvious. Does device_register() really always return with a
> reference held in all (error) cases?
>
> Thanks,
> //richard
if device_register() returned an error! Always use put_device()
to give up the reference initialized.(-- Please see the comment
for device_register() ). put_device() is able to handle those case
where it'll not return a reference.

~arvind
