Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2138ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694F821479
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KSCnF8/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694F821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbeITVE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:04:59 -0400
Received: from sonic304-17.consmr.mail.bf2.yahoo.com ([74.6.128.40]:38586 "EHLO
        sonic304-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733258AbeITVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537456859; bh=7FjwnZHpf+5P82oFLsLLkybP/C1DyPN/tYcPzqVjLLo=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=KSCnF8/V5HzrpCdyxvrvyPrzLa15LLNegBxc5ciQHhtIPTBHwlISqmmGmYdWrw9nT79q4L4Z7rgigw2mjH56nUSZHssZ7m3kWgeosoBRteqolZfwaik8/Kth3+rv59j3eq+021H8SXcILP2q98wxV56HBZW6FuvTa8IKXWbDdbO8RSp/EierGmPkxd57dzmWXYEhOWnaj1gNqB8Q/Gk1yADic/Lek5mlldq2Ob/PHxFsosbrTNgSmVW0txZ1+AsJTsz8N9suDsFPXhdhRY/kp/FotO4gMiy6NOrH5GX6WGKHhhQdPOqv5P/95a95o4UrxcKJHlCVIPWK5NKvwW2BlA==
X-YMail-OSG: WNI.G_kVM1mhbkdN2nufYLjpq0aavoqrqcF1TRlAa2dFeHwJufe2CdBKYjaMHex
 3WxWYGl8o_pELjhk8KNyPLVyXED.TXwMEPl_UHDBgbFVvUseiWg.Xy2tysXsGYCK8Oy8bqkMj_KB
 0IunEro8AnSEzjexnESR5s7NvXgHvpQpfDgNJ0W5_dv3IaXUhk04USOJSQCyaorOdQFIxd5SjsGO
 L5rJfjW4pXFYwAYcnjhC4.OImL2fXqob1a6G1o1WCMvIMBYFPQmqhAPlZ8zTRAR3LJ_1beTNhcUU
 HIncoxiSYHjHVnjgMsTx6aCo4ufY6tes4H_F0rjrYULnDsZPJJM6VkPr7SBZzjjTBmiBCPzoTppV
 7XgO3W7OHYWZ6yw4v3K_ZgdSBqtsVoM2ZtyPlvN7xMDFmPc7kZgehknnC03SZpq3DWZl4Q2S5JrM
 t3qx8lC0sTg5maug_bXFD9vVEWkGw66p53qpwbNyuFe6_R0e9svHrk7ESYgRnwIl9ciUHrFhuWex
 iLCIodLq5Dxl7RtK52EbD3BW3dCjvLu8DGcvcMpXKBxHawG6Sz3msdfLoTxwenrylw4T1P2F97Nv
 6fz3IcLTi8suK8QWXjBuCRK5ny.M4AKProC.KCjCpAUUCBkapkJ23Jx5AKGiFSSpIKEIsR7d77wZ
 GiwdkI_PSAzFQ5avMoa2Csc645qv0wdGTuHQaxpJVPjj1k1bAjE7UmZlakZVt5CaNYYCRSm3P3pk
 e4gRvs7xfKj0DRwZz0EibWEXqXZMwSo.LVNPfNGW_HkSmO.mniCFoQMBlxMt6nO09NVtD7GkHoRM
 UxV8EFui.cMASsZ8J0CD.cg4Bbwo2UjLkXgaW82mCvVo38lXBNb2smPTTDW6r7Dsh1xHluNjXoNp
 sy.bg8gPWz9qf3VtqdYl_SsWRdXSxObLxUNBalEw3v46388dDjIP79hwMvOE.O6aySFqWtxqPm4c
 wJEuQ4OODpGqhAqhLqqtZv7paLQBy9qqhPJIK74Ej35HfXMbANy.nNX12861becZquTiExkgKJEn
 NOFoACydAteamC6bEJX7pEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Sep 2018 15:20:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 379d111bb48eafd443e6480bbc8e5ea8;
          Thu, 20 Sep 2018 15:20:55 +0000 (UTC)
Subject: Re: [PATCH v3 09/16] SELinux: Abstract use of file security blob
To:     David Laight <David.Laight@ACULAB.COM>,
        LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
 <14db9a22-9f31-88fb-dbc1-8bc4ade74bf6@schaufler-ca.com>
 <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4db0c110-c1aa-aac8-901f-a9abf662b605@schaufler-ca.com>
Date:   Thu, 20 Sep 2018 08:20:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <124ae3859e8141deb35ed8355370b4ed@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 1:51 AM, David Laight wrote:
> From: Casey Schaufler
>> Sent: 20 September 2018 01:21
>>
>> SELinux: Abstract use of file security blob
>>
>> Don't use the file->f_security pointer directly.
>> Provide a helper function that provides the security blob pointer.
> ...
>> +static inline struct file_security_struct *selinux_file(const struct file *file)
>> +{
>> +	return file->f_security;
>> +}
>> +
> Why?

In patch 16/16 this becomes:

 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + selinux_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }

You could hard code this bit everywhere it's used, but that
would be prone to error. I'm not generally an abstractionist
myself, but it these cases abstraction adds value.

