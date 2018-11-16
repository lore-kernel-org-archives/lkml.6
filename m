Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779A20818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6oJUKo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779A20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389343AbeKPRMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:12:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50666 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:12:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so21119534wmw.0;
        Thu, 15 Nov 2018 23:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pIq4x0z0Jydx8S6oSjYzAJKPy4n3KFnv5oBJa03VF4=;
        b=U6oJUKo4Krrz5GwzQ7dbnWca0mE2j4M6LavXMyG+Ja4vtkdUoHn9+6F+/oXePNNl7v
         D5zpmHxWzywZR9RJcAV7NDkDfqY2DRBY78ZXuoqd+dapMZT8sjw5JsMahqagObBxNR9s
         F/cKQ1vXUg7m651U+93ZHAS1aLDDOm6vOLljLdxnuksOSe4NRFz7F2hd2BM1sOR2nzbV
         PlPlFKrhVmNUsDxc+u5wI9q8NUr1xwWSCOyaVWgUyjs4tFVMMQcHuV5eNkENaD9OA71y
         VaxFgwXIPd/WnNbI2Q/0oOznT+cW0Vkd91QgSKw68p3LFacBFMzH+DeBbx1dzMojSZDT
         oCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/pIq4x0z0Jydx8S6oSjYzAJKPy4n3KFnv5oBJa03VF4=;
        b=ttQuGxdsr2yovdSieDZWSYfy/UzKxHRMyH3za8GM1H+09jQYGLy8dqF6OWaW/9KXce
         HXdgDHEoz8kjEP4uf7pED5zcI68TSmW3MSw+15TV4IER10TAa6sCkeBBN/EVCpcSVu7t
         6ii8wkGL7dZKzhSPnJBxgpb3Txe3Nehl9zb6iv/xIuZ7spP2tsjlfEmBJz0X/NYpxFPw
         bc5iRDRpusypJfPe3QpMNq4ww2yxeIQhChoJDr6wA80/omVUcj9GwKiIQKcjMaE5j6uB
         czlVq93OS8TFDrznsOr9GN98hJobMh4Eeclc+KSopW3lBmqyBJ4//0pVH+/hjl273DMc
         xL8Q==
X-Gm-Message-State: AGRZ1gLsB1zuRk6KXfD9/15fQagFSBgzZNjiGzBwGcqiNegonzUc1xLS
        ZcVZyWhXUaiRgycr+6n3/ouyknH+
X-Google-Smtp-Source: AJdET5dZPxc+JrwYAFKk1oBqpPRaUnM+3v53vf1qpMla4AoNET5SqOurgxhBmLAQANv7gEpf1UNRmg==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr5421191wmf.56.1542351690844;
        Thu, 15 Nov 2018 23:01:30 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id q2sm8730470wru.56.2018.11.15.23.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:01:30 -0800 (PST)
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
To:     Bart Van Assche <bvanassche@acm.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181110190521.GA2627@thunk.org>
 <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
 <20181111141426.GA7377@thunk.org>
 <98fe5cf7-722a-37d6-156d-842e8812e430@redhat.com>
 <1542328654.100259.18.camel@acm.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <c819493c-2a45-4911-8879-310c910ee42a@redhat.com>
Date:   Fri, 16 Nov 2018 08:01:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542328654.100259.18.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 01:37, Bart Van Assche wrote:
> All user space interfaces in the Linux kernel for storage that I'm familiar
> with not only allow configuration of parameters but also make it easy to
> query which parameters have been configured. The existing sysfs and configfs
> interfaces demonstrate this. Using BPF to configure SG/IO access has a
> significant disadvantage, namely that it is very hard to figure out what has
> been configured. Figuring out what has been configured namely requires
> disassembling BPF. I'm not sure anyone will be enthusiast about this.

Well, that's a problem with BPF in general.  With great power comes
great obscurability.

Paolo
