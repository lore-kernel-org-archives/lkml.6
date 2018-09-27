Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3520421708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eaXGDyz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520421708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeI1CG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:06:27 -0400
Received: from sonic308-15.consmr.mail.gq1.yahoo.com ([98.137.68.39]:38811
        "EHLO sonic308-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727294AbeI1CG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1538077593; bh=Yb2K+xqiu1b2y141oFfOmLYeKTNTAH+VWyFadU5/gOE=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=eaXGDyz9/2CJ7TNuio424b+nBX+ZmEhRky7CfxKO9kqlvg29vaHUUCdfXk/2NCLGaOAbO/CFJT2hTJrn+y5drXAFz5QnK+ispk4Kjn4JveFlkm+YiLfY9T6VktUFJhv32r8TgKrrDM84bsDoIain336QhBwwcEZhPnvLJ3Mg4Qyh9W2H5LIhK2HES/fiDqabdO7Ju4wTnsRWtAie5PblbiIxznw0k6bBQ0hki0Zk4kX/9NZnVP2GBj6d8hnhXapPvq0tnz/FIuxI3rKtNvF9qbVc0+nuhAFfVN6x6fN5WaOGn3p89x1yROPuGRgo/b0Y2FScwvROlhPY5uXFnVkwVg==
X-YMail-OSG: A98Pb3YVM1na2EO___ACnfmag2femHviUAhmHo6dT2b6KHmc6zmbaRth_8lbcvb
 yQSEIqbGBy5BkmAqOAiiXV0AcCO.xXyco4jjB3f0S2xwZF9KfOPY7sXmQULe2nJjbT_5uHnvCZCj
 DtG6nJLI5JGEKFqLIdsbhCJ0A74fgWFgYLC8UBynDzG6uY3vQ8pALCXS5rLix5AyUp2CifbVqUnp
 bmOb.ETMA8H8upLKQ9E2BsWpRYN0Kj8KJKsEkyzqfjmBHSgxQrB0urGu2ZVC.R4psu442TetT1sN
 AWZ3C65voxYnThtlAR08ejL3dN6x22af.ATy1lr7qZzwY6jhAPDbMW7OdIPi1opLGQ00GH2mQB96
 1xU44VPGSXM6eLTwoU7OD6OjsNc2J7KLit0OG1c3oeEkRxEi7LY.7uUrtpo3s9ilGdVEDV.Sbckq
 EXV87ZJ89.xu9HvLiGMQtayRdMNK2MQlTbWqs8yYz8QWX7usrrsSRxaXVMw4uytImgi.cfKNseOq
 Y_8rQPRlI2htyzYfjsycM3ynJtqFM.liUcqS8L5DLF431ecgX2RU5LAQayJPfGL.Obz7SPqSQkuO
 eROaKuv.0_wSoxc.8ucpQgue7SZG2.bGQ_t8oyOqjmQlDVOFzDRA0PPd_KTelwNNK0Th81d.XJa6
 dp1o2284jdbMR82m.j1tjONNg1No3f7Qt2Fkbf3SnOvNyVnQsW0JHxcXoyNGWpEB6PaTrMQ2xq8i
 01hgxsBR.ve0RgnPJG9ly4u4g6Rbn1c.htj9InNzOm0yfH_2MIXlOQtVikzWYTNb4ZVcNVBtv0cN
 A0ho99EZ0m.CGQuqlfo4wAj9td6rIllzHXE7Dji6Vabh8VzEucGirWUTrhSP9wBztl.BaY7XWkwL
 f5uxJW0Kp4qDmTxBz0GN2N6j.J7H0P7kbfvfBAXeazkcFsGQxqs7KRkCEC5L5yQNs1e5dPSIlNnE
 HXykvhOo049E5AYJFDoIUOthRj6.wE4GRVGayzn0csdwm1JwHwKu55Iv2RR6uSjAegC63h7v2j.9
 ipih9PtMw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Thu, 27 Sep 2018 19:46:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cb7767fc7bda0cfe5fd8a9c78e79c14f;
          Thu, 27 Sep 2018 19:46:29 +0000 (UTC)
Subject: Re: Bug: getcwd: cannot access parent directories
To:     Roel Van de Paar <roel.vandepaar@percona.com>,
        linux-kernel@vger.kernel.org
References: <CAGQTitMPcrHRhFVLfApe21T7hYyeX05ffuSJj452+f+ZksmQqg@mail.gmail.com>
 <CAGQTitONf2L_p9JQ7oMac+Sw2wdJZg_z2MHucpdf87vvBBgF0g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <04f4b19f-2990-6ad3-1ae4-b41da1ca089f@schaufler-ca.com>
Date:   Thu, 27 Sep 2018 12:46:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGQTitONf2L_p9JQ7oMac+Sw2wdJZg_z2MHucpdf87vvBBgF0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2018 6:54 PM, Roel Van de Paar wrote:
> Ping :)
>
> On 21 September 2018 at 18:16, Roel Van de Paar
> <roel.vandepaar@percona.com> wrote:
>> [1.] One line summary of the problem:
>>
>> "cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory" on move of directories to
>> another volume
>>
>> [2.] Full description of the problem/report:
>>
>> Example output (testcase below):
>>
>> /tmp/1/2$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/..$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/../..$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/../../..$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/../../../..$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/../../../../..$ cd ..
>> cd: error retrieving current directory: getcwd: cannot access parent
>> directories: No such file or directory
>> /tmp/1/2/../../../../../..$ cd ..
>> /tmp$
>>
>> - The number of ".." required is not correct
>> - The number of ".." matches the number of subdirs (see below)
>>
>> [4.] Kernel information
>>
>> Tested on latest updates of:
>> * Ubuntu Xenial
>> * Ubuntu Bionic
>> * Centos 7
>>
>> [7.] A small shell script or example program which triggers the
>> problem (if possible)
>>
>> In session 1
>>   cd /tmp
>>   mkdir -p 1/2
>>   cd 1/2
>>
>> In session 2 (another terminal session)
>>   cd /tmp
>>   mkdir -p 3/4/5/6/7
>>   mv 1 3/4/5/6/7
>>   mv 3 /dev/shm   # where /dev/shm is some other disk. /dev/shm
>> reproduction works too. If the disk is the same, the issue will not
>> show.

Please try doing this under strace, in particular

	strace mv 3 /dev/shm

What you will see is that the mv command does a copy/delete
when changing filesystems. The original "2" directory, which
is your current working directory, will have no parent as the
original "1" will have been removed.

>>
>> Back to session 1
>>   cd ..   # fail
>>   cd ..   # fail
>>   cd ..   # fail
>>   cd ..   # fail
>>   cd ..   # fail
>>   cd ..   # fail
>>   cd ..   # works, but to completely incorrect directory given the
>> many 'cd ..'```
>>
>> The problem is made more clear here by using 3/4/5/6/7 but you can
>> also just use a single subdir to see it
> Roel Van de Paar, Technical Director - Quality Assurance, Percona

The system is working properly.

