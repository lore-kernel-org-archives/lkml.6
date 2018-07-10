Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE28C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7BF208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VK+7u4v6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7BF208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeGJXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:30:01 -0400
Received: from sonic308-16.consmr.mail.gq1.yahoo.com ([98.137.68.40]:39238
        "EHLO sonic308-16.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732305AbeGJXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1531265316; bh=7ZsuvngLdaQKxqLuRYKT98yYZUfA+IY8qbGPlm++Fzw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VK+7u4v6w3UeWDdCtkLkSBwAxT4LgHzKwIAFpS9PAh6/FaMe3JfRY3e9NtA/Q9uQF02TlWs54MyXu6OkE0mho2WthibrknDV0iyU4bEXJUrTTOxSgxeMImeqcVMU7jywqlXrQBrIf1W1bs2uvc8dXsqhCTm7c+mVbounVxqqz/9uiqYwMK5qrzs5cKXLML1HsHdVgdx8T6bzHyha3r+ac65otvfSMlz92uk2LIDkxulvJ5I/O3qRAGzsj0hIKETyXiZdjICYdWvq/H5mreNmsxmQZMk+E5W7Z411b66QWI8UYsfEdREZy7shgd1bDL2A2a0r7Rep0MK/YWi/vDhoxA==
X-YMail-OSG: 3NsdhXsVM1k2U315gBRA_Ua5ZIbQzYQ.SJM41hQWemG6MbJnn.lrx.vRpTPUF6P
 e.0gmj1KP2FTJ.4Hd93RXlqCbGoST1_Xq50YFCRULpIdA7RZDUkMCVxDT8FCIIjdH8AC6HPOp9W4
 FQbGvrq2eS7Ptfugj_of04jyvTjFXrNDomc9zGtVF5ddI45vFPINQZT4x0loL1vfkgxA.ZD_hCZb
 PT7R.YEf5kA1zaRWWIJIWCMc4LNf4ZeywR_XsVwf2HNjjr56_yhmLzQMwZzj1CMwDQjCiR6h2a0L
 VbGVmTilbf3rbVAN6cUhEr0QWgCXFLwIPIuOWnS.Rrnz9AaEWMPxjBlI3svULjmBEyQidhjlDwNP
 XYSAKiPwWeWOwDlUaPhxVA.ut.iXqlImqXm.XMrSHPF3tRuV14tOtyZqvZTLYtIQFiFe44KzsPvC
 YXB7L3ni0JBnnaRhb2HaKsagLLvH1B.7KuJtRGpQoFcTWwl0pfnDQ0ph4XcW.dNuBMz8jcVJF32l
 9vnKhIPWD1PfqKVJtiySiX_vgRR8AQiBhXPhk7HoQzw.DkwMC_hKPFBLZW9OQHGbEsV0kfQRFWJ9
 fKE13ZuheHt9ASQSL_ibbot0MJWfhbvxvP0D1O4.LfFHTRzigph0n61pHD0wIFIcykaaFMJU41FG
 .KwsMEGgeEXQbakZE.uWd1SFP28MtTtWEsBMdRiauezxw1DKpE16dS.s2.VtkZuJ9IgpYQgktM2t
 GxkEkm2OZhlx6G.3D3rdfiV76GTKSLbClwRSplh3Wh5eZXTNAJbDJUJTo6C8GjqFKmw3Ree4QerZ
 12l6Mle_2OlI6wXx7zmM4umz7dXpxAxmYQK6217SdQhVXuomsUjFDeyiqxvFLcl6SlRDhzIDgYEB
 QjZvD7F8RB7kxTWL_BlkkkQ6NoQz8CeOBIm7kZ03OylXRXuZq2622TGPUOQQ2pPoayj.v4mm3cMx
 KknoDLebfiKYRZcY8goqOgRmlwTAaC23BUXsZ9HD47eGes0OIyQakziO1DQ71csyssu84PzeaS.7
 xSEdPj7qP.ff.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 10 Jul 2018 23:28:36 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8d8fe1d099b610d34f46cf9228dbb2bb;
          Tue, 10 Jul 2018 23:28:31 +0000 (UTC)
Subject: Re: [PATCH 08/32] smack: Implement filesystem context security hooks
 [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
References: <dc5039cb-97cf-fe72-d601-f48eb26e8e66@schaufler-ca.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126254346.14533.14191961720018099798.stgit@warthog.procyon.org.uk>
 <16480.1531264793@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <27bf0500-470d-d68a-2757-25cfae05d5a0@schaufler-ca.com>
Date:   Tue, 10 Jul 2018 16:28:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <16480.1531264793@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/2018 4:19 PM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> Implement filesystem context security hooks for the smack LSM.
>>>
>>> Question: Should the ->fs_context_parse_source() hook be implemented to
>>> check the labels on any source devices specified?
>> Checking the label on a block device when doing a mount
>> is just going to end in tears. If you're remounting from
>> an already mounted filesystem it might make sense to check
>> that the new mount doesn't provide greater access than the
>> existing mount. If the original mount has smackfsdefault="_"
>> I could see prohibiting the additional mount having
>> smackfsdefault="*" on a filesystem that doesn't support
>> xattrs. But that requires that a (hopefully) privileged
>> process be involved, and we expect them to have a clue.
>> So no, I don't see it necessary.
> I think I may have meant the device file rather than the actual device
> content.

You may have! I see no reason to look at the label on /dev/sdb1
when mounting it. There's already sufficient privilege required
to protect that in my mind.

>
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

